FROM mcr.microsoft.com/mssql-tools
COPY ["Scripts/init-database.sh", "./tmp/init-database.sh"]
COPY ["Modelagem-banco-de-dados/tech-challenge-mer-1.sql", "./tmp/tech-challenge-mer-1.sql"]
COPY ["Modelagem-banco-de-dados/tech-challenge-mer-2.sql", "./tmp/tech-challenge-mer-2.sql"]
ENTRYPOINT ["/bin/bash", "./tmp/init-database.sh"]