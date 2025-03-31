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
#include "commands/copyfrom_internal.h"
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
	int			n_attributes = list_length(cstate->attnumlist);
	char	   *line;
	int			line_size = n_attributes + 1;	/* +1 is for new line */
	int			read_bytes;

	ereport(NOTICE, (errmsg("CopyFromOneRow")));

	cstate->cur_lineno++;
	line = palloc(line_size);
	read_bytes = CopyFromStateGetData(cstate, line, line_size, line_size);
	if (read_bytes == 0)
		return false;
	if (read_bytes != line_size)
		ereport(ERROR,
				(errcode(ERRCODE_BAD_COPY_FILE_FORMAT),
				 errmsg("one line must be %d bytes: %d",
						line_size, read_bytes)));

	if (cstate->cur_lineno == 1)
	{
		/* Success */
		TupleDesc	tupDesc = RelationGetDescr(cstate->rel);
		ListCell   *cur;
		int			i = 0;

		foreach(cur, cstate->attnumlist)
		{
			int			attnum = lfirst_int(cur);
			int			m = attnum - 1;
			Form_pg_attribute att = TupleDescAttr(tupDesc, m);

			if (att->atttypid == INT2OID)
			{
				values[i] = Int16GetDatum(line[i] - '0');
			}
			else if (att->atttypid == INT4OID)
			{
				values[i] = Int32GetDatum(line[i] - '0');
			}
			else if (att->atttypid == INT8OID)
			{
				values[i] = Int64GetDatum(line[i] - '0');
			}
			nulls[i] = false;
			i++;
		}
	}
	else if (cstate->cur_lineno == 2)
	{
		/* Soft error */
		TupleDesc	tupDesc = RelationGetDescr(cstate->rel);
		int			attnum = lfirst_int(list_head(cstate->attnumlist));
		int			m = attnum - 1;
		Form_pg_attribute att = TupleDescAttr(tupDesc, m);
		char		value[2];

		cstate->cur_attname = NameStr(att->attname);
		value[0] = line[0];
		value[1] = '\0';
		cstate->cur_attval = value;
		errsave((Node *) cstate->escontext,
				(
				 errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
				 errmsg("invalid value: \"%c\"", line[0])));
		CopyFromSkipErrorRow(cstate);
		cstate->cur_attname = NULL;
		cstate->cur_attval = NULL;
		return true;
	}
	else
	{
		/* Hard error */
		ereport(ERROR,
				(errcode(ERRCODE_BAD_COPY_FILE_FORMAT),
				 errmsg("too much lines: %llu",
						(unsigned long long) cstate->cur_lineno)));
	}

	return true;
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
