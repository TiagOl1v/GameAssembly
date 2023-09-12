.8086
.model small
.stack 2048

dseg segment para public 'data'

   
   MenuOptions db "                                                           ",13,10
				db "                    **************************************",13,10
				db "                    *                                    *",13,10
				db "                    *        2022/2023                   *",13,10
				db "                    *   ISEC - Trabalho Pratico de TAC   *",13,10
				db "                    *       Ultimate tic-tac-toe         *",13,10
				db "                    *                                    *",13,10
				db "                    *   1- Jogar                         *",13,10
				db "                    *   2- Ajuda                         *",13,10
				db "                    *   3- Sair                          *",13,10
				db "                    *                                    *",13,10
				db "                    *                                    *",13,10
				db "                    **************************************",13,10
				db "                                                          ",13,10
				db "                                                          ",13,10
				db "                                                          ",13,10,'$'
				
				
	Ajuda       db "                                                          ",13,10
				db "                    **************************************",13,10
				db "                    *                                    *",13,10
				db "                    *                Ajuda               *",13,10
				db "                    *                                    *",13,10
				db "                    *   O jogo e constituido por 9 mini  *",13,10
				db "                    *  tabubleios que todos juntos fazem *",13,10
				db "                    *  um tabuloreiro grande, o objetivo *",13,10
				db "                    * e fazer 3 em linha ou coluna ou na *",13,10
				db "                    *  	  diagonal no tabuleiro grande,  *",13,10
				db "                    *       para ganhar uma celula do    *",13,10
				db "                    * tabuleiro principal temos primeiro *",13,10
				db "                    *    de ganhar o mini tabuleiro      *",13,10
				db "                    *     correspondente a essa celula   *",13,10
				db "                    *                        			 *",13,10
				db "                    *                      	             *",13,10
				db "                    **************************************",13,10
				db "                                                          ",13,10
				db "                                                          ",13,10,'$'
			
			
	
	;--------------------------- VARS nome PLayers------------------------------------------
	
	introduznome    db	    "Nome do PLAYER-1 :$"
	POSycursor      db		15							
	POSxcursor		db		30						
	
	nomeplayerText	db		"         $"
	introduznome2   db	    "Nome do PLAYER-2 :$"						
	nomeplayer2TEXT	db		"         $"
	S_Vezde   db	    	"A vez de ->            $"
	
	
	POSyAux   		db		?						; Posição de teste para fazer verificações
	POSxAux			db		?	
	CarTeste		db		32  					; Guarda um caracter de teste para fazer verificações
		
	
	Simb_X 			db 		'X'
    Simb_O 			db 		'O'
    player1_S 		db 		" $" 					; Guarda o simbolo correspondente ao P1 
    player2_S 		db 		" $"					; Guarda o simbolo correspondente ao P2
	ID_Simb			db		2						; variavel que detecta qual jogador comeca  a jogar
	MUDA_XO         db      1                       ; troca entre o X e o O quando há uma jogada
	
	
	
	idplayers    	db	    "PLAYER1( )-->             vs 	  PLAYER2( )-->            $"
	Erro_Open       db      'Erro ao tentar abrir o ficheiro$'
    Erro_Ler_Msg    db      'Erro ao tentar ler do ficheiro$'
    Erro_Close      db      'Erro ao tentar fechar o ficheiro$'
    Fich         	db      'jogo.TXT',0
	Fich_BemVindo   db      'bemvindo.TXT',0
	Fich_Nomes   	db      'nome.TXT',0
	winner_X		db 		'!!! X VENCEU o JOGO !!!$'
	winner_O		db 		'!!! O(bola) VENCEU o JOGO !!!$'
	INDICA		db 			' Percione ESC para sair$'
	
	
    HandleFich      dw      0
    car_fich        db      ?
	
	vencedorx     	db   " Vencedor X  $"
	vencedorO         db   " Vencedor O $"
	
	
	espaco         db   "-$"
	
	VP				db   0
	v1				db   0
	v2				db   0
	v3				db   0
	v4				db   0
	v5				db   0
	v6				db   0
	v7				db   0
	v8				db   0
	v9				db   0
	
	
	JogoPrincipal   db  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'
	
	TabMini_1 		db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'
    TabMini_2 		db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'
    TabMini_3 		db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'
    TabMini_4 		db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'
    TabMini_5 		db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'
    TabMini_6 		db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'
    TabMini_7 		db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'
    TabMini_8 		db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'
    TabMini_9 		db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'
	
		
	Car				db		32	; Guarda um caracter do Ecran 	
	Cor				db		7	; Guarda os atributos de cor do caracter
	UserInputMenu   dw  	?
	POSy			db		9	; a linha pode ir de [1 .. 25]
	POSx			db		4	; POSx pode ir [1..80]	
	
	
				
dseg ends

cseg segment para public 'code'

     assume cs:cseg, ds:dseg
	 

apaga_ecra	proc
			mov		ax,0B800h
			mov		es,ax
			xor		bx,bx
			mov		cx,25*80
		
apaga:		mov		byte ptr es:[bx],' '
			mov		byte ptr es:[bx+1],7
			inc		bx
			inc 	bx
			loop	apaga
			ret
apaga_ecra	endp




ApagarLinha PROC

    mov ax, 0B800h    ; Endereço base da memória de vídeo
    mov es, ax        
    mov bx, 80*2*3    ; Vai para a treceira linha
    mov cx, 80        ; O numero das colunas todas 

apaga:

    mov byte ptr es:[bx], ' '    ; Caractere de espaço
    mov byte ptr es:[bx+1], 7   
    add bx, 2        			
    loop apaga        			; Repete até que todas as colunas sejam apagadas

    ret

ApagarLinha endp

goto_xy	macro		POSx,POSy

		mov		ah,02h
		mov		bh,0		; numero da página
		mov		dl,POSx
		mov		dh,POSy
		mov cx, 1     ; Quantidade de caracteres para escrever
		int		10h
endm

Print MACRO STR 

	MOV AH,09H

	LEA DX,STR 

	INT 21H

ENDM

LE_TECLA	PROC
		
		mov		ah,08h
		int		21h
		mov		ah,0
		cmp		al,0
		jne		SAI_TECLA
		mov		ah, 08h
		int		21h
		mov		ah,1
		
SAI_TECLA:	RET
LE_TECLA	endp


Print_X MACRO POSx,POSy

goto_xy POSx, POSy

    mov ah, 09h   
    mov al, 'X'  
    mov bh, 0     
	mov bl, 00000001b   ; letra azul apenas
    int 10h       

ENDM


Print_O MACRO POSx,POSy

goto_xy POSx, POSy

    mov ah, 09h   
    mov al, 'O'  
    mov bh, 0     
	mov bl, 00001100b   ; letra vermelha
    int 10h       

ENDM

VencedorPrincipal PROC

cmp vp,1
je saida

linha:

	mov 		al, JogoPrincipal[0]
	cmp  		JogoPrincipal[1], al
	jne 	 	linhav2	
	cmp 		al, JogoPrincipal[2]
	je 			vencedor	

linhav2:

	mov 		al, JogoPrincipal[3]
	cmp  		JogoPrincipal[4], al
	jne 	 	linhav3
	cmp 		al, JogoPrincipal[5]
	je 			vencedor
	
linhav3:
	
	mov 		al, JogoPrincipal[6]
	cmp  		JogoPrincipal[7], al
	jne 	 	coluna1
	cmp 		al, JogoPrincipal[8]
	je 			vencedor
	
coluna1:

	mov 		al, JogoPrincipal[0]
	cmp  		TabMini_1[3], al
	jne 	 	coluna2
	cmp 		al, JogoPrincipal[6]
	je 			vencedor
	
coluna2:

	mov 		al, JogoPrincipal[1]
	cmp  		JogoPrincipal[4], al
	jne 	 	coluna3
	cmp 		al, JogoPrincipal[7]
	je 			vencedor


coluna3:

	mov 		al, JogoPrincipal[2]
	cmp  		JogoPrincipal[5], al
	jne 	 	diagonal1
	cmp 		al, JogoPrincipal[8]
	je 			vencedor	
	
diagonal1:

	mov 		al, JogoPrincipal[0]
	cmp  		JogoPrincipal[4], al
	jne 	 	diagonal2
	cmp 		al, JogoPrincipal[8]
	je 			vencedor
	
diagonal2:
	mov 		al, JogoPrincipal[2]
	cmp  		JogoPrincipal[4], al
	jne 	 	saida
	cmp 		al, JogoPrincipal[6]
	je 			vencedor
	jmp			saida

vencedor:
	
    cmp al, 'O'
	jne  vencedor_x
	mov al,1 
	mov VP, al
	call ApagarLinha
	goto_xy 13,5
	Print winner_O
	goto_xy 13,4
	print INDICA
	jmp saida
	
vencedor_x:

	mov al,1 
	mov VP, al
	
	call ApagarLinha
	goto_xy 13,5
	Print winner_X
	goto_xy 13,4
	print INDICA

saida:

goto_xy POSx,POSy
ret
VencedorPrincipal ENDP




Verf_vencedor proc

cmp v1,1
je  sai


linha:

	mov 		al, TabMini_1[0]
	cmp  		TabMini_1[1], al
	jne 	 	linhav2	
	cmp 		al, TabMini_1[2]
	je 			vencedor	

linhav2:

	mov 		al, TabMini_1[3]
	cmp  		TabMini_1[4], al
	jne 	 	linhav3
	cmp 		al, TabMini_1[5]
	je 			vencedor
	
