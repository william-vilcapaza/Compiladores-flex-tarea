%{
/*Libraries*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
FILE *yyin;
%}
/*OPTIONS SECTION*/
/* This tells Flex to read a single input file*/
%option noyywrap
/*This will allow us to get the line number*/
%option yylineno

/*TOKEN SECTION*/
LETTER          [a-zA-Z]
DIGIT           [0-9]
ESPACE          ["  "]
BEG_COMENT      ["/*"]
END_COMENT      ["*/"]
END_SENTENCE    [";"]
UNDERSCORE      [-_]
CHAR_DOT        ["."]

ID	            {LETTER}({LETTER}|{DIGIT})*
CONST_INTEGER   (-?[1-9][0-9]{0,4})|0
CONST_FLOAT     {DIGIT}{0,8}{CHAR_DOT}{DIGIT}{1,8}

/*Logical operators and basic arithmetic operators*/
OP_SUM          ["+"]
OP_SUBT         ["-"]
OP_MULT         ["*"]
OP_DIV          ["/"]
OP_EQ           ["="]
OP_GT           [">"]
OP_LT           ["<"]
OP_GOE          ">="
OP_LOE          "<="
OP_NOT          "!"
OP_NE           "!="

/*KEYWORDS*/
WHERE 	        [W|w][H|h][E|e][R|r][E|e]
FROM	        [F|f][R|r][O|o][M|n]
SELECT	        [S|s][E|e][L|l][E|e][C|c][T|t]

/*RULES AND SEMANTIC ACTION SECTION*/
%%
{END_SENTENCE}  { printf("\nEND_SENTENCE (%s)", yytext);}
{CONST_INTEGER} { fn_checkran(yytext), printf("\nCONST_INTEGER (%s)", yytext);}
{CONST_FLOAT}   { printf("\nCONST_FLOAT (%s)", yytext);}

{OP_SUM}        { printf("\nOP_SUM (%s)", yytext);}
{OP_SUBT}       { printf("\nOP_SUBT (%s)", yytext);}
{OP_MULT}       { printf("\nOP_MULT (%s)", yytext);}
{OP_DIV}        { printf("\nOP_DIV (%s)", yytext);}
{OP_EQ}         { printf("\nOP_EQ (%s)", yytext);}
{OP_GT}         { printf("\nOP_GT (%s)", yytext);}
{OP_LT}         { printf("\nOP_LT (%s)", yytext);}
{OP_GOE}        { printf("\nOP_GOE (%s)", yytext);}
{OP_LOE}        { printf("\nOP_LOE (%s)", yytext);}
{OP_NOT}        { printf("\nOP_NOT (%s)", yytext);}
{OP_NE}         { printf("\nOP_NE (%s)", yytext);}

{WHERE} 	    { printf("\nKEYWORD: (%s)", yytext); }
{FROM} 		    { printf("\nKEYWORD:(%s)", yytext); }
{SELECT}	    { printf("\nKEYWORD: (%s)", yytext);}
{ID}		    { printf("\nID: (%s)", yytext);}

"\n"
"\t"
" "
%%

int main(int argc, char *argv[])
{
    if( (yyin = fopen(argv[1], "rt")) == NULL){
        printf("\nCould not open file: %s\n", argv[1]);
        return 1;
    }
    else{
        printf("\nSuccessfully open file", argv[1]);
        yylex();
    }
    printf("\nFLEX has finished reading the file");
    fclose(yyin);
    return 0;
}
/*This function will help us to know if the value is within the range*/
int fn_checkran(char *ptr)
{
    int value = atoi(ptr);
    if( value < -32768 || value > 32768 )
    {
        printf("Error: variable out of range");
        return yyerror();
    }    
}

/*This function will return the error*/
int yyerror(void){
    printf("\n Lexical Error: Invalid Character: %s \n", yytext);
    exit(1);
}