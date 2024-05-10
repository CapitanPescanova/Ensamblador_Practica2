#######################
## DECLARACION ALIAS ##
#######################
.eqv _b 4
.eqv _e 4

.eqv _base_global, $t0
.eqv _sumando, $t1
.eqv _factor, $t2
.eqv _exponente, $t3

###########################
## DECLARACION VARIABLES ##
###########################

########################
## CODIGO DE EJECUCON ##
########################
.text 
	add _base_global, $zero, _b
	add _exponente, $zero, _e

	jal potencia_recur

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
	beqz _sumando, else_sum
	
		#Si no es igual a 0 restamos uno al segundo sumando y volvemos a llamar a la subrutina
		add _sumando, _sumando, -1
		
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
		move $v1, _base_global
		
		#recuperamos $ra de la pila para salir de la subrutina
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		#salimos de la subrutina
		jr $ra
	
	
	
	##PRODUCTO RECURSIVO##
	producto_recur:
    	#Guardamos $ra en la pila cada vez que entremos en la subrutina
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    
    	#Comprobamos que el segundo factor sea igual a 0 
   	beqz _factor, else_product

        	#Si no es igual a 0 restamos uno al segundo factor y volvemos a llamar a la subrutina
        	add _factor, _factor, -1
               	jal producto_recur
        	
        	#Igualamos el valor del producto resultante al _sumando para que la subrutina suma_recur pueda trabajar
        	move _sumando, $v1

        	#Llamamos a la subrutina suma_recur
        	jal suma_recur

        	# Recuperamos $ra de la pila para salir de la subrutina
        	lw $ra, 0($sp)
        	addi $sp, $sp, 4
        
        	# Salimos de la subrutina
        	jr $ra

	else_product:
    		# Si el segundo producto es igual a 0 establecemos en $v1 el valor cero
    		li $v1, 0
   
    		# Recuperamos $ra de la pila para salir de la subrutina
    		lw $ra, 0($sp)
    		addi $sp, $sp, 4
    
    		# Salimos de la subrutina
    		jr $ra



	##POTENCIA RECURSIVA##
	potencia_recur:
    	#Guardamos $ra en la pila cada vez que entremos en la subrutina
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    
    	#Comprobamos que el exponente sea igual a 0 
   	beqz _exponente, else_potencia

        	#Si no es igual a 0 restamos uno al exponente y volvemos a llamar a la subrutina
        	add _exponente, _exponente, -1
               	jal potencia_recur
        	
        	#Igualamos el valor de la potencia resultante al _factor para que la subrutina producto_recur pueda trabajar
        	move _factor, $v1

        	#Llamamos a la subrutina potencia_recur
        	jal producto_recur

        	# Recuperamos $ra de la pila para salir de la subrutina
        	lw $ra, 0($sp)
        	addi $sp, $sp, 4
        
        	# Salimos de la subrutina
        	jr $ra

	else_potencia:
    		# Si el exponente es igual a 0 establecemos en $v1 el valor uno
    		li $v1, 1
   
    		# Recuperamos $ra de la pila para salir de la subrutina
    		lw $ra, 0($sp)
    		addi $sp, $sp, 4
    
    		# Salimos de la subrutina
    		jr $ra
