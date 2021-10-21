#!/usr/bin/python3

import json
from os import devnull
import subprocess
import argparse
import re

backup_file="inventory.json"

class MyInventory(object):

    def __init__(self):
        self.inventory = {}
        self.read_cli_args()

        # Called with `--list`.
        if self.args.list:
            self.inventory = self.populate()
        # Called with `--host [hostname]`.
        elif self.args.host:
            # Not implemented, since we return _meta info `--list`.
            self.inventory = self.empty_inventory()
        # If no groups or vars are present, return an empty inventory.
        else:
            self.inventory = self.empty_inventory()

        print (json.dumps(self.inventory));

    def empty_inventory(self):
        return {'_meta': {'hostvars': {}}}

    # Read the command line args passed to the script.
    def read_cli_args(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('--list', action = 'store_true')
        parser.add_argument('--host', action = 'store')
        self.args = parser.parse_args()

    def from_file(self, group):
        with open(backup_file, 'r') as f:
            file_content = json.load(f)
            f.close()
        if group=="app":
            file_app = file_content.get('app',()).get('hosts',()).get('appserver',()).get('ansible_host',())
            return {file_app}
        if group=="db":
            file_db = file_content.get('db',()).get('hosts',()).get('dbserver',()).get('ansible_host',())
            return {file_db}

    def populate(self):
        '''Populate inventory with given instances'''
        cmd2 = "(cd ../terraform/stage/ && terraform output -json)"
        output = subprocess.run(cmd2, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, check=False)
        if re.match(r'{', output.stdout.decode('utf-8')):
            yc_obj = json.loads(output.stdout.decode('utf-8'))
            if 'external_ip_address_db' in yc_obj:
                ip_db = yc_obj.get ('external_ip_address_db',()).get ('value',())
            else:
                ip_db = list(self.from_file("db"))
            if 'external_ip_address_app' in yc_obj:
                ip_app = yc_obj.get ('external_ip_address_app',()).get ('value',())
            else:
                ip_app = list(self.from_file("app"))
        else:
            ip_db = list(self.from_file("db"))
            ip_app = list(self.from_file("app"))

        return {
            'app': {
                'hosts': ip_app,
            },
            'db': {
                'hosts': ip_db,
            },
            '_meta': {
                'hostvars': {
                }
            }
        }

    def empty_inventory(self):
        return {'_meta': {'hostvars': {}}}

# Get the inventory.
MyInventory()
