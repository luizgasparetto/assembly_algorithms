.data
vector: .word 1, 2, 8, 8, 5, 9
vector_length: .word 6
array_position_multipler: .word 4
loading_message: .asciz "Carregando...\n"
success_message: .asciz "Vetor lido com sucesso, o item foi encontrado: "
empty_message: .asciz "Vetor lido com sucesso, não foi encontrado um item repetido!\n"

.text
.global main

main:
la s1, vector
la s2, loading_message
la s3 success_message
la s4, empty_message

la s5, vector_length
lw s5, 0(s5)

la s6, array_position_multipler
lw, s6, 0(s6)

li a7, 4
add a0, x0, s2
ecall

add t0, x0, x0
add t1, s5, x0

jal x0, iterator

iterator:
bge t0, t1, end_empty_iterator

slli t2, t0, 2
add t3, s1, t2 
lw s7, 0(t3)

beq s7, t4, end_founded_iterator

add t4, x0, s7

addi t0, t0, 1
jal x0, iterator

end_founded_iterator:
li a7, 4
add a0, x0, s3
ecall

li a7, 1
add a0, x0, s7
ecall

li a7, 93
addi a0, x0, 1
ecall

end_empty_iterator:
li a7, 4
add a0, x0, s4
ecall

li a7, 93
addi a0, x0, 1
ecall