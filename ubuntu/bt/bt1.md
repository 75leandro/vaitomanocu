



→ ifconfig  .... verificação configuração de rede

→ Alterando o endeeço IP... 'ip atual' 10.0.11.170....
#############
1) ifconfig wlp1s0 10.0.11.135 netmask 255.255.255.0 up...'sobe a placa de rede'. down 'desce a placa de rede'.... 
Obs: altera o ip atual dentro da sessão corrente apenas

2) dhclient wlp1s0
    Obs: renova o número de ip via dhcp



1- Interface de rede servidor
→ IP Fixo
→ Instalar opacote do  servidor DHCP:
  isc-chdp-server

2- Arquivo de configuração do  servidor DHCP:
/etc/dhcp/dhcpd.conf

-- Especificar interfaces a serem usadas.

/etc/default/isc-dhcp-server

Iniciar /parar/ reiniciar servidor dhcp

 service is-dhcp-server  start|stop|restart|status

→ localiza erro  para  vereficação no log ...

 grep dhcpd /var/log/syslog | less

→ verificar as concessões ativas

 cat /var/lib/dhcp/dhcpd.leases



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



# Vim comandos..
→ tab ball .... multiplas janelas simultâneamente...

→ gt ... mover por entre as janelas...

→ctrl w w ... cursor alterna entre janelas terminal/editor... ou mais....

→ yn ... copia n linhas
→ yw ... palavra inteira
→ yy ... linha inteira
→ dd ... recorta linha inteira
→ dw ... recorta palavra atual
→ ndd .. recorta n linhas apartir d cursor
→ D ... da posição do cursor até o final da linha...
→ cc ... recorta entra no modo inserção e cola ao entrar no modo comando...
** Usando caracteres especias..
→ :digraphs .... para ver tabela de caracteres especiais
→ ctrl + k .... shift S + * =  Σ



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
--- 10.0.11.170 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4046ms
rtt min/avg/max/mdev = 4.362/4.977/5.577/0.462 ms

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

leandro@abstract-programmer:~/bt$ sudo chmod 770 arqteste 
[sudo] senha para leandro: 
leandro@abstract-programmer:~/bt$ ls -l
total 8
-rwxrwx--- 1 leandro leandro    0 abr  9 21:12 arqteste
Permissão parcial: 
leandro@abstract-programmer:~/bt$ sudo chmod 644 arqteste 

Permissão total:
leandro@abstract-programmer:~/bt$ sudo chmod 777 arqteste
total 8
-rwxrwxrwx 1 leandro leandro    0 abr  9 21:12 arqteste

Negar permissão para todos:....
leandro@abstract-programmer:~/bt$ sudo chmod 000 arqteste
total 8
---------- 1 leandro leandro    0 abr  9 21:12 arqteste

Permitir apenas leitura e gravação...
leandro@abstract-programmer:~/bt$ sudo chmod 664 arqteste
total 8
-rw-rw-r-- 1 leandro leandro    0 abr  9 21:12 arqteste

# Criando conta de Usuário... 'passwd'

→ useradd [opções] conta
1) -c comentário: # define campo comentário (nome, usuário, telefone, etc...)

2) -d dir_home # define o diretório home do usuário

3) -m # cria e preenche o diretório home ...

4) -s bash # usa o shell como padrão da conta...

5) -e # data de inspiração define a data em que a conta so usuário será
desabilitada... formato AAAA-MM-DD

6) -u UID # UID desejada para o usuário...

Obs: Criando usuário
→ useradd -m -c "leandro hoher" -s /bin/bash leandro

7) criando senha para usuário já existente..

→ sudo passwd 'usuário'
→ 
8) bloqueio de usuário

→ sudo passwd -l 'usuário'
→ 
9) desbloqueio de usuário

→ sudo passwd -u 'usuário'
 Alterando grupo e proprietário.....

→ chgrp ( change group ) ... alterarc grupo e proprietário de arquivo e diretório...

sintáxe: 
chgrp [novo_grupo] [nome_arquivo]

chown ( change owner) ... altera proprietário do arquivo...

sintáxe:

chown [novo_proprietário] [nome_arquivo]


addgroup 

→ Adicionando usuário a grupo

local /etc/group

