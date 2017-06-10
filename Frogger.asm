; multi-segment executable file template.

data segment
   Frog_location dw 52960 ;the middle of the first floor line:165,colum:160 
   lives db 3
   score dw 0
   timer dw 58660,0
   Lives_Str db "Lives:$"
   score_str db "Score:$"
   GameOver_msg db "Game Over$"
   PlayAgain_msg db "Play Again - press a$"
   Quit_msg db "Quit - press any othre key$"
   Win_msg db "You Won$"
   num_str db 6 dup (?)
   key db ?
   holes db 5 dup(0)
   lines db 11 dup(0)
   hole db 64 dup(2h)
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
           
   car db 2 dup(0h),3 dup(0Eh),5 dup(0h),2 dup(0Eh), 3 dup(0h)
       db 0h, 5 dup(4h), 2 dup(0h) , 5 dup(4h),1h, 0h
       db 1h, 5 dup(4h),1h,4h, 2 dup(1h),4 dup(4h),1h
       db 0h,4h,3 dup(1h), 4 dup(4h),2 dup(1h), 2 dup(4h),0Eh,1h
       db 0h,4h,3 dup(1h), 4 dup(4h),2 dup(1h), 3 dup(4h),1h
          
       db 0h,4h,3 dup(1h), 4 dup(4h),2 dup(1h), 3 dup(4h),1h
       db 0h,4h,3 dup(1h), 4 dup(4h),2 dup(1h), 2 dup(4h),0Eh,1h
       db 1h, 5 dup(4h),1h,4h, 2 dup(1h),4 dup(4h),1h
       db 0h, 5 dup(4h), 2 dup(0h) , 5 dup(4h),1h, 0h
       db 2 dup(0h),3 dup(0Eh),5 dup(0h),2 dup(0Eh), 3 dup(0h)
   
   
   log db 1h, 23 dup(0h), 1h
       db 1h,0h,8h,0h, 20 dup(6h),0h
       db 0h,3 dup(8h),0h,19 dup(6h), 0h
       db 2 dup(0h),8h,0h, 20 dup(6h),0h
       db 0h, 2 dup(8h),0h,20 dup(6h),0h
       db 2 dup(0h),8h,0h, 20 dup(6h),0h
       db 0h, 2 dup(8h),0h,20 dup(6h),0h
       db 2 dup(0h),2 dup(8h),0h,19 dup(6h),0h
       db 0h,2 dup(8h),0h, 20 dup(6h),0h
       db 1h,23 dup(0h),1h
               
   Car1A dw 31680 ,1 ,0 ,2
   Car1B dw 31780 ,1 ,0 ,2
   Car1C dw 31880 ,1 ,0 ,2
   
   Car2A dw 36000 ,2 ,0 ,-4
   Car2B dw 36075 ,2 ,0 ,-4
   Car2C dw 35925 ,2 ,0 ,-4
   Car2D dw 36150 ,2 ,0 ,-4
   
   Car3A dw 40065 ,2 ,0 ,3
   Car3B dw 40115 ,2 ,0 ,3
   Car3C dw 40165 ,2 ,0 ,3
   Car3D dw 40215 ,2 ,0 ,3  
   
   Car4A dw 44360 ,2 ,0 ,-4
   Car4B dw 44285 ,2 ,0 ,-4
   Car4C dw 44210 ,2 ,0 ,-4
   Car4D dw 44135 ,2 ,0 ,-4
   
   Car5A dw 48440 ,2 ,0 ,5
   Car5B dw 48520 ,2 ,0 ,5
   Car5C dw 48600 ,2 ,0 ,5
   
   Log5A dw 23650,2,0,3
   
   
   screen_color db 0h
   timer_color db 0Ah     
        
    
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
;----------------------------------------------------------------
;******************************************************************
;gets location on the screen trogh ax
;returns the x axies of the location at dx
;******************************************************************
proc GetX
push ax
push cx
xor dx,dx
mov cx,320
div cx 
pop cx 
pop ax
ret
endp GetX
;------------------------------------------------------------------


;******************************************************************
;gets a location in di to draw the hole
;drwas a hole in sizes 64*20 pixels
;******************************************************************
proc Draw_hole
pusha
mov ax, 0A000h
mov es,ax

mov si, offset hole

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
proc draw_frog
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
endp draw_frog
;-----------------------------------------------------------------

