.data
vector: .word 10, 20, 30, 40, 50
vector_length:

.text
.global main

main:
    la t0, vector           
    la t1, vector_length      
    sub s0, t1, t0        
    srai s0, s0, 2
    
    add t0, x0, x0
    add t1, x0, x0

    li a7, 1
    add a0, x0, s0
    ecall