hoher534@hoher534-X102BA:~$ sudo addgroup blablabla
info: Selecionando GID da faixa 1000 a 59999 ...
info: Adicionando grupo 'blablabla' (GID 1003) ...
hoher534@hoher534-X102BA:~$ sudo gpasswd -a admin_test blablabla 
Adicionando usuário admin_test ao grupo blablabla

Grupos aos quais faz parte:

groups admin_test 
admin_test : admin_test sudo blablabla


Removendo usuário de grupo:

sudo gpasswd -d admin_test blablabla
Removendo usuário admin_test do grupo blablabla


userdel -> deleta usuário e diretório .

hoher534@hoher534-X102BA:~$ sudo userdel -r oliver 
userdel: oliver fila de correspondência (/var/mail/oliver) não encontrada
userdel: diretório pessoal oliver (/home/oliver) não encontrado

# Tranferência de arquivos via 'ssh' de : Servidor para Cliente....

sudo scp -r leandro@192.168.122.1:/home/leandro/Downloads/ /Documentos/ .... Obs "/Documentos/" Gerou criou diretório na raiz do sistema, para transferência dos arquivos...

Obs.2) O endereço inet 192.168.122.1 esta vinculada a placa de rede virtual ' virbr0 ' em ssh de hoher534 para leandro...


# Localização de arquivos...

- Atualização de banco de dados updatedb
→ locate bashrc

# Localização de programas...
→ whereis vim ... localiza o camwhichinho do programa assim como a pa
gina manual do mesmo...

Ou:
→ which ... demostra apenas o caminho do programa... 

# Copy in/ Copy out ... "cpio" → Criar arquivamentos...

→ ls | cpio  -ov > arquivamento.cpio 
Copia todos os arquivos do diretorio atual...

- Extrair arquivos cpio
cpio -idv < arquivamento.cpio

- Copiar arvore de diretorio inteira atual /home para outro diretorio /
find . -depth | cpio -pmdv /teste


obs: d cria diretório quando for necessário
     m retem hora de modificação de arquivos
     v modo verboso
     p modo de passagem 

- Mostrar conteúdo do arquivo
cpio -t < arquivamento.cpio

- Criar arquivo cpio no fomato TAR
ls | cpio -o -H tar> arquivo.tar
     -o opção de saída


# Umask ... Conversão de octal para binario
0022   =  000010010
→ octal  binario

NOT (000010010) = 111101101
Permissão padrão de arquivo = 666
666 = 110110110

AND lógico:
111101101
110110110
---------
110100100 = 644

umask 022 determina a permissão 644 para arquivos...

777 = 111111111  permissão para diretorios... mesma conversão para AND lógico

# Cron ...   Agendamento de tarefas ..ho..
  
→ crontab -e
Ex:
minuto / hora / dia da semanDea na / mês / ano
33     19       *               *      *  touch cronteste.txt
//      //      //               //    // /usr/bin/scriptteste.sh
-Tarefa acima designada foi agendada. executara o script apontado no caminho..
→ crontab -l => Demostra a tarefa agendada...


# Compactação de arquivos ' Gzip'

→ gzip testegzip.txt => Compacta o arquivo ' arquivos recebem a terminação ou,
na prática testesgzip.txt.gz...'


→ gzip  -d testegzip.txt.gz => Descompacta o arquivo citado...prefixo gunzip
 
# Tar - Empacotamento de arquivos

→ tar -cf arquivo_master.tar arq* ... 
→  tar -tf arquivo_master.tar .... Demostra o conteúdo do arquivo...
→  tar -rf arquivo_master.tar arquivo_solto.txt ... Anexa o novo arquivo...
→  tar -f arquivo_master.tar --delete arquivo_solto.txt ... remove o arquivo..
→  tar cvf armario.tar pasta_arq_teste_tar/ cria pasta e copia recursivamente
o conteúdo do diretorio apontado....
→  tar -cvzf gavetario.tar.gz blq*... comprime
→  tar -xzvf gavetario.tar.gz .... Descomprime os arquivos

→   tar -cvjf gavetario.tar.bz2 blq* ... usando 'bzip2', para comprimir
→   tar -xjvf gavetario.tar.bz2  ... extrai os arquivos

# Gerenciador de pacotes dpkg

