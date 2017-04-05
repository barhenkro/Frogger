; multi-segment executable file template.

data segment
   holes db 64 dup(2h)
         db 20 dup(2h), 24 dup(1h), 20 dup(2h)
   water db 1h       
   floor db 5h
ends

stack segment
    dw   128  dup(0)
ends

code segment 


;******************************************************************
;initaiting graphic video mode
;******************************************************************    
proc Init_Graphics
    push ax
    mov ax,13h
    int 10h
    pop ax
    ret
endp Init_Graphic
;-----------------------------------------------------------------


;******************************************************************
;gets a location in di to draw the hole
;drwas a hole in sizes 64*20 pixels
;******************************************************************
proc Draw_hole
pusha
mov si, offset holes

mov cx,4
Four_lines:
push cx
mov cx, 64
rep movsb
add di, 256 ;moving one line down 320-64=256
sub si, 64
pop cx
loop Four_lines 

add si, 64
mov cx,16
Sixteen_Lines:
push cx
mov cx,64
rep movsb
add di, 256
sub si,64
pop cx
loop Sixteen_Lines
popa
ret
endp Draw_hole
;-----------------------------------------------------------------
              

;******************************************************************
;gets location trogh di to start drawing the floor
;draws 10 lines of the floor
;******************************************************************
proc draw_Floor
    pusha
    mov cx, 4800 ; 15 lines = 15*320=4800 pixels
    floor_lines:
    mov si, offset floor
    movsb
    loop floor_Lines
    popa
    ret
    endp draw_Floor
;-----------------------------------------------------------------

;******************************************************************
;gets location in di to draw the water part 
;draws 50*320 pixels of water
;******************************************************************
proc draw_water
    pusha
    popa
    mov cx,16000 ; 50 lines 50*320=16000
    watering:
    mov si, offset water
    movsb
    loop watering 
    ret
    endp draw_water 
;-----------------------------------------------------------------

;******************************************************************
;gets void
;draws the non moving elements to the screen
;built in prociders: draw_hole,draw_water,draw_floor
;******************************************************************
proc draw_screen
    pusha
    mov ax, 0A000h
    mov es,ax
    
    ;drawing holes
    mov di,9600   ;line 20 on the scrren 30*320=9600
    mov cx,5
    holes_part:
    call Draw_hole
    add di,64     ;320/5=64
    loop holes_part
    
    ;drawing water    
    mov di,16000       ;50*320=16000
    call draw_water
    
    ;drawing floor
     mov di,32000  ;320*100=32000
     call draw_Floor
     mov di, 54400 ;170*320=17000
     call draw_floor
    
    
    
    popa
    ret
    endp draw_screen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



start:
; set segment registers:
    mov ax, data
    mov ds, ax

    ; add your code here
   ; mov ax, 0A000h
;    mov es,ax
    
    
    call Init_Graphics
    ;xor di,di
;    call draw_Floor
    call draw_screen
    
    mov ax, 4C00h
    int 21h 
    
    
      
    

    
    
   
   
    
    
    
   
ends

end start ; set entry point and stop the assembler.
