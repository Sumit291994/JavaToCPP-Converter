%{
#include<stdio.h>
int a=0;
int cl_count=0;
int main_bracecount = -1;
int brace_count=-1;
int inherit_count=0;
char mainfunc[100];
char mainfunc2[1000]="";
%}
%START CLASS BDY EXTEND MAINF SOPLN1 SOPLN2
ALPHA [a-zA-Z]
NUM [0-9]
SPECIAL [+-*;]
obrace [\{]
cbrace [\}]
public "public"
private "private"
protected "protected"
static "static"
string "String"
newline "\n"
%%
<BDY>"public static void main(String ...args)" {
						BEGIN MAINF;
						strcpy(mainfunc,"int main()");
						}
<BDY>"System.out.println" {
			  printf("cout<<");
			  }
<BDY,MAINF>"System.out.println" {
				  strcat(mainfunc2,"cout<<");
				}

<BDY,MAINF>"{" {
		main_bracecount++;
		strcat(mainfunc2,yytext);
	       }

<BDY,MAINF>"}" {
		main_bracecount--;
		if(main_bracecount==-1)
			{
			BEGIN 0;
			strcat(mainfunc2,"return 0;\n}");
			}
		else
			{
			strcat(mainfunc2,yytext);
			}
	       }

"{" { 
	if(brace_count==-1) 
		{
		BEGIN BDY; 
		brace_count++; 
		printf(" { \n");
		} 
	else 
		{
		brace_count++; 
		printf(" { \n");
		}
    }

"}" { 
	if(brace_count==0) 
		{
		brace_count--;
		printf(" }; \n");
		} 
	else if(brace_count == -1)
		{
		printf("Error : Unmatched Braces");
		}
	else 
		{
		brace_count--; 
		printf(" } \n");
		} 
    }

<BDY>"String " {
		printf("char* ");
	       }

<BDY>[ a-zA-Z_\(\)\:\;\\]|"\n"|"\"" {
					printf("%s",yytext);
				    }

<BDY,MAINF>[ a-zA-Z;0-9=\+\-\*\/:\[\]\(\)&,\^_!\|\?\>\<\.\\]|"\n"|"\""	{ 
									strcat(mainfunc2,yytext);
									}

"public " { 
	   if(cl_count==0)
 		{ 
		printf(" "); 
		}
	   else
		{
		printf("public ");
		}
 	  }

"private " { 
	    if(cl_count==0) 
		{ 
		printf(" "); 
		} 
	    else 
		{
		printf("private ");
		} 
	   }

"class " { 
	 BEGIN CLASS; 
	 cl_count=1;
	 printf("class "); 
	 }

<EXTEND>[a-zA-Z_]+ { 
		   printf(" %s" , yytext);
		   BEGIN 0;
		   }

<CLASS>[a-zA-Z_]+ {
		  printf(" %s" , yytext);
		  BEGIN 0;
		  }

"extends " { 
	   if(inherit_count==0) 
		{
		inherit_count = 1;
		BEGIN EXTEND; 
		printf(" : ");
		} 
	   else 
		{ 
		printf("Java Error");
		}
	   }

"\n"+ 	{ 
	printf("\n"); 
	}

#["\t"]+|[" "]+ {  }
%%

int main()
	{
	if(a==0)
		{
		a=1;
		printf("#include<iostream>\nusing namespace std;\n");
		}
	yylex();
	if(brace_count==-1)
		{
		printf("%s",mainfunc);
		printf("%s",mainfunc2);
		}
	return 0;
	}