;******************************************************************
;draws a car 
;gets the location for drawing trogh di
;******************************************************************
proc draw_car
    pusha
    mov ax, 0A000h
    mov es,ax
    mov si, offset car 
    mov cx,10
    
    caring:
    push cx
    mov cx,15
    rep movsb
    add di,305
    pop cx
    loop caring
    
    
    
    
    popa
    ret
endp draw_car

;-----------------------------------------------------------------
;******************************************************************
;gets nothing
;waiting for key press
;returns retutrns a key trough variable key 
;******************************************************************
proc wait4key
    pusha
    xor ah,ah
    int 16h
    mov key,al
    popa
    ret
endp wait4key
;-----------------------------------------------------------------
;******************************************************************
;gets nothing
;not waiting for key press
;retutrns a key trough variable key
;******************************************************************

proc get_key
    pusha
    mov key,-1
    mov ah,1h
    int 16h
    jz skip
     call wait4key
   ; xor ah,ah
;    int 16h
;    mov key,al
     skip:
    popa
    ret 
endp get_key

;-----------------------------------------------------------------

;******************************************************************
;gets  string at ds:[si] (end in $)
;returns his length at cx
;******************************************************************
proc Get_Length
    push si
    xor cx,cx 
    counting_length:
    cmp ds:[si] , '$'
    jz end_Get_Length
    inc cx
    inc si
    jmp counting_length
    end_Get_Length:
    pop si
    ret 
    endp Get_Length
;------------------------------------------------------------------

;******************************************************************
;gets string at ds:[si]
;x at dl ,y at dh, color at bl 
;prints the string
;******************************************************************
proc Print_Str
    pusha
    push bx
    xor bh,bh
    mov ah, 2
    int 10h  ;set cursor

    pop bx
    call Get_length
    Printing:
    mov al, [si] 
    mov ah, 0eh  
    int 10h
    inc si
    loop Printing
    
    popa
    ret
endp Print_Str
;------------------------------------------------------------------

;******************************************************************
;prints the lives on the screen
;******************************************************************
proc Print_lives
    pusha
    mov dh, 23
    mov dl, 32
    ;mov bh, 0
;    mov ah, 2
;    int 10h  
    mov bl, 4
    lea si, Lives_Str
    call Print_Str
    mov al, lives
    add al, '0'
   ; mov bl, 4 
    mov ah, 0eh  
    int 10h
    
    
     
    
    popa
    ret
endp Print_Lives
;------------------------------------------------------------------  
;******************************************************************
;prints the points on the screen
;******************************************************************
proc Print_score
    pusha
    mov dh, 23
    mov dl, 1
    ;mov bh, 0
;    mov ah, 2
;    int 10h  
    mov bl, 0Eh
    lea si, score_str
    call Print_Str
    mov ax, score
    call num2str
    lea si,num_str
    mov dl, 7
    call print_str
    
    
     
    
    popa
    ret
endp Print_score
;------------------------------------------------------------------
;******************************************************************
;gets number in ax 
;puts ascii representation  in num_str 
;******************************************************************
proc num2str
    pusha
    lea si, num_str
    mov di,si
    convert:
        mov cl,10
        div cl
        add ah, '0' 
        mov [si],ah
        inc si 
        xor ah, ah 
        cmp al, 0
    jnz convert
    mov [si],'$' 
    
    dec si
    reverse:
    cmp di,si
    ja end_num2str
        mov ah,[si]
        mov al,[di]
        mov [si],al
        mov [di],ah
        inc di
        dec si
        jmp reverse
    end_num2str:
    popa
    ret
endp num2str 
;------------------------------------------------------------------




;******************************************************************
;gets void
;draws the non moving elements to the screen
;built in prociders: draw_hole,draw_water,draw_floor
;******************************************************************
proc draw_screen
    pusha
    mov ax, 0A000h
    mov es,ax
    ;restarting variables
    mov lives,3
    call Print_lives
    mov score,0
    call Print_score 
    call restart_timer
    call restart_holes
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
     call draw_frog
    
     
     
     
    
    
    
    popa
    ret
    endp draw_screen
;----------------------------------------------------------------- 

