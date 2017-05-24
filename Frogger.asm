; multi-segment executable file template.

data segment
   Frog_location dw 52960 ;the middle of the first floor line:163,colum:160 
   key db ?
   holes db 64 dup(2h)
         db 20 dup(2h), 24 dup(1h), 20 dup(2h)
   water db 1h       
   floor db 5h                                                   
   frog_up_rest db 2 dup(0Ah)
                db 2 dup(0Ah),3h,0Ah,3h,2 dup(0Ah)
                db 5 dup(0Ah)
                db 2 dup(0Ah), 3 dup(0Eh), 2 dup(0Ah)
                db 0Eh,0Ah,0Eh
                db 2 dup(0Ah),0Eh,0Ah,0Eh,2 dup(0Ah)
                db 2 dup(0Ah), 3 dup(0Eh), 2 dup(0Ah)
                db 2 dup(0Ah)
                                                          
   frog_area db 117 dup(5h)
   invader db 2 dup(0h),4h, 5 dup(0h) ,4h,2 dup(0h)
           db 3 dup(0h),4h,3 dup(0h),4h,3 dup(0h)
           db 2 dup(0h), 7 dup(4h),2 dup(0h)
           db (0h),2 dup(4h), 0h, 3 dup(4h),0h, 2 dup(4h), 0h
           db 11 dup(4h)
           db 4h,0h,7 dup(4h),0h, 4h
           db 4h,0h,4h, 5 dup(0h), 4h,0h,4h
           db 3 dup(0h), 2 dup(4h), 0h, 2 dup(4h),3 dup(0h)    
   car dw 31680 , 2 ,0
   yosi dw 36000,2 ,0 
   screen_color db 0h     
        
    
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
;gets location on the screen trogh ax
;returns the y axies of the location at ax
;******************************************************************
proc GetY
push dx
push cx
xor dx,dx
mov cx,320
div cx 
pop cx
pop dx
ret
endp GetY
;-----------------------------------------------------------------


;******************************************************************
;gets a location in di to draw the hole
;drwas a hole in sizes 64*20 pixels
;******************************************************************
proc Draw_hole
pusha
mov ax, 0A000h
mov es,ax

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
;draws 13 lines of the floor
;******************************************************************
proc draw_Floor
    pusha
    mov ax, 0A000h
    mov es,ax
    
    mov cx, 4160 ; 13 lines = 13*320=4160 pixels
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
;draws 65*320 pixels of water
;******************************************************************
proc draw_water
    pusha
    mov ax, 0A000h
    mov es,ax
    
    mov cx,20800 ; 65 lines 65*320=20800
    watering:
    mov si, offset water
    movsb
    loop watering 
    popa
    ret
    endp draw_water 
;-----------------------------------------------------------------


;******************************************************************
;gets location to start drawing the frog trough variable frog_location
;draws the frog there
;******************************************************************
proc draw_frog_up_rest
    pusha
    mov ax, 0A000h
    mov es,ax
    
    mov di, frog_location
    mov si, offset frog_up_rest
    ;line:1
    movsb
    add di,5
    movsb
    ;line:2
    add di,312
    mov cx,2
    rep movsb
    inc di
    mov cx,3
    rep movsb
    inc di
    mov cx,2
    rep movsb
    ;line:3
    add di,312
    movsb
    inc di
    mov cx,3
    rep movsb
    inc di
    movsb
    ;line:4
    add di,313                                                        
    mov cx,7
    rep movsb
    ;lien:5
    add di,315
    mov cx,3
    rep movsb
    ;line:6
    add di,315
    mov cx,7
    rep movsb
    ;line:7
    add di,312
    mov cx,2
    rep movsb
    inc di
    mov cx,3
    rep movsb
    inc di
    mov cx,2
    rep movsb
    ;line:8
    add di,312
    movsb
    add di,5
    movsb
    
    popa
    ret
endp draw_frog_up_rest
;-----------------------------------------------------------------

;******************************************************************
;draws an invader 
;gets the location for drawing trogh di
;******************************************************************
proc draw_invader
    pusha
    mov ax, 0A000h
    mov es,ax
    mov si, offset invader 
    mov cx,8
    
    invadering:
    push cx
    mov cx,11
    rep movsb
    add di,309
    pop cx
    loop invadering
    
    
    
    
    popa
    ret
endp draw_invader

;-----------------------------------------------------------------

;******************************************************************
;gets nothing
;retutrns a key trough variable key
;******************************************************************

proc get_key
    pusha
    mov key,-1
    mov ah,1h
    int 16h
    jz skip
    xor ah,ah
    int 16h
    mov key,al
     skip:
    popa
    ret 
endp get_key

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
    xor di,di   ;line 0 
    mov cx,5
    holes_part:
    call Draw_hole
    add di,64     ;320/5=64
    loop holes_part
    
    ;drawing water    
    mov di,6400       ;20*320=6400
    call draw_water
    
    ;drawing floor
     mov di,27200  ;320*85=27200
     call draw_Floor
     mov di, 52160 ;163*320=52160
     call draw_floor
     call draw_frog_up_rest
     
     
     
    
    
    
    popa
    ret
    endp draw_screen
