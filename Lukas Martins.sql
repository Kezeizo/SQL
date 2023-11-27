/* LUKAS MARTINS DA SILVA  */

/*Criar uma package pck_empregados. Dentro desta package criar uma procedure que faça
INSERT, UPDATE e DELETE. Caso ocorra algum erro deve ser exibido para o usuário final e 
caso tenha sucesso também. Tabela para realizar as instruções DML é a employees.*/

/* PACKAGE ESPECIFICAÇÃO*/

create or replace package pck_empregados is

  procedure prc_dml_employees(p_dml            in varchar2,
                              P_FIRST_NAME     in out EMPLOYEES.First_Name%type,
                              P_LAST_NAME      in out EMPLOYEES.Last_Name%type,
                              P_EMAIL          in out EMPLOYEES.Email%type,
                              P_PHONE_NUMBER   in out EMPLOYEES.Phone_Number%type,
                              P_HIRE_DATE      in out EMPLOYEES.Hire_Date%type,
                              P_JOB_ID         in out EMPLOYEES.Job_Id%type,
                              P_SALARY         in out EMPLOYEES.Salary%type,
                              P_COMMISSION_PCT in out EMPLOYEES.Commission_Pct%type,
                              P_MANAGER_ID     in out EMPLOYEES.Manager_Id%type,
                              P_DEPARTMENT_ID  in out EMPLOYEES.Department_Id%type,
                              P_STATUS         in out EMPLOYEES.Status%type,
                              P_EMPLOYEE_ID    in out EMPLOYEES.EMPLOYEE_ID%type,
                              p_msg            out varchar2);

end pck_empregados;

/* PACKAGE BODY */

create or replace package body pck_empregados is

procedure prc_dml_employees(p_dml in varchar2, P_FIRST_NAME in out EMPLOYEES.First_Name%type, P_LAST_NAME in out EMPLOYEES.Last_Name%type, P_EMAIL in out EMPLOYEES.Email%type, P_PHONE_NUMBER in out EMPLOYEES.Phone_Number%type, P_HIRE_DATE in out EMPLOYEES.Hire_Date%type, P_JOB_ID in out EMPLOYEES.Job_Id%type, P_SALARY in out EMPLOYEES.Salary%type, P_COMMISSION_PCT in out EMPLOYEES.Commission_Pct%type, P_MANAGER_ID in out EMPLOYEES.Manager_Id%type, P_DEPARTMENT_ID in out EMPLOYEES.Department_Id%type, P_STATUS in out EMPLOYEES.Status%type, P_EMPLOYEE_ID in out EMPLOYEES.EMPLOYEE_ID%type, p_msg out varchar2) is
begin
if p_dml = 'I' then

if P_EMPLOYEE_ID is
null then select employees_seq.nextval into P_EMPLOYEE_ID from dual;
end if;
begin
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id, status) values(p_employee_id, P_FIRST_NAME, P_LAST_NAME, p_email, p_phone_number, p_hire_date, p_job_id, nvl(p_salary, 0), nvl(p_commission_pct, 0), p_manager_id, p_department_id, p_status); p_msg := 'Registro inserido com sucesso!';
exception
when others then p_msg := 'Falha ao inserir registro. Entre em contato com o suporte! ' || sqlerrm;
end; elsif p_dml = 'U' then
begin
update employees e set e.first_name = p_first_name, e.last_name = p_last_name, e.email = p_email, e.phone_number = p_phone_number, e.hire_date = p_hire_date, e.job_id = p_job_id, e.salary = p_salary, e.commission_pct = p_commission_pct, e.manager_id = p_manager_id, e.department_id = p_department_id, e.status = p_status where e.employee_id = p_employee_id; p_msg := 'Registro alterado com sucesso!';
exception
when others then p_msg := 'Falha ao alterar registro. Entre em contato com o suporte!';
end; elsif p_dml = 'D' then
begin
delete employees e where e.employee_id = P_EMPLOYEE_ID; p_msg := 'Registro excluído com sucesso!';
exception
when others then p_msg := 'Falha ao remover registro. Entre em contato com o suporte!';
end; elsif p_dml = 'S' then
begin
select e.employee_id, e.first_name, e.last_name, e.email, e.phone_number, e.hire_date, e.job_id, e.salary, e.commission_pct, e.manager_id, e.department_id, decode(e.status, 'A', 'Ativo', 'Inativo') into p_employee_id, p_first_name, p_last_name, p_email, p_phone_number, p_hire_date, p_job_id, p_salary, p_commission_pct, p_manager_id, p_department_id, p_status from employees e where e.employee_id = P_EMPLOYEE_ID;
exception
when no_data_found then p_msg := 'Registro não encontrato.';
end; else p_msg := 'Operação não tratada. Entre em contato com o suporte!';
end if;

