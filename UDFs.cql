CREATE FUNCTION some_function ( arg int )  CALLED ON NULL INPUT RETURNS int LANGUAGE java AS $$ return arg; $$;

CREATE FUNCTION name ( first_name text, last_name text )  CALLED ON NULL INPUT RETURNS text LANGUAGE java AS $$ return first_name + " " + last_name; $$;
