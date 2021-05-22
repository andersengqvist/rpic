#/bin/bash

ssh -i ~/.ssh/rpic_key pi@192.168.1.21 "sudo shutdown now"
ssh -i ~/.ssh/rpic_key pi@192.168.1.22 "sudo shutdown now"
ssh -i ~/.ssh/rpic_key pi@192.168.1.23 "sudo shutdown now"
ssh -i ~/.ssh/rpic_key pi@192.168.1.24 "sudo shutdown now"
