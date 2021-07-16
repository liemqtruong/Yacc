%{
  #include "dstruct.h"
  #ifndef debug
  #define debug 0
  #endif
  int yylineno;
  extern char* yytext; /*extern char* yytext[]*/
  extern FILE* outFile_p;

  void yyerror (char*);
  int yylex();
  int isatty(int);
  int noerror=1;
%}

%union{
 char stval[100];
 char* ptr;
 COLABR *colbr;
 ATTR *attr;
 RESPONS *resp;
 CARD *card;

 long nval;
 VERSION *version;

 }

%token ONE TWO THREE FOUR FIVE SIX SEVEN EIGHT NINE TEN ELEVEN TWELVE THIRTEEN
%token SERIAL_LIST_BEGIN_1  SERIAL_LIST_END_1
%token SERIAL_LIST_BEGIN_2  SERIAL_LIST_END_2
%token SERIAL_ITEM_SEPARATOR
%token ALL
%token STRING
%token DIGIT
%token EMPTY


/*%type <nval> digits*/
%type <stval> version
%type <nval> line_number
%type <stval> characters
%type <nval> length
%type <nval> unit_identifier
%type <nval> crc


%type <nval> database_type_identifier
%type <nval> PICC_software
%type <nval> Transceiver_software
%type <nval> Flash_Interface_software
%type <nval> Diagnostics_software
%type <nval> TAS_platform_software
%type <nval> VOBC_ATP_software
%type <nval> VOBC_ATO_software
%type <nval> wayside_interface_software
%type <nval> wayside_train_control_software
%type <nval> wayside_database_software
%type <nval> static_guideway_database
%type <nval> system_parameters_database
%type <nval> subsystem_configuration_database

%type <nval> VOBC
%type <nval> ZC_MAU
%type <nval> ZC_VIU
%type <nval> DSU
%type <nval> AMI
%type <nval> TOD
%type <nval> Datalogger

%type <nval> component_identifier
%type <nval> subsystem_type

%type <stval> compatibility_configuration
%type <stval> configuration_data


/*line_no length app_units unit_id natural_no crc*/

%start data
%%

data:version
     line_number
     length
     unit_identifier
     crc


component_identifier:DIGIT{} /* 1 to 13 only */

subsystem_type:DIGIT{}   /* 1 to 6 only */

/* TODO: Must guarantee that digit is <database type identifier> */
compatibility_configuration:DIGIT SERIAL_ITEM_SEPARATOR version line_number length configuration_data crc
          {
          }
          

configuration_data: SERIAL_LIST_BEGIN_2 component_items SERIAL_LIST_END_2

component_items :   component_item SERIAL_ITEM_SEPARATOR component_item 
                        |   component_item
                        |   EMPTY

component_item :   EMPTY


/*
<configuration_data> ::=    <serialization list begin 2>   
                                 <component items>   
                            <serialization list end 2>

<component_items> ::=   <component_item> SERIAL_ITEM_SEPARATOR <component_item> 
                        |   <component_item > 
                        |   <empty>

<component_item> ::=   SERIAL_LIST_BEGIN_1   
                            <component identifier> SERIAL_ITEM_SEPARATOR <list of component versions>
                       SERIAL_LIST_END_1


<list of component versions> ::=   <serialization list begin 2>   
                                       <component version>   <serialization item seperator>   <component version> 
                                       |   <component version> 
                                       |   <empty>   
                                   <serialization list end 2>

<component version>  ::=   <serialization list begin 1> 
                                <version> <serialization item seperator> <list of unit configurations> 
                           <serialization list end 1> 

<list of unit configurations> ::=   <serialization list begin 2>   
                                        <unit configuration>   <serialization item seperator>   <unit configuration> 
                                        |   <unit configuration> 
                                        |   <empty>   
                                    <serialization list end 2>

<unit configuration> ::=   <serialization list begin 1> 
                               <subsystem type> <serialization item seperator> <applicable units> 
                           <serialization list end 1>


<applicable units> ::=   ALL 
                         |   <unit range> 
                         |   <unit list> 
                         |   <unit identifier>


<unit range> ::=   <serialization list begin 1>   
                        <low unit identifier> - <high unit identifier>   
                   <serialization list end 1>


<low unit identifier> ::= <unit identifier>


<high unit identifier> ::= <unit identifier>


<unit list> ::=    <serialization list begin 2>    
                      <unit identifier>   <serialization item seperator>   <unit identifier> 
                      |   <unit identifier> 
                      |   <empty>   
                   <serialization list end 2>
*/

version:STRING
         {
         }


line_number:DIGIT
            {
            }

characters:STRING
           {
           }
           | /* empty */

length:DIGIT
       {
       }

unit_identifier:DIGIT
                {
                }
crc:DIGIT
   {
   }



database_type_identifier:SIX{}
PICC_software:ONE {}
Transceiver_software:TWO {}
Flash_Interface_software:THREE {}
Diagnostics_software:FOUR {}
TAS_platform_software:FIVE {}
VOBC_ATP_software:SIX {}
VOBC_ATO_software:SEVEN {}
wayside_interface_software:EIGHT {}
wayside_train_control_software:NINE {}
wayside_database_software:TEN {}
static_guideway_database:ELEVEN {}
system_parameters_database:TWELVE {}
subsystem_configuration_database:THIRTEEN {}
VOBC:ONE {}
ZC_MAU:TWO {}
ZC_VIU:THREE {}
DSU:FOUR {}
AMI:FIVE {}
TOD:SIX {}
Datalogger:SEVEN {}


component_identifier:PICC_software  {}
|Transceiver_software  {}
|Flash_Interface_software  {}
|Diagnostics_software  {}
|TAS_platform_software  {}
|VOBC_ATP_software  {}
|VOBC_ATO_software  {}
|wayside_interface_software  {}
|wayside_train_control_software  {}
|wayside_database_software  {}
|static_guideway_database  {}
|system_parameters_database  {}
|subsystem_configuration_database  {}



subsystem_type:VOBC
|ZC_MAU    {}
|ZC_VIU    {}
|DSU    {}
|AMI    {}
|TOD    {}
|Datalogger    {}



/*********************************
data:digits
{
   if (noerror)
      printf ("Digits\n");
}

digits:DIGIT
       {
          if (noerror)
             printf ("\tTerminal\n");
       }
       |digits DIGIT
       {
          if (noerror)
             printf ("\tNested digits\n");
       }
***********************************/

%option noyywrap
#include<stdio.h>
#include <iostream.h>
#include <string.h>
extern void yyerror(char* msg)
{
 noerror=0;
 if(strcmp(msg,"syntax error"))
  printf(" Syntax Error in Line : %d : %s\n",yylineno,msg);
}

int
yyparse (char const *file)
{
	yyin = fopen (file, "r");
	if (!yyin)
		exit (2);
	/* One token only. */
	yylex ();
	if (fclose (yyin) != 0)
		exit (3);
	return 0;
}


int main(int argc, char* argv[]) 
{
    yyFlexLexer Lexer;
    Lexer.yylex();
    return 0;
}