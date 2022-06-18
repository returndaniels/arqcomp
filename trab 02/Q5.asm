ORG 300

N:     DW  42
AUX:   DS  1
LC:    DS  1

ORG 0
      LDA   N
      JZ    TESTA_ZERO   ; Se for 0, desvia para TESTA_ZERO
      LDA   N+1
      JN    FIM          ; Se for negativo, devia para FIM
LOOP:
      LDA   #0
      STA   LC
      LDA   N
      AND   #1
      JNZ   IMPAR
PAR:
      LDA   N+1
      AND   #1            ; Verifica se ultimo bit da parte alta é 1
      JNZ   WC_PAR        ; Se for, desvia para WC_PAR

      LDA   N             ; Divide N por 2
      SHR
      STA   N
      LDA   N+1
      SHR
      STA   N+1
      JMP   TESTE
WC_PAR:
      LDA   N           ; Divide N por 2 (parte baixa)
      SHR
      OR    #128        ; Adiciona 1 ao bit mais relevante da parte baixa
      STA   N
      LDA   N+1         ; Divide N por 2 (parte alta)
      SHR
      STA   N+1
      JMP   TESTE
IMPAR:
      LDA   N
      SHL
      STA   AUX
      JC    WC_IMPAR
      JMP   H_IMPAR
WC_IMPAR:
      LDA   #1
      STA   LC
H_IMPAR:
      LDA   N+1
      SHL
      ADD   N+1
      OR    LC
      STA   N+1
L_SUM:
      LDA   N
      ADD   AUX
      STA   N
      JC    WC_L_SUM
      JMP   TESTE
WC_L_SUM:
      LDA   N+1
      ADD   #1
      STA   N+1

TESTE:
      LDA   N
      SUB   #1
      JZ    FIM
      JMP   LOOP

TESTA_ZERO:
      LDA   N+1
      JZ    FIM
FIM:
      HLT