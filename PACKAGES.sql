/* PACKAGE ESPECIFICAÇÃO*/
create or replace package pck_util as
  contador int;
  procedure saudacao;
  procedure publico;
end;


/* PACKAGE BODY*/
create or replace package body pck_util as
procedure saudacao is
begin
  publico;
  contador := contador + 1;
end saudacao;
    
procedure privado(pValor in number) is
begin
  dbms_output.put_line('Tipo número ' || pValor);
end privado;

procedure privado (pValor in date) is
  begin
   dbms_output.put_line('Tipo data ' || to_char(pValor, 'dd-mm-yyy hh24:mi:ss'));
  end privado;
  
procedure privado (pValor in varchar2) is
  begin
     dbms_output.put_line('Tipo caractere ' || pValor);
  end privado;
  
procedure publico is
  begin
    privado (pValor => 'Olá, seja bem vindo!');
    privado (pValor => 123456789);
    privado (pValor => sysdate);
end publico;
  
begin
  contador := 0;
end;


/* CHAMADA PACKAGE */
begin
  pck_util.saudacao;
  dbms_output.put_line('A package foi executada nessa sessão (banco): ' || pck_util.contador || ' vez(es)!');
end;
























        

    
