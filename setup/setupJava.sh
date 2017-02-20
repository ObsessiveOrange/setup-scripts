#!/bin/bash

JAVAVERSION=8

printf "\e[1;34mSetting up Java (OpenJDK) %d\n\e[m" $JAVAVERSION

sudo apt update
sudo apt install openjdk-$JAVAVERSION-jdk openjdk-$JAVAVERSION-jre openjdk-$JAVAVERSION-doc openjdk-$JAVAVERSION-source

printf "\e[1;34mJava (OpenJDK) setup successful\n\e[m"
