                      /*LUKAS MARTINS DA SILVA*/

/*1) Cite e explique para que serve pelo menos 8 objetos de banco de dados oracle.*/

/*Tables: objetos principais, armazenam e organizam os dados.
Constraint: regra que os dados devem estar em conformidade.
View: Lógica para visualizar os dados.
Sequences: Auto incremento para alguma coluna.
Synonyms: Criar apelidos para objetos.
Packages: Organizam um conjunto de objetos.
Procedures: Blocos de comando que executam instruções pl/sql.
Functions: Semelhante aos Procedures, porém requerem um retorno.*/

/****************************************************************************************/

/*2) Após inserir um registro no banco de dados e logo após fazer um comando de criação 
de outra tabela. O registro será comitado na base de dados? Justifique sua resposta.*/

/*Sim, pois quando a query de create for executada o dado será comitado imediatamente na hora
da execução.*/

/****************************************************************************************/

/*3) Você foi incumbido de criar um cadastro de livros. Para isso precisa criar uma tabela 
de produtos os as seguintes informações: código identificados, código, nome, situação.*/

CREATE TABLE LIVROS(
ID_LIVROS INT NOT NULL,
CODIGO INT NOT NULL,
NOME VARCHAR2(100) NOT NULL,
SITUACAO CHAR(1) NOT NULL
);

/****************************************************************************************/

/*4) Crie uma chave primária para a tabela de livros.*/

ALTER TABLE LIVROS ADD CONSTRAINT livros_pk PRIMARY KEY (ID_LIVROS);

/****************************************************************************************/

/*5) Crie uma tabela de clientes que tenha: código identificador, nome, cpf, situação.*/

CREATE TABLE CLIENTES(
ID_CLIENTES INT NOT NULL,
NOME VARCHAR2(100) NOT NULL,
CPF VARCHAR2(20) NOT NULL,
SITUACAO CHAR(1) NOT NULL,
CONSTRAINT produtos_pk PRIMARY KEY (ID_CLIENTES)
);

/****************************************************************************************/

/*6) Crie uma tabela de movimentação de empréstimos que tenha: código identificador, 
código identificador do livro, código identificador do cliente data de retirada e data de 
devolução. As colunas de “código identificador do livro” e “código identificador de 
cliente” devem ser chaves estrangeiras da tabela de livros e clientes.*/

CREATE TABLE MOVIMENTACAO_EMPRESTIMOS(
ID_MOV_EMP INT NOT NULL,
ID_CLIENTE INT NOT NULL,
ID_LIVRO INT NOT NULL,
DATA_RETIRADA DATE,
DATA_DEVOLUCAO DATE,
CONSTRAINT mov_emp_pk PRIMARY KEY (ID_MOV_EMP),
CONSTRAINT MOVIMENTACAO_LIVROS_FK FOREIGN KEY (ID_LIVRO) REFERENCES LIVROS (ID_LIVROS),
CONSTRAINT MOVIMENTACAO_CLIENTES_FK FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES (ID_CLIENTES)
);

/****************************************************************************************/

/*7) Alterar a coluna situação das tabelas de livros e clientes para status. Criar uma 
restrição para só permitir valores A (Ativo) ou I (Inativo).*/

ALTER TABLE LIVROS RENAME COLUMN SITUACAO TO STATUS;
ALTER TABLE CLIENTES RENAME COLUMN SITUACAO TO STATUS;
ALTER TABLE LIVROS ADD CONSTRAINT STATUS_CK CHECK(STATUS IN ('A','I'));
ALTER TABLE CLIENTES ADD CONSTRAINT STATUS_CLIENTES_CK CHECK(STATUS IN ('A','I'));

/****************************************************************************************/

/*8) Crie uma sequence para as tabelas: livros, clientes e movimentação de empréstimos.*/

create sequence livros_seq
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;

create sequence clientes_seq
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;

create sequence movimentacao_emprestimos_seq
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;

/****************************************************************************************/

/*9) Insira os seguintes dados nas tabelas:*/

insert into livros
  (ID_LIVROS,
   CODIGO,
   NOME,
   STATUS)
values
  (livros_seq.nextval, livros_seq.nextval, 'Storytelling com dados', 'A');
  
insert into livros
  (ID_LIVROS,
   CODIGO,
   NOME,
   STATUS)
values
  (livros_seq.nextval, livros_seq.nextval, 'ponto de inflexão', 'A');
  
insert into livros
  (ID_LIVROS,
   CODIGO,
   NOME,
   STATUS)
values
  (livros_seq.nextval, livros_seq.nextval, 'R para data science', 'A'); 
  
insert into livros
  (ID_LIVROS,
   CODIGO,
   NOME,
   STATUS)
values
  (livros_seq.nextval, livros_seq.nextval, 'o guia do hidromel', 'I');  

insert into livros
  (ID_LIVROS,
   CODIGO,
   NOME,
   STATUS)
