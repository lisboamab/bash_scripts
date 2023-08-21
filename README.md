# Meus Bash Scripts
## Descrição
Esse diretorio tem como objetivo agregar meus scripts em bash com diferentes propositos, seja estudos, trabalhos academicos ou outros

## Script de Criação de Diretórios, Grupos e Usuários

Este é um script Bash simples para automatizar a criação de diretórios, grupos e usuários em sistemas Linux. O script também configura permissões de acesso usando o comando `setfacl`, se o pacote `acl` estiver instalado.

### Uso

1. Clone ou baixe este repositório para o seu sistema Linux.

2. Execute o script com privilégios de superusuário (root ou usando `sudo`) para garantir que as operações que exigem permissões de administrador sejam executadas corretamente.

   ```bash
   sudo ./users_directories_permissions.sh