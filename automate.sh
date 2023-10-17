#!/bin/bash

cd altschoolexam
vagrant up

vagrant ssh master

chmod +x setup.sh

./setup.sh