end prc_dml_employees;

begin
-- Initialization
null;
end pck_empregados;

/* CALL */

pck_empregados.prc_dml_employees(p_dml => v_dml, p_first_name => v_first_name, p_last_name => v_last_name, p_email => v_email, p_phone_number => v_phone_number, p_hire_date => v_hire_date, p_job_id => v_job_id, p_salary => v_salary, p_commission_pct => v_commission_pct, p_manager_id => v_manager_id, p_department_id => v_department_id, p_status => v_status, p_employee_id => v_employee_id, p_msg => v_msg);

select * from employees order by employee_id;

/***********************************************************************************************************/
/***********************************************************************************************************/
/***********************************************************************************************************/

/* 2 – Alterar a package pck_empregados e crie uma procedure para consultar as informações do empregado. Ao informar um email deve retornar as seguintes informações na procedure:
• Nome completo
• Endereço completo de trabalho
• Cidade de trabalho
• salário anual com comissão
• nome do cargo/job
• nome do departamento
*/

/* PACKAGE ESPECIFICAÇÃO*/
create or replace package pck_empregados is

procedure prc_dml_employees(p_dml in varchar2, P_FIRST_NAME in out EMPLOYEES.First_Name%type, P_LAST_NAME in out EMPLOYEES.Last_Name%type, P_EMAIL in out EMPLOYEES.Email%type, P_PHONE_NUMBER in out EMPLOYEES.Phone_Number%type, P_HIRE_DATE in out EMPLOYEES.Hire_Date%type, P_JOB_ID in out EMPLOYEES.Job_Id%type, P_SALARY in out EMPLOYEES.Salary%type, P_COMMISSION_PCT in out EMPLOYEES.Commission_Pct%type, P_MANAGER_ID in out EMPLOYEES.Manager_Id%type, P_DEPARTMENT_ID in out EMPLOYEES.Department_Id%type, P_STATUS in out EMPLOYEES.Status%type, P_EMPLOYEE_ID in out EMPLOYEES.EMPLOYEE_ID%type, p_msg out varchar2);

procedure prc_consulta_empregado(P_NOME_COMPLETO in out EMPLOYEES.First_Name%type,

P_JOB_ID out EMPLOYEES.Job_Id%type, P_SALARIO_ANUAL_CMS out number, P_CIDADE out varchar2, p_departamento out varchar2, p_endereco out varchar2, P_EMPLOYEE_ID out EMPLOYEES.EMPLOYEE_ID%type, P_EMAIL in out EMPLOYEES.Email%type, p_msg out varchar2);

end pck_empregados;

/* PACKAGE BODY */
create or replace package body pck_empregados is

procedure prc_consulta_empregado(P_NOME_COMPLETO in out EMPLOYEES.First_Name%type,

P_JOB_ID out EMPLOYEES.Job_Id%type, P_SALARIO_ANUAL_CMS out number, P_CIDADE out varchar2, p_departamento out varchar2, p_endereco out varchar2, P_EMPLOYEE_ID out EMPLOYEES.EMPLOYEE_ID%type, P_EMAIL in out EMPLOYEES.Email%type, p_msg out varchar2) is
begin
select e.employee_id, e.email, e.first_name || ' ' || e.last_name, e.job_id, e.salary * (e.salary * e.commission_pct * 12), l.city, d.department_name, l.street_address into p_employee_id, p_email, p_nome_completo, p_job_id, p_salario_anual_cms, p_CIDADE, p_departamento, p_endereco from employees e inner join departments d on e.department_id = d.department_id inner join locations l on d.location_id = l.location_id where e.email = p_email;
exception
when no_data_found then p_msg := 'Registro não encontrado.';
end prc_consulta_empregado;

begin
-- Initialization
null;

end pck_empregados;