;******************************************************************
;gets location to delete area of the frog trogh di
;delets the area
;******************************************************************
proc delete_area
    pusha
     mov ax, 0A000h
     mov es,ax
     mov si, offset frog_area 
    dec di
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
proc remember_area
pusha
 mov si,frog_location
     dec si
     mov di, offset frog_area
     mov ax,0a000h
     mov ds,ax
     mov ax,data
     mov es, ax
     
     mov cx,9
     remembering_area:
      push cx
      mov cx,9
      rep movsb
      add si,311
      pop cx
     loop remembering_area
      
     mov ax ,data
     mov ds ,ax
popa
ret
endp remember_area
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
    mov ax,di
    call GetX ;dx = x axies 
    call GetY ;ax = y axies
      
    
    cmp key, 'w'
     jnz s
     sub frog_location ,4160 ;13*320
     jmp moving_proces
     
    s: cmp key, 's'
     jnz a
     cmp ax ,165
     jz not_wasd
     add frog_location ,4160
     jmp moving_proces
     
    a:cmp key, 'a'
      jnz d 
      sub dx,15
      cmp dx,1
      jz not_wasd
      js not_wasd
      sub frog_location ,15
      jmp moving_proces
       
    d:cmp key, 'd'
      jnz not_wasd
      add dx,15
      cmp dx,311
      jz not_wasd
      ja not_wasd
      add frog_location,15
      jmp moving_proces
       
    ;di previous frog location
    ;frog_location variable new frog location
    moving_proces:
    
     
     call delete_area
     call remember_area
     call draw_frog 
    
      
    not_wasd:Nop
      
    popa
    ret
 endp move_frog
 
 ;-------------------------------------------------------------------------------------------------- 
;***************************************************************
;gets a start location trogh di
;filling a blank (black) in the sizes of the invader
;***************************************************************
proc clear_car
   pusha
    mov ax,0A000h
    mov es,ax
    mov cx,10
    width_clearing:
    push cx
        mov cx,15
        Length_clearing:
        lea si,screen_color
        movsb
        loop Length_clearing
    add di,305    
    pop cx    
    loop width_clearing
    popa
    ret
endp clear_car
;-------------------------------------------------------------------------------------------------- 
;**********************************************************************************************************************
;first gets wanted number of ticks to check
;second  the location of the previous ticks since midnight
;updates previous ticks
;use ja if time had passed
;use jb if time hadn't  passed
;**********************************************************************************************************************
proc check_ticks
    mov bp,sp
    pusha
    mov bx,[bp+2]
    ;[bx] = previous ticks since midnight
    ;[bp+4] = amount of ticks
    xor ah, ah
    int 1Ah
    ;dx= current ticks since midnight
    mov ax,dx
    sub ax,[bx] 
    ;ax = diffrence between ticks
    cmp ax, [bp+4] ;if ax>[bp+4] => time had passed
    jb not_passed
    mov [bx],dx
    not_passed:
    popa 
    ret 4
    endp check_ticks
;----------------------------------------------------------------------------------------------------------------------
;******************************************************************
;gets parametes trogh the stack
;first gets offset of the location on the screen
;second gets pixels to check when adding 
;updates the location
;if Y is changed restarting it to the start of the lline
;if Y not changed adding pixels to the location 
;******************************************************************
  proc CheckY
    mov bp,sp
    pusha 
    xor dx,dx
    mov bx,[bp+4]
    ;[bx] = the location on the screen
    ;[bp+2] = pixels per unit
     mov ax, [bx]
     call GetY
     mov cx,ax
     ;cx= y axies of the old location
     mov ax,[bx]
     add ax,[bp+2]
     call GetY
     mov dx,ax
     ;dx = y axies of the new location
     cmp cx,dx
     jz Y_!changed
        mov dx,1
        cmp [bp+2],0
        jns Right
        js Left
            Right:
            sub [bx],320
            jmp Y_!changed
            left:
            add [bx],320
            jmp Y_!changed 
            
            
        Y_!changed:
        mov ax,[bp+2]
        add [bx], ax
        
    cmp dx,1
    popa
    ret 4
  endp CheckY 
;----------------------------------------------------------------------------------------------------------------------
  

