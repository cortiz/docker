#!/bin/bash
service apache2 start;
service mysql start;
su crafter
./runStudio.sh
