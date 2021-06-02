/*定义部分*/
%{
    #include <string.h>
    int id_num=0;
    enum node_kind {INT=1,TYPE,RETURN,IF,ELSE,WHILE,FOR,BREAK,SWITCH,CASE,ID,
                    COLON,SEMI,COMMA,RELOP,ASSIGNOP,PLUS,MINUS,AUTOADD,AUTOSUB,
                    STAR,DIV,AND,OR,NOT,LP,RP,LB,RB,LC,RC };
    char *node_name[] = {"null","int","TYPE","RETURN","IF","ELSE","WHILE","FOR","BREAK","SWITCH","CASE","ID",
                    "COLON","SEMI","COMMA","RELOP","ASSIGNOP","PLUS","MINUS","AUTOADD","AUTOSUB",
                    "STAR","DIV","AND","OR","NOT","LP","RP","LB","RB","LC","RC"}; 
    #define YYSTYPE YYLVAL
%}
/*辅助定义*/
id [A-Za-z][A-Za-z0-9]*
int [0-9][0-9]*

/*规则部分：正规表达式+动作， 词法分析器识别出一个单词后，将该单词对应的字符串保存在 yytext中*/
%%
 /*注释处理 单行+多行*/
\/\/[^\n]*  {;}//匹配注释的正则表达式
\/\*(\s|.)*?\*\/ {;}//匹配注释的正则表达式
{int} {return INT;}
"int" {return TYPE;}
"return" {return RETURN;}
"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
"for" {return FOR;}
"break" {return BREAK;}
"switch" {return SWITCH;}
"case" {return CASE;}
{id} {id_num++; return ID;}

":" {return COLON;}
";" {return SEMI;}
"," {return COMMA;}
">"|"<"|">="|"<="|"=="|"!=" {return RELOP;}
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
[\n] {;}
[ \r\t] {;}
.   {printf("Error type A: Mysterious character\"%s\" \n",yytext);}


%%
void main(int argc,char *argv[]){
	int token_type;
	while (token_type = yylex()) {
		printf("%s:\t%s\n", yytext, node_name[token_type]);
	}
	printf("id_num:\t%d\n",id_num);
	return 0;
}

int yywrap(){
    return 1;
}
