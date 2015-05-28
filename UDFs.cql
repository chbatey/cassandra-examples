CREATE FUNCTION some_function ( arg int )  CALLED ON NULL INPUT RETURNS int LANGUAGE java AS $$ return arg; $$;

CREATE FUNCTION name ( first_name text, last_name text )  CALLED ON NULL INPUT RETURNS text LANGUAGE java AS $$ return first_name + " " + last_name; $$;

// Max

CREATE FUNCTION maxI(current int, candidate int)
CALLED ON NULL INPUT
RETURNS int LANGUAGE java AS
'if (current == null) return candidate; else return Math.max(current, candidate);' ;

CREATE AGGREGATE maxAgg(int)
SFUNC maxI
STYPE int
INITCOND null;

CREATE TABLE keyvalue(key text , value int );
INSERT INTO keyvalue (key, value ) VALUES ( "chris", 5);
INSERT INTO keyvalue (key, value ) VALUES ( 'chris', 5);
INSERT INTO keyvalue (key, value ) VALUES ( 'luke', 10);
INSERT INTO keyvalue (key, value ) VALUES ( 'patrick', 15);
INSERT INTO keyvalue (key, value ) VALUES ( 'haddad', 20);

// Group By and Count

CREATE FUNCTION state_group_and_count( state map<text, int>, type text )
CALLED ON NULL INPUT
RETURNS map<text, int>
LANGUAGE java AS '
Integer count = (Integer) state.get(type);  if (count == null) count = 1; else count++; state.put(type, count); return state; ' ;

CREATE OR REPLACE AGGREGATE group_and_count(text)
SFUNC state_group_and_count
STYPE map<text, int>
INITCOND {};


CREATE TABLE customer_events(customer_id text, time timeuuid, event_type text, origin text, staff set<text>, PRIMARY KEY((customer_id), time));
INSERT INTO customer_events(customer_id , time, event_type , origin ) values ('chbatey', now(), 'login', 'IOS');
INSERT INTO customer_events(customer_id , time, event_type , origin ) values ('chbatey', now(), 'logout', 'IOS');
INSERT INTO customer_events(customer_id , time, event_type , origin ) values ('chbatey', now(), 'login', 'IOS');
INSERT INTO customer_events(customer_id , time, event_type , origin ) values ('chbatey', now(), 'watch_movie', 'IOS');

select group_and_count(event_type) from customer_events ;

// Group by and total

CREATE TABLE customer_purchases(customer_id text, time timeuuid, item text, amount int, primary key(customer_id, time));

INSERT INTO customer_purchases(customer_id ,time,  item , amount ) values ('chbatey', now(), 'batman', 100);
INSERT INTO customer_purchases(customer_id ,time,  item , amount ) values ('chbatey', now(), 'banana', 75);
INSERT INTO customer_purchases(customer_id ,time,  item , amount ) values ('chbatey', now(), 'cat', 50);
INSERT INTO customer_purchases(customer_id ,time,  item , amount ) values ('haddad', now(), 'house', 5000000);
INSERT INTO customer_purchases(customer_id ,time,  item , amount ) values ('haddad', now(), 'bread', 10);
INSERT INTO customer_purchases(customer_id ,time,  item , amount ) values ('haddad', now(), 'chips', 45);

CREATE FUNCTION state_group_and_total( state map<text, int>, type text, amount int )
CALLED ON NULL INPUT
RETURNS map<text, int>
LANGUAGE java AS '
Integer count = (Integer) state.get(type);  if (count == null) count = amount; else count = count + amount; state.put(type, count); return state; ' ;


CREATE OR REPLACE AGGREGATE group_and_total(text, int)
SFUNC state_group_and_total
STYPE map<text, int>
INITCOND {};