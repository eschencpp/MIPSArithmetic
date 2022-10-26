#Objective: Take user input and do arithmetic operations
#CS2640 Eric Chen
#Program 1: Getting Familiar with Assembly
#Date - 10/25/2022
#Github https://github.com/eschencpp/MIPSArithmetic
#Group members: me
.data
intInput: .asciiz "Enter an integer: "
displayInput: .asciiz "\nYour input is: "
options: .asciiz "\nPlease select an option: (1-4) \n1. Addition \n2. Subtraction \n3. Multiplication \n4. Division\n"
addMsg: .asciiz "The result for addition is: "
subMsg: .asciiz "The result for subtraction is: "
multMsg: .asciiz "The result for multiplication is: "
divMsg: .asciiz "The result for division is: "
sameInp: .asciiz "\nUser inputs are the same"
diffInp: .asciiz "\nUser inputs are different"
.text
main: 
	#Task 1: Taking user inputs
	li $v0, 4	#Prompt user for input #1 in console
	la $a0,intInput
	syscall
	li $v0, 5 	#Take user input int
	syscall
	move $s0, $v0 	#Store input variable to $s0
	
	li $v0, 4	#Prompt user for input #2 in console
	la $a0,intInput
	syscall
	li $v0, 5 	#Take user input int
	syscall
	move $s1, $v0 	#Store input variable  to $s1
	
	li $v0, 4	#Display input 1 to user
	la $a0,displayInput
	syscall
	li $v0, 1  	
	move $a0,$s0
	syscall
	
	li $v0, 4	#Display input 2 to user
	la $a0,displayInput
	syscall
	li $v0, 1  	
	move $a0,$s1
	syscall
	
	#Task 2: Arithmetic operation options
	li $v0, 4
	la $a0,options
	syscall
	
	li $v0, 5 	#Take user input 
	syscall
	la $s2, ($v0) 	#Store input variable into var
	
	#If statements to check option input (Available options 1-4)
	beq $s2, 1, addition
	beq $s2, 2, subtract
	beq $s2, 3, multi
	beq $s2, 4, divi
	
	#Task 3: Conditions
resume:
	beq $s0, $s1, eqInput	#If input 1 and input 2 equal then print input is equal
	bne $s0, $s1, notEqInput #If input 1 and input 2 not equal then print input is not equal
	
	
	j exit
	
addition:
	li $v0, 4	#Print message for addition
	la $a0, addMsg	
	syscall
		
	add $t0, $s0, $s1	#Add $s0 and $s1
	li $v0, 1		#Print result
	move $a0, $t0
	syscall
	 
	j resume
	
subtract:
	li $v0, 4	#Print message for subtraction
	la $a0,subMsg
	syscall
	
	sub $t0, $s0, $s1	#Subtract $s0 and $s1
	li $v0, 1		# Print result
	move $a0, $t0
	syscall
	
	j resume
	
	
multi:	
	li $v0, 4	#Print message for multiplication
	la $a0,multMsg
	syscall
	mul $t0, $s0, $s1	#Do multiplcation on $s0 and $s1
	li $v0, 1	
	move $a0, $t0
	syscall
	j resume
	
	
divi:
	li $v0, 4	#Print message for division
	la $a0,divMsg
	syscall
	mtc1 $s0, $f1	#Convert $s0 and $s1 to float
	cvt.s.w $f1,$f1
	mtc1 $s1, $f2
	cvt.s.w $f2,$f2
	
	div.s $f12, $f1, $f2 #Divide float numbers and output
	
	li $v0, 2
	syscall
	
	j resume
	
	

eqInput:
	li $v0, 4	#Print prompt if equal
	la $a0, sameInp
	syscall
	
	j exit

notEqInput:
	li $v0, 4	#Print prompt if not equal
	la $a0, diffInp
	syscall
	
exit:
	li $v0, 10 	#Exit Program
	syscall 
	
