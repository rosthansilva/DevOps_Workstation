#!/usr/bin/env bash

echo "*** Startando Deploy da DevOps Workstation ***"

sleep 2

if [[ $UID != 0 ]]; then
    echo "Por favor, rode o script com sudo"
    echo " "
    echo "sudo $0 $*"
    exit 1
fi

echo "Instalando Ansible e ssh-pass"


apt-get update

packages=( "python3-apt" "ansible" "git" "sshpass" "ssh" "wget" "curl")

for i in "${packages[@]}"
do
  if ! [ -x "$(command -v $i)" ]; then
    echo "== No Ok = Instalando -  $i ==" >&1
    apt-get -y install $i
    echo " " && echo " " && sleep 2
  else
    echo "== Pkg Ok = $i - already installed =="
    echo " " && echo " " && sleep 2
  fi
done

echo  " " && echo " "
echo "Instalando Ansible e ssh-pass"
echo  " " && echo " "
  SERVICE="ssh"

  if ps ax | grep -v grep | grep $SERVICE > /dev/null
  then
    echo "$SERVICE Ok == Running!"
  else
    echo "$SERVICE NOT OK == Is not running!"
    systemctl start $SERVICE
    systemctl enable $SERVICE
  fi
