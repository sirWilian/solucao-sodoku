(*  Programa que le uma matriz 9x9 e determina 
    se é uma solução para o sudoku ou não.*)
program sudoku;

const   MAX = 9;
        VALIDO = 1;
        INVALIDO = 0;

type 
    tpmatriz =  array [1..MAX, 1..MAX] of integer;
    elemento = longint;
    conjunto = array [0..MAX+1] of elemento;

var
    m	    : tpmatriz;
    ok	    : boolean;
    lin, col : integer;

(* ----------------------------------------------
    TAD Conjunto
   --------------------------------------------- *)
procedure inicializar_conjunto (var c: conjunto);
(* cria as estruturas necessarias para o tipo conjunto.
    custo: constante. *)
begin
    c[0]:= 0;
end;

function cardinalidade (c: conjunto): longint;
(*  retorna a cardinalidade do conjunto c 
    custo: constante. *)
begin
    cardinalidade:= c[0];
end;

function pertence (x: elemento; c: conjunto): boolean;
(* retorna true se x pertence ao conjunto c e false caso contrario.
    como a estrutura esta ordenada é feita uma busca binária.
    custo: proporcial ao logaritmo do tamanho do conjunto. *)
var ini, fim, meio: longint;
begin
    ini:= 1;
    fim:= c[0];
    meio:= (ini + fim) div 2;
    while ((ini <= fim) and (x <> c[meio])) do
    begin
        if (x < c[meio]) then
            fim:= meio - 1
        else
            ini:= meio + 1;
        meio:= (ini + fim) div 2;
    end;
    if (ini <= fim) then
        pertence:= true
    else
        pertence:= false;
end;

(* insere o elemento x no conjunto c, mantem os elementos ordenados. *)
procedure inserir (x: elemento; var c: conjunto);
var i: longint;
begin
    if (not pertence (x,c)) then
    begin
        i:= c[0];
        while ((i >= 1) and (x <= c[i])) do
        begin
            c[i+1]:= c[i];
            i:= i - 1;
        end;
        (* agora pode inserir x *)
        c[i+1]:= x;
        c[0]:= c[0] + 1;
    end;
end;

(* le a matriz Sudoku e retorna VALIDO se todos
    os valores estão no intervalo [1,9] e 
    INVALIDO, caso contrario *) 
function leMatriz(var m: tpmatriz): integer;
var   
    l, c: integer;
begin
    for l:=1 to MAX do
        for c:=1 to MAX do
        begin
	        read(m[l,c]);
        end;
    for l:=1 to MAX do 
        for c:=1 to MAX do
            if m[l,c] > 9 then
                leMatriz:= 0
            else if m[l,c] < 1 then
                leMatriz:= 0
            else
                leMatriz:= 1;
end;

function linhaOK(var m : tpmatriz; lin: integer ): boolean;
var
    c: conjunto;
    i: integer;
begin
    inicializar_conjunto(c);
    for i:=1 to 9 do
        inserir(m[lin,i], c);
    if (cardinalidade(c)= 9) then
        linhaOK:= true
    else
        linhaOK:= false;
end;

function colunaOK(var m : tpmatriz; col: integer ): boolean;
var
    c: conjunto;
    i: integer;
begin
    inicializar_conjunto(c);
    for i:=1 to 9 do
        inserir(m[i,col], c);
    if (cardinalidade(c) = 9) then
        colunaOK:= true
    else
        colunaOK:= false;
end;

function submatrizOK(var m : tpmatriz; lin, col: integer ): boolean;
var
    c: conjunto;
    linha, coluna: integer;
begin
    inicializar_conjunto(c);
    for linha:=lin to lin+2 do
        for coluna:=col to col+2 do
        begin
            inserir(m[linha, coluna], c);
            if (cardinalidade(c) = 9) then
                submatrizOK:= true
            else
                submatrizOK:= false;
        end;
end;

begin
    ok:= leMatriz(m) = VALIDO;
    lin:= 1;
    while ((lin <= 9) and ok) do
    begin
        ok:= linhaOK(m, lin);
        lin:= lin + 1;
    end;
    col:= 1;
    while ((col<=9) and ok) do
    begin
        ok:= colunaOK(m, col);
        col:= col + 1;
    end;
    lin:= 1;
    while ((lin <= 9) and ok) do
    begin
        col:=  1;
        while ((col <= 9) and ok) do
        begin
	        ok:= submatrizOK(m, lin, col);
	        col:= col + 3;
        end;
        lin:= lin + 3;
    end;
    if ok then
        writeln( 'solucao correta' )
    else
        writeln( 'preenchimento incorreto' );
     
end.