linhav3:
	
	mov 		al, TabMini_1[6]
	cmp  		TabMini_1[7], al
	jne 	 	coluna1
	cmp 		al, TabMini_1[8]
	je 			vencedor
	
coluna1:

	mov 		al, TabMini_1[0]
	cmp  		TabMini_1[3], al
	jne 	 	coluna2
	cmp 		al, TabMini_1[6]
	je 			vencedor
	
coluna2:

	mov 		al, TabMini_1[1]
	cmp  		TabMini_1[4], al
	jne 	 	coluna3
	cmp 		al, TabMini_1[7]
	je 			vencedor


coluna3:

	mov 		al, TabMini_1[2]
	cmp  		TabMini_1[5], al
	jne 	 	diagonal1
	cmp 		al, TabMini_1[8]
	je 			vencedor	
	
diagonal1:

	mov 		al, TabMini_1[0]
	cmp  		TabMini_1[4], al
	jne 	 	diagonal2
	cmp 		al, TabMini_1[8]
	je 			vencedor
	
diagonal2:
	mov 		al, TabMini_1[2]
	cmp  		TabMini_1[4], al
	jne 	 	sai
	cmp 		al, TabMini_1[6]
	je 			vencedor

	jmp			sai

vencedor:
	
    cmp al, 'O'
	jne  vencedor_x
	mov al,1 
	mov v1, al
	mov al, 'O'
	mov JogoPrincipal[0],al
	Print_O 54,12
	
	goto_xy 3,8
	mov cx, 7  	
	
linhaO1:
 
    mov ah, 09h
    mov al, 'O'  
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO1   ; Repete o loop até todas as colunas serem pintadas

	goto_xy 3,9
	mov cx, 7  
	
linhaO2:
  
    mov ah, 09h
	mov al, 'O'   
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx      	; Decrementa o contador 
    jnz linhaO2    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 3,10
	mov cx, 7  

linhaO3:
    
    mov ah, 09h
	mov al, 'O'  
    mov bh, 0    
    mov bl, 01000000b
    int 10h     

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO3    ; Repete o loop até todas as colunas serem pintadas
	jmp sai

vencedor_x:
	
	cmp al, 'X'
	jne sai
	mov al,1 
	mov v1, al
	mov al, 'X'
	mov JogoPrincipal[0],al
	Print_X 54,12
	
goto_xy 3,8
mov cx, 7
     
linha8:
    
    mov ah, 09h
    mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha8    ; Repete o loop até todas as colunas serem pintadas

	goto_xy 3,9
	mov cx, 7  
	
linha9:
   
    mov ah, 09h
	mov al, 'X'  
    mov bh, 0   
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha9    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 3,10
	mov cx, 7  

linha10:
   
    mov ah, 09h
	mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    
	int 10h     
    inc dl        ; Incrementa a coluna do cursor
    dec cx       ; Decrementa o contador 
    jnz linha10    ; Repete o loop até todas as colunas serem pintadas
	

sai:
goto_xy POSx,POSY
ret

Verf_vencedor endp 

Verf_vencedor2 proc

cmp v2,1
je  sai


linha:

	mov 		al, TabMini_2[0]
	cmp  		TabMini_2[1], al
	jne 	 	linhav2	
	cmp 		al, TabMini_2[2]
	je 			vencedor	

linhav2:

	mov 		al, TabMini_2[3]
	cmp  		TabMini_2[4], al
	jne 	 	linhav3
	cmp 		al, TabMini_2[5]
	je 			vencedor
	
linhav3:
	
	mov 		al, TabMini_2[6]
	cmp  		TabMini_2[7], al
	jne 	 	coluna1
	cmp 		al, TabMini_2[8]
	je 			vencedor
	
coluna1:

	mov 		al, TabMini_2[0]
	cmp  		TabMini_2[3], al
	jne 	 	coluna2
	cmp 		al, TabMini_2[6]
	je 			vencedor
	
coluna2:

	mov 		al, TabMini_2[1]
	cmp  		TabMini_2[4], al
	jne 	 	coluna3
	cmp 		al, TabMini_2[7]
	je 			vencedor


coluna3:

	mov 		al, TabMini_2[2]
	cmp  		TabMini_2[5], al
	jne 	 	diagonal1
	cmp 		al, TabMini_2[8]
	je 			vencedor	
	
diagonal1:

	mov 		al, TabMini_2[0]
	cmp  		TabMini_2[4], al
	jne 	 	diagonal2
	cmp 		al, TabMini_2[8]
	je 			vencedor
	
diagonal2:
	mov 		al, TabMini_2[2]
	cmp  		TabMini_2[4], al
	jne 	 	sai
	cmp 		al, TabMini_2[6]
	je 			vencedor

	jmp			sai

vencedor:
	
    cmp al, 'O'
	jne  vencedor_x
	mov al,1 
	mov v2, al
	mov al, 'O'
	mov JogoPrincipal[1],al
	Print_O 56,12
	
goto_xy 12,8
mov cx, 7	
	
linhaO1:
 
    mov ah, 09h
    mov al, 'O'  
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO1   ; Repete o loop até todas as colunas serem pintadas

	goto_xy 12,9
	mov cx, 7  
	
linhaO2:
  
    mov ah, 09h
	mov al, 'O'   
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx      	; Decrementa o contador 
    jnz linhaO2    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 12,10
	mov cx, 7  

linhaO3:
    
    mov ah, 09h
	mov al, 'O'  
    mov bh, 0    
    mov bl, 01000000b
    int 10h     

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO3    ; Repete o loop até todas as colunas serem pintadas
	jmp sai

vencedor_x:
	
	cmp al, 'X'
	jne sai
	mov al,1 
	mov v2, al
	mov al, 'X'
	mov JogoPrincipal[1],al
	Print_X 56,12
	
goto_xy 12,8
mov cx, 7
     
linha8:
    
    mov ah, 09h
    mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha8    ; Repete o loop até todas as colunas serem pintadas

	goto_xy 12,9
	mov cx, 7  
	
linha9:
   
    mov ah, 09h
	mov al, 'X'  
    mov bh, 0   
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha9    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 12,10
	mov cx, 7  

linha10:
   
    mov ah, 09h
	mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    
	int 10h     
    inc dl        ; Incrementa a coluna do cursor
    dec cx       ; Decrementa o contador 
    jnz linha10    ; Repete o loop até todas as colunas serem pintadas
	
sai:
goto_xy POSx,POSY
ret

Verf_vencedor2 endp 


Verf_vencedor3 proc

cmp v3,1
je  sai


linha:

	mov 		al, TabMini_3[0]
	cmp  		TabMini_3[1], al
	jne 	 	linhav2	
	cmp 		al, TabMini_3[2]
	je 			vencedor	

linhav2:

	mov 		al, TabMini_3[3]
	cmp  		TabMini_3[4], al
	jne 	 	linhav3
	cmp 		al, TabMini_3[5]
	je 			vencedor
	
linhav3:
	
	mov 		al, TabMini_3[6]
	cmp  		TabMini_3[7], al
	jne 	 	coluna1
	cmp 		al, TabMini_3[8]
	je 			vencedor
	
coluna1:

	mov 		al, TabMini_3[0]
	cmp  		TabMini_3[3], al
	jne 	 	coluna2
	cmp 		al, TabMini_3[6]
	je 			vencedor
	
coluna2:

	mov 		al, TabMini_3[1]
	cmp  		TabMini_3[4], al
	jne 	 	coluna3
	cmp 		al, TabMini_3[7]
	je 			vencedor


coluna3:

	mov 		al, TabMini_3[2]
	cmp  		TabMini_3[5], al
	jne 	 	diagonal1
	cmp 		al, TabMini_3[8]
	je 			vencedor	
	
diagonal1:

	mov 		al, TabMini_3[0]
	cmp  		TabMini_3[4], al
	jne 	 	diagonal2
	cmp 		al, TabMini_3[8]
	je 			vencedor
	
diagonal2:
	mov 		al, TabMini_3[2]
	cmp  		TabMini_3[4], al
	jne 	 	sai
	cmp 		al, TabMini_3[6]
	je 			vencedor

	jmp			sai

vencedor:
	
    cmp al, 'O'
	jne  vencedor_x
	mov al,1 
	mov v3, al
	mov al, 'O'
	mov JogoPrincipal[2],al
	Print_O 58,12
	
	goto_xy 21,8
	mov cx, 7  	
	
linhaO1:
 
    mov ah, 09h
    mov al, 'O'  
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO1   ; Repete o loop até todas as colunas serem pintadas

	goto_xy 21,9
	mov cx, 7  
	
linhaO2:
  
    mov ah, 09h
	mov al, 'O'   
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx      	; Decrementa o contador 
    jnz linhaO2    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 21,10
	mov cx, 7  

linhaO3:
    
    mov ah, 09h
	mov al, 'O'  
    mov bh, 0    
    mov bl, 01000000b
    int 10h     

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO3    ; Repete o loop até todas as colunas serem pintadas
	jmp sai

vencedor_x:
	
	cmp al, 'X'
	jne sai
	mov al,1 
	mov v3, al
	mov al, 'X'
	mov JogoPrincipal[2],al
	Print_X 58,12
	
	
goto_xy 21,8
mov cx, 7
     
linha8:
    
    mov ah, 09h
    mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha8    ; Repete o loop até todas as colunas serem pintadas

	goto_xy 21,9
	mov cx, 7  
	
