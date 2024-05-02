#######################
## DECLARACION ALIAS ##
#######################
.eqv _b 2
.eqv _e 3

.eqv _aux1, $t0
.eqv _aux2, $t1
.eqv _aux3, $t2
.eqv _aux4, $t3


###########################
## DECLARACION VARIABLES ##
###########################
.data


########################
## CODIGO DE EJECUCON ##
########################
.text 
	add _aux1, $zero, _b
	add _aux3, $zero, _e

	jal producto_recur

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
	beqz _aux2, else_sum
	
		#Si no es igual a 0 restamos uno al segundo sumando y volvemos a llamar a la subrutina
		add _aux2, _aux2, -1
		
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
		move $v1, _aux1
		
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
   	beqz _aux3, else_product

        	#Si no es igual a 0 restamos uno al segundo factor y volvemos a llamar a la subrutina
        	add _aux3, _aux3, -1
               	jal producto_recur
        	
        	#Igualamos el valor del producto resultante al _aux2 para que la subrutina suma_recur pueda trabajar
        	move _aux2, $v1

        	#Iniciamos _aux3 a 0 y llamamos a la subrutina suma_recur
        	move _aux3, $zero
        	jal suma_recur

		#Aprovechamos el registro _aux3 para sumar y acumular los resultados de la subrutina suma_recur
		add _aux3, _aux3, $v1
		
		#igualamos $v1 a _aux3 ya que es la salida de nuestra subrutina
		move $v1, _aux3

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
