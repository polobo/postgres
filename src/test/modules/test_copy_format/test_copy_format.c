/*--------------------------------------------------------------------------
 *
 * test_copy_format.c
 *		Code for testing custom COPY format.
 *
 * Portions Copyright (c) 2025, PostgreSQL Global Development Group
 *
 * IDENTIFICATION
 *		src/test/modules/test_copy_format/test_copy_format.c
 *
 * -------------------------------------------------------------------------
 */

#include "postgres.h"

#include "commands/copyapi.h"
#include "commands/defrem.h"
#include "utils/builtins.h"

PG_MODULE_MAGIC;

static void
TestCopyFromInFunc(CopyFromState cstate, Oid atttypid,
				   FmgrInfo *finfo, Oid *typioparam)
{
	ereport(NOTICE, (errmsg("CopyFromInFunc: attribute: %s", format_type_be(atttypid))));
}

static void
TestCopyFromStart(CopyFromState cstate, TupleDesc tupDesc)
{
	ereport(NOTICE, (errmsg("CopyFromStart: the number of attributes: %d", tupDesc->natts)));
}

static bool
TestCopyFromOneRow(CopyFromState cstate, ExprContext *econtext, Datum *values, bool *nulls)
{
	ereport(NOTICE, (errmsg("CopyFromOneRow")));
	return false;
}

static void
TestCopyFromEnd(CopyFromState cstate)
{
	ereport(NOTICE, (errmsg("CopyFromEnd")));
}

static const CopyFromRoutine CopyFromRoutineTestCopyFormat = {
	.type = T_CopyFromRoutine,
	.CopyFromInFunc = TestCopyFromInFunc,
	.CopyFromStart = TestCopyFromStart,
	.CopyFromOneRow = TestCopyFromOneRow,
	.CopyFromEnd = TestCopyFromEnd,
};

static void
TestCopyToOutFunc(CopyToState cstate, Oid atttypid, FmgrInfo *finfo)
{
	ereport(NOTICE, (errmsg("CopyToOutFunc: attribute: %s", format_type_be(atttypid))));
}

static void
TestCopyToStart(CopyToState cstate, TupleDesc tupDesc)
{
	ereport(NOTICE, (errmsg("CopyToStart: the number of attributes: %d", tupDesc->natts)));
}

static void
TestCopyToOneRow(CopyToState cstate, TupleTableSlot *slot)
{
	ereport(NOTICE, (errmsg("CopyToOneRow: the number of valid values: %u", slot->tts_nvalid)));
}

static void
TestCopyToEnd(CopyToState cstate)
{
	ereport(NOTICE, (errmsg("CopyToEnd")));
}

static const CopyToRoutine CopyToRoutineTestCopyFormat = {
	.type = T_CopyToRoutine,
	.CopyToOutFunc = TestCopyToOutFunc,
	.CopyToStart = TestCopyToStart,
	.CopyToOneRow = TestCopyToOneRow,
	.CopyToEnd = TestCopyToEnd,
};

PG_FUNCTION_INFO_V1(test_copy_format);
Datum
test_copy_format(PG_FUNCTION_ARGS)
{
	bool		is_from = PG_GETARG_BOOL(0);

	ereport(NOTICE,
			(errmsg("test_copy_format: is_from=%s", is_from ? "true" : "false")));

	if (is_from)
		PG_RETURN_POINTER(&CopyFromRoutineTestCopyFormat);
	else
		PG_RETURN_POINTER(&CopyToRoutineTestCopyFormat);
}

PG_FUNCTION_INFO_V1(test_copy_format_wrong_return_value);
Datum
test_copy_format_wrong_return_value(PG_FUNCTION_ARGS)
{
	bool		is_from = PG_GETARG_BOOL(0);

	if (is_from)
		PG_RETURN_CSTRING(pstrdup("is_from=true"));
	else
		PG_RETURN_CSTRING(pstrdup("is_from=false"));
}