linha9:
   
    mov ah, 09h
	mov al, 'X'  
    mov bh, 0   
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha9    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 21,10
	mov cx, 7  

linha10:
   
    mov ah, 09h
	mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    
	int 10h     
    inc dl        ; Incrementa a coluna do cursor
    dec cx       ; Decrementa o contador 
    jnz linha10    ; Repete o loop até todas as colunas serem pintadas
	

sai:
goto_xy POSx,POSY
ret

Verf_vencedor3 endp 


Verf_vencedor4 proc

cmp v4,1
je  sai


linha:

	mov 		al, TabMini_4[0]
	cmp  		TabMini_4[1], al
	jne 	 	linhav2	
	cmp 		al, TabMini_4[2]
	je 			vencedor	

linhav2:

	mov 		al, TabMini_4[3]
	cmp  		TabMini_4[4], al
	jne 	 	linhav3
	cmp 		al, TabMini_4[5]
	je 			vencedor
	
linhav3:
	
	mov 		al, TabMini_4[6]
	cmp  		TabMini_4[7], al
	jne 	 	coluna1
	cmp 		al, TabMini_4[8]
	je 			vencedor
	
coluna1:

	mov 		al, TabMini_4[0]
	cmp  		TabMini_4[3], al
	jne 	 	coluna2
	cmp 		al, TabMini_4[6]
	je 			vencedor
	
coluna2:

	mov 		al, TabMini_4[1]
	cmp  		TabMini_4[4], al
	jne 	 	coluna3
	cmp 		al, TabMini_4[7]
	je 			vencedor


coluna3:

	mov 		al, TabMini_4[2]
	cmp  		TabMini_4[5], al
	jne 	 	diagonal1
	cmp 		al, TabMini_4[8]
	je 			vencedor	
	
diagonal1:

	mov 		al, TabMini_4[0]
	cmp  		TabMini_4[4], al
	jne 	 	diagonal2
	cmp 		al, TabMini_4[8]
	je 			vencedor
	
diagonal2:
	mov 		al, TabMini_4[2]
	cmp  		TabMini_4[4], al
	jne 	 	sai
	cmp 		al, TabMini_4[6]
	je 			vencedor

	jmp			sai

vencedor:
	
    cmp al, 'O'
	jne  vencedor_x
	mov al,1 
	mov v4, al
	mov al, 'O'
	mov JogoPrincipal[3],al
	Print_O 54,13
	
	goto_xy 3,12
	mov cx, 7  	
	
linhaO1:
 
    mov ah, 09h
    mov al, 'O'  
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO1   ; Repete o loop até todas as colunas serem pintadas

	goto_xy 3,13
	mov cx, 7  
	
linhaO2:
  
    mov ah, 09h
	mov al, 'O'   
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx      	; Decrementa o contador 
    jnz linhaO2    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 3,14
	mov cx, 7  

linhaO3:
    
    mov ah, 09h
	mov al, 'O'  
    mov bh, 0    
    mov bl, 01000000b
    int 10h     

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO3    ; Repete o loop até todas as colunas serem pintadas
	jmp sai

vencedor_x:
	
	cmp al, 'X'
	jne sai
	mov al,1 
	mov v4, al
	mov al, 'X'
	mov JogoPrincipal[3],al
	Print_X 54,13
	
goto_xy 3,12
mov cx, 7
     
linha8:
    
    mov ah, 09h
    mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha8    ; Repete o loop até todas as colunas serem pintadas

	goto_xy 3,13
	mov cx, 7  
	
linha9:
   
    mov ah, 09h
	mov al, 'X'  
    mov bh, 0   
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha9    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 3,14
	mov cx, 7  

linha10:
   
    mov ah, 09h
	mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    
	int 10h     
    inc dl        ; Incrementa a coluna do cursor
    dec cx       ; Decrementa o contador 
    jnz linha10    ; Repete o loop até todas as colunas serem pintadas
	

sai:
goto_xy POSx,POSY
ret

Verf_vencedor4 endp 


Verf_vencedor5 proc

cmp v5,1
je  sai


linha:

	mov 		al, TabMini_5[0]
	cmp  		TabMini_5[1], al
	jne 	 	linhav2	
	cmp 		al, TabMini_5[2]
	je 			vencedor	

linhav2:

	mov 		al, TabMini_5[3]
	cmp  		TabMini_5[4], al
	jne 	 	linhav3
	cmp 		al, TabMini_5[5]
	je 			vencedor
	
linhav3:
	
	mov 		al, TabMini_5[6]
	cmp  		TabMini_5[7], al
	jne 	 	coluna1
	cmp 		al, TabMini_5[8]
	je 			vencedor
	
coluna1:

	mov 		al, TabMini_5[0]
	cmp  		TabMini_5[3], al
	jne 	 	coluna2
	cmp 		al, TabMini_5[6]
	je 			vencedor
	
coluna2:

	mov 		al, TabMini_5[1]
	cmp  		TabMini_5[4], al
	jne 	 	coluna3
	cmp 		al, TabMini_5[7]
	je 			vencedor


coluna3:

	mov 		al, TabMini_5[2]
	cmp  		TabMini_5[5], al
	jne 	 	diagonal1
	cmp 		al, TabMini_5[8]
	je 			vencedor	
	
diagonal1:

	mov 		al, TabMini_5[0]
	cmp  		TabMini_5[4], al
	jne 	 	diagonal2
	cmp 		al, TabMini_5[8]
	je 			vencedor
	
diagonal2:
	mov 		al, TabMini_5[2]
	cmp  		TabMini_5[4], al
	jne 	 	sai
	cmp 		al, TabMini_5[6]
	je 			vencedor

	jmp			sai

vencedor:
	
    cmp al, 'O'
	jne  vencedor_x
	mov al,1 
	mov v5, al
	mov al, 'O'
	mov JogoPrincipal[4],al
	Print_O 56,13
	
	goto_xy 12,12
	mov cx, 7  	
	
linhaO1:
 
    mov ah, 09h
    mov al, 'O'  
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO1   ; Repete o loop até todas as colunas serem pintadas

	goto_xy 12,13
	mov cx, 7  
	
linhaO2:
  
    mov ah, 09h
	mov al, 'O'   
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx      	; Decrementa o contador 
    jnz linhaO2    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 12,14
	mov cx, 7  

linhaO3:
    
    mov ah, 09h
	mov al, 'O'  
    mov bh, 0    
    mov bl, 01000000b
    int 10h     

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO3    ; Repete o loop até todas as colunas serem pintadas
	jmp sai

vencedor_x:
	
	cmp al, 'X'
	jne sai
	mov al,1 
	mov v5, al
	mov al, 'X'
	mov JogoPrincipal[4],al
	Print_X 56,13
	
goto_xy 12,12
mov cx, 7
     
linha8:
    
    mov ah, 09h
    mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha8    ; Repete o loop até todas as colunas serem pintadas

	goto_xy 12,13
	mov cx, 7  
	
linha9:
   
    mov ah, 09h
	mov al, 'X'  
    mov bh, 0   
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha9    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 12,14
	mov cx, 7  

linha10:
   
    mov ah, 09h
	mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    
	int 10h     
    inc dl        ; Incrementa a coluna do cursor
    dec cx       ; Decrementa o contador 
    jnz linha10    ; Repete o loop até todas as colunas serem pintadas
	

sai:
goto_xy POSx,POSY
ret

Verf_vencedor5 endp 


Verf_vencedor6 proc

cmp v6,1
je  sai


linha:

	mov 		al, TabMini_6[0]
	cmp  		TabMini_6[1], al
	jne 	 	linhav2	
	cmp 		al, TabMini_6[2]
	je 			vencedor	

linhav2:

	mov 		al, TabMini_6[3]
	cmp  		TabMini_6[4], al
	jne 	 	linhav3
	cmp 		al, TabMini_6[5]
	je 			vencedor
	
linhav3:
	
	mov 		al, TabMini_6[6]
	cmp  		TabMini_6[7], al
	jne 	 	coluna1
	cmp 		al, TabMini_6[8]
	je 			vencedor
	
coluna1:

	mov 		al, TabMini_6[0]
	cmp  		TabMini_6[3], al
	jne 	 	coluna2
	cmp 		al, TabMini_6[6]
	je 			vencedor
	
coluna2:

	mov 		al, TabMini_6[1]
	cmp  		TabMini_6[4], al
	jne 	 	coluna3
	cmp 		al, TabMini_6[7]
	je 			vencedor


coluna3:

	mov 		al, TabMini_6[2]
	cmp  		TabMini_6[5], al
	jne 	 	diagonal1
	cmp 		al, TabMini_6[8]
	je 			vencedor	
	
diagonal1:

	mov 		al, TabMini_6[0]
	cmp  		TabMini_6[4], al
	jne 	 	diagonal2
	cmp 		al, TabMini_6[8]
	je 			vencedor
	
diagonal2:
	mov 		al, TabMini_6[2]
	cmp  		TabMini_6[4], al
	jne 	 	sai
	cmp 		al, TabMini_6[6]
	je 			vencedor

	jmp			sai

vencedor:
	
    cmp al, 'O'
	jne  vencedor_x
	mov al,1 
	mov v6, al
	mov al, 'O'
	mov JogoPrincipal[5],al
	Print_O 58,13
	
	goto_xy 21,12
	mov cx, 7  	
	
linhaO1:
 
    mov ah, 09h
    mov al, 'O'  
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO1   ; Repete o loop até todas as colunas serem pintadas

	goto_xy 21,13
	mov cx, 7  
	
