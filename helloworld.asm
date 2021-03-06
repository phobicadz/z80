; Simple text scroller for the ZX Spectrum
; by Peter Hanratty

; =====================================
ORG 32768
LD	IX,Message	; IX = Pointer to message

GetChar:
LD	A,(IX+0)		; Get current char
AND	#FF		; Test for NULL
JR	NZ,CopyChar
LD	IX,Message	; Go back to start of message
LD	A,(IX+0)

CopyChar:
LD	D,0		; Move char value to DE
LD	E,A
RL	E		; Multiply by 8 using carry
RL	D
RL	E
RL	D
RL	E
RL	D
LD	HL,(23606)	; Get CHARS value
ADD	HL,DE		; Add char offset
LD	DE,TempChar	; Copy 8 bytes
LD	BC,8		; into TempChar
LDIR

LD	C,8		; Do the following 8 times...

ScrollChar:
PUSH	BC		; Save loop counter
LD	DE,TempChar	; Current char data
LD	HL,#50FF	; Top line of bottom-right screen char

LD	C,8		; Do the following 8 times...

PasteChar:
EX	DE,HL
SLA	(HL)		; Get MSB of current char
RL	A		; Save it in A
EX	DE,HL
SRA	A		; Restore carry
RL	(HL)		; Rotate screen char, saving MSB
RL	A		; and introducing previous saved bit

LD	B,31		; Do the following for the rest of the line...

ScrollLine:
DEC	HL		; Go back 1 char
SRA	A		; Prime carry from previous saved bit
RL	(HL)		; Rotate, as above
RL	A		; And save for next char
DJNZ	ScrollLine

INC	DE		; Next line of char
PUSH	DE
LD	DE,#11F
ADD	HL,DE		; Next line of screen
POP	DE
DEC	C
JR	NZ,PasteChar

LD	HL,#600		; Wait a while...
Wait:
DEC	HL
LD	A,H
OR	L
JR	NZ,Wait

POP	BC
DEC	C
JR	NZ,ScrollChar	; Continue until entire char scrolled

INC	IX		; Get next char
JR	GetChar

Message:
DB	"    Hello Dallas!    ",0

TempChar:
DB	0,0,0,0,0,0,0,0