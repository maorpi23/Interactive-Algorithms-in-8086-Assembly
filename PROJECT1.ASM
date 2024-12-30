data segment
msg1 db 'please choose one of the following options: $'
msg2 db '1. Prime number checker$'
msg3 db '2. Caesars shift coder $'
msg4 db '3. Exit $'
msg5 db 'Enter a positive integer number N(255>N>2):  $'
Number dw ?
msg6 db 'Type a string (only small characters in english): $'
string1 db 100 dup(?)
msg7 db 'Enter one decimal digit (between 2 to 9): $'
offset1 db ?
string2 db 100 dup(?)
msg8 db 'the number is prime $'
msg9 db 'the number is not prime $'
is_prime dw ?
msg10 db 'the string after convertion:  $'
data ends

stack1 segment stack
db 100h dup(0)
stack1 ends

code segment
assume cs:code, ds:data, ss: stack1
main:  mov ax,data
       mov ds,ax
       ;printing the main menu
       menu:
       mov dx, offset msg1
       mov ah,9
       int 21h

       mov dl,10
       mov ah,2
       int 21h

       mov dx, offset msg2
       mov ah,9
       int 21h

       mov dl,10
       mov ah,2
       int 21h

       mov dx, offset msg3
       mov ah,9
       int 21h

       mov dl,10
       mov ah,2
       int 21h

       mov dx, offset msg4
       mov ah,9
       int 21h

       mov dl,10
       mov ah,2
       int 21h

       mov ah,1
       int 21h
       mov ah,0
       mov bl,al 
       
       mov dl,10
       mov ah,2
       int 21h
       
       cmp bl,'1'
       je prime_number

       cmp bl,'2'
       je caesars

       cmp bl,'3'
       je exit
       
       jmp menu
       
       ;jumping to the end of the program if the user enter '3' 
        exit:
       jmp end1
       
       
       
       
       ;if the user enter 2:
       caesars:
       ;printing a massege to the user to recieve a small letters string from the user 
       mov dx,offset msg6
       mov ah,9
       int 21h
       
       ;calling get_string procedure that recieves a string from the user and saves it in 'string1' data
       mov bx, offset string1
       push bx 
       call get_string
       
       mov dl,10
       mov ah,2
       int 21h
       
       ;printing a message to the user to recieve from him a one digit num
       mov dx,offset msg7
       mov ah,9
       int 21h
       
       ;we recieves the number from the user and saving it in 'offset1' data
       mov ah,1
       int 21h
       mov ah,0
       sub al,'0'
       mov offset1,al
       
       ;start making the caesar's code 
       mov si,0  ;string2 index counter
       
       ;going throw all string1's chars
   heiset:
       mov ah, string1[si]   ;copying to ah register the char in si index of string1
       ;if ah=='$' we reached to the end of string1 so we jumping to the next part section
       cmp ah,'$'
       je print_string2
       
       ;adding to the char that save in ah register our offset1's value
       ;if the new ah value out of the alphabet range we making a 'restart' in the restart section
       ;else we adding the new char to 'string2' data 
       add ah,offset1 
       cmp ah, 'z'
       ja restart
       mov string2[si], ah
       inc si
       jmp heiset
       
       ;we getting here if the new char is out of the alphabet range
       ;in that case we starting over the alphabet order by subbing of the value 26 from ah register
       ;then we adding the new char to 'string2' data
   restart:
       sub ah,26
       mov string2[si],ah
       inc si
       jmp heiset
       
       ;printing the string after the caesar's code process
   print_string2:
       mov string2[si],'$'
       mov dl,10
       mov ah,2
       int 21h
       
       mov dx, offset msg10
       mov ah,9
       int 21h
       
       mov dx, offset string2
       mov ah,9
       int 21h
       
       mov dl,10
       mov ah,2
       int 21h
       jmp menu ;jumping again to reprint the menu
        
       
       
       
       ;if the user enters '1'
       prime_number:
       ;printing a message to the user to give us a number between 2-255
       mov dx, offset msg5
       mov ah,9
       int 21h
       
       ;calling to a procedure that recieves a number from the user and saves it in 'Number' data
       mov bx, offset Number
       push bx
       call get_number
       
       ;calling to a procedure that checks if the given number is a prime number or not, and prints the result 
       push Number
       mov bx, offset is_prime ;flag that will help us to check if the number is prime or not after the procedure
       push bx
       mov bx, offset msg8
       push bx
       mov bx,offset msg9
       push bx
       call check
       
       mov dl,10
       mov ah,2
       int 21h
       
       ;if is_prime flag equal to 0 the number is not prime, if the flag equal to 1 the number is prime
       mov cx,is_prime
       cmp cx, 0
       je is_not_prime

       mov dl,10
       mov ah,2
       int 21h
       ;if the number is prime we calling a procedure that prints a 'number' size triangle
       push Number 
       call print_triangle
       jmp go_to_menu
      
       ;if the number is not prime we calling a procedure that prints a 'number' size square
       is_not_prime:
       mov dl,10
       mov ah,2
       int 21h
       push Number 
       call print_square
       
   go_to_menu:
       jmp menu ; jumping back to the menu

       
   end1:
       mov ah,4ch
       int 21h

       
       ;procedure that recieves a number from the user and saves it in 'Number' data      
