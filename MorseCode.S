# MorseCode.S

.macro pushall
push r16
push r17
push r18
push r19
push r20
push r21
push r22
push r23
push r24
push r25
push r26
push r27
push r28
push r29
push r30
push r31
.endm ; of pushall

.macro popall
pop r31
pop r30
pop r29
pop r28
pop r27
pop r26
pop r25
pop r24
pop r23
pop r22
pop r21
pop r20
pop r19
pop r18
pop r17
pop r16
.endm ; of popall

#--------------------------------------------------------------------
    .data

# binary representation of Morse code: 0: dot; 1: dash
morse_table: 
    .byte 0b01, 0b1000, 0b1010, 0b100, 0b0, 0b0010
# the number of binary digits in each character 
morse_width: 
    .byte 2, 4, 4, 3, 1, 4
# the English symbols encoded by the above Morse code 
ascii_table: 
    .byte 'A', 'B', 'C', 'D', 'E', 'F'
table_length:
    .byte 6

    .comm val, 1
    .comm width, 1
    .comm ascii, 1
    .global val, ascii, width

#---------------------------------------------------------------------

.text
    .global decode_morse
    .global start

WAIT: 
  push r22
  push r23
  push r24
  push r25
  push r16
  push r17
  push r19
  ldi r22, 0xa0 //this loads the value of 160 into register 22

  call delay //there is an issue with the delay function
  pop r16
  pop r17
  pop r19
  pop r25
  pop r24
  pop r23
  pop r22
  ret

LONG:
  push r17
  //turn on the light here
  ldi r17, 0x20
  out 0x04, r17
  out 0x05, r17
  call WAIT
  call WAIT
  //turn off the light here
  ldi r17, 0
  out 0x05, r17
  call WAIT
  pop r17
  ret

SHORT:
  //turn on light
  push r19
  ldi r19, 0x20
  out 0x04, r19
  out 0x05, r19
  //wait once
  call WAIT
  //turn off light
  ldi r19, 0
  out 0x05, r19
  //ret here
  pop r19
  ret

start:
  

decode_morse:
    pushall
    
    LDI R31, hi8(morse_table) ; initialize high byte of Z
    LDI R30, lo8(morse_table) ; initialize low byte of Z
    LDI R29, hi8(ascii_table) ; initialize high byte of Y
    LDI R28, lo8(ascii_table) ; initialize low byte of Y
    LDI R27, hi8(morse_width) ; initialize high byte of X
    LDI R26, lo8(morse_width) ; initialize low byte of X

    # ENTER YOUR CODE BELOW
    
    popall
    RET
