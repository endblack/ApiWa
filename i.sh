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
  wget https://raw.githubusercontent.com/endblack/ApiWa/main/src/user.sh > /dev/null 2>&1
  wget https://raw.githubusercontent.com/endblack/ApiWa/main/src/app.js > /dev/null 2>&1
  wget https://raw.githubusercontent.com/endblack/ApiWa/main/src/favicon.ico > /dev/null 2>&1
  wget https://raw.githubusercontent.com/endblack/ApiWa/main/apioff > /dev/null 2>&1
  wget https://raw.githubusercontent.com/endblack/ApiWa/main/apion > /dev/null 2>&1
  chmod 777 apion apioff
  mv apion apioff /bin
  rm /root/apiWa/src/user.sh /root/apiWa/app.js
  mv user.sh /root/apiWa/src
  mv app.js favicon.ico /root/apiWa
  echo
  echo "Atualização terminada! use apion para reiniciar"
  echo
  #echo "Não esqueça de editar a porta no arquivo /root/apiWa/dados.js"
  echo
  [[ -e /root/apiWa/token.txt ]] && {
  exit 0
  }
  echo "Token de acesso a sua api, guarde com SEGURANÇA:"
  echo
  token=$(node -e "console.log(require('crypto').randomBytes(50).toString('base64'));")
  echo $token
  echo $token > /root/apiWa/token.txt
  echo
  apion
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
echo "Instalação da Api terminada"
echo
echo "Adicione a porta no arquivo /root/apiWa/dados.js"
echo
echo "Depois use o comando apion para ativar"
echo
echo "Token de acesso a sua api, guarde com SEGURANÇA:"
echo
token=$(node -e "console.log(require('crypto').randomBytes(50).toString('base64'));")
echo $token
echo $token > /root/apiWa/token.txt
echo 
cd