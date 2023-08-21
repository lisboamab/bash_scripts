#!/bin/bash

echo "Criando Diretorios e Grupos..."
mkdir /publico
mkdir /adm
mkdir /ven
mkdir /sec
groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC


echo "Criando usuarios..."
user_group_pares=(
  "carlos GRP_ADM"
  "maria GRP_ADM"
  "joao GRP_ADM"
  "debora GRP_VEN"
  "sebastiana GRP_VEN"
  "roberto GRP_VEN"
  "josefina GRP_SEC"
  "amanda GRP_SEC"
  "rogerio GRP_SEC"
)

# Loop para adicionar cada usuário ao grupo correspondente
for par in "${user_group_pares[@]}"; do
  user_name="${par%% *}"
  group_name="${par#* }"

  useradd -m -G "$group_name" "$user_name"
done

#Vou remover essa parte, achei melhor fazer com um laço for
#useradd -m -G GRP_ADM carlos
#useradd -m -G GRP_ADM maria
#useradd -m -G GRP_ADM joao

#useradd -m -G GRP_VEN debora
#useradd -m -G GRP_VEN sebastiana
#useradd -m -G GRP_VEN roberto

#useradd -m -G GRP_SEC josefina
#useradd -m -G GRP_SEC amanda
#useradd -m -G GRP_SEC rogerio

echo "Passando permissões para usuario root e grupos..."
chown root:root /publico
chmod 777 /publico

chown root:root /adm
chmod 700 /adm

chown root:root /ven
chmod 700 /ven

chown root:root /sec
chmod 700 /sec

chown :GRP_ADM /adm
chmod 770 /adm

chown :GRP_VEN /ven
chmod 770 /ven

chown :GRP_SEC /sec
chmod 770 /sec

# verificar se o pacote acl está instalado antes de executar o comando setfacl
if ! command -v setfacl &> /dev/null; then
    echo "O comando setfacl não está instalado. Instalando..."
    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update
        sudo apt-get install acl
    elif [ -x "$(command -v yum)" ]; then
        sudo yum install acl
    else
        echo "Não foi possível encontrar um gerenciador de pacotes suportado (apt-get ou yum). Instale o acl manualmente."
        exit 1
    fi
fi

# se chegou aqui, o setfacl está instalado e pode prosseguir com o restante do script
echo "O comando setfacl está instalado. Continuando com o script..."

# O setfacl é um comando que facilita o a distribuição de permissões de forma mais refinada
#d:u:: se refere ao proprietario
#d:g:: se refere ao grupo
#d:o:: se refere aos demais usuarios
#rwx é referente a read, write e execute
setfacl -m d:u::rwx,d:g::rwx,d:o::- /adm
setfacl -m d:u::rwx,d:g::rwx,d:o::- /ven
setfacl -m d:u::rwx,d:g::rwx,d:o::- /sec

echo "Finalizado!"