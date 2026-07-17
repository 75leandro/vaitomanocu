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

sudo deluser --remove-home oliver .. remoção completa do sistema ..
# Tranferência de arquivos via 'ssh' de : Servidor para Cliente....

sudo scp -r leandro@192.168.122.1:/home/leandro/Downloads/ /Documentos/ .... Obs "/Documentos/" Gerou criou diretório na raiz do sistema, para transferência dos arquivos...

Obs.2) O endereço inet 192.168.122.1 esta vinculada a placa de rede virtual ' virbr0 ' em ssh de hoher534 para leandro...


# Localização de arquivos...

- Atualização de banco de dados updatedb
→ locate bashrc
38






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

# Alterando permissão de usuarios ... comando 'chage'...


→ sudo chage -l hoher

Última mudança de senha					: abr 08, 2026
Senha expira					: nunca
Senha inativa					: nunca
Conta expira						: nunca
Número mínimo de dias entre troca de senhas		: 0
Número máximo de dias entre troca de senhas		: 99999
Número de dias de avisos antes da expiração da senha	: 7ração...

# comando visudo... habilita usuário para comandos especificos....

→ executar visudo no arquivo /etc/sudoers
→ em * user privilege specification:
ex:
root  ALL=(ALL:ALL) ALL
hoher ALL=(ALL) ALL
outro ALL=(root) !/sbin/fdisk .... Não tera perimissão apenas para execução
do comando especifico...
    
sudo addgroup blablabla
[sudo] senha para leandro:       
info: Selecionando GID da faixa 1000 a 59999 ...
info: Adicionando grupo 'blablabla' (GID 1003) ...

 which apt-get
/usr/bin/apt-get

→ adionando usuario ao grupo

sudo adduser hoher blablabla
info: Adicionando usuário 'hoher' ao grupo 'blablabla' ...
→ usando o visudo no arquivo /etc/suders 
marcar o seguinte comentario...
'# Permitir que menbros do grupo blablabla usem o apt-gett
%blablabla ALL=(root) /usr/bin/apt-get

→ usando visudo abaixo do comentário # Cmnd alias especification...
Cmnd_Alias FIREWALL = /sbin/iptables,

→ adicionando regra de entrada para o alias no usuario.

outro ALL=(root) !/sbin/fdisk, FIREWALLL 

fuser -v .
                     USUÁRIO     PID ACESSO COMANDO
/home/leandro/Documentos:
                     leandro    6043 ..c.. bash
                     leandro   13826 ..c.. gnome-calculato
                     leandro   13865 ..c.. gedit
leandro@leandro:~/Documentos$ sudo fuser -ki . 
[sudo] senha para leandro:       

/home/leandro/Documentos:  6043c 13826c 13865c 13918c 13919c
Matar o processo 6043? (y/N) n
Matar o processo 13826? (y/N) y
Matar o processo 13865? (y/N) y
Matar o processo 13918? (y/N) 
Matar o processo 13919? (y/N) y 
sudo: unable to execute /usr/bin/fuser: Connection reset by peer
[1]-  Morto                   gnome-calculator
[2]+  Morto                   gedit testearquivos
leandro@leandro:~/Documentos$ 

 fuser -v .
                     USUÁRIO     PID ACESSO COMANDO
/home/leandro/Documentos:
                     leandro    6043 ..c.. bash

→ vereficando acesso remoto....

sudo fuser -v -n tcp 22
                     USUÁRIO     PID ACESSO COMANDO
22/tcp:              root          1 F.... systemd
                     root       1103 F.... sshd


sudo fuser -ki  22/tcp .... encerra o sshd...

# Comando xargs.....

seq 6 | xargs -n2
1 2
3 4
5 6

find . -type f | xargs -n 1 grep bt1.md
scp /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134:~/
bt1.md                                        100%   15KB 303.4KB/s   00:00
scp /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134:~/
bt1.md                                        100%   15KB 303.4KB/s   00:00
rsync -avz /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134:~/
 bt1.md
 bt1.md
scp /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134:~/
bt1.md                                        100%   15KB 303.4KB/s   00:00
scp /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134:~/
bt1.md                                        100%   15KB 303.4KB/s   00:00
rsync -avz /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134:~/
leandro@leandro:~/vaitomanocu/ubuntu/bt$ vim bt1.md 
grep: ./chave: Arquivo ou diretório inexistente
grep: de: Arquivo ou diretório inexistente


# Awk filtro de texto....