linhaO2:
  
    mov ah, 09h
	mov al, 'O'   
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx      	; Decrementa o contador 
    jnz linhaO2    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 21,14
	mov cx, 7  

linhaO3:
    
    mov ah, 09h
	mov al, 'O'  
    mov bh, 0    
    mov bl, 01000000b
    int 10h     

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO3    ; Repete o loop até todas as colunas serem pintadas
	jmp sai

vencedor_x:
	
	cmp al, 'X'
	jne sai
	mov al,1 
	mov v6, al
	mov al, 'X'
	mov JogoPrincipal[5],al
	Print_X 58,13
	
goto_xy 21,12
mov cx, 7
     
linha8:
    
    mov ah, 09h
    mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha8    ; Repete o loop até todas as colunas serem pintadas

	goto_xy 21,13
	mov cx, 7  
	
linha9:
   
    mov ah, 09h
	mov al, 'X'  
    mov bh, 0   
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha9    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 21,14
	mov cx, 7  

linha10:
   
    mov ah, 09h
	mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    
	int 10h     
    inc dl        ; Incrementa a coluna do cursor
    dec cx       ; Decrementa o contador 
    jnz linha10    ; Repete o loop até todas as colunas serem pintadas
	

sai:
goto_xy POSx,POSY
ret

Verf_vencedor6 endp 


Verf_vencedor7 proc

cmp v7,1
je  sai


linha:

	mov 		al, TabMini_7[0]
	cmp  		TabMini_7[1], al
	jne 	 	linhav2	
	cmp 		al, TabMini_7[2]
	je 			vencedor	

linhav2:

	mov 		al, TabMini_7[3]
	cmp  		TabMini_7[4], al
	jne 	 	linhav3
	cmp 		al, TabMini_7[5]
	je 			vencedor
	
linhav3:
	
	mov 		al, TabMini_7[6]
	cmp  		TabMini_7[7], al
	jne 	 	coluna1
	cmp 		al, TabMini_7[8]
	je 			vencedor
	
coluna1:

	mov 		al, TabMini_7[0]
	cmp  		TabMini_7[3], al
	jne 	 	coluna2
	cmp 		al, TabMini_7[6]
	je 			vencedor
	
coluna2:

	mov 		al, TabMini_7[1]
	cmp  		TabMini_7[4], al
	jne 	 	coluna3
	cmp 		al, TabMini_7[7]
	je 			vencedor


coluna3:

	mov 		al, TabMini_7[2]
	cmp  		TabMini_7[5], al
	jne 	 	diagonal1
	cmp 		al, TabMini_7[8]
	je 			vencedor	
	
diagonal1:

	mov 		al, TabMini_7[0]
	cmp  		TabMini_7[4], al
	jne 	 	diagonal2
	cmp 		al, TabMini_7[8]
	je 			vencedor
	
diagonal2:
	mov 		al, TabMini_7[2]
	cmp  		TabMini_7[4], al
	jne 	 	sai
	cmp 		al, TabMini_7[6]
	je 			vencedor

	jmp			sai

vencedor:
	
    cmp al, 'O'
	jne  vencedor_x
	mov al,1 
	mov v7, al
	mov al, 'O'
	mov JogoPrincipal[6],al
	Print_O 54,14
	
	goto_xy 3,16
	mov cx, 7  	
	
linhaO1:
 
    mov ah, 09h
    mov al, 'O'  
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO1   ; Repete o loop até todas as colunas serem pintadas

	goto_xy 3,17
	mov cx, 7  
	
linhaO2:
  
    mov ah, 09h
	mov al, 'O'   
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx      	; Decrementa o contador 
    jnz linhaO2    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 3,18
	mov cx, 7  

linhaO3:
    
    mov ah, 09h
	mov al, 'O'  
    mov bh, 0    
    mov bl, 01000000b
    int 10h     

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO3    ; Repete o loop até todas as colunas serem pintadas
	jmp sai

vencedor_x:
	
	cmp al, 'X'
	jne sai
	mov al,1 
	mov v7, al
	mov al, 'X'
	mov JogoPrincipal[6],al
	Print_X 54,14
	
goto_xy 3,16
mov cx, 7
     
linha8:
    
    mov ah, 09h
    mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha8    ; Repete o loop até todas as colunas serem pintadas

	goto_xy 3,17
	mov cx, 7  
	
linha9:
   
    mov ah, 09h
	mov al, 'X'  
    mov bh, 0   
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha9    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 3,18
	mov cx, 7  

linha10:
   
    mov ah, 09h
	mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    
	int 10h     
    inc dl        ; Incrementa a coluna do cursor
    dec cx       ; Decrementa o contador 
    jnz linha10    ; Repete o loop até todas as colunas serem pintadas
	

sai:
goto_xy POSx,POSY
ret

Verf_vencedor7 endp 



Verf_vencedor8 proc

cmp v8,1
je  sai


linha:

	mov 		al, TabMini_8[0]
	cmp  		TabMini_8[1], al
	jne 	 	linhav2	
	cmp 		al, TabMini_8[2]
	je 			vencedor	

linhav2:

	mov 		al, TabMini_8[3]
	cmp  		TabMini_8[4], al
	jne 	 	linhav3
	cmp 		al, TabMini_8[5]
	je 			vencedor
	
linhav3:
	
	mov 		al, TabMini_8[6]
	cmp  		TabMini_8[7], al
	jne 	 	coluna1
	cmp 		al, TabMini_8[8]
	je 			vencedor
	
coluna1:

	mov 		al, TabMini_8[0]
	cmp  		TabMini_8[3], al
	jne 	 	coluna2
	cmp 		al, TabMini_8[6]
	je 			vencedor
	
coluna2:

	mov 		al, TabMini_8[1]
	cmp  		TabMini_8[4], al
	jne 	 	coluna3
	cmp 		al, TabMini_8[7]
	je 			vencedor


coluna3:

	mov 		al, TabMini_8[2]
	cmp  		TabMini_8[5], al
	jne 	 	diagonal1
	cmp 		al, TabMini_8[8]
	je 			vencedor	
	
diagonal1:

	mov 		al, TabMini_8[0]
	cmp  		TabMini_8[4], al
	jne 	 	diagonal2
	cmp 		al, TabMini_8[8]
	je 			vencedor
	
diagonal2:
	mov 		al, TabMini_9[2]
	cmp  		TabMini_8[4], al
	jne 	 	sai
	cmp 		al, TabMini_8[6]
	je 			vencedor

	jmp			sai

vencedor:
	
    cmp al, 'O'
	jne  vencedor_x
	mov al,1 
	mov v8, al
	mov al, 'O'
	mov JogoPrincipal[7],al
	Print_O 56,14
	
	goto_xy 12,16
	mov cx, 7  	
	
linhaO1:
 
    mov ah, 09h
    mov al, 'O'  
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO1   ; Repete o loop até todas as colunas serem pintadas

	goto_xy 12,17
	mov cx, 7  
	
linhaO2:
  
    mov ah, 09h
	mov al, 'O'   
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx      	; Decrementa o contador 
    jnz linhaO2    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 12,18
	mov cx, 7  

linhaO3:
    
    mov ah, 09h
	mov al, 'O'  
    mov bh, 0    
    mov bl, 01000000b
    int 10h     

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO3    ; Repete o loop até todas as colunas serem pintadas
	jmp sai

vencedor_x:
	
	cmp al, 'X'
	jne sai
	mov al,1 
	mov v8, al
	mov al, 'X'
	mov JogoPrincipal[7],al
	Print_X 56,14
	
goto_xy 12,16
mov cx, 7
     
linha8:
    
    mov ah, 09h
    mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha8    ; Repete o loop até todas as colunas serem pintadas

	goto_xy 12,17
	mov cx, 7  
	
linha9:
   
    mov ah, 09h
	mov al, 'X'  
    mov bh, 0   
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha9    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 12,18
	mov cx, 7  

linha10:
   
    mov ah, 09h
	mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    
	int 10h     
    inc dl        ; Incrementa a coluna do cursor
    dec cx       ; Decrementa o contador 
    jnz linha10    ; Repete o loop até todas as colunas serem pintadas
	

sai:
goto_xy POSx,POSY
ret

Verf_vencedor8 endp 

Verf_vencedor9 proc

cmp v9,1
je  sai


linha:

	mov 		al, TabMini_9[0]
	cmp  		TabMini_9[1], al
	jne 	 	linhav2	
	cmp 		al, TabMini_9[2]
	je 			vencedor	

linhav2:

	mov 		al, TabMini_9[3]
	cmp  		TabMini_9[4], al
	jne 	 	linhav3
	cmp 		al, TabMini_9[5]
	je 			vencedor
	
linhav3:
	
	mov 		al, TabMini_9[6]
	cmp  		TabMini_9[7], al
	jne 	 	coluna1
	cmp 		al, TabMini_9[8]
	je 			vencedor
	
coluna1:

	mov 		al, TabMini_9[0]
	cmp  		TabMini_9[3], al
	jne 	 	coluna2
	cmp 		al, TabMini_9[6]
	je 			vencedor
	
coluna2:

	mov 		al, TabMini_9[1]
	cmp  		TabMini_9[4], al
	jne 	 	coluna3
	cmp 		al, TabMini_9[7]
	je 			vencedor


coluna3:

	mov 		al, TabMini_9[2]
	cmp  		TabMini_9[5], al
	jne 	 	diagonal1
	cmp 		al, TabMini_9[8]
	je 			vencedor	
	
