.data
vector: .word 1, 2, 3, 3, 5, 2, 2, 1, 2, 5, 1, 7, 2, 4, 1, 4, 1, 4, 3, 2  # Vetor de n�meros
vector_size: .word 20  # Tamanho do vetor
question_text: .asciz "Insira at� qual n�mero voc� deseja ler (1 a 20): "  # Texto de solicita��o
result_success: .asciz "Resultado: "  # Texto do resultado

.text
.global main  # Define a fun��o principal como global

main:
    la s2, vector  # Carrega o endere�o do vetor em s2

    jal ra, request_number  # Chama a fun��o para solicitar o n�mero

    add s3, x0, a0  # Armazena o n�mero lido em s3
    addi s1, x0, 1  # Inicializa o produto em 1 (s1)

    jal ra, multiply_vector  # Chama a fun��o de multiplica��o

    # Exibe o texto "Resultado: "
    addi a7, x0, 4  # C�digo de chamada do sistema para impress�o de string
    la a0, result_success  # Carrega o endere�o da string "Resultado: " em a0
    ecall  # Chama o sistema

    # Exibe o resultado da multiplica��o
    addi a7, x0, 1  # C�digo de chamada do sistema para impress�o de inteiro
    add a0, x0, s1  # Move o resultado da multiplica��o (s1) para a0
    ecall  # Chama o sistema

    # Termina o programa
    addi a7, x0, 10  # C�digo de chamada do sistema para terminar o programa3
    ecall  # Chama o sistema

# Fun��o para solicitar o n�mero
request_number:
    addi sp, sp, -8  # Reserva espa�o na pilha para 2 registros (ra e s0)
    sw ra, 4(sp)  # Salva o valor de ra na pilha
    sw s0, 0(sp)  # Salva o valor de s0 na pilha

    # Imprime a mensagem "Insira at� qual n�mero voc� deseja ler (1 a 20): "
    li a7, 4  # C�digo de chamada do sistema para impress�o de string
    la a0, question_text  # Carrega o endere�o da string em a0
    ecall  # Chama o sistema

    # L� o n�mero inserido pelo usu�rio
    li a7, 5  # C�digo de chamada do sistema para leitura de inteiro
    ecall  # Chama o sistema

    # Restaura os valores de s0 e ra da pilha
    lw s0, 0(sp)  # Carrega o valor de s0 da pilha
    lw ra, 4(sp)  # Carrega o valor de ra da pilha
    addi sp, sp, 8  # Libera o espa�o na pilha

    jalr ra  # Retorna para a fun��o chamadora

# Fun��o para multiplicar os elementos do vetor
multiply_vector:
    addi sp, sp, -12
    sw ra, 8(sp) # Aloca ra na pilha
    sw s0, 4(sp) # Aloca s0 na pilha
    sw s3, 0(sp) # Aloca s3 na pilha

    addi t0, x0, 0 # �ndice do vetor

iterate_loop:
    bge t0, s3, end_loop

    slli t2, t0, 2 # Calcula o deslocamento no vetor
    add t3, s2, t2 # Carrega o endere�o do elemento do vetor

    lw s4, 0(t3)   # Carrega o valor do vetor

    mul s1, s1, s4 # Multiplica o acumulador pelo valor do vetor

    addi t0, t0, 1 # Incrementa o �ndice

    jal x0, iterate_loop

# Fun��o para terminar o loop
end_loop:
    lw s3, 0(sp) # Devolve s3
    lw s0, 4(sp) # Devolve s0
    lw ra, 8(sp) # Devolve ra
    addi sp, sp, 12

    jalr ra
