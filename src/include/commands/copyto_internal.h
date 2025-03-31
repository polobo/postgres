/*-------------------------------------------------------------------------
 *
 * copyto_internal.h
 *	  Internal definitions for COPY TO command.
 *
 *
 * Portions Copyright (c) 1996-2025, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 *
 * src/include/commands/copyto_internal.h
 *
 *-------------------------------------------------------------------------
 */
#ifndef COPYTO_INTERNAL_H
#define COPYTO_INTERNAL_H

/*
 * Represents the different dest cases we need to worry about at
 * the bottom level
 */
typedef enum CopyDest
{
	COPY_DEST_FILE,				/* to file (or a piped program) */
	COPY_DEST_FRONTEND,			/* to frontend */
	COPY_DEST_CALLBACK,			/* to callback function */
} CopyDest;

#endif							/* COPYTO_INTERNAL_H */
