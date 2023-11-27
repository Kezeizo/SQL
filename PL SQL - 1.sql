begin 
  dbms_output.put_line('Hello World!');
end;

/*************************************************************************************/

declare 
  v_retorno number;

begin 
  select count(1) into v_retorno from employees;
end;

/*************************************************************************************/

declare
  vTotal number;
begin
  vTotal := 2;
  
  if (vTotal = 0) then 
    dbms_output.put_line('Nenhum registro encontrado');
  elsif (vTotal = 1) then
    dbms_output.put_line('Um registro encontrado');
  else 
    dbms_output.put_line('Mais de um registro encontrado');
  end if; 
end;

/*************************************************************************************/

begin 
  for vContador in 1..30 loop
    dbms_output.put_line('Executou: ' || to_char(vContador, '90'));
    end loop;
end;

begin
  for i in 1..10 loop
    dbms_output.put_line('Olá, i=' || i);
    end loop;
end;

declare
    i number;
begin
  i := 1;
  
  while (i <= 10) loop
    dbms_output.put_line('Executou: ' || i);
    i := i + 1;
  end loop;
end;

/*Faça um bloco pl/sql e imprimir na saída todos as datas que 
caírem em sábado ou domingo. Da data de hoje até o final do ano.*/

declare
    data date := sysdate;
begin

  while (data <= '31-12-2021') loop
    
    if (to_char (data, 'd') = '7') then
      dbms_output.put_line('Caiu em um sábado: ' || data);
    elsif (to_char (data, 'd') = '1') then
      dbms_output.put_line('Caiu em um domingo: ' || data);
    else
    dbms_output.put_line(data);
    end if;
  data := data + 1;
  end loop;
end;


/*Adicione uma coluna chamada status na tabela employees, após isso faça um bloco pl/sql para
inserir A quando o departamento não for nulo e I para quando for nulo.*/

alter table employees add (status char(1));

declare 
  v_id number;

begin 
  select count(1) into v_id from employees;
  for i in 1..v_id loop
    dbms_output.put_line('i = ' || i);
    begin
      update status from employees where 
    end;
  end loop;
end;


/*Faça um bloco pl/sql para inverter os caracteres (LIATERXRB) e formar a palavra BRXRETAIL;*/

declare
caractere varchar(20);
tamanho number;
cont number;
begin 
  caractere := 'LIATERXRB';
  tamanho := length(caractere);
  cont := 1;
  for i in 1..tamanho loop
    dbms_output.put(substr(caractere,tamanho,1));
    tamanho := tamanho - 1;
  end loop;
end;

/************************************************************************************************************/

/*
Crie uma tabela com uma unica coluna do tipo string. Após faça um bloco pl/sql para percorrer o texto abaixo.
Todas as palavras (exceto pontuação) devem ser inseridas na tabela. Depois de inserir remova os registros
duplicados até ficar só um registro de cada palavra.


Texto:
O rato roeu a roupa do rei de Roma,
O rato roeu a roupa do rei da Rússia,
O rato roeu a roupa do RodovaIho...
*/

create table texto(
texto varchar2(200)
);

create or replace procedure insere_texto (texto in varchar2(200)) as
begin
  insert into texto (texto) values (O rato roeu a roupa do rei de Roma,O rato roeu a roupa do rei da Rússia,O rato roeu a roupa do RodovaIho...);
end;

-- select * from texto;

/*
Faça quatro blocos pl/sql. E em cada um deles crie um exemplo de código que irá gerar uma exceção.
Cada bloco pl/sql deve ter uma das seguintes exceções.
Erro_nome (exception customizada)
no_data_found
too_many_rows
others then
*/

DECLARE
nome_c countries.country_name%Type;
alerta_gringo EXCEPTION;
erro varchar2(3000);
BEGIN

Select c.country_name
Into nome_c
From countries c
Where c.country_id = 'AR';

If nome_c like '%Argentina%' then
RAISE alerta_gringo;
End If;

DBMS_OUTPUT.PUT_LINE('Nome: ' || nome_c);

EXCEPTION
When alerta_gringo Then
DBMS_OUTPUT.PUT_LINE('** Argentino detectado **');

END;

/*************************************/

DECLARE
nome_c countries.country_name%Type;
erro varchar2(3000);
BEGIN

Select c.country_name
Into nome_c
From countries c
Where c.country_id = 'BT';

DBMS_OUTPUT.PUT_LINE('Nome: ' || nome_c);

EXCEPTION
when no_data_found then
DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado!');
END;

/*************************************/

DECLARE
nome_c countries.country_name%Type;
erro varchar2(3000);
BEGIN

Select c.country_name
Into nome_c
From countries c;

DBMS_OUTPUT.PUT_LINE('Nome: ' || nome_c);

EXCEPTION
when too_many_rows then
DBMS_OUTPUT.PUT_LINE('Muitos registros encontrados!');
END;

/*************************************/

DECLARE
nome_c countries.country_name%Type;
erro varchar2(3000);

BEGIN

Select c.country_name
Into nome_c
From countries c;
--Where c.country_id = 'AR';

DBMS_OUTPUT.PUT_LINE('Nome: ' || nome_c);

EXCEPTION
when others then
DBMS_OUTPUT.PUT_LINE('ERRO! Por favor contate o suporte técnico');
END;


/*
Faça uma função que receba 3 parametros. pvalor1, pvalor2 e poperacao;
O paramentro poperacao deve receber (+ ou - ou / ou *).
Programe a função para fazer os cálculos e retornar o valor.
Caso seja informado um parametro não previsto deve retornar uma mensagem para o usuário.
*/

DECLARE
pvalor1 number;
pvalor2 number;
operacao varchar2(10);
resultado number;

BEGIN

pvalor1 := &pvalor1;
pvalor2 := &pvalor2;
operacao := '&operacao';

if (operacao = '+') then
   resultado := pvalor1 + pvalor2;
elsif (operacao = '-') then
   resultado := pvalor1 - pvalor2;
elsif (operacao = '/') then
   resultado := pvalor1 / pvalor2;
elsif (operacao = '*') then
   resultado := pvalor1 * pvalor2;

end if;

DBMS_OUTPUT.PUT_LINE('Resultado da operação: ' || resultado);

EXCEPTION
when others then
DBMS_OUTPUT.PUT_LINE('ERRO! Por favor contate o suporte técnico');
END;


















































select employee_id, start_date, end_date, job_id, department_id from job_history















