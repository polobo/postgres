/*-------------------------------------------------------------------------
 *
 * copyapi.h
 *	  API for COPY TO/FROM handlers
 *
 *
 * Portions Copyright (c) 1996-2025, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 *
 * src/include/commands/copyapi.h
 *
 *-------------------------------------------------------------------------
 */
#ifndef COPYAPI_H
#define COPYAPI_H

#include "commands/copy.h"

/*
 * API structure for a COPY TO format implementation. Note this must be
 * allocated in a server-lifetime manner, typically as a static const struct.
 */
typedef struct CopyToRoutine
{
	NodeTag		type;

	/*
	 * Set output function information. This callback is called once at the
	 * beginning of COPY TO.
	 *
	 * 'atttypid' is the OID of data type used by the relation's attribute.
	 *
	 * 'finfo' can be optionally filled to provide the catalog information of
	 * the output function.
	 */
	void		(*CopyToOutFunc) (CopyToState cstate, Oid atttypid,
								  FmgrInfo *finfo);

	/*
	 * Start a COPY TO. This callback is called once at the beginning of COPY
	 * TO.
	 *
	 * 'tupDesc' is the tuple descriptor of the relation from where the data
	 * is read.
	 */
	void		(*CopyToStart) (CopyToState cstate, TupleDesc tupDesc);

	/*
	 * Write one row stored in 'slot' to the destination.
	 */
	void		(*CopyToOneRow) (CopyToState cstate, TupleTableSlot *slot);

	/*
	 * End a COPY TO. This callback is called once at the end of COPY TO.
	 */
	void		(*CopyToEnd) (CopyToState cstate);
} CopyToRoutine;

extern void CopyToStateFlush(CopyToState cstate);

/*
 * API structure for a COPY FROM format implementation. Note this must be
 * allocated in a server-lifetime manner, typically as a static const struct.
 */
typedef struct CopyFromRoutine
{
	NodeTag		type;

	/*
	 * Set input function information. This callback is called once at the
	 * beginning of COPY FROM.
	 *
	 * 'atttypid' is the OID of data type used by the relation's attribute.
	 *
	 * 'finfo' can be optionally filled to provide the catalog information of
	 * the input function.
	 *
	 * 'typioparam' can be optionally filled to define the OID of the type to
	 * pass to the input function.
	 */
	void		(*CopyFromInFunc) (CopyFromState cstate, Oid atttypid,
								   FmgrInfo *finfo, Oid *typioparam);

	/*
	 * Start a COPY FROM. This callback is called once at the beginning of
	 * COPY FROM.
	 *
	 * 'tupDesc' is the tuple descriptor of the relation where the data needs
	 * to be copied. This can be used for any initialization steps required by
	 * a format.
	 */
	void		(*CopyFromStart) (CopyFromState cstate, TupleDesc tupDesc);

	/*
	 * Read one row from the source and fill *values and *nulls.
	 *
	 * 'econtext' is used to evaluate default expression for each column that
	 * is either not read from the file or is using the DEFAULT option of COPY
	 * FROM. It is NULL if no default values are used.
	 *
	 * Returns false if there are no more tuples to read.
	 */
	bool		(*CopyFromOneRow) (CopyFromState cstate, ExprContext *econtext,
								   Datum *values, bool *nulls);

	/*
	 * End a COPY FROM. This callback is called once at the end of COPY FROM.
	 */
	void		(*CopyFromEnd) (CopyFromState cstate);
} CopyFromRoutine;

extern int	CopyFromStateGetData(CopyFromState cstate, void *dest, int minread, int maxread);

extern void CopyFromSkipErrorRow(CopyFromState cstate);

#endif							/* COPYAPI_H */
