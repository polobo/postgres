/* src/test/modules/test_copy_format/test_copy_format--1.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION test_copy_format" to load this file. \quit

CREATE FUNCTION test_copy_format(internal)
	RETURNS copy_handler
	AS 'MODULE_PATHNAME', 'test_copy_format'
	LANGUAGE C;

CREATE FUNCTION test_copy_format_wrong_input_type(bool)
	RETURNS copy_handler
	AS 'MODULE_PATHNAME', 'test_copy_format'
	LANGUAGE C;

CREATE FUNCTION test_copy_format_wrong_return_type(internal)
	RETURNS bool
	AS 'MODULE_PATHNAME', 'test_copy_format'
	LANGUAGE C;

CREATE FUNCTION test_copy_format_wrong_return_value(internal)
	RETURNS copy_handler
	AS 'MODULE_PATHNAME', 'test_copy_format_wrong_return_value'
	LANGUAGE C;

CREATE FUNCTION text(internal)
	RETURNS copy_handler
	AS 'MODULE_PATHNAME', 'test_copy_format'
	LANGUAGE C;

CREATE FUNCTION csv(internal)
	RETURNS copy_handler
	AS 'MODULE_PATHNAME', 'test_copy_format'
	LANGUAGE C;

CREATE FUNCTION binary(internal)
	RETURNS copy_handler
	AS 'MODULE_PATHNAME', 'test_copy_format'
	LANGUAGE C;
