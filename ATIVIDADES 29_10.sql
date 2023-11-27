/*



1- Crie uma tabela de log com os seguintes campos.
id NUMBER,
data DATE,
usuario VARCHAR2(50),
desc_objeto VARCHAR2(500),
desc_slqerror VARCHAR2(4000),
desc_log VARCHAR2(4000)
*/
create table log(
id NUMBER,
data DATE,
usuario VARCHAR2(50),
desc_objeto VARCHAR2(500),
desc_slqerror VARCHAR2(4000),
desc_log VARCHAR2(4000),
CONSTRAINT LOG_pk PRIMARY KEY (id) 
);

create sequence log_seq
minvalue 1
maxvalue 9999999999999999999999999999
start with 2
increment by 1
nocache;

/*
Após isso crie uma procedure que irá popular esta tabela.
*/

create or replace package pck_logs is

  procedure prc_logs_dml(p_dml           in varchar2,
                         P_id            in out log.id%type,
                         P_data          in out log.data%type,
                         P_usuario       in out log.usuario%type,
                         P_desc_objeto   in out log.desc_objeto%type,
                         P_desc_slqerror in out log.desc_slqerror%type,
                         P_desc_log      in out log.desc_log%type,
                         p_msg           out varchar2);

end pck_logs;

create or replace package body pck_logs is


  procedure prc_logs_dml(p_dml            in varchar2,
                              P_id    out  log.id%type,
                              P_data     out  log.data%type,
                              P_usuario          out log.usuario%type,
                              P_desc_objeto   in out log.desc_objeto%type,
                              P_desc_slqerror     in out log.desc_slqerror%type,
                              P_desc_log     in out log.desc_log%type,
                              p_msg            out varchar2) is
  begin
    if p_dml = 'I' then

      if P_id is null then
        select log_seq.nextval into P_id from dual;
      end if;
      begin
  insert into log
    (id, data, usuario, desc_objeto, desc_slqerror, desc_log)
  values
    (p_id, p_data, p_usuario, p_desc_objeto, p_desc_slqerror, p_desc_log);
        p_msg := 'Registro inserido com sucesso!';
      exception
        when others then
          p_msg := 'Falha ao inserir registro. Entre em contato com o suporte! ' ||
                   sqlerrm;
      end;
    else
      p_msg := 'Operação não tratada. Entre em contato com o suporte!';
    end if;
  end prc_logs_dml;
  begin
  -- Initialization
  null;
  end pck_logs;







/*
2 - Crie uma trigger para a tabela de funcionários e para cada vez que um registro de salário, cargo ou departamento for alterado deve ser
inserido um log de monitoramento na tabela do exercício 1.
*/

create or replace trigger trg_employees
  after update on employees
  for each row
declare
var_operacao char(1);
begin
   if updating and :old.salary <> :new.salary then
     dbms_output.put_line('Salário alterado.');
   insert into log
   (id, data, usuario, desc_objeto, desc_slqerror, desc_log)
   values
   (log_seq.nextval, sysdate, user, 'Tabela employees', '',:old.salary || :new.salary);
   elsif updating and :old.job_id <> :new.job_id then
     dbms_output.put_line('Cargo alterado.');
     insert into log
     (id, data, usuario, desc_objeto, desc_slqerror, desc_log)
     values
   (log_seq.nextval, sysdate, user, 'Tabela employees', '',:old.job_id || ' - ' || :new.job_id);
   elsif updating and :old.department_id <> :new.department_id then
         dbms_output.put_line('Departamento alterado.');
     insert into log
     (id, data, usuario, desc_objeto, desc_slqerror, desc_log)
     values
   (log_seq.nextval, sysdate, user, 'Tabela employees', '',:old.department_id || ' - ' || :new.department_id);
   else
     dbms_output.put_line('Erro.');
   end if;
end trg_employees;


/*
3 - Edite a producedure pck_funcionarios criada emexercícios anteriores e crie uma procedure para efetuar um percentual de aumento de salarios.
Deve ser informado o id do funcionário, o % de aumento e de retorno deve voltar o nome do funcionário, salário antigo e salário novo com o % de
aumento.
*/

