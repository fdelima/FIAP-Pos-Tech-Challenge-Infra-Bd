#!/bin/bash

#AZURE_CLIENT_ID: {{ secrets.AZURE_CLIENT_ID }}
#AZURE_TENANT_ID: {{ secrets.AZURE_TENANT_ID }}
#AZURE_SUBSCRIPTION_ID: {{ secrets.AZURE_SUBSCRIPTION_ID }}

#AZURE_SA_USER: {{ secrets.AZURE_SA_USER }}
#AZURE_SERVER_NAME: {{ secrets.AZURE_SERVER_NAME }}

#DOCKER_USERNAME: {{ secrets.DOCKER_USERNAME }}
#DOCKER_TOKEN: {{ secrets.DOCKER_TOKEN }}

#SERVER_NAME: {{ secrets.SERVER_NAME }}
#TEST_SERVER_NAME: {{ secrets.TEST_SERVER_NAME }}
#SA_USER: {{ secrets.SA_USER }}
#SA_PASSWORD: {{ secrets.SA_PASSWORD }}


echo "Aguarde até a execução do DER"
echo "Aguardando serviço sqlserver ficar pronto."
sleep 5
echo "Executando der"

echo "Executando part 1"
/opt/mssql-tools/bin/sqlcmd -S {{ secrets.TEST_SERVER_NAME }} -U {{ secrets.SA_USER }} -P {{ secrets.SA_PASSWORD }} -d master -i /tmp/tech-challenge-mer-1.sql
exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo "Executando part 2"
    sleep 5
    /opt/mssql-tools/bin/sqlcmd -S {{ secrets.TEST_SERVER_NAME }} -U {{ secrets.SA_USER }} -P {{ secrets.SA_PASSWORD }} -d tech-challenge-micro-servico-cadastro-grupo-71 -i /tmp/tech-challenge-mer-2.sql
    echo "DER executado :: Successfully " $exit_code
else
for (( i = 1; i <= 3; i++ ))
do 
    sleep 5
    echo "Executando der :: Nova tentativa :: " $i
    echo "Executando part 1"
    /opt/mssql-tools/bin/sqlcmd -S {{ secrets.TEST_SERVER_NAME }} -U {{ secrets.SA_USER }} -P {{ secrets.SA_PASSWORD }} -d master -i /tmp/tech-challenge-mer-1.sql
    exit_code=$?
    if [ $exit_code -eq 0 ]; then
        echo "Executando part 2"
        sleep 5
        /opt/mssql-tools/bin/sqlcmd -S {{ secrets.TEST_SERVER_NAME }} -U {{ secrets.SA_USER }} -P {{ secrets.SA_PASSWORD }} -d tech-challenge-micro-servico-cadastro-grupo-71 -i /tmp/tech-challenge-mer-2.sql
        echo "DER executado :: Successfully " $?
        break
    fi
done
fi
