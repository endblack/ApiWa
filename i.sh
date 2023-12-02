#!/bin/bash

[[ "$(whoami)" != "root" ]] && {
    echo
    echo "Instale com usuario root!"
    echo
    exit 0
}
[[ -e /root/apiWa/app.js ]] && {
  echo
  echo "Atualizando api...."
  echo
  wget https://raw.githubusercontent.com/endblack/ApiWa/main/apiWa.zip > /dev/null 2>&1
  wget https://raw.githubusercontent.com/endblack/ApiWa/main/apioff > /dev/null 2>&1
  wget https://raw.githubusercontent.com/endblack/ApiWa/main/apion > /dev/null 2>&1
  chmod 777 apion apioff
  mv apion apioff /bin
  unzip apiWa.zip
  rm apiWa.zip
  echo
  echo "Atualização terminada! use apion para reiniciar"
  echo
  exit 0
}
apt update -y
echo
echo "Instalado a api e suas dependências, aguarde..."
echo
apt install nodejs -y > /dev/null 2>&1
apt install unzip -y > /dev/null 2>&1
apt install screen -y > /dev/null 2>&1
apt install wget -y > /dev/null 2>&1
wget https://raw.githubusercontent.com/endblack/ApiWa/main/apiWa.zip > /dev/null 2>&1
wget https://raw.githubusercontent.com/endblack/ApiWa/main/apioff > /dev/null 2>&1
wget https://raw.githubusercontent.com/endblack/ApiWa/main/apion > /dev/null 2>&1
chmod 777 apion apioff
mv apion apioff /bin
unzip apiWa.zip
rm apiWa.zip
echo 
echo "Instalação da Api terminada"
echo
echo "Adicione a porta no arquivo /root/apiWa/dados.js"
echo
echo "Depois use o comando apion para ativar"