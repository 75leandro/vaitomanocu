# Comandos Internos do Vim...

#
#
#
# tab ball:
> Ativa conjunto de >wwabas na sessão corrente
# ctrl w w:
> Navega entre as abas do terminal Shell/ Editor vim
# source / so%:
> Carrega as alterações do arquivo...
# bn
> Mantém o buffer da sessão, arquivos abertos

# Movimentação do Cursor.....

→ Inicío de linha: 0 <home>
→ Fim de linha   : $ <end>
→ Página anterior: <C-b>
→ Próxima página : <C-f>
→ Início do próximo buffer: gg
→ Fim do buffer : G

# Seleção de texto:...

→ Seleção de Caracteres: <v><direções>
→ seleção de linhas: <V><direções> (para cima ou para baixo)
→ Seleção de blocos: <C-v><direções>

# Recortar(delete) e copiar(yank)

→ Seleções: 

* selecionanado área : vi 'caracter ou simbolo':
* Seleção e delete :  dt'caracter  ou simbulo' seleciona e deleta o trecho marcacdo...:w
* Copiar : y
* Recortar : d
* Deleta parágrafo inteiro : d} ....
* Colar após cursor : P
* Colar antes do cursor: p

* Recortar a linha corrente   : dd
* Copiar a linha corrente : yy

* Recortar várias linhas abaixo: <#linhas>dd ou d<#linhas>j
e Copiar várias linhas abaixo : <#linhas>yy ou y<#linhas>j

* Recortar várias linhas acima: d<#linhas>k
* Copiar várias linhas acima: y<#linhas>k


# Desfazer/refazer
* Desfazer : u
* Refazer : <C-u>

# Abrir e fechar arquivos...

* $ vi <arquivo> Abrir o arquivo pela linha de comandos
* :e <arquivo>   Abrir ou criar arquivo
* :bd!           Fechar arquivo corrente sem salvar
* :bd            Fechar arquivo corrente
* :bp            Retorna ao arquivo anterior 'buffer prewius'
* :bn            Avança 'buffer next'...:
* :ctrl 6       alterna entre os ul:tímos dois buffers abertos...
# Sair e salvar...

* :w [nome]<cr>  Salvar
* :sav  <novo_nome><cr>  Salvar como...
* :x [nome]<cr> ou :wq[nome]<cr> Salvar  e sair
* :q!                   Sair sem salvar
* :q                    Sair


# Trabalhando com multiplas janelas...

* vim -o : janela Horizontal
* vim -O : janela Vertical