/* CALL */
begin
-- Call the procedure
pck_empregados.prc_consulta_empregado(p_nome_completo => :p_nome_completo, p_job_id => :p_job_id, p_salario_anual_cms => :p_salario_anual_cms, p_cidade => :p_cidade, p_departamento => :p_departamento, p_endereco => :p_endereco, p_employee_id => :p_employee_id, p_email => :p_email, p_msg => :p_msg);
end;

/***********************************************************************************************************/
/***********************************************************************************************************/
/***********************************************************************************************************/
/*3 – Crie uma tabela de monitoramento de logs*/

CREATE TABLE LOGS
(ID NUMBER, 
DATA DATE, 
USUARIO VARCHAR2(50), 
DESC_OBJETO VARCHAR2(500),
DESC_SLQERROR VARCHAR2(4000),
DESC_LOG VARCHAR2(4000), 
CONSTRAINT LOGS_PK PRIMARY KEY(ID));

/***********************************************************************************************************/
/***********************************************************************************************************/
/***********************************************************************************************************/
/*4 – Crie uma tabela chamada carros. Com as colunas:
• código
• Nome
• Marca
• Ano
• Valor*/

CREATE TABLE CARROS(
ID INT, 
NOME VARCHAR2(50), 
MARCA VARCHAR2(50), 
ANO INT, 
VALOR NUMBER, 
CONSTRAINT CARROS_PK PRIMARY KEY(ID));

/***********************************************************************************************************/
/***********************************************************************************************************/
/***********************************************************************************************************/
/*5 – Crie uma procedure para popular o ID da tabela carros quando for informado nulo ao inserir um registro.*/

create sequence carros_seq minvalue 1 maxvalue 9999999999999999999999999999 start with 1 increment by 1 nocache;

create or replace trigger trg_carros_pop
  before insert or update on PER_RES
  for each row
begin
  if inserting and :new.id is null then

    select carros_seq.nextval into :new.id from dual;
    
   end if;
  
end trg_carros_pop;

/***********************************************************************************************************/
/***********************************************************************************************************/
/***********************************************************************************************************/
/*6 – Crie outra procedure para a tabela carros que todas as vezes que for alterado o valor do 
carro registre um log na sua tabela de monitoramento criada na questão 3. Quero saber a data 
da alteração, usuário da alteração, id do registro alterado, valor antes da alteração e o valor 
alterado.*/

/*insert into carros
  (id, nome, marca, ano, valor)
values
  (carros_seq.nextval, 'Santana', 'Volkswagen', 1997, 30000);*/

create sequence logs_seq minvalue 1 maxvalue 9999999999999999999999999999 start with 1 increment by 1 nocache;

create or replace trigger trg_carros
  after update on carros
  for each row

begin
  if updating then
    if :old.valor <> :new.valor then
      insert into logs
        (id, data, usuario, desc_objeto, desc_slqerror, desc_log)
      values
        (logs_seq.nextval,
         sysdate,
         user,
         'Tabela carros',
         '',
         'Id do registro: ' || :new.id || ' ' || 'Valor anterior: ' ||
         :old.valor || ' ' || 'valor alterado: ' || :new.valor);
    
    end if;
  end if;
end trg_carros;

update carros set valor = 4000 where nome = 'Santana'

select * from carros 
select * from logs 


/***********************************************************************************************************/
/***********************************************************************************************************/
/***********************************************************************************************************/
/*7 – Crie uma tabela de perguntas e respostas, nesta deve ter uma coluna para pergunta e 
outra para resposta. Após isso crie um trigger para popular seu ID, e também uma função.
Nesta função deve ser informado uma pergunta e retornado uma resposta.*/
CREATE TABLE PER_RES(
ID INT, 
PERGUNTA VARCHAR2(200), 
RESPOSTA VARCHAR2(200), 
CONSTRAINT PER_RES_PK PRIMARY KEY(ID));

create sequence per_res_seq minvalue 1 maxvalue 9999999999999999999999999999 start with 1 increment by 1 nocache;

create or replace trigger trg_per_res
  before insert or update on PER_RES
  for each row
begin
  if inserting and :new.id is null then

    select per_res_seq.nextval into :new.id from dual;
    
   end if;
  
end trg_per_res;

