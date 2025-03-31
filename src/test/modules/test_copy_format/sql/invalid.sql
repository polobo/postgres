CREATE SCHEMA test_schema;
CREATE EXTENSION test_copy_format WITH SCHEMA test_schema;
CREATE TABLE public.test (a smallint, b integer, c bigint);
INSERT INTO public.test VALUES (1, 2, 3), (12, 34, 56), (123, 456, 789);

SET search_path = public,test_schema;
COPY public.test FROM stdin WITH (FORMAT 'test_copy_format_wrong_input_type');
COPY public.test TO stdout WITH (FORMAT 'test_copy_format_wrong_input_type');
COPY public.test FROM stdin WITH (FORMAT 'test_copy_format_wrong_return_type');
COPY public.test TO stdout WITH (FORMAT 'test_copy_format_wrong_return_type');
COPY public.test FROM stdin WITH (FORMAT 'test_copy_format_wrong_return_value');
COPY public.test TO stdout WITH (FORMAT 'test_copy_format_wrong_return_value');
RESET search_path;

COPY public.test FROM stdin WITH (FORMAT 'test_schema.test_copy_format_wrong_input_type');
COPY public.test TO stdout WITH (FORMAT 'test_schema.test_copy_format_wrong_input_type');
COPY public.test FROM stdin WITH (FORMAT 'test_schema.test_copy_format_wrong_return_type');
COPY public.test TO stdout WITH (FORMAT 'test_schema.test_copy_format_wrong_return_type');
COPY public.test FROM stdin WITH (FORMAT 'test_schema.test_copy_format_wrong_return_value');
COPY public.test TO stdout WITH (FORMAT 'test_schema.test_copy_format_wrong_return_value');

COPY public.test FROM stdin WITH (FORMAT 'nonexistent');
COPY public.test TO stdout WITH (FORMAT 'nonexistent');
COPY public.test FROM stdin WITH (FORMAT 'invalid.qualified.name');
COPY public.test TO stdout WITH (FORMAT 'invalid.qualified.name');

DROP TABLE public.test;
DROP EXTENSION test_copy_format;
DROP SCHEMA test_schema;
