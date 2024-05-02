#######################
## DECLARACION ALIAS ##
#######################
.eqv _b 5
.eqv _e 8

.eqv _sum1, $t0
.eqv _sum2, $t1
.eqv _aux1, $t2

###########################
## DECLARACION VARIABLES ##
###########################
.data


########################
## CODIGO DE EJECUCON ##
########################
.text 
	add _sum1, $zero, _b
	add _sum2, $zero, _e

	jal suma_recur

		# Indicamos al sistema que vamos a imprimir string
		li $v0, 1
		
		#Cargamos el valor del string
		move $a0, $v1
		
		#Llamamos al sistema para que imprima el salto
		syscall

#####################
## FIN DE PROGRAMA ##
#####################
	li $v0, 10
	syscall

#################
## SUB-RUTINAS ##
#################


	##SUMA RECURSIVA##
	suma_recur:
	#Guardamos $ra en la pila cada vez que entremos en la subrutina
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	#Comprobamos que el segundo sumando sea igual a 0 
	beqz _sum2, else_sum
	
		#Si no es igual a 0 restamos uno al segundo sumando y volvemos a llamar a la subrutina
		add _sum2, _sum2, -1
		
		#Llamamos a la misma sub-rutina
		jal suma_recur
		
		#Sumamos 1 al resultado de la subrutina
		addi $v1, $v1, 1

		#recuperamos $ra de la pila para salir de la subrutina
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		#salimos de la subrutina
		jr $ra
	
	else_sum:
		#Si el segundo sumando es igual a 0 establecemos en $v1 el valor del primer sumando
		move $v1, _sum1
		
		#recuperamos $ra de la pila para salir de la subrutina
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		#salimos de la subrutina
		jr $ra
	
	


