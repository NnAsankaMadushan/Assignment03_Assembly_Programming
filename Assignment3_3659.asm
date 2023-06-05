;--------------------Displaying Text-------------------------------------
%macro displayText 2 
	mov rax,4
	mov rbx,1
	mov rcx, %1
	mov rdx, %2
	int 0x80
%endmacro

;---------------------Getting Inputs-------------------------------------
%macro getInput 2 
	mov rax,3
	mov rbx,0
	mov rcx, %1
	mov rdx, %2
	int 0x80
%endmacro	

;------------------------------------------------------------------------
section .data

textlabel2 db "Enter the number:", 0 
size2 equ $ - textlabel2	

textlabel3 db "The summation is :", 0 
size3 equ $ - textlabel3

textlabel4 db "", 0,10 ;
size4 equ $ - textlabel4	

number5 db '3659'
size5 equ $-number5

textlabel6 db "The summation of number1 and 3659 = ", 0 
size6 equ $ - textlabel6

;------------------------------------------------------------------------

section .bss

result resb 5


number1 resb 5
number2 resb 5

number3 resb 5
number4 resb 5

number6 resb 5

;-------------------------Section : Program Code-------------------------
section .text

global _start

_start: 

	displayText textlabel2, size2
	getInput number1,5
	displayText textlabel2, size2
	getInput number2,5	

;------------------------------------------------------------------------

	mov rsi,4
	mov cl,0 ;
	
;------------------------------------------------------------------------
	
assignToZero:
	mov byte[number3+rsi-1],48
	mov byte[number4+rsi-1],48
	dec rsi
	cmp rsi,0
	jg assignToZero
	
;------------------------------------------------------------------------
	mov rsi,4
	mov rdi,4
	
compareWithZero1:
	cmp byte[number1+rsi-1],48
	jge compareWithNine1
	dec rsi
	cmp rsi,0
	jg compareWithZero1	
	jmp second
	
compareWithNine1:
	cmp byte[number1+rsi-1],58
	jle assignToNo3
	dec rsi
	jmp compareWithZero1
	
assignToNo3:
	mov al, byte[number1+rsi-1]
	mov byte[number3+rdi - 1],al
	dec rdi
	dec rsi
	jmp compareWithZero1

;------------------------------------------------------------------------

second:		;assigning number2 to number4
	mov rsi,4
	mov rdi,4
	
compareWithZero2:
	cmp byte[number2+rsi-1],48
	jge compareWithNine2
	dec rsi
	cmp rsi,0
	jg compareWithZero2
	jmp adding
	
compareWithNine2:
	cmp byte[number2+rsi-1],58
	jle assignToNo4
	dec rsi
	jmp compareWithZero2
	
assignToNo4:
	mov al, byte[number2+rsi-1]
	mov byte[number4+rdi - 1],al
	dec rdi
	dec rsi
	jmp compareWithZero2

;----------------Adding two numbers------------------------------------
adding:
	mov rsi,4
	
ADDNEXT: 
	mov al, byte[number3+rsi-1]
	mov bl, byte[number5+rsi-1]
	add al,bl
	add al,cl
	sub al,96; if al = al - 96
	mov cl, 0; init carry = 0
	cmp al,10
	jl NOCARRY
	sub al,10
	mov cl, 1; make carry = 1
NOCARRY:
	add al, 0x30
	mov byte[result+rsi],al
	dec rsi
	cmp rsi,0
	jg ADDNEXT	
	add cl, 0x30
	mov byte[result+rsi],cl
	
	displayText textlabel3, size3
	displayText result, 5	;
	displayText textlabel4, size4
	
;------------------Adding Reg Number-----------------------
;adding2:
;	mov rsi,4
;	mov cl,0
;addnext2:
;	mov al,byte[number3+rsi-1]
;	mov bl, byte[number5+rsi-1]
;	add al,bl
;	add al,cl
;	sub al,96; if al = al - 96
;	mov cl, 0; init carry = 0
;	cmp al,10
;	jl nocarry2
;	sub al,10
;	mov cl, 1; make carry = 1
;nocarry2:
;	add al, 0x30
;	mov byte[result+rsi],al
;	dec rsi
;	cmp rsi,0
;	jg addnext2	
;	add cl, 0x30
;	mov byte[result+rsi],cl
	
;	displayText textlabel4, size4
;	displayText textlabel6, size6
;	displayText result, 5	;
;	displayText textlabel4, size4
	
exitProgram:
	mov rax, 1
	mov rbx, 0
	int 0x80
