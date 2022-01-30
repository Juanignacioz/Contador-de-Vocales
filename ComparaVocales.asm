 ;Realizar un programa en assembler que lea texto de hasta 255 caracteres y cuente la cantidad de vocales (A, E, I, O, U, a, e, i, o, u).
 ;El programa debe poder leer n cantidad de textos e indicar los resultados parciales (x cada texto ingresado) 
 ;y un resultado TOTAL de las cantidades.El programa debe indicar un mensaje de error cuando la suma supere un byte. 
.8086
.model small
.stack 100h

.data
	bienv db "Ingrese un texto hasta 255 caracteres", 0dh, 0ah, 24h
	text db 255 dup (24h), 0dh, 0ah, 24h
	cart db " la cantidad de vocales es: ", 0dh, 0ah, 24h
    tot  db  ("000"), 0dh, 0ah, 24h
    nuev db "Si quiere ingresar un nuevo texto ingrese 1 ", 0dh, 0ah, 24h
    op   db 1 dup (24h), 0dh, 0ah, 24h
    salto db " ", 0dh, 0ah, 24h
    chau  db "Gracias por usar el Programa ", 0dh, 0ah, 24h
.code

main proc
	mov ax, @data
	mov ds, ax
dnuevo:
    mov ah, 9
	mov dx, offset  salto        
	int 21h 

    mov ah, 9
	mov dx, offset bienv
	int 21h
   
   

	mov bx, 0
 lect:	
		mov ah, 1
		int 21h		
		cmp al, 0dh             
		je c
		mov text[bx], al		
		inc bx           
	 jmp lect


  c: 
    mov bx,0
  comparo: 
    cmp text[bx],'$'
    je fincomp 
	cmp text[bx],'a'
	je vocal
	cmp text[bx],'e'
	je vocal
	cmp text[bx],'i'
	je vocal
	cmp text[bx],'o'
	je vocal
	cmp text[bx],'u'
	je vocal
	cmp text[bx],'A'
	je vocal
	cmp text[bx],'E'
	je vocal
	cmp text[bx],'I'
	je vocal
	cmp text[bx],'O'
	je vocal
	cmp text[bx],'U'
	je vocal
aca:  inc bx
	jmp comparo
denuevo: 
        jmp dnuevo
  vocal:   
        inc si
        jmp aca

fincomp:
       
    mov ax,si  
    mov cl,10
	div cl
	add ah,30h
	mov tot[2],ah  

	xor ah,ah

	div cl
	add ah,30h
	mov tot[1],ah   

	xor ah,ah

	div cl
	add ah,30h
	mov tot[0],ah
   
    mov ah, 9 
	mov dx, offset cart
	int 21h     

	mov ah, 9
	mov dx, offset tot
	int 21h   

	mov ah, 9
	mov dx, offset nuev
	int 21h  


 otra:
    xor bx,bx
    mov ah, 1
    int 21h		
    cmp al, 31h             
	je denuevo
    cmp al, 31h             
	jne fin 
fin:
    mov ah, 9
	mov dx, offset  salto        
	int 21h 
	
    mov ah, 9
	mov dx, offset chau
	int 21h  
	mov ax, 4c00h
	int 21h
main endp

end main

