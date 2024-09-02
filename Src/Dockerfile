FROM mcr.microsoft.com/mssql-tools
COPY ["init-database.sh", "./tmp/init-database.sh"]
COPY ["tech-challenge-mer-1.sql", "./tmp/tech-challenge-mer-1.sql"]
COPY ["tech-challenge-mer-2.sql", "./tmp/tech-challenge-mer-2.sql"]
ENTRYPOINT ["/bin/bash", "./tmp/init-database.sh"]