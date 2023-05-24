echo off
C:\GnuWin32\bin\flex lexmini.l
echo "FLEX compiled the lexical specification from the file lexmini.l (a file lex.yy.c was created)"
pause
C:\MinGW\bin\gcc.exe lex.yy.c -o Compilado.exe
echo "The execution of the C compiler on the lex.yy.c file has finished (a Compiled.exe file was created)"
pause
Compilado.exe Test.txt
echo "The lexical analyzer was executed on the file Prueba.txt"
del lex.yy.c
@REM del Compilado.exe
echo "The files generated throughout this process were deleted, ending..."
pause