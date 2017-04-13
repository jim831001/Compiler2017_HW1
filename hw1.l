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
	However, the four basic functions mu
	st be finished.
*/
	typedef struct Symbol_Table {
		char* id;
		char* type;
		struct Symbol_Table *next;
	} ST;	

	ST *head,*mov_head,*camp_head;
	
	void create_symbol();
	void insert_type();
	void insert_symbol();
	int lookup_symbol();
	void dump_symbol();
	int linenum = 0;
	int iscreated = 0;
%}

/*	define regular expression label */

letter [a-zA-Z]
digit [0-9]
id {letter}+({letter}|{digit})*
comment "(*"([^*]|\n|"*"+[^)])*"*"+")"

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

int		{printf("%s \t INT \n",yytext); insert_type("INT");}
double  {printf("%s \t DOUBLE \n",yytext); insert_type("DOUBLE");}
char	{printf("%s \t CHAR \n",yytext); insert_type("CHAR");}
print	{printf("%s \t PRINT \n",yytext); }
if		{printf("%s \t IF \n",yytext); }
else	{printf("%s \t ELSE \n",yytext); }
while	{printf("%s \t WHILE \n",yytext); }
return	{printf("%s \t RETURN \n",yytext); }
break	{printf("%s \t BREAK \n",yytext); }
read	{printf("%s \t READ \n",yytext); }

 /*Identifiers*/
 
{id} {printf("%s \t ID \n",yytext); insert_symbol(yytext);}

 /*Integer Constants*/
 
{digit}+	{printf("%s \t INT NUM \n",yytext); }
[-+]?{digit}*\.?{digit}+	{printf("%s \t FLOAT NUM \n",yytext); }
 
 /*String Constants*/
 
["][0-9a-zA-z]["] {printf("%s \t ID \n",yytext); }

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
	dump_symbol(); //Print the symbol table

	return 0;
}

int yywrap(void) {
    return 1;
}

void create_symbol(){
	head = (ST*)malloc(sizeof(ST));
	mov_head = head;
	printf("Create a symbol table\n");
}

void insert_type(char* s){
	//printf("The type is: %s\n", s);
	char *tstr = malloc(sizeof(char)*strlen(s));
	strcpy(tstr,s);
	if (iscreated == 0){
		create_symbol();
		iscreated = 1;
	}	
	mov_head->type = tstr;
	//printf("The type is: %s\n", mov_head->type);
	
}

void insert_symbol(char* s){
	char *cstr = malloc(sizeof(char)*strlen(s));
	strcpy(cstr,s);
	int result = 0;
	int isrepeat = 0;
	camp_head = head;
	while(camp_head->next != NULL){
		result = strcmp(cstr, camp_head->id);
		if (result == 0){ //找到相同的Symbol
			isrepeat = 1;	
		}	
		camp_head = camp_head->next;
	}	
	if (isrepeat == 1){	
		//printf("Repeat!\n");
	}else if (isrepeat == 0){
		mov_head->id = cstr;
		printf("Insert a symbol: %s\n", mov_head->id);
		ST *tmp = (ST*)malloc(sizeof(ST));
		mov_head->next = tmp;
		mov_head = tmp;
		mov_head->next = NULL;
		tmp=NULL;	
		free(tmp);
	}
}
	


int lookup_symbol(char* sym){

}

void dump_symbol(){
	int index = 1;
	printf("The symbol table dump\n");
	mov_head = head;
	while(mov_head->next != NULL){
		printf("%d , %s , %s\n", index++, mov_head->id, mov_head->type);
		mov_head = mov_head->next;	
	}		
}
