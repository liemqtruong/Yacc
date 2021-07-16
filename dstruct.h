#ifndef DSTRUCT_H
#define DSTRUCT_H

#include <stdio.h>
#include <string.h>
#include <malloc.h>
enum RELATION {NONE, USING_R,HAS_A_R, KIND_OF_R };
enum BOOL {FALSE,TRUE };

typedef struct COLABR 
{
   char* className;
   RELATION relation;
   COLABR *next;                  
} COLABR ;

typedef struct  ATTR {
   char *attribute;
   ATTR *next;
} ATTR;

typedef struct RESPONS{
   char *methodName;
   ATTR *attribute;
   RESPONS *next;
}RESPONS;

typedef struct CARD {
   char *className;
   RESPONS *responsibility;
   COLABR  *colabration;
   CARD *next;
} CARD;

/* ***********AURIC STUFF************* */
typedef struct VERSION {
   long value;
}VERSION;

typedef struct LINE_NUM {
   long value;
}LINE_NUM;

typedef struct LENGTH {
   long value;
}LENGTH;

typedef struct APP_UNITS {
   long value;
}APP_UNITS;

typedef struct UNIT_ID {
   long value;
}UNIT_ID;

typedef struct NATURAL_NUM {
   long value;
}NATURAL_NUM;

typedef struct CRC {
   long value;
}CRC;

typedef struct DIGIT {
   long value;
}DIGIT;


COLABR *getNewColbr();
RESPONS *getNewResp();
CARD *getNewCard();
ATTR *getNewAttr();
void generatePseudoCode(CARD *cardList,FILE* fp);
void displayDataStruct(CARD *cardList);
#endif

