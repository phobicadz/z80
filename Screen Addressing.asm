;Define Location
;Entry : B=Line,C=Column
;Preserved : BC,DE
;EXIT: HL=Address in display file, A=L
DF-LoC:
LD     A,B
AND    0F8H
ADD    A,40H
LD     H,A
LD     A,B
AND    7
RRCA
RRCA
RRCA
ADD    A,C
LD     L,A
RET

;Clear Screen
CLS-DF:
LD     HL,4000H
LD     BC,17FFH
LD     (HL),L
LD     D,H
LD     E,1
LDIR
RET