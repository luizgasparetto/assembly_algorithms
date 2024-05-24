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

    addi t0, x0, 0  # Inicializa o �ndice em 0 (t0)

    jal ra, multiply_vector_recursive  # Chama a fun��o recursiva de multiplica��o

    # Exibe o texto "Resultado: "
    addi a7, x0, 4  # C�digo de chamada do sistema para impress�o de string
    la a0, result_success  # Carrega o endere�o da string "Resultado: " em a0
    ecall  # Chama o sistema

    # Exibe o resultado da multiplica��o
    addi a7, x0, 1  # C�digo de chamada do sistema para impress�o de inteiro
    add a0, x0, s1  # Move o resultado da multiplica��o (s1) para a0
    ecall  # Chama o sistema

    # Termina o programa
    addi a7, x0, 10  # C�digo de chamada do sistema para terminar o programa
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

# Fun��o recursiva para multiplicar os elementos do vetor
multiply_vector_recursive:
    addi sp, sp, -12  # Reserva espa�o na pilha
    sw ra, 8(sp)  # Salva o valor de ra na pilha
    sw s0, 4(sp)  # Salva o valor de s0 na pilha
    sw t0, 0(sp)  # Salva o valor de t0 na pilha

    bge t0, s3, end_recursion  # Se t0 >= s3, termina a recurs�o

    slli t2, t0, 2  # Calcula o deslocamento no vetor (t0 * 4)
    add t3, s2, t2  # Carrega o endere�o do elemento do vetor em t3

    lw s4, 0(t3)  # Carrega o valor do vetor em s4

    mul s1, s1, s4  # Multiplica o acumulador (s1) pelo valor do vetor (s4)

    addi t0, t0, 1  # Incrementa o �ndice (t0)

    jal ra, multiply_vector_recursive  # Chama a fun��o recursiva

end_recursion:
    lw t0, 0(sp)  # Restaura o valor de t0 da pilha
    lw s0, 4(sp)  # Restaura o valor de s0 da pilha
    lw ra, 8(sp)  # Restaura o valor de ra da pilha
    addi sp, sp, 12  # Libera o espa�o na pilha

    jalr ra  # Retorna para a fun��o chamadora
