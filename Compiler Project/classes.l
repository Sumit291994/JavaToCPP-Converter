%{
#include<stdio.h>
int cl_count=0;
int brace_count=-1;
int inherit_count=0;
%}
%START CLASS BDY EXTEND
ALPHA [a-zA-Z]
NUM [0-9]
SPECIAL [+-*;]
%%
"public "|"private " { 
			if(cl_count==0) 
				{
				return ACCESS;
				} 
			else 
				{
				return BODY;
				} 
		     }

"class " { 
	BEGIN CLASS; 
	cl_count=1; 
	return CLAS; 
	}

<EXTEND>[a-zA-Z_]+ { 
			return INHERITCLASS; 
		   }

<CLASS>[a-zA-Z_]+ {
			return NAME; 
		  }

"extends " { 
		if(inherit_count==0) 
			{
			BEGIN EXTEND; 
			return INHERIT;
			} 
		else 
			{ 
			return BODY;
			} 
	   }

"{" { 
	if(brace_count==-1) 
		{
		BEGIN BDY; 
		brace_count++; 
		return BRACE;
		} 
	else 
		{
		brace_count++; 
		return BODY;
		} 
    }

<BDY>[a-zA-Z;0-9=\+\-\*\/:\[\]\(\)&,\^_!\|\?\>\<\.\\]+ { 
							return BODY; 
						       }

"}" { 
	if(brace_count==0) 
		{
		brace_count--; 
		return CLOSEBRACE;
		} 
	else 
		{
		brace_count--; 
		return BODY;
		} 
    }

["\n"]+ { 
	return NEWLINE; 
	}

#["\t"]+|[" "]+ {  }
%%

