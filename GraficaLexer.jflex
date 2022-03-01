paquete;

import java_cup.runtime.*;

%%

%class GraficaLexer
%unicode
%line
%column
%cup
%public


%{

    private Symbol symbol(int tipo){
        return new Symbol(tipo, yyline+1, yycolumn+1);
    }

    private Symbol symbol(int tipo, Object value){
        return new Symbol(tipo, yyline+1, yycolumn+1, value);
    }   

%}


/*Identificadores*/

numero = [0-9]
//letra = [a-zA-Z]+
//espacios=[ ,\t,\r,\n]+

/*Tab = \t | "    "
Enter = \n
Salto = \r
Espacio1 = [ \f]
Espacio = {Salto} | {Espacio1}*/

%%

/* Simbolo Reservado de Separacion de Parametros */
    "," 	                                	                {return symbol(sym.COMA, new String(yytext()));}
    ";" 	                                	                {return symbol(sym.PUNTO_Y_COMA, new String(yytext()));}
    ":" 	                                	                {return symbol(sym.DOS_PUNTOS, new String(yytext()));}


/* Simbolos para el ingreso de parametros */
    "{" 	                                	                {return symbol(sym.LLAVES_A, new String(yytext()));}
    "}" 	                                	                {return symbol(sym.LLAVES_C, new String(yytext()));}
    "[" 	                                	                {return symbol(sym.CORCHETES_A, new String(yytext()));}
    "]" 	                                	                {return symbol(sym.CORCHETES_C, new String(yytext()));}


/* Simbolos de Operacion */
    "+"                                             	        {return symbol(sym.MAS, new String(yytext()));}
    "-"                                             	        {return symbol(sym.MENOS, new String(yytext()));}
    "*"                                             	        {return symbol(sym.POR, new String(yytext()));}
    "/"                                             	        {return symbol(sym.DIVISION, new String(yytext()));}
    	
    "("                                             	        {return symbol(sym.PARENTESIS_A, new String(yytext()));}
    ")"     		                            	            {return symbol(sym.PARENTESIS_C, new String(yytext()));}


/* Palabras Reservadas de definicion*/	
    "Def"                                          	            {return symbol(sym.DEF1, new String(yytext()));}
    "def"                                          	            {return symbol(sym.DEF2, new String(yytext()));}


/* Palabras Reservadas de Barras*/
    "ejex"                                         	            {return symbol(sym.EJE_X, new String(yytext()));}
    "ejey"                                      	            {return symbol(sym.EJE_Y, new String(yytext()));}

/* Palabras Reservadas de Pie*/
    "etiquetas"                                       	        {return symbol(sym.ETIQUETAS, new String(yytext()));}
    "valores"                                        	        {return symbol(sym.VALORES, new String(yytext()));}
    "tipo"                                          	        {return symbol(sym.TIPO, new String(yytext()));}
    "cantidad"      						                    {return symbol(sym.CANTIDAD, new String(yytext()));}
    "porcentaje"                                                {return symbol(sym.PORCENTAJE, new String(yytext()));}
    "total"                                                     {return symbol(sym.TOTAL, new String(yytext()));}
    "extra"                                                     {return symbol(sym.EXTRA, new String(yytext()));}
    
/* Palabras Reservadas de Barras/Pie*/
    "unir"                                       	            {return symbol(sym.UNIR, new String(yytext()));}
    "titulo"                                       	            {return symbol(sym.TITULO, new String(yytext()));}

/* Palabras Reservadas de Ejecucion*/ 
    "Ejecutar"                                         		    {return symbol(sym.EJECUTAR, new String(yytext()));}
    
/* Numeros */
    {numero}+                                               	{return symbol(sym.ENTERO, new Integer(yytext()));}

/* Decimal */
    {numero}+"\."{numero}+                                     	{return symbol(sym.DECIMAL, new Integer(yytext()));}

/* texto */
    //Texto = {letra}+ errores con letra y numero :(
    Texto = "\""[[a-zA-Z]|numero|[ ,\t,\r,\n]*]*"\""            {return symbol(sym.ID, new String(yytext()));}

/* comentario */
    (#(.)*\n)                                                   {return symbol(sym.COMENTARIO, new String(yytext()));}

/*  Errores */       
    [^]                                                     	{return symbol(sym.ERROR, new String(yytext()));}