diagonal1:

	mov 		al, TabMini_9[0]
	cmp  		TabMini_9[4], al
	jne 	 	diagonal2
	cmp 		al, TabMini_9[8]
	je 			vencedor
	
diagonal2:
	mov 		al, TabMini_9[2]
	cmp  		TabMini_9[4], al
	jne 	 	sai
	cmp 		al, TabMini_9[6]
	je 			vencedor

	jmp			sai

vencedor:
	
    cmp al, 'O'
	jne  vencedor_x
	mov al,1 
	mov v9, al
	mov al, 'O'
	mov JogoPrincipal[8],al
	Print_O 58,14
	
	goto_xy 21,16
	mov cx, 7  	
	
linhaO1:
 
    mov ah, 09h
    mov al, 'O'  
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO1   ; Repete o loop até todas as colunas serem pintadas

	goto_xy 21,17
	mov cx, 7  
	
linhaO2:
  
    mov ah, 09h
	mov al, 'O'   
    mov bh, 0     
    mov bl, 01000000b
    int 10h      

    inc dl        ; Incrementa a coluna do cursor
    dec cx      	; Decrementa o contador 
    jnz linhaO2    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 21,18
	mov cx, 7  

linhaO3:
    
    mov ah, 09h
	mov al, 'O'  
    mov bh, 0    
    mov bl, 01000000b
    int 10h     

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linhaO3    ; Repete o loop até todas as colunas serem pintadas
	jmp sai

vencedor_x:
	
	cmp al, 'X'
	jne sai
	mov al,1 
	mov v9, al
	mov al,	'X'
	mov JogoPrincipal[8],al
	Print_X 58,14
	
goto_xy 21,16
mov cx, 7
     
linha8:
    
    mov ah, 09h
    mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha8    ; Repete o loop até todas as colunas serem pintadas

	goto_xy 21,17
	mov cx, 7  
	
linha9:
   
    mov ah, 09h
	mov al, 'X'  
    mov bh, 0   
    mov bl, 00010000b
    int 10h       

    inc dl        ; Incrementa a coluna do cursor
    dec cx        ; Decrementa o contador 
    jnz linha9    ; Repete o loop até todas as colunas serem pintadas
	
	goto_xy 21,18
	mov cx, 7  

linha10:
   
    mov ah, 09h
	mov al, 'X'   
    mov bh, 0     
    mov bl, 00010000b
    
	int 10h     
    inc dl        ; Incrementa a coluna do cursor
    dec cx       ; Decrementa o contador 
    jnz linha10    ; Repete o loop até todas as colunas serem pintadas
	

sai:
goto_xy POSx,POSY
ret

Verf_vencedor9 endp 


verDir proc

    mov 	al, POSx 			; guarda POS numa var de test
    mov 	POSxAux, al
    inc 	POSxAux 				
    inc 	POSxAux				; A var AUX anda (Usamos uma aux para caso seja uma parede ele nao andar)
	
	goto_xy	POSxAux,POSy		; Apenas a POS (x ou y) em que o cursor anda muda
	mov 	ah, 08h				; Guarda o Caracter que está na posição do cursor
	mov		bh,0				; numero da página
	int		10h
	mov		Carteste, al		; Guarda o Caracter que está na posição do curso AUX
	cmp 	Carteste, 177		;Compara o caracter onde esta o AUX para saber se é parade (±) se for parede vai para as verf (avanca) 
	je 	avanca					; vai para outra verf
	
	mov   	 al, POSxAux 		
    mov  	 POSx,al			;Reset da posiçao
    jmp return4
	
avanca:
	cmp POSxAux, 28				; verf se pode passar para uma table ou nao
	je  return4
	
	mov al, POSxAux   
	add al, 3        
	mov POSx, al   				;Faz o cursor original andar

return4:						; saida
    ret
	
verDir  endp



verEsq proc
    mov al, POSx 					; guarda POS numa var de test
    mov POSxAux, al
    dec POSxAux 					
    dec POSxAux						; A var AUX anda (Usamos uma aux para caso seja uma parede ele nao andar)
	
	goto_xy	POSxAux, POSy			; Apenas a POS (x ou y) em que o cursor anda muda
	
	mov 		ah, 08h				
	mov			bh,0				; numero da página
	int			10h
	mov			Carteste, al		; Guarda o Caracter que está na posição do Curso numa var de teste
	cmp 		Carteste, 177		;Compara o caracter onde esta o AUX para saber se é parade (±) se for parede vai para as verf (avanca) 
	je avanca
	
	mov   al, POSxAux 		; Reset na posiçao do cursor teste
	mov   POSx, al
    jmp return4				; saida

	
avanca:
	cmp POSxAux, 2
	je  return4
	
	mov al, POSxAux 
	sub al, 3        
	mov POSx, al   ;Faz o cursor original andar

return4:
    ret
	
verEsq endp


verCima proc
    mov al, POSy 				; guarda POS numa var de test
    mov POSyAux, al
    dec POSyAux					; A var AUX anda (Usamos uma aux para caso seja uma parede ele nao andar)
	
	goto_xy	POSx, POSyAux 		; Apenas a POS (x ou y) em que o cursor anda muda
	mov 	ah, 08h				;  Guarda o Caracter que está na posição do curso AUX
	mov		bh,0				; numero da página
	int		10h
	mov		Carteste, al		; Guarda o Caracter que está na posição do Curso numa var de teste
	cmp 	Carteste, 177		;Compara o caracter onde esta o AUX para saber se é parade (±) se for parede vai para as verf (avanca) 
	je avanca
	
	mov   	al, POSyAux 		;Reset da posiçao
    mov   	POSy, al
    jmp return4					; saida
	
avanca:
	cmp POSyAux, 7
	je  return4					; saida
	
	mov 	al, POSyAux   
	sub 	al, 1        	
	mov 	POSy, al   ;Faz o cursor original andar

return4:
    ret
	
verCima endp

verBaixo proc
    mov al, POSy 				; guarda POS numa var de test
    mov POSyAux, al
    inc POSyAux 				; A var AUX anda (Usamos uma aux para caso seja uma parede ele nao andar)
	
	goto_xy	POSx, POSyAux 		; Apenas a POS (x ou y) em que o cursor anda muda
	mov 		ah, 08h				;  Guarda o Caracter que está na posição do curso AUX
	mov			bh,0				; numero da página
	int			10h
	mov			Carteste, al		; Guarda o caracter que está na posição do Curso numa var de teste
	cmp 		Carteste, 177		;Compara o caracter onde esta o AUX para saber se é parade (±) se for parede vai para as verf (avanca) 
	je avanca
	
	mov   al, POSyAux 		;Reset da posiçao
    mov   POSy, al
    jmp return4				; saida
	
avanca:
	cmp POSyAux, 19
	je  return4				; saida
	
	mov al, POSyAux   		
	add al, 1        
	mov POSy, al   		;Faz o cursor original andar

return4:
    ret
	
verBaixo endp

ANDA_LADO PROC

    mov 	al, POSx 			; guarda POS numa var de test
    mov 	POSxAux, al
    inc 	POSxAux 				
    inc 	POSxAux				; A var AUX anda (Usamos uma aux para caso seja uma parede ele nao andar)
	
	goto_xy	POSxAux,POSy		; Apenas a POS (x ou y) em que o cursor anda muda
	mov 	ah, 08h				; Guarda o Caracter que está na posição do cursor
	mov		bh,0				; numero da página
	int		10h
	mov		Carteste, al		; Guarda o Caracter que está na posição do curso AUX
	cmp 	Carteste, 177		;Compara o caracter onde esta o AUX para saber se é parade (±) se for parede vai para as verf (avanca) 
	je 	avanca					; vai para outra verf
	
	mov   	 al, POSxAux 		
    mov  	 POSx,al	;Reset da posiçao
	jmp return4
    
	
avanca:
	cmp POSxAux, 28		; verf se pode passar para uma table ou nao
	je ESQUERDA
	
	mov al, POSxAux   
	add al, 3        
	mov POSx, al   				;Faz o cursor original andar
    jmp return4
	
ESQUERDA:
    dec POSx					
    dec POSx
    
return4:						; saida
    ret
        
ANDA_LADO endp

; ---------------------------------------------------INICIO Verificao de posicoes na tela -----------------------------------------------------

adiciona_tab1 proc


x1:

	goto_xy	4, 8		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola1
	mov     TabMini_1[0], al
	jmp     x2
	
bola1:

	mov		Carteste, al		
	cmp 	Carteste, 79		 
	jne 	x2
	mov     TabMini_1[0], al
   
	
x2:

	goto_xy	6, 8		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		 
	jne 	bola2
	mov     TabMini_1[1], al

	jmp     x3
	
bola2:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x3
	mov     TabMini_1[1], al

   


x3:

	goto_xy	8, 8		
	mov 	ah, 08h				
	mov		bh,0			
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola3
	mov     TabMini_1[2], al

	jmp     x4
	
bola3:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x4
	mov     TabMini_1[2], al

  


x4:

	goto_xy	4, 9		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola4
	mov     TabMini_1[3], al

	jmp     x5
	
bola4:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x5
	mov     TabMini_1[3], al

   

x5:

	goto_xy	6, 9		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola5
	mov     TabMini_1[4], al

	jmp     x6
	
bola5:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x6
	mov     TabMini_1[4], al

   
	
x6:

	goto_xy	8, 9		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola6
	mov     TabMini_1[5], al
	jmp     x7
	