;******************************************************************
 ;gets an offset of array trogh the stuck and moves the invader once in some seconds
 ;array[0] = location
 ;array[1] = waiting time in ticks
 ;array[2] = previous passed ticks since midnight 
 ;array[3] =pixels per unit of time
 ;moves the invader and updates the location
 ;******************************************************************
 proc move_car
    
    mov bp,sp
    pusha
    mov bx,[bp+2]
    ;[bx] = array[0]
    push [bx+2]
    mov ax,bx
    add ax,4
    push ax
    call check_ticks
    jb done_driving
        mov di,[bx]
        call clear_car 
        push bx
        push [bx+6]
        call CheckY
        mov di,[bx]
        call draw_car
    done_driving:
    popa
    ret 2 
    endp move_car
 
 
;--------------------------------------------------------------------------------------------------
 
;******************************************************************
;kills the frog by moving it to the start
;******************************************************************
proc KillFrog
    pusha
    ;points
    dec lives
    call Print_lives
    call restart_lines
    call restart_timer
    ;drawings
    mov di,Frog_location
    call delete_area
    mov Frog_location, 52960
    call remember_area
    call draw_frog
    popa
    ret
    endp KillFrog
  
;-------------------------------------------------------------------------------------------------- 

;******************************************************************
;the procider checks if the the frog was ran over by a car
;if it does, kill the frog
;******************************************************************
proc IsCrashing
    pusha
    mov ax, 0a000h
    mov es,ax
    mov bx, Frog_location
    
    cmp es:[bx] , 0Ah
     jnz Crashed
    cmp es:[bx+6] , 0Ah
     jnz Crashed
    cmp es:[bx+319] , 0Ah
     jnz Crashed
    cmp es:[bx+327] , 0Ah
     jnz Crashed
    cmp es:[bx+1919] , 0Ah
     jnz Crashed
    cmp es:[bx+1927] , 0Ah
     jnz Crashed
    cmp es:[bx+2240] , 0Ah
     jnz Crashed
    cmp es:[bx+2246] , 0Ah
     jnz Crashed
     jmp Didnt_Crashed
     
    
    
    Crashed:
     push Frog_location
     call KillFrog
     pop di
     dec di
     call clear_car
     
     
     
    Didnt_Crashed: 
     popa
     ret
endp IsCrashing
;--------------------------------------------------------------------------------------------------
;******************************************************************
;the procider checks if the the frog  has drown at the water
;if it does, kill the frog
;******************************************************************

proc IsDrowning
    pusha
    
    mov ax, 0a000h
    mov es,ax
    mov bx, Frog_location
    mov ah, water 
    
    cmp bx,6400 ; if the frog on the holes part
     jb Didnt_Drown 
    cmp es:[bx-1] , ah; if the frog on the water 
    jnz Didnt_Drown
    cmp es:[bx+2247] , ah 
     jnz Didnt_Drown
      call KillFrog
    
    Didnt_Drown:
    popa
    ret
endp IsDrowning 
;--------------------------------------------------------------------------------------------------    
;******************************************************************
;draws a log 
;gets the location for drawing trogh di
;******************************************************************
proc draw_log
    pusha
    mov ax, 0A000h
    mov es,ax
    mov si, offset log 
    mov cx,10
    
    loging:
    push cx
    mov cx,25
    rep movsb
    add di,295
    pop cx
    loop loging
    
    
    
    
    popa
    ret
endp draw_log

;-----------------------------------------------------------------
;***************************************************************
;gets a start location trogh di
;filling water at the sizes of the log
;***************************************************************
proc clear_log
    pusha
    
    mov ax, 0A000h
    mov es,ax
    mov cx,10
    clearing_log:
    push cx
    mov cx,25
        log_line:
        lea si,  water
        movsb
        loop log_line
    add di,295
    pop cx
    loop clearing_log
    
    popa
    ret
endp clear_log
;-------------------------------------------------------------------------------------------------- 
;***************************************************************
;check if the frog ontop of the log 
;gets the location on the screen troght di
;if it does, moves the frog with the log
;return 1 in ZF if the frog on top
;else returns 0
;***************************************************************
proc is_ontop
    pusha 
    lea si,log
    mov ax,0a000h
    mov es,ax
    mov cx,10
    compare_line:
    push cx
        mov cx,25
        compare_pixels:
        cmpsb
        jnz ontop
        loop compare_pixels
        add di,295
    pop cx
    loop compare_line
    mov ax,1
    jmp end_is_ontop   
ontop:
pop cx
mov ax,0