values
  (livros_seq.nextval, livros_seq.nextval, 'Eragon', 'I');
  
insert into livros
  (ID_LIVROS,
   CODIGO,
   NOME,
   STATUS)
values
  (livros_seq.nextval, livros_seq.nextval, 'Sherlock Holmes', 'A');   
  
insert into livros
  (ID_LIVROS,
   CODIGO,
   NOME,
   STATUS)
values
  (livros_seq.nextval, livros_seq.nextval, 'Data Sciente para Negócio', 'A'); 
  
insert into livros
  (ID_LIVROS,
   CODIGO,
   NOME,
   STATUS)
values
  (livros_seq.nextval, livros_seq.nextval, 'python para análise de dados', 'A'); 
  


insert into clientes
  (ID_CLIENTES,
   NOME,
   CPF,
   STATUS)
values
  (clientes_seq.nextval, 'Marcos', '01571871012', 'A'); 
  
insert into clientes
  (ID_CLIENTES,
   NOME,
   CPF,
   STATUS)
values
  (clientes_seq.nextval, 'Carlos', '02112354810', 'A'); 
  
insert into clientes
  (ID_CLIENTES,
   NOME,
   CPF,
   STATUS)
values
  (clientes_seq.nextval, 'José', '32145754520', 'I'); 
  
insert into clientes
  (ID_CLIENTES,
   NOME,
   CPF,
   STATUS)
values
  (clientes_seq.nextval, 'Maira', '01452485210', 'A');
  
insert into clientes
  (ID_CLIENTES,
   NOME,
   CPF,
   STATUS)
values
  (clientes_seq.nextval, 'João', '01232145610', 'A');  
  


insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 1, 1, '01-01-21','15-01-21');  
  
insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 1, 1, '15-01-21','30-01-21');  
  
insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 1, 2, '02-02-21','17-02-21');
  
insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 1, 4, '02-02-21','17-02-21');
 
insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 2, 3, '01-12-21','20-12-21');

insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 2, 5, '02-02-21','17-02-21');
  
insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 3, 6, '01-03-21','15-03-21');
  
insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 4, 7, '20-06-21','20-08-21');
  
insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 4, 7, '21-08-21','21-10-21');
  
insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 4, 6, '10-04-21','20-04-21'); 
  
insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 4, 5, '01-03-21','15-03-21'); 
  
insert into movimentacao_emprestimos
  (id_mov_emp,
   id_cliente,
   id_livro,
   data_retirada,
   data_devolucao)
values
  (movimentacao_emprestimos_seq.nextval, 4, 1, '10-05-21','20-05-21');   

select * from livros;
select * from clientes;
select * from movimentacao_emprestimos; 

/****************************************************************************************/

/*10) Faça uma query para exibir as seguintes informações: Livro, Cliente e quantidade de 
livros emprestados.*/
                                   /* REVISAR*/
select
c.nome,
l.nome,
count(m.id_mov_emp) quantidade_livros_emprestados
from movimentacao_emprestimos m
inner join livros l on m.id_livro = l.id_livros
inner join clientes c on m.id_cliente = c.id_clientes
group by c.nome,l.nome;

/****************************************************************************************/

/*11) Faça um update para que os nomes de livros e clientes fiquem com as primeiras 
letras de cada nome em maiúsculo.*/

update livros
set nome = initcap(nome);

update clientes
set nome = initcap(nome);

/****************************************************************************************/

/*12) Faça uma query para contar o total de caracteres dos nomes de livros.*/

select 
nome, 
length(nome) as qtd_caracteres 
from livros;
    
/****************************************************************************************/

/*13) Faça uma query para remover acentos, e caracteres especiais nos nomes dos livros.*/

select 
nome, 
translate(nome,'ãó','ao') as qtd_caracteres 
from livros;

/****************************************************************************************/

/*14) Faça um exemplo de query utilizando NOT EXISTS com os dados das tabelas criadas anteriormente.*/

/*Mostra todos os livros que não são dos id's 1,2,3,4,5*/
select
m.ID_MOV_EMP,
m.ID_CLIENTE,
m.ID_LIVRO,
m.DATA_RETIRADA,
m.DATA_DEVOLUCAO
from movimentacao_emprestimos m
where not exists (select 1 from movimentacao_emprestimos inner join livros l on m.id_livro = l.id_livros where l.id_livros in (1,2,3,4,5));

/****************************************************************************************/

/*15) Faça uma query para ranquear os clientes que mais leram livros no ano.*/

select
c.nome as cliente,
count(m.id_mov_emp) quantidade_livros_lidos
from movimentacao_emprestimos m
inner join livros l on m.id_livro = l.id_livros
inner join clientes c on m.id_cliente = c.id_clientes
group by c.nome
order by count(m.id_mov_emp) desc;

/****************************************************************************************/