get_number proc

       mov si,0;count the num of digits
       
       ;in this section we:
       ;receiving digits from the user one by one untill he enter '.'
       ;pushing all the digits to the stack one by one 
       ;increasing the num of digits counter by one after every digit
       input:
       mov ah,1
       int 21h
       mov ah,0
       cmp al,'.'
       je num 
       push ax
       inc si
      jmp input

      ;in this section we converting the number to be a decimal integer 
       num:
       mov di,1     ;mul counter
       mov cx,0     ;register to save the number
       
       ;in each iteretion we:
       num1:
       pop ax       ;popping out a digit from the stack in reverse order  
       sub ax,'0'   ;converting the digit from string to a number
       mul di       ;multiplying the digit with the mul counter 
       add cx,ax    ;adding the result to the register that saves the number
       mov ax,10
       mul di       ;multiplying our mul counter by 10 for the next digit
       mov di,ax    ;saving the result back to di register
       dec si       ;decreasing the num of digits counter by ine
       cmp si,0     ;if the num og digits counter equal to 0 we done converting
       ja num1
       
       ;saving the number's value at Number data 
       mov bp,sp
       mov bx,[bp+2]
       mov [bx], cx
       ret 2

get_number endp       
       
       
       
       
       
       ;procedure that checks if a number is a prime number and prints a message due to the result
check proc
      mov bp,sp
      mov ax,[bp+8] 
      mov cx,[bp+8] ;ax and cx registers saves the number's value
      mov bx,2      ;bx=devider counter
      
      ;keep looping the section while bx>cx and we did't found that the number is not a prime
      L1:
      mov dx,0     ;initializing the register that saves the reminder to 0
      div bx       ;deviding ax(number's value) with bx(devider counter), the reminder result saves in dx register 
      cmp dx,0     ;if there is no reminder the number is not a prime number and we jumping to 'not_prime' section
      je not_prime
      
      ;if there is a reminder:
      inc bx       ;increasing the devider counter by one
      mov ax,cx    ;re-initializing ax register to contain the number's value
      cmp bx,cx    ;comparing the devider counter to number- keep looping as long as bx<cx
      jb L1 
      
      ;if we getting here the number is a prime
      prime:
      mov ax,1
      mov bx, [bp+6]
      mov [bx],ax ;setting the is_prime flag to 1
     
      mov dl,10
      mov ah,2 
      int 21h
      
      ;printing a message that the number is prime
      mov cx,[bp+4]
      mov dx,cx
      mov ah,9
      int 21h
      jmp sof1;jumping to the end of the procedure
      
      ;if we getting here the number is not a prime
      not_prime:
      mov ax,0
      mov bx, [bp+6]
      mov [bx],ax   ;setting the is_prime flag to 0
      
      mov dl,10
      mov ah,2 
      int 21h
      ;printing a message that the number is not a prime
      mov cx,[bp+2]
      mov dx,cx
      mov ah,9
      int 21h
      
      ;end of procedure
 sof1:    
      ret 8
check endp

  ;;procedure that prints a triangle from '@' chars
print_triangle proc

      mov bp,sp
      mov cx, [bp+2] ;cx= triangle's base and high size
      mov si,1       ;counter for num of rows
      mov bx,0       ;counter for our location in the row
      
      print:
      cmp si, cx ;if si>cx we reached t oour rows limit so we jumping to the end of the procedure 
      ja sof
      
     ;printing '@' in our current triangle's location   
      mov dl, '@'
      mov ah,2
      int 21h
     
      inc bx    ;increasing by one our row location after printing the char
      cmp bx,si ;checking if we reached to our current row limit
      jb print
        
      ;if we do:
      mov dl,10   ;creating a new row
      mov ah,2
      int 21h
      inc si      ;increasing by one the num of rows counter
      xor bx,bx   ;setting our location in the row back to 0
      jmp print   ;jumping back to the start of print section 
    
      ;end of procedure- we getting here when the program done printing the triangle
      sof:    
      mov dl,10
      mov ah,2
      int 21h
      ret 2

print_triangle endp

     ;procedure that prints a square from '*' chars
print_square proc

       mov bp,sp
       mov cx,[bp+2] ;cx=square's each side size
       mov si,0      ;counter for  num of rows
       mov bx,0      ;counter for our location in the row
       
       ;printing the square
   print_s:
       cmp si,cx   ;if num of rows >= square's sides size then we stop printing and jumping to the end of the procedure
       jae sof2
       
       cmp bx,cx   ;if our location in the row >=square's sides size then we need to jump to a new line
       jae next_line
       
       mov dl, '*'
       mov ah,2   ;printing '*' in our current location of the square
       int 21h
       inc bx     ;increasing the row location counter by one
       jmp print_s
       
       
   next_line:
       xor bx,bx   ; initialize our row location counter back to 0
       inc si      ;increasing the rows counter by one
       mov dl,10   ;creating new line
       mov ah,2
       int 21h
       jmp print_s
       
       ;end of the procedure
  sof2:
      mov dl,10
      mov ah,2
      int 21h
      ret 2
print_square endp

;procedure that recieves a string from the user and saves it in 'string1' data 
get_string proc
    mov bp,sp
    mov bx,[bp+2]  ;bx=the memory pointer of string1
    
get_char:
    mov ah,1      ;receiving a char from the user
    int 21h
    cmp al,'.'    ;if the user enters '.' we done getting chars and jumping straight to the end of the procedure 
    je sof3
    
    mov [bx],al   ;adding the char to the end of 'string1' 
    inc bx
    jmp get_char
    
    ;end of the procedure
    sof3:
    mov cx,'$'
    mov [bx],cx
    ret 2
get_string endp

    
code ends
end main