end_is_ontop:
cmp ax,0
popa
ret            
endp is_ontop 
;--------------------------------------------------------------------------------------------------
 ;******************************************************************
 ;gets an offset of array trogh the stuck and moves the invader once in some seconds
 ;array[0] = location
 ;array[1] = waiting time in ticks
 ;array[2] = previous passed ticks since midnight 
 ;array[3] =pixels per unit of time
 ;moves the invader and updates the location
 ;******************************************************************
 proc move_log
    
    mov bp,sp
    pusha
    mov bx,[bp+2]
    ;[bx] = array[0] 
    
    mov ax,[bx+4]
    cmp ax,0
    jnz !first_swim
    ;runs at first time
    ;update previos passed ticks
    push [bx+2]
    mov ax,bx
    add ax,4
    push ax
    call check_ticks
    ;check if  will go down
    push bx
    push [bx+6]
    call CheckY
    mov di,[bx]
    call draw_log 
    jmp done_swiming
     
    !first_swim: 
    push [bx+2]
    mov ax,bx
    add ax,4
    push ax
    call check_ticks
    jb done_swiming
        mov di, [bx]
        call is_ontop
         jz frog_detected
        mov di,[bx]
        call clear_log 
        push bx
        push [bx+6]
        call CheckY
        mov di,[bx]
        call draw_log 
        jmp  done_swiming
        
        
        frog_detected: 
        mov di,Frog_location ;delete frog
        call delete_area
        mov di,[bx]
        call clear_log ;delete log
        push bx        ;draw log
        push [bx+6]
        call CheckY
        mov di,[bx]
        call draw_log
        lea ax, Frog_location
        push ax
        push [bx+6]
        call CheckY
        mov ax,Frog_location
        call GetX
        mov ax,dx 
        add dx,[bx+6]
        cmp dx,311
        jz frog_!inLine
        ja frog_!inLine
        add ax,[bx+6]
        cmp ax,1
        jz frog_!inLine
        js frog_!inLine
        call remember_area
        call draw_frog
        jmp done_swiming
         frog_!inLine:
         call KillFrog
    done_swiming:
    popa
    ret 2 
    endp move_log
 
 
;--------------------------------------------------------------------------------------------------   

;******************************************************************
;checks if there is a frog in one of the holes
;if does puts 1 in his place at holes array
;******************************************************************
proc Check_Holes
    pusha
    
    mov ax, 0a000h
    mov es,ax
    mov bx, Frog_location
    mov ah, water
      
    cmp bx,6400
    ja end_check_holes
    cmp es:[bx-1] , ah; if the frog on the water 
    jnz place_taken
    cmp es:[bx+2247] , ah 
    jnz place_taken
    
    mov ax, bx
    call GetX ; dx= x
    shr dx,6 ; deviding dx by 64 give the hole number
    mov bx,dx
    cmp holes[bx],1
    jz place_taken
    jnz place_!taken
    
        place_taken:
        call KillFrog 
        jmp end_check_holes
        
        place_!taken:
        call restart_timer
        call restart_lines
        add score,100
        call print_score
        mov holes[bx] , 1
        mov Frog_location, 52960
        call remember_area
        call draw_frog 
        jmp end_check_holes
     
     
     
    
    end_check_holes:
    popa
    ret
    endp Check_Holes


;--------------------------------------------------------------------------------------------------

;******************************************************************
;adding pointes to score when getting first time to a line
;******************************************************************
proc line_score
    pusha
    mov ax,Frog_location
    cmp ax,6400
    jb end_line_score
    cmp ax,52160
    ja end_line_score
        call GetY ;ax=y
        sub ax,20 ;the width of the holes 
        mov cl,13 ; every 13 pixels on y are a line 
        div cl ;ax =line number
        mov bl,al
        xor bh,bh
        cmp lines[bx],1
        jz end_line_score
        mov lines[bx],1
        add score,10
        call Print_score
    end_line_score:
    popa
    ret
endp line_score 
;--------------------------------------------------------------------------------------------------
;******************************************************************
;restart lines array by setting every cell to 0
;******************************************************************
proc restart_lines
    pusha
    mov cx ,11
    lea bx,lines
    restarting_lines:
    mov [bx],0
    inc bx
    loop restarting_lines
    popa
    ret
endp restart_lines    
;--------------------------------------------------------------------------------------------------

