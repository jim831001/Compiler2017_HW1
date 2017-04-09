/*
	Topic: Homework1 for Compiler Course
	Deadline: 04.14.2359
*/

%{

/*	Definition section */

/*	insert the C library and variables you need */

	#include <stdio.h>
	#include <stdlib.h>
	#include <ctype.h>
	#include <string.h>
	
/*
	Symbol table function

	TAs create the basic function which you have to fill.
	We encourage you define new function to make the program work better.
	However, the four basic functions must be finished.
*/
	void create_symbol();
	void insert_symbol();
	int lookup_symbol();
	void dump_symbol();
	int linenum = 0;

%}

/*	define regular expression label */

letter [a-zA-Z]
digit [0-9]
id {letter}+({letter}|{digit})*

%%

 /*	Rules section */

 /* Delimiters(Parser) */

"," {printf("%s \t COMMA \n",yytext); }
";" {printf("%s \t SEMI \n",yytext); }
"(" {printf("%s \t L_ROUND \n",yytext); }
")" {printf("%s \t R_ROUND \n",yytext); }
"[" {printf("%s \t L_SQUARE \n",yytext); }
"]" {printf("%s \t R_SQUARE \n",yytext); }
"{" {printf("%s \t L_CURLY \n",yytext); }
"}" {printf("%s \t R_CURLY \n",yytext); }

 /*Operators(Parser)*/
 
"+" {printf("%s \t ADD \n",yytext);}
"-" {printf("%s \t MINUS \n",yytext);}
"*" {printf("%s \t MULTI \n",yytext);}
"/" {printf("%s \t DIVIDE \n",yytext);}
"^" {printf("%s \t EXPO \n",yytext);}
"%" {printf("%s \t REMAIN \n",yytext);}
"<" {printf("%s \t LESS \n",yytext);}
"<=" {printf("%s \t LESS_EQUAL \n",yytext);}
">=" {printf("%s \t GREATER_EREQUAL \n",yytext);}
">" {printf("%s \t GREATER \n",yytext);}
"==" {printf("%s \t EQUAL \n",yytext);}
"!=" {printf("%s \t NOT_EQUAL \n",yytext);}
"="	{printf("%s \t ASSIGN \n",yytext);}

 /* Keywords(Parser) */ 

int		{printf("%s \t INT \n",yytext); }
double  {printf("%s \t DOUBLE \n",yytext); }
print	{printf("%s \t PRINT \n",yytext); }
if		{printf("%s \t IF \n",yytext); }
else	{printf("%s \t ELSE \n",yytext); }
while	{printf("%s \t WHILE \n",yytext); }
char	{printf("%s \t CHAR \n",yytext); }
return	{printf("%s \t RETURN \n",yytext); }
break	{printf("%s \t BREAK \n",yytext); }
read	{printf("%s \t READ \n",yytext); }



 /*Identifiers*/
 
{id} {printf("%s \t ID \n",yytext); }

 /*Integer Constants*/
 
{digit}+	{printf("%s \t NUM \n",yytext); }
 
 /*String Constants*/
 
["][0-9a-zA-z]["] {printf("%s \t QUO_ID_QOU \n",yytext); }

 /* Comment Section */
 
[/][/].* 	{printf("COMMENT: %s ",yytext);}

 /*Token will be discarded*/

[ \t\0]	{;}
[\n]	{;}
.		{;}

%%

/*	C Code section */

/*	You have to define your C function in this section */

int main(int argc,char *argv[]){

	yyin = fopen(argv[1],"r");
	yylex();
	dump_symbol();

	return 0;
}

int yywrap(void) {
    return 1;
}

void create_symbol(){

}

void insert_symbol(char* s){

}

int lookup_symbol(char* sym){

}

void dump_symbol(){
	
}
