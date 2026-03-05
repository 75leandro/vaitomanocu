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







