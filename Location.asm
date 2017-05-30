;Location
; Parameters B=line, C=Column
; on exit HL=D.F ADDRESS, DE =ATTR Address, A = ATTR
; DFCC IS Altered
LOCATE:
    LD     A,B
    AND    #18
    LD     H,A
    SET    6,H  ;Comment goes here
    RRCA
    RRCA
    RRCA
    OR     #58
    LD     D,A
    LD     A,B
    AND    7
    RRCA
    RRCA
    RRCA
    ADD    A,C
    LD     L,A
    LD     E,A
    LD     A,(DE)
    LD     (DFFC),HL
    RET
DFFC:
    DB   #5C84
