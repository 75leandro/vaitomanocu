## Bt Linux

→ mysql:  mysql -u root -p; Senha@123


## DHCP

→ ifconfig  .... verificação configuração de rede

1- Interface de rede servidor
→ IP Fixo
→ Instalar opacote do  servidor DHCP:
  isc-chdp-server

2- Arquivo de configuração do  servidor DHCP:
/etc/dhcp/dhcpd.conf

# Targets Comuns... Modo de Inicialização

→multi-user.target .... Modo multiusuário, inicia apenas no terminal em modo gráfico.

→graphical.target .... Inicia no modo Grafico .
phical
→rescue.target ... Modo de recuperação com acesso root, sem rede nen serviços extras...

→systemctl get-default .... Mostra o modo setado.

→systemctl set-default multi-user.target ... Modo prompt

→systemctl graphical.target .... Modo grafico.

- Ou uso em modo temporário ... sudo systemctl isolate multi-user.target => Modo Prompt
-------------------------------- sudo systemctl isolate graphical.target => Modo Grafico...



# Vim comandos

→ tab ball .... multiplas janelas simultâneamente...

→ gt ... mover por entre as janelas...

→ctrl w w ... cursor alterna entre janelas terminal/editor... ou mais....

→ssh -X leandro@10.0.11.170 ... Acesso  remoto com interface gráfica...
→ssh -l leandro 10.0.11.170 ... Acesso sem a interface grafica...



# Firewall ufw

→ sudo ufw status
→ sudo ufw enable
→ sudo ufw desable
→ sudo ufw status enumbered
→ less /etc/services

* Permissão:

leandro@abstract-programmer:~$ sudo ufw status numbered
Estado: ativo
leandro@abstract-programmer:~$ less /etc/services 
leandro@abstract-programmer:~$ sudo ufw allow 22/tcp
Regra adicionada
Regra adicionada (v6)
leandro@abstract-programmer:~$ sudo ufw status
Estado: ativo

Para                       Ação        De
----                       ----        --
22/tcp                     ALLOW       Anywhere                  
22/tcp (v6)                ALLOW       Anywhere (v6)             

leandro@abstract-programmer:~$ sudo ufw status numbered
Estado: ativo

     Para                       Ação        De
     ----                       ----        --
[ 1] 22/tcp                     ALLOW IN    Anywhere                  
[ 2] 22/tcp (v6)                ALLOW IN    Anywhere (v6)             

leandro@abstract-programmer:~$ sudo ufw delete 1
Apagando:
 allow 22/tcp
Proceder com operação (s|n)? s
Regra apagada
leandro@abstract-programmer:~$ sudo ufw status
Estado: ativo

Para                       Ação        De
----                       ----        --
22/tcp (v6)                ALLOW       Anywhere (v6)             

leandro@abstract-programmer:~$ sudo ufw delete 1
Apagando:
 allow 22/tcp
Proceder com operação (s|n)? s
Regra apagada (v6)
leandro@abstract-programmer:~$ sudo ufw status
Estado: ativo

* Negar Permissão:

leandro@abstract-programmer:~$ sudo ufw deny ssh
Regra adicionada
Regra adicionada (v6)
leandro@abstract-programmer:~$ sudo ufw status numbered
Estado: ativo

     Para                       Ação        De
     ----                       ----        --
[ 1] 22/tcp                     DENY IN     Anywhere                  
[ 2] 22/tcp (v6)                DENY IN     Anywhere (v6)             

leandro@abstract-programmer:~$ sudo ufw delete 1
Apagando:
 deny 22/tcp
Proceder com operação (s|n)? s
Regra apagada
leandro@abstract-programmer:~$ sudo ufw delete 1
Apagando:
 deny 22/tcp
Proceder com operação (s|n)? 1
Abortado
leandro@abstract-programmer:~$ 
leandro@abstract-programmer:~$ sudo ufw status numbered
Estado: ativo

     Para                       Ação        De
     ----                       ----        --
[ 1] 22/tcp (v6)                DENY IN     Anywhere (v6)             

leandro@abstract-programmer:~$ sudo ufw delete 1
Apagando:
 deny 22/tcp
Proceder com operação (s|n)? s
Regra apagada (v6)

** Bloqueando porta internet...

leandro@abstract-programmer:~$ sudo ufw deny out 80
Regra adicionada
Regra adicionada (v6)
leandro@abstract-programmer:~$ sudo ufw status numbered
Estado: ativo

     Para                       Ação        De
     ----                       ----        --
[ 1] 80                         DENY OUT    Anywhere                   (out)
[ 2] 80 (v6)                    DENY OUT    Anywhere (v6)              (out)

leandro@abstract-programmer:~$ sudo ufw delete 1
Apagando:
 deny out 80
Proceder com operação (s|n)? s
Regra apagada