/*insert into PER_RES(ID,
                    PERGUNTA,
                    RESPOSTA)
values(per_res_seq.nextval,'O que é PL SQL?','PPL/SQL é uma extensão da linguagem padrão SQL para o SGBD Oracle da Oracle Corporation.');*/

create or replace function fnc_per_res (pPERGUNTA in number)
  return varchar2 as
  var_resposta varchar2(200);
begin
  select pr.resposta
    into var_resposta
    from per_res pr
    where pr.ID = pPERGUNTA;
  return var_resposta;
exception
  when no_data_found then
    return 'Pergunta não encontrada!';
end;

select fnc_per_res (pr.ID) as resposta
  from per_res pr


/***********************************************************************************************************/
/***********************************************************************************************************/
/***********************************************************************************************************/
/*8 – Crie um bloco PL/SQL utilizando as tabelas: • employees; • regions; • location; • jobs; • departments;
Neste bloco deve ter um exemplo de sua escolha mas que contenha 3 loops encadeados. Ou seja, um loop dentro do outro.*/


declare
  var_dep departments.department_id%type;
  var_fun employees.employee_id%type;

  cursor c_lista_dep is
    select d.department_id from departments d /*where d.department_id = 60*/ order by d.department_id;

  cursor c_lista_fun is
    select e.employee_id from employees e where e.employee_id = 206 order by e.employee_id;
    

begin
  open c_lista_dep;
  loop
    fetch c_lista_dep
      into var_dep;
    exit when c_lista_dep%notfound;
    dbms_output.put_line('Departamento: ' || var_dep);

      open c_lista_fun;
      loop
        fetch c_lista_fun
          into var_fun;
        exit when c_lista_fun%notfound;
        dbms_output.put_line('Funcionário: ' || var_fun);
      end loop;
      close c_lista_fun;
    end loop;
    close c_lista_dep;
  end;


/***********************************************************************************************************/
/***********************************************************************************************************/
/***********************************************************************************************************/
/*9 – Faça a mesma coisa pedida no exercício 8 mas utilizando um loop diferente do utilizado na questão 8.*/

declare
  var_dep departments.department_id%type;
  var_fun employees.employee_id%type;

  cursor c_lista_dep is
    select d.department_id from departments d /*where d.department_id = 60*/ order by d.department_id;

  cursor c_lista_fun is
    select e.employee_id from employees e where e.employee_id = 206 order by e.employee_id;
    

begin
  open c_lista_dep;
  loop
    fetch c_lista_dep
      into var_dep;
    exit when c_lista_dep%notfound;
    dbms_output.put_line('Departamento: ' || var_dep);

      open c_lista_fun;
      loop
        fetch c_lista_fun
          into var_fun;
        exit when c_lista_fun%notfound;
        dbms_output.put_line('Funcionário: ' || var_fun);
      end loop;
      close c_lista_fun;
    end loop;
    close c_lista_dep;
  end;

/***********************************************************************************************************/
/***********************************************************************************************************/
/***********************************************************************************************************/
/*10 – Crie uma tabela de usuários. Após crie uma procedure para inserir usuário nesta tabela.
Será informado o nome e você deverá criar o login respeitando os requisites abaixo:
• maximo 20 caracter.
• Não pode ter usuários repetidos na tabela
• Não pode ter acento
Ex.:
Marcos Telles => marcos.telles
Marcos Telles => telles.marcos
Fernando da Silva Neto => Fernando.neto
Fernando da Silva Neto => Fernando.silva*/

CREATE TABLE USUARIOS(
ID INT, 
NOME VARCHAR2(50), 
LOGIN VARCHAR2(20),  
CONSTRAINT USUARIOS_PK PRIMARY KEY(ID));

create sequence USUARIOS_SEQ minvalue 1 maxvalue 9999999999999999999999999999 start with 1 increment by 1 nocache;

create or replace procedure prc_usuarios(p_id         in int,
                                         p_nome      in varchar2,
                                         p_login          in varchar2) is
  pragma autonomous_transaction;
  v_seq number;
begin
  select nvl(max(id), 0) + 1 into v_seq from usuarios;
  --
  insert into usuarios
    (id, nome, login)
  values
    (p_id,
     p_nome,
     p_login);
  --
  commit; 
  --  
end;

begin
  prc_usuarios(p_id            => usuarios_seq.nextval,
               p_nome          => 'Stephanie',
               p_login         => NULL);
end;
















