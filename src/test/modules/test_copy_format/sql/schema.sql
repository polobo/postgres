CREATE SCHEMA test_schema;
CREATE EXTENSION test_copy_format WITH SCHEMA test_schema;
CREATE TABLE public.test (a smallint, b integer, c bigint);
INSERT INTO public.test VALUES (1, 2, 3), (12, 34, 56), (123, 456, 789);

-- Qualified name
COPY public.test FROM stdin WITH (FORMAT 'test_schema.test_copy_format');
\.
COPY public.test TO stdout WITH (FORMAT 'test_schema.test_copy_format');

-- No schema, no search path
COPY public.test FROM stdin WITH (FORMAT 'test_copy_format');
COPY public.test TO stdout WITH (FORMAT 'test_copy_format');

-- No schema, with search path
SET search_path = test_schema,public;
COPY public.test FROM stdin WITH (FORMAT 'test_copy_format');
\.
COPY public.test TO stdout WITH (FORMAT 'test_copy_format');
RESET search_path;

DROP TABLE public.test;
DROP EXTENSION test_copy_format;
DROP SCHEMA test_schema;