awk '/leandro/' sep-lin-texto.txt 
leandro:Leandro,,,:/home/leandro:/bin/bash
leandro:Leandro:/home/leandro:/bin/bash
leandro  Leandro   /home/leandro  /bin/bash
leandro  Leandro   /home/leandro  /bin/bash
leandro:x:1000:1000:Leandro,,,:/home/leandro:/bin/bash
leandro:Leandro,,,:/home/leandro:/bin/bash
leandro:Leandro,,,:/home/leandro:/bin/bash
leandro:Leandro,,,:/home/leandro:/bin/bash
leandro:Leandro,,,:/home/leandro:/bin/bash
leandro:Leandro:/home/leandro:/bin/bash
leandro  Leandro   /home/leandro  /bin/bash

→ filtro 'case_sensitive'.... para maiúsculas e minusculas...
awk '/[lL]eandro/' sep-lin-texto.txt

→ Ou usando  a variável de ambiente ' BEGIN{IGNORECASE=1}

awk 'BEGIN{IGNORECASE=1} /leandro/' sep-lin-texto.txt 
leandro:Leandro,,,:/home/leandro:/bin/bash
leandro:Leandro:/home/leandro:/bin/bash
leandro  Leandro   /home/leandro  /bin/bash
leandro  Leandro   /home/leandro  /bin/bash
leandro:x:1000:1000:Leandro,,,:/home/leandro:/bin/bash
leandro:Leandro,,,:/home/leandro:/bin/bash
leandro:Leandro,,,:/home/leandro:/bin/bash
leandro:Leandro,,,:/home/leandro:/bin/bash
leandro:Leandro,,,:/home/leandro:/bin/ba'sh

awk '!/leandro/' sep-lin-texto.txt ....ignora a string 'leandro' em todo texto

→ busca apenas a string n começo de cada linha...

 awk '/^[lL]ib/' sep-lin-texto.txt 
Libvirt Qemu,,,
Libvirt Dnsmasq,,,
Libvirt Qemu,,,
Libvirt Dnsmasq,,,


- demostra um evento especifico após o horário filtrado..

awk '/20:38$/' sep-lin-texto.txt

→ filtra saída com o número especififcos de digítos...

 awk '/[0-9]{4}/' sep-lin-texto.txt 
leandro:x:1000:1000:Leandro,,,:/home/leandro:/bin/bash
juliana:x:1001:1001:Juliana',,,:/home/juliana:/bin/bash
dom 28 jun 2026 20:38:09 -03

→ filtra linhas que contenham os caracteres maiscúlos...

 awk '/[A-D]/' sep-lin-texto.txt

awk '/^[LJ]/' sep-lin-texto.txt 

→ filtra por endereços de email...

awk '/[@]/' sep-lin-texto.txt 

→ Comando correto para o redirecionamento da saída

awk '/[@]/' .bash_history >> /home/leandro/vaitomanocu/ubuntu/bt/bt1.md

sudo scp -r leandro@10.0.11.129:/home/leandro/Downloads/ /Documentos/
sudo scp -r leandro@192.168.122.1:/home/leandro/Downloads/ /Documentos/
sudo scp -r leandro@192.168.122.1:/home/leandro/Downloads/ /Documentos/
sudo scp -r leandro@192.168.122.1:/home/leandro Documentos/
ssh X hoher@10.0.11.190
ssh -X hoher@10.0.11.190
ssh -X hoher@10.0.11.190
ssh -X hoher534@10.0.11.190
ssh -X hoher@10.0.11.190
ssh -X hoher@10.0.11.129
ssh -X hoher@10.0.11.129
ssh -X hoher@10.0.11.129
ssh -X hoher534@10.0.11.129
ssh leandro75@192.16u.122.172
ssh leandro75@192.16u.122.172/24
ssh leandro75@192.168.122.172
ssh leandro75@192.168.122.172
ssh leandro75@192.168.122.172
ssh leandro75@192.168.122.172
ssh leandro75@192.168.122.172
ssh leandro75@192.168.122.172
ssh leandro75@192.168.122.172
ssh leandro75@192.168.122.172
ssh leandro75@192.168.122.172
ssh -l leandro75@192.168.122.172
ssh-copy-id leandro75@192.168.122.134
ssh leandro75@192.168.122.134
scp /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134 /home/leandro75
scp /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134 /
sudo scp /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134 /
rsync -avz /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@192.168.122.134:~/
rsync -avz /home/leandro/vaitomanocu/ubuntu/bt/bt1.md leandro75@1.168.122.134:~/
ssh leandro75@192.168.122.134
ssh leandro75@192.168.122.134
ssh -T git@github.com
ssh -T git@github.com
leandro@leandro:~$ echo " sudo addgroup blablabla
leandro@leandro:~$ 

→ sintáxe que conta a acorrência de strings dentro do arquivo...

 awk '/[@]/ {count ++} END {print count}' .bash_history

 

### Comando de expansão de sintaxe direto o editor....

→ :r! ctrl-r shift-l Enter...digitar de forma consecutiva teclas de atalho