/************************************************************************/

/*
4 - Crie uma tabela chamada clientes com os campos (id, nome, telefone);
Após isso crie uma trigger que irá inserir a sequence no id quando informado um valor nulo.
(Ná vídeo aula tem um exemplo caso alguem tenha dúvidas.)
*/

create table clientes_1(
id int,
nome varchar2(100),
telefone varchar2(20)
);

create sequence clientes_1_seq
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;

create or replace trigger trg_clientes
  before insert on clientes_1
  for each row
  when (new.id is null)
begin
  select clientes_1_seq.nextval into :new.id from dual;
end trg_clientes;

/*select * from log

update clientes_1
set nome = 'Lukão'
where nome = 'Lukas'*/
/*
5 - Altere trigger criada no exercício 4 e todas as vezes que for alterado o nome ou telefone de um cliente, e SOMENTE quando
o valor realmente for alterado, deve ser inserido um registro de log na tabela do exercício 1.
No log deve conter informação de usuário, data, tabela alterada, e log informando o id do registro alterado a informação antiga e a nova.
*/

create or replace trigger trg_clientes
  after update on clientes_1
  for each row
declare
var_operacao char(1);
begin
   if updating and :old.nome <> :new.nome then
     dbms_output.put_line('Nome alterado.');
   insert into log
   (id, data, usuario, desc_objeto, desc_slqerror, desc_log)
   values
   (log_seq.nextval, sysdate, user, 'Tabela Cliente_01', '',:old.nome || :new.nome);
   elsif updating and :old.telefone <> :new.telefone then
     dbms_output.put_line('Telefone alterado.');
     insert into log
     (id, data, usuario, desc_objeto, desc_slqerror, desc_log)
     values
   (log_seq.nextval, sysdate, user, 'Tabela Cliente_01', '',:old.telefone || ' - ' || :new.telefone);
   else
     dbms_output.put_line('Erro.');
   end if;
end trg_clientes;

/*
6 - Na atividade da aula do dia 28/10 foi criada a pck_funcionarios. Faça a mesma lógica desta package mas agora para as seguintes tabelas:



regions - pck_regions
*/
create or replace package pck_regions is

  procedure prc_regions_dml(p_dml         in varchar2,
                            P_region_id   in out regions.region_id%type,
                            P_region_name in out regions.region_name%type,
                            p_msg         out varchar2);

end pck_regions;

create or replace package body pck_regions is

procedure prc_regions_dml(p_dml in varchar2, P_region_id in out regions.region_id%type, P_region_name in out regions.region_name%type, p_msg out varchar2) is
begin
if p_dml = 'I' then

if P_region_id is
null then select regions_seq.nextval into P_region_id from dual;
end if;
begin
insert into regions r(region_id, region_name) values(p_region_id, p_region_name); p_msg := 'Registro inserido com sucesso!';
exception
when others then p_msg := 'Falha ao inserir registro. Entre em contato com o suporte! ' || sqlerrm;
end; elsif p_dml = 'U' then
begin
update regions r set r.region_id = p_region_id, r.region_name = p_region_name where r.region_id = p_region_id; p_msg := 'Registro alterado com sucesso!';
exception
when others then p_msg := 'Falha ao alterar registro. Entre em contato com o suporte!';
end; elsif p_dml = 'D' then
begin
delete regions r where r.region_id = P_region_id; p_msg := 'Registro excluído com sucesso!';
exception
when others then p_msg := 'Falha ao remover registro. Entre em contato com o suporte!';
end; elsif p_dml = 'S' then
begin
select r.region_id, r.region_name

into p_region_id, p_region_name from regions r where r.region_id = P_region_id;
exception
when no_data_found then p_msg := 'Registro não encontrato.';
end; else p_msg := 'Operação não tratada. Entre em contato com o suporte!';
end if;

end prc_regions_dml;
--

begin
-- Initialization
null;
end pck_regions;
/*
******************************************************************

locations - pck_locations
departments - pck_departments



OBS.: as mesmas deve conter as mesmas lógicas que na pck_funcionarios.prc_employees_dml feita em aula. Somente para essas outras três tabelas.



*/


