bola6:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x7
	mov     TabMini_1[5], al

   
	
x7:

	goto_xy	4, 10		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola7
	mov     TabMini_1[6], al
	jmp     x8
	
bola7:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x8
	mov     TabMini_1[6], al
	
x8:

	goto_xy	6, 10		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola8
	mov     TabMini_1[7], al
	jmp     x9
	
bola8:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x9
	mov     TabMini_1[7], al
	
x9:

	goto_xy	8, 10		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola9
	mov     TabMini_1[8], al
	jmp    	saida
	
bola9:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	saida
	mov     TabMini_1[8], al
    jmp     saida


saida: 

call Verf_vencedor
goto_xy POSx, POSy

ret
adiciona_tab1 endp


adiciona_tab2 proc

x1:

	goto_xy	13, 8		
	mov 	ah, 08h			
	mov		bh,0			
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola1
	mov     TabMini_2[0], al
	jmp     x2
	
bola1:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x2
	mov     TabMini_2[0], al

	
x2:

	goto_xy	15, 8		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola2
	mov     TabMini_2[1], al

	jmp     x3
	
bola2:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x3
	mov     TabMini_2[1], al



x3:

	goto_xy	17, 8		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola3
	mov     TabMini_2[2], al

	jmp     x4
	
bola3:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x4
	mov     TabMini_2[2], al




x4:

	goto_xy	13, 9		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola4
	mov     TabMini_2[3], al

	jmp     x5
	
bola4:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x5
	mov     TabMini_2[3], al



x5:

	goto_xy	15, 9		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola5
	mov     TabMini_2[4], al

	jmp     x6
	
bola5:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x6
	mov     TabMini_2[4], al

	
x6:

	goto_xy	17, 9		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88	
	jne 	bola6
	mov     TabMini_2[5], al

	jmp     x7
	
bola6:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x7
	mov     TabMini_2[5], al


	
x7:

	goto_xy	13, 10		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola7
	mov     TabMini_2[6], al

	jmp     x8
	
bola7:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x8
	mov     TabMini_2[6], al

	
x8:

	goto_xy	15, 10		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88	
	jne 	bola8
	mov     TabMini_2[7], al

	jmp     x9
	
bola8:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x9
	mov     TabMini_2[7], al


x9:

	goto_xy	17, 10		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola9
	mov     TabMini_2[8], al

	jmp     saida
	
bola9:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	saida
	mov     TabMini_2[8], al

    jmp     saida

	
saida: 

call Verf_vencedor2
goto_xy POSx, POSy

ret


adiciona_tab2 endp


adiciona_tab3 proc

x1:

	goto_xy	22, 8		
	mov 	ah, 08h				
	mov		bh,0			
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola1
	mov     TabMini_3[0], al
	jmp     x2
	
bola1:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x2
	mov     TabMini_3[0], al
	
x2:

	goto_xy	24, 8		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola2
	mov     TabMini_3[1], al

	jmp     x3
	
bola2:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x3
	mov     TabMini_3[1], al

x3:

	goto_xy	26, 8		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola3
	mov     TabMini_3[2], al

	jmp     x4
	
bola3:

	mov		Carteste, al	
	cmp 	Carteste, 79	
	jne 	x4
	mov     TabMini_3[2], al

 


x4:

	goto_xy	22, 9		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola4
	mov     TabMini_3[3], al

	jmp     x5
	
bola4:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x5
	mov     TabMini_3[3], al


x5:

	goto_xy	24, 9		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola5
	mov     TabMini_3[4], al

	jmp     x6
	
bola5:

	mov		Carteste, al	
	cmp 	Carteste, 79		
	jne 	x6
	mov     TabMini_3[4], al

	
x6:

	goto_xy	26, 9		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola6
	mov     TabMini_3[5], al

	jmp     x7
	
bola6:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x7
	mov     TabMini_3[5], al


	
x7:

	goto_xy	22, 10		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola7
	mov     TabMini_3[6], al

	jmp     x8
	
bola7:

	mov		Carteste, al	
	cmp 	Carteste, 79		
	jne 	x8
	mov     TabMini_3[6], al

	
x8:

	goto_xy	24, 10	
	mov 	ah, 08h			
	mov		bh,0			
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola8
	mov     TabMini_3[7], al

	jmp     x9
	
bola8:

	mov		Carteste, al	
	cmp 	Carteste, 79		
	jne 	x9
	mov     TabMini_3[7], al

	
x9:

	goto_xy	26, 10		
	mov 	ah, 08h				
	mov		bh,0			
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88	
	jne 	bola9
	mov     TabMini_3[8], al

	jmp     saida
	
bola9:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	saida
	mov     TabMini_3[8], al

    jmp     saida

	
saida: 
  call Verf_vencedor3
goto_xy POSx, POSy

ret


adiciona_tab3 endp


adiciona_tab4 proc

x1:

	goto_xy	4, 12		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola1
	mov     TabMini_4[0], al
	jmp     x2
	
bola1:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x2
	mov     TabMini_4[0], al
 
	
x2:

	goto_xy	6, 12		
	mov 	ah, 08h			
	mov		bh,0			
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola2
	mov     TabMini_4[1], al

	jmp     x3
	
bola2:

	mov		Carteste, al		
	cmp 	Carteste, 79		 
	jne 	x3
	mov     TabMini_4[1], al

x3:

	goto_xy	8, 12		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola3
	mov     TabMini_4[2], al

	jmp     x4
	
bola3:

	mov		Carteste, al		
	cmp 	Carteste, 79		 
	jne 	x4
	mov     TabMini_4[2], al

x4:

	goto_xy	4, 13	
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola4
	mov     TabMini_4[3], al

	jmp     x5
	
bola4:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x5
	mov     TabMini_4[3], al

x5:

	goto_xy	6, 13		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola5
	mov     TabMini_4[4], al

	jmp     x6
	
bola5:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x6
	mov     TabMini_4[4], al

	
x6:

	goto_xy	8, 13		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola6
	mov     TabMini_4[5], al

	jmp     x7
	
bola6:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x7
	mov     TabMini_4[5], al

	
x7:

	goto_xy	4, 14		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola7
	mov     TabMini_4[6], al

	jmp     x8
	
bola7:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x8
	mov     TabMini_4[6], al

	
x8:

	goto_xy	6, 14		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola8
	mov     TabMini_4[7], al

	jmp     x9
	
bola8:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x9
	mov     TabMini_4[7], al

	
x9:

	goto_xy	8, 14		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola9
	mov     TabMini_4[8], al

	jmp     saida
	
bola9:

	mov		Carteste, al		
	cmp 	Carteste, 79		 
	jne 	saida
	mov     TabMini_4[8], al

    jmp     saida

	
saida: 
call Verf_vencedor4
goto_xy POSx, POSy

ret

adiciona_tab4 endp


adiciona_tab5 proc

x1:

	goto_xy	13, 12		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola1
	mov     TabMini_5[0], al
	jmp     x2
	
bola1:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x2
	mov     TabMini_5[0], al
	
x2:

	goto_xy	15, 12	
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola2
	mov     TabMini_5[1], al

	jmp     x3
	
bola2:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x3
	mov     TabMini_5[1], al

x3:

	goto_xy	17, 12		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola3
	mov     TabMini_5[2], al

	jmp     x4
	
bola3:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x4
	mov     TabMini_5[2], al

x4:

	goto_xy	13, 13	
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola4
	mov     TabMini_5[3], al

	jmp     x5
	
bola4:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x5
	mov     TabMini_5[3], al


x5:

	goto_xy	15, 13		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola5
	mov     TabMini_5[4], al

	jmp     x6
	
bola5:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x6
	mov     TabMini_5[4], al

	
x6:

	goto_xy	17, 13		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola6
	mov     TabMini_5[5], al

	jmp     x7
	
bola6:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x7
	mov     TabMini_5[5], al

x7:

	goto_xy	13, 14		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola7
	mov     TabMini_5[6], al

	jmp     x8
	
bola7:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x8
	mov     TabMini_5[6], al

x8:

	goto_xy	15, 14		
	mov 	ah, 08h				
	mov		bh,0			
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola8
	mov     TabMini_5[7], al

	jmp     x9
	
bola8:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x9
	mov     TabMini_5[7], al

	
x9:

	goto_xy	17, 14		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola9
	mov     TabMini_5[8], al

	jmp     saida
	
bola9:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	saida
	mov     TabMini_5[8], al

    jmp     saida

	
saida: 
    
call Verf_vencedor5
goto_xy POSx, POSy

ret


adiciona_tab5 endp


adiciona_tab6 proc

x1:

	goto_xy	22, 12		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola1
	mov     TabMini_6[0], al
	jmp     x2
	
bola1:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x2
	mov     TabMini_6[0], al
	
x2:

	goto_xy	24, 12		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88	
	jne 	bola2
	mov     TabMini_6[1], al

	jmp     x3
	
bola2:

	mov		Carteste, al	
	cmp 	Carteste, 79		
	jne 	x3
	mov     TabMini_6[1], al

x3:

	goto_xy	26, 12		
	mov 	ah, 08h				
	mov		bh,0			
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola3
	mov     TabMini_6[2], al

	jmp     x4
	
bola3:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x4
	mov     TabMini_6[2], al

x4:

	goto_xy	22, 13		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88	
	jne 	bola4
	mov     TabMini_6[3], al

	jmp     x5
	
