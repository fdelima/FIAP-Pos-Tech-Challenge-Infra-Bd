FROM mcr.microsoft.com/mssql-tools
COPY ["Scripts/micro-servico-pedido/init-database.sh", "./tmp/init-database.sh"]
COPY ["Modelagem-banco-de-dados/micro-servico-pedido/tech-challenge-mer-1.sql", "./tmp/tech-challenge-mer-1.sql"]
COPY ["Modelagem-banco-de-dados/micro-servico-pedido/tech-challenge-mer-2.sql", "./tmp/tech-challenge-mer-2.sql"]
ENTRYPOINT ["/bin/bash", "./tmp/init-database.sh"]