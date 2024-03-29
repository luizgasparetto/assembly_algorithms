.data
text_posicao: .asciz "Informe o valor da posição: "
v: .word 1, 2, 3, 4, 5

.text
addi a7, x0, 4
la a0, text_posicao
ecall

addi a7, x0, 5
ecall
add t1, x0, a0

la s0, v
slli t2, t1, 2
add t3, s0, t2

lw t0, 0(t3)

addi a7, x0, 1
add a0, t0, x0
ecall