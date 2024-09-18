echo "Criando os repositorios"

mkdir $PWD/app
cd $PWD/app

echo "Baixando projeto"
git clone https://github.com/lisboamab/landing-page-iracema-bot.git

cd -

docker-compose up -d

