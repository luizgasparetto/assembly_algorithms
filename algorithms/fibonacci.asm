.data
request_fibonacci_text: .asciz "Quantos digitos fibonnaci você quer?\n"
init_fibonacci: .word 1

.text
.global main

main:
addi t0, x0, 0

li a7, 4
la a0, request_fibonacci_text
ecall

li a7, 5
ecall
add t1, x0, a0

la t3, init_fibonacci
lw t3, 0(t3)

add t4, x0, x0

jal x0, fibonacci

fibonacci:
bge t0, t1, end_fibonacci

add t5, x0, t3
add t3, t3, t4
add t4, x0, t5

addi t0, t0, 1
jal x0, fibonacci

end_fibonacci:
li a0, 0
li a7, 93
ecall

