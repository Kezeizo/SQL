/*
1 - Faça uma package chamada pck_funcionarios. Nesta package deve ser possivel inserir, remover ou alterar registros da tabela employees.
Para diferenciar o tipo de transação DML crie um parametro chamado p_dml [ I = Insert U = Update D = Delete].
Será avaliado toda a solução e deve ter um retorno para o usuário caso o transação tenha sido executada com sucesso ou não.
*/
/*ESPECIFICAÇÃO*/
create or replace package pck_funcionarios as
  procedure p_dml;
end;
/*BODY*/
create or replace package body pck_funcionarios as
begin
  procedure p_dml(pnome in varchar2) as if(var = 'I') then insert
    into employees(employee_id, first_name) values(regions_seq.nextval,
                                                   initcap(pnome));
  var_resultado := pvalor1 + pvalor2;
elsif(var = 'U') then update employees set first_name = '' where regions_seq.nextval = regions_seq.nextval 
values(regions_seq.nextval, initcap(pnome)); var_resultado := pvalor1 - pvalor2; 
elsif(var = 'D') then delete from employees where regions_seq.nextval = regions_seq.nextval

end pck_funcionarios;

/*CHAMADA*/
declare
var_resultado number;

begin
  var_resultado := pck_util.fnc_calculo2(&var1,&var2,'&operacao');
  dbms_output.put_line('Resultado da operação: ' || var_resultado); 
end;
/*Tive algumas dificuldades para desenvolver esse script*/
/*
2 - Crie uma procedure chamada prc_get_dados_func. Nesta procedure será informado o id do funcionário e deve devolver todos os dados do mesmo.
*/

create or replace procedure prc_get_dados_func(p_department_id    out employees.department_id%type,
                                                 p_manager_id     out employees.manager_id%type,                
                                                 p_commission_pct out employees.commission_pct%type,
                                                 p_salary         out employees.salary%type,
                                                 p_job_id         out employees.job_id%type,
                                                 p_hire_date      out employees.hire_date%type,                   
                                                 p_phone_number   out employees.phone_number%type,
                                                 p_email          out employees.email%type,
                                                 p_last_name      out employees.last_name%type,
                                                 p_first_name      out employees.first_name%type,
                                                 p_employee_id    in employees.employee_id%type) as  


begin
  select e.first_name into p_first_name from employees e 
  where p_employee_id = e.employee_id;
  select e.last_name into p_last_name from employees e 
  where p_employee_id = e.employee_id;
  select concat(e.email,'@gmail.com') into p_email  from employees e 
  where p_employee_id = e.employee_id;
  select e.phone_number into p_phone_number  from employees e 
  where p_employee_id = e.employee_id;
  select e.hire_date into p_hire_date  from employees e 
  where p_employee_id = e.employee_id;
  select e.job_id into p_job_id  from employees e 
  where p_employee_id = e.employee_id;
  select e.salary into p_salary  from employees e 
  where p_employee_id = e.employee_id;
  select e.commission_pct into p_commission_pct  from employees e 
  where p_employee_id = e.employee_id;
  select e.manager_id into p_manager_id from employees e 
  where p_employee_id = e.employee_id;
  select e.department_id into p_department_id from employees e 
  where p_employee_id = e.employee_id;
  dbms_output.put_line('ID: ' || p_employee_id || chr(10) || 'Nome: ' || p_first_name || chr(10) || 'Sobrenome: ' || p_last_name
                       || chr(10) || 'Email: ' || p_email || chr(10) || 'Telefone: ' || p_phone_number || chr(10) || 'Data Contratação: ' || p_hire_date
                       || chr(10) || 'ID Job: ' || p_job_id || chr(10) || 'Salário: ' || p_salary || chr(10) || 'Comissão: ' || p_commission_pct
                       || chr(10) || 'ID Gerente: ' || p_manager_id || chr(10) || 'ID Departamento: ' || p_department_id);
end;
/* CHAMADA */
declare
  var_id   number;
  var_nome varchar2(50);
  var_sobrenome varchar(50);
  var_email varchar(50);
  var_telefone varchar2(20);
  var_contratacao date;
  var_id_job varchar2(20);
  var_salario number;
  var_comissao number;
  var_id_gerente number;
  var_id_dep number;
begin
  var_id := &var_id;
  prc_get_dados_func(p_employee_id => var_id, p_first_name => var_nome,p_last_name => var_sobrenome,p_email => var_email,
                     p_phone_number => var_telefone, p_hire_date => var_contratacao, p_job_id => var_id_job,
                     p_salary => var_salario, p_commission_pct => var_comissao, p_manager_id => var_id_gerente,
                     p_department_id => var_id_dep);
                     