* vim -o(n) : define número de janelasna sessão. vim -o3 / Três janelas

              * vim -p : :abrir em :abas laterais
              *        ( ctrl page up/ page down → movimentação  entre as abas ou 'gt'...


                      *  :q → fecha janela 
                      *  :qa → fecha todas as janelas da sessão 

# Trabalhando com Buffers...

                      * :bn → buffer next > próxima aba na sequência aberta
                      * :b(n1) → abre o buffer  relacionado ao número:
                      * :only → destaca apenas a janela corrente.
                      * :30Lex → Abre árvore do diretório comjanela acoplada... ('Lex'. Left Explorer)
# Busca e substituiçãode comandos...

                      → ciw .. apaga a palavra marcada pelo cursor  


# Transferindo dados entre arquivos...

                      → r   /home/leandro/vaitomanocu/cbsg/vim/test ... append no arquivo...
              → 0r   /home/leandro/vaitomanocu/cbsg/vim/test ... anexa ao inćio... 

# Abrindo arquivos recentes...
→ '0 ....abre o ultímo arquivo maniplado...
→ '1 .... penultimo ...

# Comparando arquivos com vimdiff

→ vimdiff 'nome projeto' scp://usuario@estacao//caminho/projeto

# Busca referenciada por 'caracter'
→ f'char' ... aponta para o primero caracter semelhante  na linha corrente

# Criando cabeçario de testos...
→ :.!figlet -f slant

/bin/bash: linha 1: figlet: comando não encontrado

# Mudando formato e texto...
→ set ft=markdown

# ex)  este arquivo tem...

.,.+2! while read l o; do echo $(wc $ %o) $l; done | sed s'/% //' | column -t -s 

121   linhas
522   palavras
3403  caracteres

# Criação, permissão e escrita direta no arquivo....

 echo '#!/bin/bash' > arq_tes; chmod +x arq_tes; vim arq_tes
 #------------------------------------------------------------------
# Automatizando Scripts...
# Testando número de argumento para a nomeação de arquivos...

# Opções:

editor="vim"

# Variáveis:

dia_de_hoje=$( date +'%d/%m/%Y' )

header="#!/bin/bash
#----------------------------
# Script   :
# Descrição :
# Versão    : 0.01
# Autor     : Leandro 
# Data      : $dia_de_hoje
# Licença   : GNU/GPL v3.0
#-----------------------------------
# Uso :
#--------------------------------
"
 [[ $# -ne 1 ]] && echo " apenas *1* nome para o arquivo! " && exit 1

# Testar se o arquivo já existe...

 [[ -f $1 ]] && echo "arquivo já existe! Saindo! " && exit 1
 echo "$header" > $1
 chmod +x $1
 $editor $1

 exit 0  

# Filtrando arquivos

→ shopt globstar ... mostra o estado da flag
  shopt globstar off

→ shopt -s globstar  (-s → set) / shopt -u globstar (-u → unset)
  shopt globstar on

→ Filtro: ~/**/*.md
  Busca no diretório atual  e subsequentes pelo arquivo...,



# Leitura  de arquivo via loop while lendo entrada via read....

→ while read; do echo $REPLY; done < texto.... Lê todas as linhas o arquivo...

#  Redirecionamento personalizado....

→ Abrindo e escrevendo no descritor arquivo: exec 3> escrita.txt
→ echo teste >&3
cat escrita.txt
saida
teste
→ echo teste1 >&3
cat escrita.txt
saida
teste
teste1
→→→ o arquivo permanece aberto podendo receber mais entradas de linha...
→ echo teste2 >&3
cat escrita.txt
saida
teste
teste1
teste2
→→ Fechando o descritor  de arquivos
→ exec 3>&-
* Obs. 
→ exec 3> escrita.txt
cat escrita.txt
"0" - Apaga os dados do  arquivo ....

*** Acompanhando o redirecionamento
ls -l /proc/$$/fd
#-----------------------------------------
# Criando Função de entrada direta em arquivo....

escreve() {echo $1 ;} >> $2

→ escreve 'blablabla' bla.txt

Ou..... Expansão condicional: se nao houver o argumento do nome padrão;;; novo bla.txt2:

escreve() {echo $1;} >> ${2:-bla.txt}


## ENUNCIADO....


##  PROCEDIMENTO....

## IMPLEMENTAÇÂO....
→ Gerar um número aleatório entre 1 e 100...

na=$((RANDOM % 100 + 1))

→ Solicitar a entrada de um número entre 1 ou 0,,,
while :; do
    
     read palpite 

→ Verificar se o número esta entre a faixa solicitada...

((palpite >= 1 && palpite <= 100)) || { 
    echo 'Fora da faixa pedida (0-100)!'
    continue
}

→ Incrementar a quantidade de tentavas....

((qtd++))

→ COmparar o número  informado como número aleatório...

[[ $palpite -eq $na ]] && {
    echo "Acertou em $qtd tentativas(s)!"
    exit
}    

[[ $palpite -lt $na ]] &&  comp=menor || comp=maior
    echo "spalpite é o $comp do que o número secreto."
   
done
------------------------------------------------------------------

# Descrever todos o processos que poderiam levar a esta implementação
do scriptdo exercício anterior....

# Options:

range_min=${1:-1}
range_max=${2: -100}

# Strings:

range_out="Fora da faixa  de palpites ($range_min-$range_max)!"
guess_prompt="Digite um número entre ($range_mi-$range_max): "

guess_win='Você acertou em %s tentativa(s)!'
msg_error='%s é %s do que número  secreto....'

guess_error=(menor maior)

# Functions:

get_guess() { read -p "guess_prompt" guess; }

# 3°

:

