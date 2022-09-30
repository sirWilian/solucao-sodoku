# Checa sodoku  
###### esse programa recebe como entrada uma matriz de inteiros 9x9 e verifica se é uma solução para o problema do sodoku.
-------------------------------------------------------------
para rodar o programa, você deve¹ ter instalado
algum compilador pascal em seu computador.
É recomendado o "free pascal", e para instalá-lo,
em sistemas baseados no debian, é algo simples:

> 1. abra um terminal (Ctrl + Alt + T);
> 2. digite "sudo apt install fpc";

para compilar o programa você precisará rodar o
seguinte comando:

```bash    
    fpc "nome-do-seu-programa.pas"
    fpc verifica-solucao-sodoku.pas
```
para rodar o programa utilize:
```
    ./verifica-solucao-sodoku
```

-------------------------------------------------------------
o programa pode receber dois tipos de entradas:

    1. Um arquivo .txt
        ./verifica-solucao-sodoku < possivel-solucao.txt

    2. Matriz digitada manualmente 
        digite todos os 81 números, e assim que você digitar o último deles, pressione enter.

¹ - você também pode copiar o código fonte e colar em algum
compilador pascal online, mas dessa maneira é obrigatório
que a matriz seja inserida manualmente. 
