.data
text_success: .asciz "\nArray lido com sucesso!\n"
v: .word 1, 2, 3, 4, 5

.text
.global main

main:
addi t0, x0, 0
addi t1, x0, 5

la s0, v

jal x0, init_loop

init_loop:
bge t0, t1, end_loop

slli t2, t0, 2
add t3, s0, t2 

lw s2, 0(t3)

addi a7, x0, 1
add a0, x0, s2
ecall

addi t0, t0, 1

jal x0, init_loop

end_loop:
addi a7, x0, 4
la a0, text_success
ecall