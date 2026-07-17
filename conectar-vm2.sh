#!/bin/bash

VM_NAME="ubuntu22.04"
USER="leandro75"
MAX_WAIT=180  # Aguarda até 2 minutos

echo "🚀 Iniciando VM: $VM_NAME..."
sudo virsh start $VM_NAME

echo "⏳ Aguardando IP e Serviço SSH..."
START_TIME=$SECONDS
IP=""

while true; do
    ELAPSED=$((SECONDS - START_TIME))
    if [ $ELAPSED -gt $MAX_WAIT ]; then
        echo "❌ Tempo esgotado. Não foi possível conectar."
        exit 1
    fi

    # Tenta pegar o IP
    IP=$(virsh domifaddr $VM_NAME | grep 'ipv4' | awk '{print $4}' | cut -d'/' -f1)
    
    if [ -n "$IP" ]; then
        echo "✅ IP detectado: $IP"
        echo "🔍 Verificando se a porta SSH (22) está aberta..."
        
        # Tenta conectar à porta 22 (teste de porta)
        if nc -z -w 2 $IP 22 2>/dev/null; then
            echo "✅ Porta SSH aberta! Conectando..."
            ssh $USER@$IP
            exit 0
        else
            echo "⏳ IP existe, mas SSH ainda não está pronto. Aguardando... (${ELAPSED}s)"
        fi
    fi
    
    sleep 5
done
