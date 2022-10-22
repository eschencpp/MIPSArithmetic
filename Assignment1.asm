#CS2640 Eric Chen
#Program 1: Getting Familiar with Assembly - 10/25/2022
#Objective: Take user input and do arithmetic operations
.data
intInput: .asciiz "Enter an integer: "
options: .asciiz "Please select an option: \n1. Addition \n2. Subtraction \n3. Multiplication \n4. Division\n"
addMsg: .asciiz "The result for addition is: "
subMsg: .asciiz "The result for subtraction is: "
multMsg: .asciiz "The result for multiplication is: "
divMsg: .asciiz "The result for division is: "
.text
main: 
	li $v0, 4
	la $a0,intInput
	syscall
	li $v0, 5 #Take user input int
	syscall
	move $s0, $v0 #Store input variable 
	
	li $v0, 4
	la $a0,intInput
	syscall
	li $v0, 5 #Take user input int
	syscall
	move $s1, $v0 #Store input variable 
	
	li $v0, 4
	la $a0,options
	syscall
	
	li $v0, 5 #Take user input 
	syscall
	la $s2, ($v0) #Store input variable into var
	
	#If statements to check option input
	beq $s2, 1, addition
	beq $s2, 2, subtract
	beq $s2, 3, multi
	beq $s2, 4, divi
	
	li $v0, 10 #Exit Program
	syscall 
	
addition:
	li $v0, 4
	la $a0, addMsg
	syscall
		
	add $t0, $s0, $s1
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10 #10 is value to exit program
	syscall #make service call
subtract:
	li $v0, 4
	la $a0,subMsg
	syscall
	
	sub $t0, $s0, $s1
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10 #10 is value to exit program
	syscall #make service call
multi:	
	li $v0, 4
	la $a0,multMsg
	syscall
	mul $t0, $s0, $s1
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10 #10 is value to exit program
	syscall #make service call
divi:
	li $v0, 4
	la $a0,divMsg
	syscall
	mtc1 $s0, $f1
	cvt.s.w $f1,$f1
	mtc1 $s1, $f2
	cvt.s.w $f2,$f2
	
	div.s $f12, $f1, $f2
	
	li $v0, 2
	syscall
	
	li $v0, 10 #10 is value to exit program
	syscall #make service call
	
	
	
	
