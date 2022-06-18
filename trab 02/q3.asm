;---------------------------------------------------------------------------
; Questao 3
; Grupo C
; Alunos: Carolina Naccarato, Cristian Diamantaras e Daniel de Sousa
;               DRE: 117220395      DRE: 118109047         DRE: 118064962
;---------------------------------------------------------------------------

ORG 300

V:     DW 32, 3200, -15, 13, 42, 2, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 14, 15, -3200   ; Vetor de dados
PV:    DW V    ; Ponteiro para vetor de dados
TAM:   DB 20   ; Tamanho do vetor de dados

I:     DB 1    ; Contador de voltas do laço
PT:    DS 2    ; Ponteiro de manipulação dos dados
SP:    DS 2    ; Stack pointer
AUXW:  DS 2    ; Varivavel auxiliar para manipular valores de 2 bytes
AUXB:  DS 1    ; Varivavel auxiliar para manipular valores de 1 byte
MIN:   DS 2    ; variável para armazenar valor mínimo
MAX:   DS 2    ; variável para armazenar valor máximo

ORG 0
ROTINA:
     STS  SP        ; Guarda valor da Stack Pointer
     POP            ; Desempilha endereço de retorno
     POP

     ; Comecamos lendo a posição inicial do vetor
     ; e salvando na variável de apontador
     POP
     STA PT+1       ; Armazenamos a parte alta do endereço do vetor em PT+1
     POP
     STA PT         ; Armazenamos a parte baixa do endereço do vetor em PT

     LDS  @PT       ; Carrega valor do endereço referenciado por PT
     STS  MIN       ; Salva valor mínimo inicial
     STS  MAX       ; salva valor máximo inicial
     JMP  INC       ; Desvia para INC

TESTE_MIN:
     LDS  @PT       ; Carrega valor referenciado por PT (V[i-1])
     STS  AUXW      ; Salva valor do vetor em AUXW
     LDA  MIN       ; Carrega valor mínimo 
     SUB  AUXW      ; Subtrai parte baixa
     JP   TROCA_MIN ; Desvia para TROCA_MIN se a diferença for positiva

     LDA  AUXW+1    ; Carrega parte alta do valor
     NOT
     STA  AUXB      ; Grava valor com bits invertidos

     LDA  MIN+1     ; Carrega parte alta do valor mínimo
     ADD  AUXB      ; Compara com com complemento a dois
     ADD  #1
     JP   TROCA_MIN ; Desvia para TROCA_MIN se a diferença for positiva 

TESTE_MAX:
     LDA  MAX       ; Compara valor máximo (parte baixa)
     SUB  AUXW
     JN   TROCA_MAX ; Desvia para TROCA_MAX se a diferença for negativa 
     
     LDA  MAX+1     ; Compara valor máximo (parte alta)
     ADD  AUXB
     ADD  #1
     JN   TROCA_MAX ; Desvia para TROCA_MAX se a diferença for negativa
     JMP  INC

TROCA_MIN:
     STS  MIN       ; Grava novo valor mínimo
     JMP  INC       ; Desvia para INC

TROCA_MAX:
     STS  MAX       ; Grava Novo valor máximo

INC:
     LDA  TAM       ; Carrega tamanho do vetor
     SUB  I         ; Compara com I
     JZ   FIM       ; Se forem iguais, desvia para FIM
     LDA  PT        ; Atualiza PT
     ADD  #2
     STA  PT
     LDA  I         ; Atualiza I
     ADD  #1
     STA  I
     JMP  TESTE_MIN ; Desvia para TESTE_MIN

FIM:
     LDS  SP        ; Recupera valor da stack pointer
     RET            ; Encerra rotina com endereço de retorno

INICIO:
    LDA   PV        ; Adiciona posição inicial de V na pilha 
    PUSH
    LDA   PV+1
    PUSH
    LDA   TAM       ; Carrega tamanho do vetor no acumulador
    JSR   ROTINA    ; Chama a rotina para encontar MAX e MIN
    HLT             ; Fim

END INICIO