bola4:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x5
	mov     TabMini_6[3], al

x5:

	goto_xy	24, 13		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola5
	mov     TabMini_6[4], al

	jmp     x6
	
bola5:

	mov		Carteste, al	
	cmp 	Carteste, 79	
	jne 	x6
	mov     TabMini_6[4], al

	
x6:

	goto_xy	26, 13	
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88	
	jne 	bola6
	mov     TabMini_6[5], al

	jmp     x7
	
bola6:

	mov		Carteste, al	
	cmp 	Carteste, 79		
	jne 	x7
	mov     TabMini_6[5], al

	
x7:

	goto_xy	22, 14		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola7
	mov     TabMini_6[6], al

	jmp     x8
	
bola7:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x8
	mov     TabMini_6[6], al

	
x8:

	goto_xy	24, 14		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola8
	mov     TabMini_6[7], al

	jmp     x9
	
bola8:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x9
	mov     TabMini_6[7], al

	
x9:

	goto_xy	26, 14		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola9
	mov     TabMini_6[8], al

	jmp     saida
	
bola9:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	saida
	mov     TabMini_6[8], al

    jmp     saida

	
saida: 
     
call Verf_vencedor6
goto_xy POSx, POSy

ret


adiciona_tab6 endp


adiciona_tab7 proc

x1:

	goto_xy	4, 16		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola1
	mov     TabMini_7[0], al
	jmp     x2
	
bola1:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x2
	mov     TabMini_7[0], al
	
x2:

	goto_xy	6, 16		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola2
	mov     TabMini_7[1], al
	jmp     x3
	
bola2:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x3
	mov     TabMini_7[1], al


x3:

	goto_xy	8, 16		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola3
	mov     TabMini_7[2], al

	jmp     x4
	
bola3:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x4
	mov     TabMini_7[2], al

 

x4:

	goto_xy	4, 17		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola4
	mov     TabMini_7[3], al

	jmp     x5
	
bola4:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x5
	mov     TabMini_7[3], al



x5:

	goto_xy	6, 17		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola5
	mov     TabMini_7[4], al

	jmp     x6
	
bola5:

	mov		Carteste, al		
	cmp 	Carteste, 79
	jne 	x6
	mov     TabMini_7[4], al


x6:

	goto_xy	8, 17		
	mov 	ah, 08h		
	mov		bh,0			
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola6
	mov     TabMini_7[5], al

	jmp     x7
	
bola6:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x7
	mov     TabMini_7[5], al

	
x7:

	goto_xy	4, 18	
	mov 	ah, 08h		
	mov		bh,0			
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola7
	mov     TabMini_7[6], al

	jmp     x8
	
bola7:

	mov		Carteste, al	
	cmp 	Carteste, 79	
	jne 	x8
	mov     TabMini_7[6], al

	
x8:

	goto_xy	6, 18		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola8
	mov     TabMini_7[7], al

	jmp     x9
	
bola8:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x9
	mov     TabMini_7[7], al

x9:

	goto_xy	8, 18		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola9
	mov     TabMini_7[8], al

	jmp     saida
	
bola9:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	saida
	mov     TabMini_7[8], al

    jmp     saida
	
saida: 
call Verf_vencedor7
goto_xy POSx, POSy

ret


adiciona_tab7 endp


adiciona_tab8 proc

x1:

	goto_xy	13, 16		
	mov 	ah, 08h			
	mov		bh,0			
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88	
	jne 	bola1
	mov     TabMini_8[0], al
	jmp     x2
	
bola1:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x2
	mov     TabMini_8[0], al

x2:

	goto_xy	15, 16		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88	
	jne 	bola2
	mov     TabMini_8[1], al

	jmp     x3
	
bola2:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x3
	mov     TabMini_8[1], al




x3:

	goto_xy	17, 16		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola3
	mov     TabMini_8[2], al

	jmp     x4
	
bola3:

	mov		Carteste, al		
	cmp 	Carteste, 79		 
	jne 	x4
	mov     TabMini_8[2], al

x4:

	goto_xy	13, 17		
	mov 	ah, 08h			
	mov		bh,0			
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88	
	jne 	bola4
	mov     TabMini_8[3], al

	jmp     x5
	
bola4:

	mov		Carteste, al	
	cmp 	Carteste, 79		
	jne 	x5
	mov     TabMini_8[3], al


x5:

	goto_xy	15, 17		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola5
	mov     TabMini_8[4], al

	jmp     x6
	
bola5:

	mov		Carteste, al	
	cmp 	Carteste, 79		 
	jne 	x6
	mov     TabMini_8[4], al

	
x6:

	goto_xy	17, 17		
	mov 	ah, 08h				
	mov		bh,0			
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola6
	mov     TabMini_8[5], al

	jmp     x7
	
bola6:

	mov		Carteste, al		
	cmp 	Carteste, 79		 
	jne 	x7
	mov     TabMini_8[5], al

	
x7:

	goto_xy	13, 18		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola7
	mov     TabMini_8[6], al

	jmp     x8
	
bola7:

	mov		Carteste, al	
	cmp 	Carteste, 79		
	jne 	x8
	mov     TabMini_8[6], al

	
x8:

	goto_xy	15, 18		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola8
	mov     TabMini_8[7], al

	jmp     x9
	
bola8:

	mov		Carteste, al	
	cmp 	Carteste, 79		
	jne 	x9
	mov     TabMini_8[7], al

	
x9:

	goto_xy	17, 18		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola9
	mov     TabMini_8[8], al

	jmp     saida
	
bola9:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	saida
	mov     TabMini_8[8], al

    jmp     saida

	
saida: 
     
call Verf_vencedor8
goto_xy POSx, POSy

ret


adiciona_tab8 endp


adiciona_tab9 proc

x1:

	goto_xy	22, 16	
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al
	cmp 	Carteste, 88	
	jne 	bola1
	mov     TabMini_9[0], al
	jmp     x2
	
bola1:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x2
	mov     TabMini_9[0], al
	
x2:

	goto_xy	24, 16		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola2
	mov     TabMini_9[1], al

	jmp     x3
	
bola2:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x3
	mov     TabMini_9[1], al

x3:

	goto_xy	26, 16		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola3
	mov     TabMini_9[2], al

	jmp     x4
	
bola3:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x4
	mov     TabMini_9[2], al


x4:

	goto_xy	22, 17		
	mov 	ah, 08h				
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola4
	mov     TabMini_9[3], al

	jmp     x5
	
bola4:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x5
	mov     TabMini_9[3], al


x5:

	goto_xy	24, 17	
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola5
	mov     TabMini_9[4], al

	jmp     x6
	
bola5:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x6
	mov     TabMini_9[4], al

	
x6:

	goto_xy	26, 17		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola6
	mov     TabMini_9[5], al

	jmp     x7
	
bola6:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	x7
	mov     TabMini_9[5], al

	
x7:

	goto_xy	22, 18		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al		
	cmp 	Carteste, 88		
	jne 	bola7
	mov     TabMini_9[6], al

	jmp     x8
	
bola7:

	mov		Carteste, al	
	cmp 	Carteste, 79		
	jne 	x8
	mov     TabMini_9[6], al
	
x8:

	goto_xy	24, 18		
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola8
	mov     TabMini_9[7], al

	jmp     x9
	
bola8:

	mov		Carteste, al		
	cmp 	Carteste, 79	
	jne 	x9
	mov     TabMini_9[7], al

x9:

	goto_xy	26, 18	
	mov 	ah, 08h			
	mov		bh,0				
	int		10h
	mov		Carteste, al	
	cmp 	Carteste, 88		
	jne 	bola9
	mov     TabMini_9[8], al

	jmp     saida
	
bola9:

	mov		Carteste, al		
	cmp 	Carteste, 79		
	jne 	saida
	mov     TabMini_9[8], al

    jmp     saida

saida: 
call Verf_vencedor9
goto_xy POSx, POSy
ret

adiciona_tab9 endp

; ---------------------------------------------------FIM Verificao de posicoes--------------------------------------------------------------------------
CursorGame	PROC
			mov		ax,0B800h
			mov		es,ax
CICLO:			
			goto_xy	POSx,POSy		; Vai para nova posição
			mov 	ah, 08h
			mov		bh,0			; numero da página
			int		10h		
			mov		Car, al			; Guarda o Caracter que está na posição do cursor
			mov		Cor, ah			; Guarda a cor que está na posição do cursor
		
			goto_xy	78,0			; Mostra o caractr que estava na posição do AVATAR
			mov		ah, 02h			; IMPRIME caracter da posição no canto
			mov		dl, Car	
			int		21H			
	
			goto_xy	POSx,POSy	    ; Vai para posição do cursor
		
LER_SETA:	call 	LE_TECLA
			cmp		ah, 1
			je		ESTEND
			cmp 	AL, 27		    ; ESCAPE
			JE		FIM
			cmp     VP,1			;verifica se ja ha vencedor
			je		LER_SETA
			cmp     MUDA_XO, 1
			jne     VERIF_O
			cmp     al, 58h         ; compara se al é 'X'
			jne     LER_SETA
			inc     MUDA_XO
			jmp     VERIF_ECRA
			
VERIF_O:    
            cmp     al, 4Fh         ; compara se al é 'O'
			jne     LER_SETA
			dec     MUDA_XO


