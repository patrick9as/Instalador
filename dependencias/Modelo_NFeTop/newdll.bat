@ECHO OFF

ECHO Configurando Gsoft NFeTop XE2...
echo
echo
echo

REGASM /u NFe_dll.dll /tlb:NFe_dll.tlb

regasm NFE_dll.dll /tlb:NFE_dll.tlb

exit