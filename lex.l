/*定义部分*/
%{
    #include "paser.tab.h"
    #include "string.h"
    #include "def.h"
    int yycolumn=1;
    #define YY_USER_ACTION yylloc.first_line=yylloc.last_line=yylineno; yylloc.first_column=yycolumn; yylloc.last_column=yycolumn+yyleng-1; yycolumn+=yyleng;
    typedef union {
        int type_int;
        char type_id[32];
        struct node *ptr;
    } YYLVAL;
#define YYSTYPE YYLVAL
%}
%option yylineno
/*辅助定义*/
id [A-Za-z][A-Za-z0-9]*
int [0-9][0-9]*

/*规则部分：正规表达式+动作， 词法分析器识别出一个单词后，将该单词对应的字符串保存在 yytext中*/
%%
 /*注释处理 单行+多行*/
\/\/[^\n]*  {;}//匹配注释的正则表达式
\/\*(\s|.)*?\*\/ {;}//匹配注释的正则表达式
{int} {yylval.type_int=atoi(yytext);return INT;}
"int" {strcpy(yylval.type_id,  yytext);return TYPE;}
"return" {return RETURN;}
"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
"break" {return BREAK;}
"switch" {return SWITCH;}
"case" {return CASE;}
"default" {return DEFAULT;}
{id} {strcpy(yylval.type_id,  yytext);return ID;}

":" {return COLON;}
";" {return SEMI;}
"," {return COMMA;}
">"|"<"|">="|"<="|"=="|"!=" {strcpy(yylval.type_id, yytext);return RELOP;}
"=" {return ASSIGNOP;}
"+" {return PLUS;}
"-" {return MINUS;}
"++" {return AUTOADD;}
"--" {return AUTOSUB;}
"*" {return STAR;}
"/" {return DIV;}
"&&" {return AND;}
"||" {return OR;}
"!" {return NOT;}
"(" {return LP;}
")" {return RP;}
"[" {return LB;}
"]" {return RB;}
"{" {return LC;}
"}" {return RC;}
[\n] {yycolumn=1;}
[ \r\t] {;}
.   {printf("Error type A :Mysterious character \"%s\"\n\t at Line %d\n",yytext,yylineno);}


%%
/* 和bison联用时，不需要这部分
void main(int argc,char *argv[]){
	int token_type;
	while (token_type = yylex()) {
		printf("%s:\t%s\n", yytext, node_name[token_type]);
	}
	printf("id_num:\t%d\n",id_num);
	return 0;
}
*/

int yywrap(){
    return 1;
}
