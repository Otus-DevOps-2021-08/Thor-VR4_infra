yc compute instance create \
  --name reddit-full \
  --hostname reddit-full \
  --memory=1 \
  --create-boot-disk image-id=fd81fkdukuk5n7e2matg,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --core-fraction=20 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/ya_cloud.pub