;----------------------------------------------------------------- 

;******************************************************************
;gets location to delete area of the frog trogh di
;delets the area
;remembers at frog_area variable the area
;******************************************************************
proc delete_area
    pusha
    mov cx,9
     delete_frog:
      push cx
      mov cx,9
      rep movsb
      add di,311
      pop cx
     loop delete_frog
      
    popa
    ret
endp delete_area
;-----------------------------------------------------------------

;******************************************************************
;remebermbers the area of the futre frog
;gets the start of the area trogh forg_location variable
;remembers at frog_area variable
;******************************************************************
proc remenber_area
pusha
 mov si,frog_location
     dec si
     mov di, offset frog_area
     mov ax,0a000h
     mov ds,ax
     mov ax,data
     mov es, ax
     
     mov cx,9
     remember_area:
      push cx
      mov cx,9
      rep movsb
      add si,311
      pop cx
     loop remember_area
      
     mov ax ,data
     mov ds ,ax
popa
ret
endp remenber_area
;-----------------------------------------------------------------

;******************************************************************
;gets a key trough "key" variable
;moves the frog according to the key
;updating frog_location variable
;******************************************************************
 proc move_frog
    pusha
    mov ax, 0A000h
    mov es,ax
    
    
    mov si,offset frog_area
    mov di, frog_location
      
    
    cmp key, 'w'
     jnz s
     sub frog_location ,4160 ;13*320
     jmp moving_proces
     
    s: cmp key, 's'
     jnz a
     add frog_location ,4160
     jmp moving_proces
     
    a:cmp key, 'a'
      jnz d
      sub frog_location ,16
      jmp moving_proces
       
    d:cmp key, 'd'
      jnz not_wasd
      add frog_location,16
      jmp moving_proces
       
    ;di previous frog location
    ;frog_location variable new frog location
    moving_proces:
    
     dec di
     call delete_area
     call remenber_area
     call draw_frog_up_rest 
    
      
    not_wasd:Nop
      
    popa
    ret
 endp move_frog
 
 ;-------------------------------------------------------------------------------------------------- 
 ;***************************************************************
proc clear_car
    pusha
    
     mov ax, 0A000h
    mov es,ax
    ;mov si, offset screen_color 
    mov cx,8
    
    clearing:
    mov si, offset screen_color
    push cx
    mov cx,11
    rep movsb
    add di,309
    pop cx
    loop clearing
    popa
    ret
endp clear_car
;-------------------------------------------------------------------------------------------------- 

 ;******************************************************************
 ;gets an offset of array trogh the stuck and moves the invader once in some seconds
 ;array[0] = location
 ;array[1] = waiting time in ticks
 ;array[2] = previous passed ticks since midnight
 ;moves the invader and updates the location
 ;******************************************************************
 proc move_car
    
    mov bp,sp
    pusha
    mov bx,[bp+2] ;bx=array[0]
    
    xor ax,ax
    int 1Ah ;dx= current ticks since midnight
    push dx
    
    mov ah, [bx+5]
    mov al, [bx+4]; ax = array[2] = previous ticks since midnight 
    sub dx, ax ;dx = diffrence between current and previous ticks since midnight
    cmp dx, [bx+2]
     jnc time_passed
     jc time_notPassed
    
   time_passed:
    pop [bx+4]
    mov di, [bx]
    call clear_car
    
    mov ah,[bx+1]
    mov al,[bx]
    push ax
    push ax
    call GetY
    mov dx,ax ;dx = previos y axies 
    pop ax
    add ax,5
    call GetY ; ax= new y axies
    cmp ax,dx
    pop ax
     jz Y_Not_Changed
     jnz Y_Changed
    
    Y_Not_Changed:
     add ax,5
     mov [bx],ax
     mov di, [bx]
     call draw_invader
     jmp done
     
    Y_Changed:
     mov ax,dx
     mov cx,320
     mul cx
     mov [bx],ax
     mov di, [bx]
     call draw_invader
     jmp done
    
   time_notPassed:nop
    pop dx
    jmp done
    
    
    
   done: 
    popa
    ret 2 
    endp move_car
 
 
 ;--------------------------------------------------------------------------------------------------
  
 



start:
; set segment registers:
    mov ax, data
    mov ds, ax

    ; add your code here
    mov ax, 0A000h
    mov es,ax
    
    
    call Init_Graphics
    call draw_screen
    
    testing:
     push offset car
     call move_car
     push offset yosi
     call move_car
     call get_key
     call move_frog
    jmp testing
    
    
    mov ax, 4C00h
    int 21h 
    
    
      
    

    
    
   
   
    
    
    
   
ends

end start ; set entry point and stop the assembler.
