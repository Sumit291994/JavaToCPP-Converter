%{
#include<stdio.h>
#include<stdlib.h>
%}
%token ACCESS
%token CLAS
%token INHERIT
%token INHERITCLASS
%token BRACE
%token BODY
%token NAME
%token CLOSEBRACE
%token NEWLINE
%start START
%%
START	:	ACCESS AC { printf("VALID CLASS\n"); exit(0); }
		| AC { printf("VALID CLASS\n"); exit(0); }
		;

AC	:	CLAS NAME CL
		;

CL	:	INHERIT INHERITCLASS CL
		| NEWLINE BRACE B
		| BRACE B
		;

B	:	NEWLINE BODY B
		| BODY B
		| CEND
		;

CEND	:	NEWLINE CLOSEBRACE
		| CLOSEBRACE
		;

%%
#include "lex.yy.c"
int yywrap()
{ }

yyerror()
	{ 
	printf("ERROR\n"); 
	}

int main()
	{
	yyparse();
	return 0;
	}

