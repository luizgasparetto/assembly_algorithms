.data
vetor: .word 1, 2, 3, 4, 5
size_vetor: .word 5   
matrix: .word vetor, vetor, vetor             
success_message: .asciz "\nVetor lido com sucesso!\n"

.text
.global main

main: 
la t1, size_vetor
lw t1, 0(t1)                          # t1 contém o tamanho do array

la s0, vetor                          # s0 aponta para o início do array

addi t1, t1, -1                       # Ajusta t1 para ser o índice do último elemento do array

init_reversed_loop:
blt t1, x0, end_reversed_loop         # Se t1 < 0, termina o loop

slli t2, t1, 2                        # t2 = t1 * 4 (para calcular o deslocamento do elemento)
add t3, s0, t2                        # t3 = endereço do elemento atual
lw a0, 0(t3)                          # Carrega o valor do elemento do array em a0

li a7, 1
ecall

addi t1, t1, -1                       # Decrementa o índice para mover para o próximo elemento (para trás)
j init_reversed_loop                  # Continua o loop

end_reversed_loop:
li a7, 4
la a0, success_message
ecall