leandro@abstract-programmer:~$ sudo ufw status numbered
iEstado: ativo

     Para                       Ação        De
     ----                       ----        --
[ 1] 80 (v6)                    DENY OUT    Anywhere (v6)              (out)

leandro@abstract-programmer:~$ 

** Permissão para servvidor web...

leandro@abstract-programmer:~$ sudo ufw allow from 10.0.11.170
Regra adicionada
leandro@abstract-programmer:~$ sudo ufw status
Estado: ativo

Para                       Ação        De
----                       ----        --
Anywhere                   ALLOW       10.0.11.170               

leandro@abstract-programmer:~$ ping 10.0.11.170
PING 10.0.11.170 (10.0.11.170) 56(84) bytes of data.
64 bytes from 10.0.11.170: icmp_seq=1 ttl=64 time=4.81 ms
64 bytes from 10.0.11.170: icmp_seq=2 ttl=64 time=4.36 ms
64 bytes from 10.0.11.170: icmp_seq=3 ttl=64 time=5.58 ms
64 bytes from 10.0.11.170: icmp_seq=4 ttl=64 time=4.69 ms
64 bytes from 10.0.11.170: icmp_seq=5 ttl=64 time=5.45 ms
^C
--- 10.0.11.170 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4046ms
rtt min/avg/max/mdev = 4.362/4.977/5.577/0.462 ms
leandro@abstract-programmer:~$ 

** Permissão para todas as máquinas da rede em submáscara/24...

leandro@abstract-programmer:~$ sudo ufw allow from 10.0.11.170/24
WARN: Regra alterada depois da normalização
Regra adicionada
leandro@abstract-programmer:~$ sudo ufw status
Estado: ativo

Para                       Ação        De
----                       ----        --
Anywhere                   ALLOW       10.0.11.0/24

leandro@abstract-programmer:~$ sudo ufw delete 1
Apagando:
 allow from 10.0.11.0/24
Proceder com operação (s|n)? s
Regra apagada

* Especificando máquina e porta .....

leandro@abstract-programmer:~$ sudo ufw allow from 10.0.11.170 to any port 22
Regra adicionada
leandro@abstract-programmer:~$ sudo ufw status
Estado: ativo

Para                       Ação        De
----                       ----        --
22                         ALLOW       10.0.11.170               

leandro@abstract-programmer:~$ sudo ufw delete 1
Apagando:
 allow from 10.0.11.170 to any port 22
Proceder com operação (s|n)? s
Regra apagada

** Liberadando acesso para tipo de 'Protocólo ' udc/tcp...

leandro@abstract-programmer:~$ sudo ufw allow from 10.0.11.170 to any port 22 proto tcp
Regra adicionada
leandro@abstract-programmer:~$ sudo ufw status
Estado: ativo

Para                       Ação        De
----                       ----        --
22/tcp                     ALLOW       10.0.11.170

** Bloqueando tráfego de rede de ips .... regra de precedência de entrada, 1ª regra será aplicada...

leandro@abstract-programmer:~$ sudo ufw deny from 10.0.11.140 to any port 22 proto tcp
Regra adicionada
leandro@abstract-programmer:~$ sudo ufw deny from 10.0.11.142 to any port 22 proto tcp
Regra adicionada
leandro@abstract-programmer:~$ sudo ufw allow from 10.0.11.170/24 to any port 22 proto tcp
WARN: Regra alterada depois da normalização
Regra adicionada
leandro@abstract-programmer:~$ sudo ufw status
Estado: ativo

Para                       Ação        De
----                       ----        --
22/tcp                     DENY        10.0.11.140
22/tcp                     DENY        10.0.11.142
22/tcp                     ALLOW       10.0.11.0/24

# servidor FTP

    Status do programa:

    /etc/init.d/proftpd status.... comandos: stop, start ou restart....

→   Arquivo de configuação:

  /etc/proftpd/proftpd.conf 

→ Entrada via Filezilla no Windows ... host 10.0.1.170 usuario leandro senha xxxxxx porta 22 ... estabelece conexão cliente servidor...

# Samba Servidor Windows/Linux

→ /etc/samba/smb.conf
→ sudo smbd start ou restart....
→ chgrp users /home/Publico .... Autoriza o acesso do grupo ao diretorio alvo...
→ chmod 775 /home/publico .... permissão total para root/users
→ useradd hoher -m -G users ....adicionando usuario com permissão dentro do grupo vigente....
→ passwd hoher senha xxxxxx 
→ smbpasswd -a hoher ... adicionando usuario ao banco de dados do samba....
→


# Alterar  permissão de acesso a arquivos e diretórios...

→ chmod

Modo de permmissão octal...

sintáxe:

chmod[permissões] [arquivo ou diretório]

execução = 1
escritao = 2
leitura = 4

rwx
111   1 = ligado / 0 = desligado 

--x
001 = 1

-w- = 2
010

r-- = 4
100
→ somando o resultado dos números no formato 'octal'...