→ apt-cache showpkg vim


# Run Level

- Reinicialização do sistema e finanaliação...

→ telinit0... Encerra o sistemaçy.
→ telinit6... Reinicia o sistemaç
→ telinit q ... Aplica as mudanças realizadas em /etc/inittab
→ runlevel ... Mostra o runlevel prévio e o atual...

# 'scp' (Secury Copy Protocol...)  Tranferência de arquivos via 'ssh...

scp /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134:~/
bt1.md                                        100%   15KB 303.4KB/s   00:00



cmd |caminho do arquivo no hospedeiro          | usuario/ip/local
scp /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134:~/
bt1.md                                        100%   15KB 303.4KB/s   00:00
→ Sintaxe:

1)Exemplo local para remoto: scp arquivo.txt usuario@ip:/caminho/

2)Exemplo remoto para local: scp usuario@ip:/caminho/arquivo.txt .

# Usando o método " Resync "...
→ Envia apenas as alterações posteriores ao arquivo...

rsync -avz /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134:~/

# Redirecionamento via comando 'tee'

---- Obs. sudo apt update  | tee  novoarq.txt 
- executa o camando assim como redireciona a saida para o arquivo alvo, sobscrevendo o mesmo se já houver conteúdo..


# Criando diretório e subdiretório...
sudo mkdir -p ~/web/{html,css,logs}

# Copiando arquivo 
sudo cp index.html /home/hoher534/web/logs/backup.html

# Copiand arquivo no sentido inverso do servidor...
scp /home/hoher534/anexo_bt.md leandro@10.0.11.170:~/


# Processos ps aux...
ps aux | grep ssh
root         645  0.0  0.3  15440  8648 ?        Ss   22:16   0:01 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root         755  0.0  0.3  16924 10676 ?        Ss   22:23   0:02 sshd: leandro75 [priv]
leandro+     862  0.3  0.2  17216  79576 ?        S    22:24   0:20 sshd: leandro75@pts/0
leandro+    1155 38.0  0.0   6480  2280 pts/0    S+   23:50   0:00 grep --color=auto ssh

kill  -15 645 .... Encerra o processo sshd de forma normal...
killall sshd .... Mata todos os processos relacioonados ao programa...

# Controle de tarefas...

exemplo:
bb → programa
[2627:2627:0618/210752.536954:ERROR:content/browser/network_service_instance_impl.cc:722] Network service crashed or was terminated, restarting service.
^Z → comando ...
[1]+  Parado                  brave-browser --incognito
hoher534@hoher534-X102BA:~$ bg → background 2º plano...
[1]+ brave-browser --incognito &
hoher534@hoher534-X102BA:~$ [2664:2684:0618/210958.653246:ERROR:ui/base/x/x11_software_bitmap_presenter.cc:147] XGetWindowAttributes failed for window 79691788
fg ...
brave-browser --incognito


# Expressoẽs Regulares .. Regex...
grep leandro /etc/passwd
leandro:x:1000:1000:Leandro,,,:/home/leandro:/bin/bash

# SED...

→ sed '1,2d' passwd

Demosntra o resultdo do processamento na saida padrão
Apaga as primeiras duas linhas do arquivo...


→ sed -i'1,2d' passwd

Executa o processamento diretamente no arquivo


→ sed -i /y/x/z/  passwd

entre barras estão os caracteres que seram tracados

Comando y/ traduz caracter x/ para caracter z/ de maneira global...