EXCEPTION
when others then
DBMS_OUTPUT.PUT_LINE('ID inexistente! Contate o suporte técnico.');
END;

                  
/*
3 - Crie uma função chamada fnc_get_endereco. Está função deve receber o id do funcionário e retornar uma string concatenando: Rua + Número + Cidade
*/

create or replace function fnc_get_endereco(pemployee_id in number) 
  return varchar2 as
  var_nome varchar2(100);
begin
  select l.street_address || ' ' || l.postal_code || ' ' || l.city
    into var_nome
    from employees e
    inner join departments d on d.department_id = e.department_id
    inner join locations l on l.location_id = d.location_id
   where e.employee_id = pemployee_id;
  return var_nome;
exception
  when no_data_found then
    return 'ID não encontrado!';
end;

select distinct fnc_get_endereco(e.employee_id) as nome
  from employees e


/*
4 - Altere a package pck_funcionarios e adicione nela a procudere prc_get_dados_func e a função fnc_get_endereco dentro dela.
*/

ALTER PACKAGE pck_funcionarios
      procudere prc_get_dados_func;
      functions fnc_get_endereco;
   COMPILE PACKAGE; 

/*
5 - Crie um bloco pl/sql com cursor. Neste adicione uma variável do tipo string que poderá ser o primeiro nome do funcionário e ou o segundo
nome do funcionário e ou também o nome de um pais.
Ao inserir o nome da variável seus cursores devem estar preparados para receber e retornar as informações do id concatenado com a descrição do registro.
*/

declare
  var_id employees.employee_id%type;
  var_nome employees.last_name%type;

  cursor c_id_registro is
    select e.employee_id,e.last_name 
    from employees e
    order by employee_id;
begin
  open c_id_registro;
  loop
    fetch c_id_registro
      into var_id,var_nome;
    exit when c_id_registro%notfound;
    dbms_output.put_line(var_id || ' ' || var_nome);
  end loop;
  close c_id_registro;
end;


/*
6 - Faça um bloco pl/sql com cursores onde retorne a seguinte saída:
Departamento : #####
* Funcionário : #####
*/

declare
  var_dep  employees.department_id%type;
  var_func employees.employee_id%type;
  
  cursor c_lista_fun is
    select e.department_id, e.employee_id
      from employees e
     order by e.employee_id;

begin
  open c_lista_fun;
  loop
    fetch c_lista_fun
      into var_dep, var_func;
    exit when c_lista_fun%notfound;
    dbms_output.put_line('Departamento: ' || var_dep || chr(10) || '* Funcionário: ' || var_func);
  end loop;
  close c_lista_fun;
end;
/*select * from employees*/


/*
7 - Crie uma package chamada pck_util e adicione dentro dela a função com a lógica do 3° exercício da atividade anterior que é:



Faça uma função que receba 3 parametros. pvalor1, pvalor2 e poperacao;
O paramentro poperacao deve receber (+ ou - ou / ou *).
Programe a função para fazer os cálculos e retornar o valor.
Caso seja informado um parametro não previsto deve retornar uma mensagem para o usuário.

*/
/*ESPECIFICAÇÃO*/
create or replace package pck_util as
  function fnc_calculo2(pvalor1   in number,
                        pvalor2   in number,
                        poperacao in varchar2) return number;
end;
/*BODY*/
create or replace package body pck_util as
  function fnc_calculo2(pvalor1   in number,
                        pvalor2   in number,
                        poperacao in varchar2) return number is
    var_resultado number;
    var_erro exception;
  begin
    if (poperacao = '+') then
      var_resultado := pvalor1 + pvalor2;
    elsif (poperacao = '-') then
      var_resultado := pvalor1 - pvalor2;
    elsif (poperacao = '/') then
      var_resultado := pvalor1 / pvalor2;
    elsif (poperacao = '*') then
      var_resultado := pvalor1 * pvalor2;
    else
      raise var_erro;
    end if;
    return var_resultado;
  
  EXCEPTION
    when var_erro then
      DBMS_OUTPUT.PUT_LINE('ERRO! Por favor contate o suporte técnico');
  end;
end pck_util;
/*CHAMADA*/
declare
var_resultado number;

begin
  var_resultado := pck_util.fnc_calculo2(&var1,&var2,'&operacao');
  dbms_output.put_line('Resultado da operação: ' || var_resultado); 
end;











