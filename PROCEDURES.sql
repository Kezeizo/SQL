create procedure primeira_proc as
begin
  dbms_output.put_line('Minha primeira Procedure!!');
end;
/***************************************************************************/
begin
  primeira_proc;
end;
/***************************************************************************/
create or replace procedure prc_insere_cidade(pnome in varchar2) as
begin
  insert into regions
    (region_id, region_name)
  values
    (regions_seq.nextval, initcap(pnome));

/*exception
  when dup_val_on_index then
    raise_aplicattion_error(-20001, 'Registro já cadastrado!');*/
end;
/***************************************************************************/
begin
  prc_insere_cidade('Sul');
end;

select * from regions;

/***************************************************************************/
create or replace procedure prc_insere_locations(p_street_address  in locations.street_address%type,
                                                 p_postal_code    in locations.postal_code%type,
                                                 p_city           in locations.city%type,
                                                 p_state_province in locations.state_province%type,
                                                 p_country_id     in locations.country_id%type,
                                                 p_location_id   out locations.location_id%type) as  
begin
  select locations_seq.nextval into p_location_id from dual;
  
  insert into locations
  (location_id,
   street_address,
   postal_code,
   city,
   state_province,
   country_id)
  values 
  (p_location_id,
  p_street_address,
  p_postal_code,
  p_city,
  p_state_province,
  p_country_id);
  
end;

select * from locations;

declare
v_location_id integer;
begin
  prc_insere_locations(p_street_address => 'Rua Antônio Scheidt',
                       p_postal_code => '82630-330',                   
                       p_city => 'Curitiba',        
                       p_state_province => 'Paraná',
                       p_country_id => 'BR',
                       p_location_id => v_location_id);        

dbms_output.put_line('ID: ' || v_location_id);

end;                              
                       
                       
                    


create or replace procedure prc_log_pop(p_DESC_LOG      in log.DESC_LOG%type,
                                        p_DESC_SLQERROR in log.DESC_SLQERROR%type,
                                        p_DESC_OBJETO   in log.DESC_OBJETO%type,
                                        p_USUARIO       in log.USUARIO%type,
                                        p_DATA          in log.DATA%type,
                                        p_ID            in log.ID%type,
                                        p_msg           out varchar2) as
begin
  select log_seq.nextval into p_id from dual;
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
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       


































