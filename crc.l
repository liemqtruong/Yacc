%{
  #include "dstruct.h"
  #include "crc.tab.y"
  #include <string.h>

%}

%%
[ \t\n]*  {}

ALL                { return ALL; }

[0-9]+          { yylval.nval=atoi(yytext); printf ("Digit %d\n", yylval.nval); return DIGIT; }    /* convert to natural number */
[a-zA-Z]+       { printf ("%s\n", yytext); strcpy(yylval.stval,yytext); return STRING; }
#[a-zA-Z]*      { printf ("%s\n", yytext); strcpy(yylval.stval,yytext); /*return COMMENT;*/ }
\(              { printf ("%s\n", yytext); return SERIAL_LIST_BEGIN_1; }                        /* May be BEGIN here */
\)              { printf ("%s\n", yytext); return SERIAL_LIST_END_1; }
\[              { printf ("%s\n", yytext); return SERIAL_LIST_BEGIN_2; }
\]              { printf ("%s\n", yytext); return SERIAL_LIST_END_2; }
,               { printf ("%s\n", yytext); return SERIAL_ITEM_SEPARATOR; }

[\^]             { yyerror ("No token found !") ; }

%%

/*
[1]                { return ONE;}
[2]                { return TWO;}
[3]                { return THREE; }
[4]                { return FOUR; }
[5]                { return FIVE; }
[6]                { return SIX; }
[7]                { return SEVEN; }
[8]                { return EIGHT; }
[9]                { return NINE; }
[10]               { return TEN; }
[11]               { return ELEVEN; }
[12]               { return TWELVE; }
[13]               { return THIRTEEN; }
*/


