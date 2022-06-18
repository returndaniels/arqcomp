;---------------------------------------------------------------------------
; Questao 4
; Grupo C
; Alunos: Carolina Naccarato, Cristian Diamantaras e Daniel de Sousa
;               DRE: 117220395      DRE: 118109047         DRE: 118064962
;---------------------------------------------------------------------------

ORG 300

SP:   DW  0          ; Stack Pointer
STR1: STR "Teste"  ; String 1
      DB  0          ; Termina com nulo
STR2: STR "Teste 1"  ; String 2
      DB  0          ; Termina com nulo
PT1:  DW  STR1       ; Ponteiro para a string 1
PT2:  DW  STR2       ; Ponteiro para a string 2
AUX1: DW  0          ; Ponteiro auxiliar para a primeira string
AUX2: DW  0          ; Ponteiro auxiliar para a segunda string
AUX:  DW  0          ; Variavel auxiliar para armazenar um caractere

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

       ; Copia PT1 para AUX1
       POP
       STA AUX1+1 ; Armazenamos a parte alta em AUX2
       POP
       STA AUX1   ; Armazenamos a parte baixa em AUX2+2

       JMP COMPARA

COMPARA:
       LDA @AUX2         ; Le o proximo caractere da segunda string
       OR #0             ; Verifica se chegou ao fim da string
       JNZ NOTNULL2      ; Trata o caso da string 2 nao ter chegado ao fim

       LDA @AUX1         ; Le o proximo caractere da primeira string
       OR #0             ; Verifica se chegou ao fim da string
       JNZ STRING2_MENOR ; Trata caso da string 2 ser menor

       ; Strings são iguais: Acumulador recebe 0
       LDA #0
       JMP FIM

NOTNULL2:
       LDA @AUX1         ; Le o proximo caractere da primeira string
       OR #0             ; Verifica se chegou ao fim da string
       JNZ NOTNULL1      ; Trata o caso da string 1 nao ter chegado ao fim

       ; Trata caso do proximo caractere ser igual a nulo
       LDA @AUX2         ; Le o proximo caractere da segunda string
       OR #0             ; verifica se eh o caractere nulo
       JNZ STRING1_MENOR ; Trata caso da string 1 ser menor

       ; Strings são iguais: Acumulador recebe 0
       LDA #0
       JMP FIM

NOTNULL1:
       LDA @AUX1  ; Le o proximo caractere da primeira string
       STA AUX    ; Faz o acumulador apontar para AUX1
       LDA @AUX2 ; Le o proximo caractere da primeira string
       SUB AUX    ; Subtrai o corrente caractere da string 1 do corrente caractere da string 2

       JN STRING2_MENOR
       JNZ STRING1_MENOR

       ; Incrementa de 1 os apontadores de ambas as cadeias
       LDA AUX1
       ADD #1
       STA AUX1
       LDA AUX2
       ADD #1
       STA AUX2

       ; Volta para o inicio para garantir o loop
       JMP COMPARA

STRING2_MENOR:
       ; String 2 menor: Acumulador recebe -1
       LDA #0FFh
       JMP FIM

STRING1_MENOR:
       ; String 1 menor: Acumulador recebe 1
       LDA #1
       JMP FIM

FIM:
       LDS SP
       RET

INICIO:
       LDA PT1 ; Adiciona PT1 na pilha 
       PUSH
       LDA PT1+1
       PUSH

       LDA PT2 ; Adiciona PT2 na pilha
       PUSH
       LDA PT2+1
       PUSH

       JSR ROTINA ; Chama rotina para avaliar strings
       OUT 0      ; Exibe acumulador no visor
       HLT        ; Fim
END INICIO







