.data
vetor: .word 1, 2, 3, 4, 5
size_vetor: .word 5   
matrix: .word vetor, vetor, vetor             
success_message: .asciz "\nVetor lido com sucesso!\n"

.text
.global main

main: 
la t1, size_vetor
lw t1, 0(t1)                          

la s0, vetor                          

addi t1, t1, -1                       

init_reversed_loop:
blt t1, x0, end_reversed_loop         

slli t2, t1, 2                        
add t3, s0, t2                        
lw a0, 0(t3)                          

li a7, 1
ecall

addi t1, t1, -1                    
j init_reversed_loop                 

end_reversed_loop:
li a7, 4
la a0, success_message
ecall