rw-
110 = 6

rwx = 7

permissões:
pro   grup  outros
rwx   rw-   rw-
111   110   100
7     6     6  

rw-r-----
rw-  r--   ---
6    4     0

Alterando as permissões do arquivo....

leandro@abstract-programmer:~/bt$ > arqteste
leandro@abstract-programmer:~/bt$ ls -l
total 8
-rw-rw-r-- 1 leandro leandro    0 abr  9 21:12 arqteste
-rw-rw-r-- 1 leandro leandro  276 mar 24 21:06 comandos
drwxrwxr-x 2 leandro leandro 4096 mar 23 23:11 vim
leandro@abstract-programmer:~/bt$ sudo chmod 770 arqteste 
[sudo] senha para leandro: 
leandro@abstract-programmer:~/bt$ ls -l
total 8
-rwxrwx--- 1 leandro leandro    0 abr  9 21:12 arqteste
-rw-rw-r-- 1 leandro leandro  276 mar 24 21:06 comandos
drwxrwxr-x 2 leandro leandro 4096 mar 23 23:11 vim
leandro@abstract-programmer:~/bt$ 
Permissão parcial: 
leandro@abstract-programmer:~/bt$ sudo chmod 644 arqteste 
leandro@abstract-programmer:~/bt$ ls -l
total 8
-rw-r--r-- 1 leandro leandro    0 abr  9 21:12 arqteste

Permissão total:
leandro@abstract-programmer:~/bt$ sudo chmod 777 arqteste
leandro@abstract-programmer:~/bt$ ls -l
total 8
-rwxrwxrwx 1 leandro leandro    0 abr  9 21:12 arqteste

Negar permissão para todos:....
leandro@abstract-programmer:~/bt$ sudo chmod 000 arqteste
leandro@abstract-programmer:~/bt$ ls -l
total 8
---------- 1 leandro leandro    0 abr  9 21:12 arqteste

Permitir apenas leitura e gravação...
leandro@abstract-programmer:~/bt$ sudo chmod 664 arqteste
leandro@abstract-programmer:~/bt$ ls -l
total 8
-rw-rw-r-- 1 leandro leandro    0 abr  9 21:12 arqteste


# Alterando grupo e proprietário.....

→ chgrp ( change group ) ... alterar grupo e proprietário de arquivo e diretório...

sintáxe: 
chgrp [novo_grupo] [nome_arquivo]

chown ( change owner) ... altera proprietário do arquivo...

sintáxe:

chown [novo_proprietário] [nome_arquivo]

leandro@abstract-programmer:~/bt$ ls -l
total 4
-rw-rw-r-- 1 leandro leandro    0 abr  9 21:12 arqteste
drwxrwxr-x 2 leandro leandro 4096 abr  9 21:45 vim
leandro@abstract-programmer:~/bt$ sudo chown hoher arqteste 

leandro@abstract-programmer:~/bt$ ls -l
total 4
-rw-rw-r-- 1 hoher   leandro    0 abr  9 21:12 arqteste
drwxrwxr-x 2 leandro leandro 4096 abr  9 21:45 vim
leandro@abstract-programmer:~/bt$ 

→ Criando grupo...

addgroup 

leandro@abstract-programmer:~/bt$ sudo addg
addgnupghome  addgroup      
leandro@abstract-programmer:~/bt$ sudo addgroup oliver_scripts
info: Selecionando GID da faixa 1000 a 59999 ...
info: Adicionando grupo 'oliver_scripts' (GID 1002) ...

leandro@abstract-programmer:~/bt$ sudo chgrp oliver_scripts arqteste 
leandro@abstract-programmer:~/bt$ ls -l
total 4
-rw-rw-r-- 1 hoher   oliver_scripts    0 abr  9 21:12 arqteste
drwxrwxr-x 2 leandro leandro        4096 abr  9 21:45 vim
leandro@abstract-programmer:~/bt$ 

Renomeando proprietário e grupo...

leandro@abstract-programmer:~/bt$ sudo chown leandro arqteste 
leandro@abstract-programmer:~/bt$ sudo chgrp leandro arqteste 
leandro@abstract-programmer:~/bt$ ls -l
total 4
-rw-rw-r-- 1 leandro leandro    0 abr  9 21:12 arqteste
drwxrwxr-x 2 leandro leandro 4096 abr  9 21:45 vim
leandro@abstract-programmer:~/bt$ 


# Tranferência de arquivos via 'ssh' de : Servidor para Cliente....

sudo scp -r leandro@192.168.122.1:/home/leandro/Downloads/ /Documentos/ .... Obs "/Documentos/" Gerou criou diretório na raiz do sistema, para transferência dos arquivos...

Obs.2) O endereço inet 192.168.122.1 esta vinculada a placa de rede virtual ' virbr0 ' em ssh de hoher534 para leandro...

























