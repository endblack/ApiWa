[ "$(whoami)" != "root" ]] && {
    echo
    echo "Instale com usuario root!"
    echo
    exit 0
}
[[ -e /root/apiWa/app.js ]] && {
  echo
  echo "Nada para atualizar"
  echo
  exit 0
}
apt update -y
echo
echo "Instalado api e suas dependências, aguarde..."
echo
apt install nodejs -y > /dev/null 2>&1
apt install unzip -y > /dev/null 2>&1
apt install screen -y > /dev/null 2>&1
apt install wget -y > /dev/null 2>&1
wget https://raw.githubusercontent.com/endblack/ApiWa/main/apiWa.zip > /dev/null 2>&1
wget https://raw.githubusercontent.com/endblack/ApiWa/main/offapi > /dev/null 2>&1
wget https://raw.githubusercontent.com/endblack/ApiWa/main/onapi > /dev/null 2>&1
chmod +x onapi offapi
mv onapi offapi /bin
unzip apiWa.zip
echo 
echo "Instalação da api terminada. Use o comando onapi para ativar"
echo 