→ sed -i '/^#/d' passwd  ... expressão regular (/^#) ancôra inicio de linha

dentro do arquivo apaga todas as linhas comentadas...

→ sed -i '/^$/d' passwd 

apaga todos as linhas em branco do arquivo.


→ sed -s '/^$/BRANCO' passwd

substitui as linhas em branco pelo o nome da string selecionada 


→ sed -i 's/este/aquele/g' passwd

substitui o primeiro termo pelo segundo...

# Particionamento...

→ sudo fdisk -l

Disco /dev/sda: 232,89 GiB, 250059350016 bytes, 488397168 setores
Modelo de disco: WDC WD2500BEVT-6
Unidades: setor de 1 * 512 = 512 bytes
Tamanho de setor (lógico/físico): 512 bytes / 512 bytes
Tamanho E/S (mínimo/ótimo): 512 bytes / 512 bytes
Tipo de rótulo do disco: gpt
Identificador do disco: ECC783C9-3D81-4776-BE54-EF292FA8F939

Dispositivo  Início       Fim   Setores Tamanho Tipo
/dev/sda1      2048      4095      2048      1M BIOS inicialização
/dev/sda2      4096   1054719   1050624    513M Sistema EFI
/dev/sda3   1054720 488396799 487342080  232,4G Linux sistema de arquivos
Disco /dev/sda: 232,89 GiB, 250059350016 bytes, 488397168 setores
Modelo de disco: WDC WD2500BEVT-6
Unidades: setor de 1 * 512 = 512 bytes
Tamanho de setor (lógico/físico): 512 bytes / 512 bytes
Tamanho E/S (mínimo/ótimo): 512 bytes / 512 bytes
Tipo de rótulo do disco: gpt
Identificador do disco: ECC783C9-3D81-4776-BE54-EF292FA8F939

Dispositivo  Início       Fim   Setores Tamanho Tipo
/dev/sda1      2048      4095      2048      1M BIOS inicialização
/dev/sda2      4096   1054719   1050624    513M Sistema EFI
/dev/sda3   1054720 488396799 487342080  232,4G Linux sistema de arquivos
Disco /dev/sda: 232,89 GiB, 250059350016 bytes, 488397168 setores
Modelo de disco: WDC WD2500BEVT-6
Unidades: setor de 1 * 512 = 512 bytes
Tamanho de setor (lógico/físico): 512 bytes / 512 bytes
Tamanho E/S (mínimo/ótimo): 512 bytes / 512 bytes
Tipo de rótulo do disco: gpt
Identificador do disco: ECC783C9-3D81-4776-BE54-EF292FA8F939

Dispositivo  Início       Fim   Setores Tamanho Tipo
/dev/sda1      2048      4095      204::8      1M BIOS inicialização
/dev/sda2      4096   1054719   1050624    513M Sistema EFI
/dev/sda3   1054720 488396799 487342080  232,4G Linux sistema de arquivos
t

→ fdisk /dev/sdb  .... Partiona o disco.

# Netstat 

→ netstat -na --tcp 

Conexões Internet Ativas (servidores e estabelecidas)
Proto Recv-Q Send-Q Endereço Local          Endereço Remoto         Estado      
tcp        0      0 127.0.0.1:5900          0.0.0.0:*               OUÇA      
tcp        0      0 0.0.0.0:44321           0.0.0.0:*               OUÇA      
tcp        0      0 0.0.0.0:44322           0.0.0.0:*               OUÇA      
tcp        0      0 0.0.0.0:44323           0.0.0.0:*               OUÇA      
tcp        0      0 127.0.0.54:53           0.0.0.0:*               OUÇA      
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               OUÇA      
tcp        0      0 0.0.0.0:25              0.0.0.0:*               OUÇA      
tcp        0      0 0.0.0.0:21              0.0.0.0:*               OUÇA      
tcp        0      0 0.0.0.0:22              0.0.0.0:*               OUÇA      
tcp        0      0 127.0.0.1:631           0.0.0.0:*               OUÇA      
tcp        0      0 0.0.0.0:4330            0.0.0.0:*               OUÇA      
tcp        0      0 0.0.0.0:139             0.0.0.0:*               OUÇA      
tcp        0      0 0.0.0.0:445             0.0.0.0:*               OUÇA      
tcp        0      0 127.0.0.53:53           0.0.0.0:*               OUÇA      
tcp        0      0 192.168.122.1:53        0.0.0.0:*               OUÇA      
tcp        0      0 10.0.11.170:59052       10.0.11.129:22          ESTABELECIDA
tcp        0      0 192.168.122.1:46830     192.168.122.134:22      ESTABELECIDA
tcp6       0      0 :::44321                :::*                    OUÇA      
tcp6       0      0 :::44322                :::*                    OUÇA      
tcp6       0      0 :::44323                :::*                    OUÇA      
tcp6       0      0 :::80                   :::*                    OUÇA      
tcp6       0      0 :::25                   :::*                    OUÇA      
tcp6       0      0 :::22                   :::*                    OUÇA      
tcp6       0      0 :::4330                 :::*                    OUÇA      
tcp6       0      0 :::139                  :::*                    OUÇA      
tcp6       0      0 ::1:631                 :::*                    OUÇA      
tcp6       0      0 :::445                  :::*                    OUÇA      

# Sticky bit....
→ chmod 1757 diretório # permissão 1=sticky
→ find / -perm + 4000 .... localiza arquivos que contenham sticky bit ativo.


- alterando usuário:

su hoher

-alterando permissão para escrita e leitura no arquivo...
chmod 757 /home/hoher

$ ls -l /home
total 12
drwxr-xrwx   4 hoher   hoher   4096 jun 24 22:21 hoher
drwxr-x---+ 33 leandro leandro 4096 jun 24 22:23 leandro
drwxrwxr-x   2 root    users   4096 abr  7 20:22 publico
$ 

- removendo arquivo no diretorio do usuario hoher
rm /home/hoher/stick 
rm: remover arquivo comum vazio '/home/hoher/stick' protegido contra escrita? s
leandro@leandro:~/vaitomanocu/ubuntu/bt$ vim bt1.md 

$ chmod 1757 /home/hoher
echo " > testesticky
$ ls
arqteste'  testesticky
$ chmod 1757 /home/hoher → Ativação do bit stick
$
$ ls -l /home
total 12
drwxr-xrwt   4 hoher   hoher   4096 jun 24 22:43 hoher
drwxr-x---+ 33 leandro leandro 4096 jun 24 22:40 leandro
drwxrwxr-x   2 root    users   4096 abr  7 20:22 publico
$ 

 ls -l /home/hoher/
total 0
-rw-rw-r-- 1 leandro leandro 0 jun 24 22:42 arqteste
-rw-rw-r-- 1 leandro leandro 0 jun 24 22:56 arqteste2
-rw-rw-r-- 1 hoher   hoher   0 jun 24 22:43 testesticky
leandro@leandro:~/vaitomanocu/ubuntu/bt$ 

→ TEntativa de remossão do arquivo no diretório /hoher ....

rm /home/hoher/testesticky 
rm: remover arquivo comum vazio '/home/hoher/testesticky' protegido contra escrita? s
rm: não foi possível remover '/home/hoher/testesticky': Operação não permitida

$ chmod 0757 /home/hoher .... Desativa bitsticky

 ls -l /home/hoher
total 0
-rw-rw-r-- 1 leandro leandro 0 jun 24 22:42 arqteste
-rw-rw-r-- 1 leandro leandro 0 jun 24 22:56 arqteste2
-rw-rw-r-- 1 hoher   hoher   0 jun 24 22:43 testesticky

 rm /home/hoher/testesticky fere
rm: remover arquivo comum vazio '/home/hoher/testesticky' protegido contra escrita? s
leandro@leandro:~/vaitomanocu/ubuntu/bt$ 
# Trace Route ... Rota que todoes os pacates seguem 'Roteadores intermediarios'...

# Ajustando fuso-horário...
→ caminho: /usr/share/zoneinfo/Brazil...
→  sudo dpkg-reconfigure tzdata....
→ sudo vim /etc/timezone .... arquivo de edição do local...


# Gerando chave SSH..

→ sshkeygen -t dsa.... gera par de chaves
→ scp 'id_chave' servidor@ip .. transfere o aquivo via ssh para a maquina alvo
→ cat 'id_chave' >> ~/.ssh/authorized_kes

→ ssh-copy-id id_dsa.pub leandro75@192.168.xxx.xxx .... no cliente


→ ssh-agent $SHELL
→ ssh-add ... carrega as chaves privadas carregadas neste cliente...
→ ssh-add -l .... recarrega a chave e demosntra a mesma na linha de saida...

# Adiministração de usuários....

→ su hoher ... permanece no diretório do administrador /home/leandro...

→ su - hoher ... entra no diretório /home/hoher
 echo sudo chage -l hoher
Última mudança de senha					: abr 08, 2026
Senha expira					: nunca
Senha inativa					: nunca
Conta expira						: nunca
Número mínimo de dias entre troca de senhas		: 0
Número máximo de dias entre troca de senhas		: 99999
Número de dias de avisos antes da expiração da senha	: 7