VERIF_ECRA:
			goto_xy	POSx,POSy 	; verifica se pode escrever o caracter no ecran
			mov		CL, Car
			cmp		CL, 32		; Só escreve se for espaço em branco
			JNE 	LER_SETA
			mov		ah, 02h		; coloca o caracter lido no ecra
			mov		dl, al
			int		21H	
			call    ANDA_LADO

			cmp   	ID_Simb, 1
			je		Muda
			mov al, 1
			mov ID_Simb, al		
			jmp bota
		
Muda:
			mov al, 2
			mov ID_Simb, al

bota:	
			call	adiciona_tab1
			call	adiciona_tab2
			call	adiciona_tab3
			call	adiciona_tab4
			call	adiciona_tab5
			call	adiciona_tab6
			call	adiciona_tab7
			call	adiciona_tab8
			call	adiciona_tab9
			call    VencedorPrincipal
			call 	Algoritmo
			goto_xy	POSx,POSy
			jmp		CICLO
		
ESTEND:		cmp 	al,48h
			jne		BAIXO
			call    verCima    ; verifica se pode ir para cima
			jmp		CICLO

BAIXO:		cmp		al,50h
			jne		ESQUERDA	
			call 	verBaixo  ; verifica se pode ir para baixo
			jmp		CICLO

ESQUERDA:
			cmp		al,4Bh
			jne		DIREITA
			call    verEsq ; verifica se pode ir para a esquerda
			jmp		CICLO

DIREITA:
			cmp		al,4Dh
			jne		LER_SETA 
			call    verDir ; verifica se pode ir para a direita
			jmp		CICLO

fim:				
			call MenuInicial
CursorGame	endp

;Template do Jogo

IMP_FICH	PROC


        mov     ah,3dh
        mov     al,0
        int     21h
        jc      erro_abrir
        mov     HandleFich,ax
        jmp     ler_ciclo

erro_abrir:
        mov     ah,09h
        lea     dx,Erro_Open
        int     21h
        jmp     sai_f

ler_ciclo:
        mov     ah,3fh
        mov     bx,HandleFich
        mov     cx,1
        lea     dx,car_fich
        int     21h
		jc		erro_ler
		cmp		ax,0
		je		fecha_ficheiro
        mov     ah,02h
		mov		dl,car_fich
		int		21h
		jmp		ler_ciclo

erro_ler:
        mov     ah,09h
        lea     dx,Erro_Ler_Msg
        int     21h

fecha_ficheiro:
        mov     ah,3eh
        mov     bx,HandleFich
        int     21h
        jnc     sai_f

        mov     ah,09h
        lea     dx,Erro_Close
        Int     21h
sai_f:	
		RET
		
IMP_FICH	endp		

;MENU INICIAL

MostraMenu	proc

	goto_xy   0,3
	lea  dx,  MenuOptions 
	mov  ah,  9
	int  21h
	ret
	
MostraMenu	endp

X_ou_O PROC


    mov ah, 2Ch  
    int 21h      
    mov cx, dx   

   
    mov ah, 40h 
    mov bx, 2    
    int 21h      

    ;
    test dl, 1  
    jz player1_is_X

   
    mov al, Simb_O 
    mov player1_S, al
    jmp player2_symbol_done

player1_is_X:
    
    mov al, Simb_X
    mov player1_S, al
	mov al, 1
	mov ID_Simb, al

player2_symbol_done:
 
    mov al, Simb_X
    cmp player1_S, al
    je player2_is_O
    mov al, Simb_X
    mov player2_S, al
    jmp Sair

player2_is_O:

    mov al, Simb_O
    mov player2_S, al

Sair:

call Jogar

X_ou_O ENDP




INSTRUCOES	PROC
	call		apaga_ecra 
	goto_xy		0,2
    lea         dx, Ajuda ; mostra a ajuda
    mov         ah, 9
    INT			21H
	
	call		MenuInicial
	ret

INSTRUCOES	ENDP


escreve1 proc					; Introduzir o nome do player1
	xor si,si
	mov cx,10					
			
	xor si,si
	goto_xy 11,13
	Print introduznome
	mov POSxcursor,30
	mov POSycursor,13

cursor:
	goto_xy POSxcursor ,POSycursor 
	mov ah,07h
  	int  21h
ciclo:	
	cmp al ,0DH			; ao percionar enter ele vai para saida
	je saida
	cmp al,'A'			; intrevalo possivel para escrever na tabela ASCII entre A e Z
	jb cursor			; caso nao pertenca volta ate que seja maiuscula
	cmp al,'Z'
	ja 	cursor
	jmp letra			; se for maiuscula é aceite


letra:
	mov nomeplayerText[si],al	; move o caracter digitado para a string 				
	inc si
	cmp si, 10					; ve quando si chega a 10 (max)
	je saida
    jmp imprimeLetra
	
imprimeLetra:
	goto_xy 30 ,13			; vai imprimindo a medida que escreve uma letra
	print nomeplayertext	
	inc POSxcursor
	jmp cursor
	
saida:
	ret
	
escreve1 endp


escreve2 proc					; Introduzir o nome do player2
	
	xor si,si
	mov cx,10					
	
	
			

	xor si,si
	goto_xy 11,14
	print introduznome2
	mov POSxcursor,30
	mov POSycursor,14

cursor:
	goto_xy POSxcursor ,POSycursor
	mov ah,07h
  	int  21h
	
ciclo2:	
	cmp al ,0DH			; ao percionar enter ele vai para saida
	je saida
	cmp al,'A'			; intrevalo possivel para escrever na tabela ASCII entre A e Z
	jb 	cursor			; caso nao pertenca volta ate que seja maiuscula
	cmp al,'Z'
	ja 	cursor
	jmp letra2			; se for maiuscula é aceite
	
letra2:

	mov nomeplayer2TEXT[si],al	; move o caracter digitado para a string 
	inc si
	cmp si, 10					; ve quando si chega a 10 (max)
	je saida
    jmp imprimeLetra
	
imprimeLetra:
	goto_xy 30 ,14
	print nomeplayer2TEXT
	inc POSxcursor
	jmp cursor
	
saida:
	ret
	
escreve2 endp


PlayerNames Proc

	call apaga_ecra
	
	lea  dx,Fich_Nomes
	
	call IMP_FICH
	
	call escreve1
	
	call escreve2
	
	call X_ou_O
	
	
PlayerNames ENDP

troca_P proc

	cmp 	ID_Simb, 1
	je 		Mostra2

Mostra1 :
	goto_xy 17,3
	print nomeplayer2Text
	jmp Sair


Mostra2 :
	goto_xy 16,3
	print nomeplayerText

Sair:
ret

troca_P endp



Algoritmo proc

	call ApagarLinha

	goto_xy 3,3
	Print S_Vezde

	call troca_P

ret
Algoritmo endp

player1simb PROC

    mov  al,  player1_S
    cmp al, 'X'
    jne o_simb

    mov ah,  09h
    mov bh,  0
    mov bl,  00000001b
    int      10h
    jmp saida

o_simb:
 
    mov ah,  09h
    mov al,  player1_S
    mov bh,  0
    mov bl,  00001100b
    int      10h

saida: ret

player1simb endp

player2simb PROC

    mov  al,  player2_S
    cmp al, 'X'
    jne o_simb

    mov ah,  09h
    mov bh,  0
    mov bl,  00000001b
    int      10h
    jmp saida

o_simb:
 
    mov ah,  09h
    mov al,  player2_S
    mov bh,  0
    mov bl,  00001100b
    int      10h

saida: ret

player2simb endp

JOGAR    PROC

    call    apaga_ecra

    lea     dx,Fich

    call    IMP_FICH

    goto_xy 1,1
    Print idplayers
    goto_xy 15,1
    Print nomeplayerText
    goto_xy 48,1
    Print nomeplayer2Text

    goto_xy 9,1
    call player1simb
    goto_xy 42,1
    call player2simb



    call     Algoritmo

    call     CursorGame



JOGAR    ENDP

Le_Tecla_Menu	PROC

	nao_ha:	
		mov		ah,0bh
		int		21h
		cmp		al,0
		je		nao_ha ;loop

		mov		ah,08h
		int		21h
		mov		ah,0
		cmp		al,0
		jne		sucesso

		mov		ah, 08h
		int		21h
		mov		ah,1
			
	sucesso:	;sai do loop
		RET

Le_Tecla_Menu	endp

	 
MenuInicial	proc	
		
	loopMenu: 

		call	Le_Tecla_Menu

		call	apaga_ecra  ; apaga o ecra

		call    MostraMenu ; imprime o menu no ecra

		mov ah, 1h
		int 21h	

		; chama o procedimento conforme a tecla pressionada
		
		cmp 	al, 49 ; 1
		je		OPCJOGAR
		cmp		al, 50 ; 2
		je		OPCINSTRUCOES
		cmp		al, 51 ; 3
		je		OPCSAIR
		cmp		al, 27 ; ESC
		je		OPCSAIR
		jmp     loopMenu ; jump -> volta a tentar
		
		; switch

	OPCJOGAR:
						
		call   PlayerNames
			
	OPCINSTRUCOES:

		call    INSTRUCOES 
			
	OPCSAIR:	
			
			mov  ax, 4c00h
			int  21h


MenuInicial	endp

Main	proc

	mov		ax, dseg
	mov		ds,ax
		
	mov		ax,0B800h
	mov		es,ax	
		
	call 	apaga_ecra			
	lea     dx,Fich_BemVindo
	call	IMP_FICH
	call  	LE_TECLA
	call	MenuInicial	
	call	apaga_ecra 
	
main endp
cseg ends

end main