#!/bin/bash
echo "Config Started" >> /home/ec2-user/msg
cd /tmp
echo "Config Step -1 : download chef dk" >> /home/ec2-user/msg
curl -O https://packages.chef.io/files/stable/chefdk/2.5.3/el/7/chefdk-2.5.3-1.el7.x86_64.rpm
echo "Config Step -2 : install chef dk" >> /home/ec2-user/msg
sudo rpm -Uvh chefdk-2.5.3-1.el7.x86_64.rpm
echo "Config Step -3 : setup chef shell" >> /home/ec2-user/msg
echo 'eval "$(chef shell-init bash)"' >> /home/ec2-user/.bash_profile
echo "Config Step -4 : Cleanup" >> /home/ec2-user/msg
rm -f /tmp/*.rpm
echo "Config Finished" >> /home/ec2-user/msg