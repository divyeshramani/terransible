#!/bin/bash
echo "Config Started" >> /home/ec2-user/msg
cd /tmp
echo "Config Step -1" >> /home/ec2-user/msg
curl -O https://packages.chef.io/files/stable/chefdk/2.5.3/el/7/chefdk-2.5.3-1.el7.x86_64.rpm
echo "Config Step -2" >> /home/ec2-user/msg
sudo rpm -Uvh chefdk-2.5.3-1.el7.x86_64.rpm
echo "Config Step -3" >> /home/ec2-user/msg
echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
echo "Config Finished" >> /home/ec2-user/msg