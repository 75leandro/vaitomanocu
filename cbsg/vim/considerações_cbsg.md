
# Observações iniciais:

* Variáveis Especiais...

- $$ → PID
- $? → N° status saída
- $0 → Armazena nome do Programa
- $n → N° atribuido ao argumentos por ordem de ocorrência
- $# → Armazena n° de argumentos passados para o script...

#--------------------------------------------------

* Expansão de lista de variáveis...
- Uso de chaves e colchetes com n° indíce.

- fruta=("blalblabla" "blabla" "bla")
- echo $fruta
- blalblabla

- echo ${fruta[2]}
- blabla

- echo ${!fruta[@]}
- 3

- → quantidade de elementos: ${#nome[@]}
- → lista todos os valores:  ${nome[@|*]}
- → lista todos os indíces:  ${!nome[@|*]}

-
** Variáveis  associativas....

---> carro[vw]="fusca"
- → unset carro,,,

--> Obs: declare -p var .... '-p' atributos e propriedades ...

---> declare -A carro

---> carro[vw]="fusca"
---> carro[fiat]="147"
---> carro[ford]="corcel 74"
- echo ${carro[fiat]}
- 147
- echo ${carro[ford]}
- corcel 74

- echo ${#carro[@]}
- 3

- echo ${carro[@]}
- fusca corcel 74 fiat 147

- echo ${!carro[@]}
vw fiat ford

- declare -A origem

- origem[vw]=alemanhã
- indice=vw
- echo "${carro[$indice]} - ${origem[$indice]}"
--> fusca - alemanhã


----------------------------------------------------

# Loop for in lista


for argumento; do
    echo $argumento
done

exit 0

→ Chamada: ./loop_for arg1 $1, arg2 $2, arg3 $3, arg... $...

---------------------------------------------------

# Loop for 'expressão aritmética'
-- Enquanto condição n <= 10 for verdadeira....
 
for (( n = 1; n <= 10 ; n++ )); do
     echo $n
done

-- Ou, mesma consequência... usando a expansão de {}.

for n in {1..10..}; do
    echo $n
done

--------------------------------------------------

# Loop for ' break / continue....

-->  BREAK
for n in {1..10}; do
     [[ $n -gt 5 ]] && break || echo $n
done

--> CONTINUE
for n in {1..10}; do
    [[ $n -lt 6 ]] && continue || echo $n
done

---------------------------------------------------------------



# Loop while

--> WHILE - Enquanto a condição 'n' for  verdadeira faça...

n=0
while [[ $n -lt 5 ]]; do
    echo $n
       ((n++))
done


--> UNTIL - Enquanto a condição 'n' for falsa faça...
n=0
until [[ $n -eq 5 ]]; do
    echo $n
       ((n++))
done

cut: o delimitador deve ser um único caractere
Tente "cut --help" para mais informações.
Tente "cut --help" para mais informações.
-------------------------------------------------------

# Lista de pacotes/ Administração do sistema...

* sudo apt edit-sources '.*'
* apt list --installed | grep ^python.....  filtra programa indicado no inicio da frase
* apt-cache search --names-only 'w3m'
* apt install 
* apt purge .... desinstalação do pacote.
* sudo hostnamectl set-hostname 'xxxxxx' ..... altera o log de nome...
* sudo nano /etc/hosts .... altera o nome direto no arquivo manualmente....


# Baixar Legendas de Video e Aúdio...

* yt-dlp 

# Disponibilidade de Ips...

* sudo virsh net-dhcp-leases default

# Linguagens de programação...

* Assembly →→ Linguagem de baixo nível...
* 
* ASSEMBLER →→ MONTADOR PROGRAMA
* LINKER    →→ LIGADOR
---> Etapas que geram arquivos compilados

# Editores de Texto

* Marcador de númeração de linhas: alt shift # .... abre a marcação de orientação de linhas,

=== Gerando scripts  via linha de comando...
     echo $'#!/bin/bash\n\n\\n' > texto1.txt; nano +3 texto1.txt
*                     → 03 quebras de linha...


# Escrevendo arquivos com utilitários...

* Ex.1)

* cat << MARCA >> heardoc_redirecionamento.md
> [] item primário
> [] item secundárimum

MARCA



leandro:x:1000:1000:Leandro,,,:/home/leandro:/bin/bash


# Ordenação dos Cursos:

→ 1°) - Cusrso basíco programação Shell
→ 2°) - Curso Shell Gnu
→ 3°) - Curso intensivo de progamação em bash → 4°) - Curso shell Gnu Linux



