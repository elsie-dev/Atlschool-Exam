#!/bin/bash

cd altschoolexam
vagrant up

vagrant ssh master

chmod +x setup.sh

./setup.sh


chmod +x lamp.sh
./lamp.sh

chmod +x phpconfig.sh
sudo ./phpconfig.sh
