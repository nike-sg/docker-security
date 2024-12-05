# Dockerfile Security Tests
Este Dockerfile contém as ferramentas necessárias para realizar os testes de segurança.

### Contém: 
- Apache Benchmark (ab) (Teste de Desempenho)
- SQLMap (Teste de SQL Injection)
- Hydra (Teste de Força Bruta)
- Nmap (Teste de Firewall e redes)
- Ferramentas para testes de headers de segurança (cURL, etc.)
- Configuração de firewall e análise de logs (ex.: Fail2Ban e utilitários como grep, less)

### IMPORTANTE
O Git não permite subir arquivos grandes, assim sendo deve-se encontrar um arquivo de senhas comuns e colocar na raiz do projeto para rodar o Docker.
O arquivo de senhas `passwords.txt`, tem um pequeno, mas para um teste mais efetivo o ideal é achar um grande. 
Busque pelas Keywords: passwords-list, wordlists, ... 

### Comandos Docker
Considerando que o Docker já esteja instalado em sua máquina.
- Build
```docker build -t ferramentas-seguranca:ubuntu .```

- Executar
```docker run -it --rm ferramentas-seguranca:ubuntu```

Após a máquina estando UP é só realizar os testes


### Testes

- Apache Benchmark (Alterar URL)
```ab -n 1000 -c 10 https://URL.com.br/```

- SQLMap (Alterar URL)
```sqlmap -u "https://URL.com.br/" —dbs —dbms=mysql —level=3 —risk=2 --tamper="space2comment,randomcase" —output-dir=reports/```

- SSL (Alterar URL)
```openssl s_client -connect URL.com.br:443```

- Hydra  (Alterar URL)
```hydra -l suporte -P passwords.txt -f URL.com.br https-post-form "/:login=^USER^&senha=^PASS^:F=Dados incorretos"```

- Medusa
SSH (Alterar IP_ALVO)
```medusa -h IP_ALVO -u root -P passwords.txt -M ssh -t 4 -vV -f -O medusa-results.txt```

FTP (Alterar IP_ALVO)
```medusa -h IP_ALVO -u root -P passwords.txt -M ftp -t 4 -vV -f -O medusa-results.txt```

MySQL (Alterar IP_ALVO)
```medusa -h IP_ALVO -u root -P passwords.txt -M mysql -t 4 -vV -f -O medusa-results.txt```

- Nmap
Completo
```nmap -A IP_ALVO```

O terminal ficará travado realizando o procedimento, porém não mostrará que está funcionando. Ao pressionar enter ele mostará o status.
```nmap -sS -p- IP_ALVO```

Caso queira realizar um teste de uma/umas portas específicas 
```nmap -sS -p 53,161 IP_ALVO```

Varredura SYN + Detecção de Versão e Sistema Operacional
```nmap -sS -sV -O IP_ALVO```

Varredura UDP + Detecção de Serviços + Scan de Firewall
```nmap -sU -sV -T4 IP_ALVO```

Varredura Completa com Scripts e Detecção de Sistema Operacional
```nmap -A -O IP_ALVO```