/*16) Faça três querys sem utilizar os dados das tabelas criadas. Após isso faça um UNION 
e UNION ALL entre elas e explique com suas palavras o funcionamento.*/

/*A query abaixo unifica as três tabelas, porém o UNION ALL retorna linhas duplicadas, já o UNION não,
ele executa uma função semelhante ao "select distinct"*/
select 'Lido' as status, 'L' as id
  from dual
union 
select 'Lido' as status, 'L' as id
  from dual
union
select 'Não Lido' as status, 'N' as id
  from dual
union
select 'Iniciado' as status, 'I' as id
  from dual;
  
select 'Lido' as status, 'L' as id
  from dual
union all
select 'Lido' as status, 'L' as id
  from dual
union all
select 'Não Lido' as status, 'N' as id
  from dual
union all
select 'Iniciado' as status, 'I' as id
  from dual;

/****************************************************************************************/

/*17) Faça uma query para exibir os meses do ano que tiveram empréstimos.*/
  
select distinct
to_char(m.data_retirada, 'MM-YYYY') as mes_emprestimo
from movimentacao_emprestimos m
order by mes_emprestimo;

/****************************************************************************************/

/*18) Faça uma query para exibir o mês que teve menos empréstimos no ano.*/

select
to_char(m.data_retirada, 'MM-YYYY') as mes_menos_emprestimo,
count(id_livro) as qtd
from movimentacao_emprestimos m
group by to_char(m.data_retirada, 'MM-YYYY')
order by count(id_livro) asc;

/****************************************************************************************/

/*19) Faça uma query para exibir o ranqueamento dos 2 livros com maior quantidade de 
empréstimos. Nas colunas de resultado devem ter o nome do livro, posição do 
ranqueamento e quantidade total de empréstimos.*/
                                                      /* REVISAR */
select
l.nome as nome_livro,
rank() over (order by count(m.id_mov_emp)) ranqueamento,
count(m.id_mov_emp) as total_emprestimos
from movimentacao_emprestimos m
inner join livros l on m.id_livro = l.id_livros
group by l.nome
order by ranqueamento desc fetch first 2 rows only;

/****************************************************************************************/

/*20) Faça uma query para exibir todos os livros, clientes e total de empréstimos 
e depois exiba somente os resultados onde o total de empréstimos é maior que 2.*/

select
l.nome as nome_livro,
count(m.id_mov_emp) as total_emprestimos
from movimentacao_emprestimos m
inner join livros l on m.id_livro = l.id_livros
inner join clientes c on m.id_cliente = c.id_clientes
group by l.nome
having count(m.id_mov_emp) > 2;

/****************************************************************************************/

/*21) Faça uma query para mostrar todos os livros no qual não tiveram empréstimos.*/

select 
l.nome as sem_emprestimo
from livros l
left join movimentacao_emprestimos m on m.id_livro = l.id_livros
where m.id_livro is null;

/****************************************************************************************/

/*22) Faça um inner join da tabela de livros, clientes e empréstimos. Depois exiba na saída 
somente o nome livro e cliente. Na saída não pode ter valores repetidos.*/

select distinct
l.nome as nome_livro,
c.nome as nome_cliente
from movimentacao_emprestimos m
inner join livros l on m.id_livro = l.id_livros
inner join clientes c on m.id_cliente = c.id_clientes;

/****************************************************************************************/

/*23) Inative os livros que não possuem empréstimos de livros.*/

update livros l
SET status = 'I'
where l.nome = (select l.nome as sem_emprestimo from livros l left join movimentacao_emprestimos m on m.id_livro = l.id_livros where m.id_livro is null);

/*select * from livros l
where l.nome = (select l.nome as sem_emprestimo from livros l left join movimentacao_emprestimos m on m.id_livro = l.id_livros where m.id_livro is null)*/

/****************************************************************************************/

/*24) Remova os clientes que não possuem empréstimos de livros.*/

/*select 
c.nome as "Não Realizou Empréstimo"
from clientes c
left join movimentacao_emprestimos m on m.id_cliente = c.id_clientes
where m.id_cliente is null*/

delete from clientes c
where c.nome = (select 
c.nome as "Não Realizou Empréstimo"
from clientes c
left join movimentacao_emprestimos m on m.id_cliente = c.id_clientes
where m.id_cliente is null);

/*select * from clientes*/

/****************************************************************************************/

/*25) Faça um exemplo de query utilizando EXISTS com os dados das tabelas criadas anteriormente.*/

/*Mostra todos os livros que são dos id's 1 e 2*/
select
m.ID_MOV_EMP,
m.ID_CLIENTE,
m.ID_LIVRO,
m.DATA_RETIRADA,
m.DATA_DEVOLUCAO
from movimentacao_emprestimos m
where exists (select 1 from movimentacao_emprestimos inner join livros l on m.id_livro = l.id_livros where l.id_livros in (1,2));
  
  
  
  
  
  
  
  
  
  
  
  
  
  






















































































