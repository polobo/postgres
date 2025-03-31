CREATE EXTENSION test_copy_format;
CREATE TABLE public.test (a smallint, b integer, c bigint);
INSERT INTO public.test VALUES (1, 2, 3), (12, 34, 56), (123, 456, 789);

-- public.text must not be used
COPY public.test FROM stdin WITH (FORMAT text);
\.
COPY public.test TO stdout WITH (FORMAT text);
COPY public.test FROM stdin WITH (FORMAT 'pg_catalog.text');
\.
COPY public.test TO stdout WITH (FORMAT 'pg_catalog.text');

-- public.csv must not be used
COPY public.test FROM stdin WITH (FORMAT csv);
\.
COPY public.test TO stdout WITH (FORMAT csv);
COPY public.test FROM stdin WITH (FORMAT 'pg_catalog.csv');
\.
COPY public.test TO stdout WITH (FORMAT 'pg_catalog.csv');

-- public.binary must not be used
\getenv abs_builddir PG_ABS_BUILDDIR
\set filename :abs_builddir '/results/binary.data'
COPY public.test TO :'filename' WITH (FORMAT binary);
COPY public.test FROM :'filename' WITH (FORMAT binary);
COPY public.test TO :'filename' WITH (FORMAT 'pg_catalog.binary');
COPY public.test FROM :'filename' WITH (FORMAT 'pg_catalog.binary');

DROP TABLE public.test;
DROP EXTENSION test_copy_format;
