create or replace function fnc_primeira_func return varchar2 as
begin
  if to_char(sysdate, 'HH24') < 12 then
    return 'Bom dia!';
  elsif to_char(sysdate, 'HH24') < 18 then
    return 'Boa tarde!'; else
      return 'Boa noite';
  end if;
  end;

  declare
    var_msg varchar2(15);
  begin
    var_msg := fnc_primeira_func;
    dbms_output.put_line(var_msg);
  end;

select fnc_primeira_func from dual;

/*****************************************************************************************/
create or replace function fnc_get_name_employees(pemployee_id in number) --default 1
  return varchar2 as
  var_nome varchar2(100);
begin
  select e.first_name || ' ' || e.last_name
    into var_nome
    from employees e
   where e.employee_id = pemployee_id;
  return var_nome;
exception
  when no_data_found then
    return 'Funcionário não encontrado!';
end;

select fnc_get_name_employees(e.employee_id) as nome, e.job_id
  from employees e




















