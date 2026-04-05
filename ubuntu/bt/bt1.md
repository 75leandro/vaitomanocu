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

        