;******************************************************************
;draws progress bar which represents the timer
;******************************************************************
proc restart_timer
    pusha
    mov ax,0A000h
    mov es,ax 
    mov timer,58660
    mov di,58660
    mov cx,10
    width_timer:
    push cx
        mov cx,120
        Length_timer:
        lea si,timer_color
        movsb
        loop Length_timer
    add di,200    
    pop cx    
    loop width_timer
    popa
    ret
    endp restart_timer
;--------------------------------------------------------------------------------------------------  
;******************************************************************
;updates the timer by deleting every 0.5 sec colum from the timer
;timer set at first for 60 sec
;******************************************************************
proc update_timer
    pusha ;timer[0] =pointer of colum at the timer, timer[1] = last time ticks were updated
    mov ax,0A000h
    mov es,ax
    
    mov dl,screen_color
    mov di, timer
    push 9
    lea bx ,timer
    add bx,2
    push bx
     call check_ticks
     jb end_update_timer
     cmp es:[di], dl
     jz end_timer
        mov cx,10
        clear_colum:
            lea si,screen_color
            movsb
            add di,319
        loop clear_colum
        inc timer
        jmp end_update_timer
     end_timer:
     call killFrog   
        
    end_update_timer:
    popa
    ret
    endp update_timer  
;--------------------------------------------------------------------------------------------------

;******************************************************************
; Check if there are frogs at all 5 holes
;returns 1 in ZF if palyer won, else returns 0
;******************************************************************
proc Check_win   
    pusha
    mov ax,0
    lea si, holes
    mov cx,5
    scaning_holes:
    cmp [si],1
    jnz !all
    inc si
    loop scaning_holes 
    mov ax,1
    !all:
    cmp ax,1
    popa
    ret
endp Check_win
;--------------------------------------------------------------------------------------------------

;******************************************************************
;setting all holes at holes array to 0
;******************************************************************
proc restart_holes
    pusha
    mov cx,5
    lea si, holes
    restarting_holes:
        mov [si],0
        inc si
    loop restarting_holes
    popa
    ret
    endp restart_holes
;--------------------------------------------------------------------------------------------------

;******************************************************************
;show the game over screen
;******************************************************************
proc GameOver_screen
    pusha
    call Init_Graphics ;clearing the screen
    mov bl, 0Fh
    xor dl,dl
    xor dh,dh
    lea si ,PlayAgain_msg
    call Print_str
    lea si,Quit_msg
    inc dh
    call Print_str
    lea si, GameOver_msg
    mov dl,16
    mov dh,12
    call Print_str
    popa
    ret
endp GameOver_screen 
;--------------------------------------------------------------------------------------------------
;******************************************************************
;show the game over screen
;******************************************************************
proc win_screen
    pusha
    call Init_Graphics  
    mov dl,17
    mov dh,10
    mov bl,0Eh
    lea si, win_msg
    call Print_str
    
    dec dl
    add dh,2
    mov bl, 0Eh
    lea si, score_str
    call Print_Str
    mov ax, score
    call num2str
    lea si,num_str
    add dl,6
    call print_str
    
    mov bl, 0Fh
    xor dl,dl
    xor dh,dh
    lea si ,PlayAgain_msg
    call Print_str
    lea si,Quit_msg
    inc dh
    call Print_str

    
    
    popa
    ret
endp win_screen
;--------------------------------------------------------------------------------------------------

start:
; set segment registers:
    mov ax, data
    mov ds, ax

    ; add your code here
    mov ax, 0A000h
    mov es,ax
    
   prep_Game: 
    call Init_Graphics
    call draw_screen
    
   The_Game:
     call get_key
     call move_frog
     lea bx,Log5A
     push bx
     call move_log
     
     ;cars part
     mov cx,18
     mov ax, offset Car1A
     move_all_cars:
        push ax
        call move_car
        add ax,8
     loop move_all_cars  
     call IsCrashing
     ;call IsDrowning
     call Check_Holes
     call line_score
     call update_timer 
     call Check_win 
     jz win_game 
   cmp lives,0
   jnz The_Game
   jmp end_game
   
   win_game:
   call win_screen
   call wait4key
   cmp key,'a'
    jz prep_Game 
        jmp 0ffffh:0000  ;quit the game
   
   end_game:
   call GameOver_screen
   call wait4key 
    cmp key,'a'
    jz prep_Game 
        jmp 0ffffh:0000  ;quit the game
    
    
    
      
    

    
    
   
   
    
    
    
   
ends

end start ; set entry point and stop the assembler.
