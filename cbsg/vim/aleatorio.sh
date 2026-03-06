#!/bin/bash

# Decrever todos os processos que poderiam  levar a esta  implementação
# do script 'Jogo.sh', do exercício anterior...

# Options~~~~~~~~~~~~~~~~

range_min=${1:-1}
range_max=${2:-100}

# Strings-----------------------------

range_out="Fora da faixa de palpites ($range_min-$range_max)!"
guess_prompt="Digite um número entre ($range_min-$range_max): "

guess_win='Você acertou em %s tentativa(s)!'
msg_error='%s é %s do que o número secreto!...'

guess_error=(menor maior)

# Functions ------------

get_guess() { read -p "$guess_prompt" guess; }

round_inc() ((rounds++))

check_range() (($1 >= range_min && $1 <= range_max))

game() {
     # echo $sn:$rounds:$guess   # <--- apenas para teste!
     round_inc
     get_guess
     check_range $guess || { echo $range_out; game;}
     [[ $guess -eq $sn ]] && { printf "$guess_win\n\n" $round; exit; }
     printf "$msg_error\n\n" $guess ${guess_error[guess > sn]}
     game
 }

 main() {
      clear
      sn=$(( RANDOM % $range_max + $range_min))
      game
 }

# Main------------------

main




