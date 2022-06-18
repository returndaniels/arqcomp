;---------------------------------------------------------------------------
; Questao 2
; Grupo C
; Alunos: Carolina Naccarato, Cristian Diamantaras e Daniel de Sousa
;               DRE: 117220395      DRE: 118109047         DRE: 118064962
;---------------------------------------------------------------------------

ORG 300

SP:   DW  0          ; Stack Pointer
VAR1: DW 15 		 ; Variável 1 de 16 bits
VAR2: DW 15  		 ; Variável 2 de 16 bits
AUX1: DW 0			 ; Variável auxiliar para VAR1
AUX2: DW 0			 ; Variável auxiliar para VAR2

ORG 0
ROTINA:
	STS SP
    POP
    POP

    ; Comecamos lendo os valores das variaveis declaradas
    ; acima e salvando nas variaveis auxiliares
    POP
    STA AUX2+1 ; Armazenamos a parte alta em AUX1
    POP
    STA AUX2   ; Armazenamos a parte baixa em AUX1+1

    POP
    STA AUX1+1 ; Armazenamos a parte alta em AUX2
    POP
    STA AUX1   ; Armazenamos a parte baixa em AUX2+2

    JMP COMPARA

COMPARA:
	; Realiza a subtracao da parte alta
	; Se a parte alta de alguma das variaveis for maior,
	; ja podemos avaliar o resultado
	LDA AUX1
	SUB AUX2
	JP VAR1_MAIOR ; Trata caso VAR1 maior
	JN VAR1_MENOR ; Trata caso VAR1 menor

	; Caso nao seja possivel avaliar o resultado a partir
	; da parte alta, realiza a subtracao da parte baixa
	; usando complemento a 2
	LDA AUX2+1
	NOT
	STA AUX2+1
	LDA AUX1+1    ; Armazenamos parte baixa no acumulador
	ADD AUX2+1    ; Fazemos AUX1 + !AUX2
	ADD #1 	      ; Adicionamos 1 para o complemento a 2
	JP VAR1_MAIOR ; Trata caso VAR1 maior
	JN VAR1_MENOR ; Trata caso VAR1 menor

	; Variaveis sao iguais: Acumulador recebe 0
	LDA #0
    JMP FIM

VAR1_MAIOR:
	; Variavel 1 maior: Acumulador recebe 1
	LDA #1
	JMP FIM

VAR1_MENOR:
	; Variavel 1 menor: Acumulador recebe -1
	LDA #0FFh
    JMP FIM

FIM:
       LDS SP
       RET

INICIO:
	LDA VAR1 ; Adiciona VAR1 na pilha 
    PUSH
    LDA VAR1+1
    PUSH

    LDA VAR2 ; Adiciona VAR2 na pilha 
    PUSH
    LDA VAR2+1
    PUSH

    JSR ROTINA ; Chama a rotina para comparar as variaveis
    OUT 0 	   ; Exibe acumulador no visor
    HLT        ; Fim

END INICIO
