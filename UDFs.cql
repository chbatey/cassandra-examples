CREATE FUNCTION some_function ( arg int )  CALLED ON NULL INPUT RETURNS int LANGUAGE java AS $$ return arg; $$;

CREATE FUNCTION name ( first_name text, last_name text )  CALLED ON NULL INPUT RETURNS text LANGUAGE java AS $$ return first_name + " " + last_name; $$;

CREATE FUNCTION countEventTypes( state map<text, int>, type text ) CALLED ON NULL INPUT RETURNS map<text, int> LANGUAGE java AS ' Integer count = (Integer) state.get(type);  if (count == null) count = 1; else count = count + 1; state.put(type, count); return state; ' ;

CREATE OR REPLACE AGGREGATE count_by_type(map<text, int>) SFUNC countEventTypes STYPE map<text, int> INITCOND {};

INSERT INTO customer_events(customer_id , t, event_type , origin ) values ('chbatey', now(), 'login', 'IOS');
INSERT INTO customer_events(customer_id , t, event_type , origin ) values ('chbatey', now(), 'logout', 'IOS');
select count_by_type(event_type) from customer_events ;
CREATE TABLE customer_events(customer_id text , t timeuuid, event_type text , origin text , primary KEY (customer_id , t));
