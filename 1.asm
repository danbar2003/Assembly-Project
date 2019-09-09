;																			;
;       			                       `-.`'.-'                         ;
;                                       `-.        .-'.                     ;
;                                    `-.    -./\.-    .-'                   ;
;                                        -.  /_|\  .-                       ;
;                                    `-.   `/____\'   .-'.                  ;
;                                 `-.    -./.-""-.\.-      '                ;
;                                    `-.  /< (()) >\  .-'                   ;
;                                  -   .`/__`-..-'__\'   .-                 ;
;                                ,...`-./___|____|___\.-'.,.                ;                                   ,-'   ,` . . ',   `-,                   ;
;                                ,-'   ________________  `-,                ;
;                                   ,'/____|_____|_____\                    ;
;                                  / /__|_____|_____|___\                   ;
;                                 / /|_____|_____|_____|_\                  ;
;                                ' /____|_____|_____|_____\                 ;
;                              .' /__|_____|_____|_____|___\                ;
;                             ,' /|_____|_____|_____|_____|_\               ;
;,,---''--...___...--'''--.. /../____|_____|_____|_____|_____\ ..--```--..._;
;                           '../__|_____|_____|_____|_____|___\             ;
;      \    )              '.:/|_____|_____|_____|_____|_____|_\            ;
;      )\  / )           ,':./____|_____|_____|_____|_____|_____\           ;
;     / / ( (           /:../__|_____|_____|_____|_____|_____|___\          ;
;    | |   \ \         /.../|_____|_____|_____|_____|_____|_____|_\         ;
; .-.\ \    \ \       '..:/____|_____|_____|_____|_____|_____|_____\        ;
;(=  )\ `._.' |       \:./ _  _ ___  ____ ____ _    _ _ _ _ _  _ ___\       ;
; \ (_)       )       \./  											 \      ;
;  \    `----'         """"""""""""""""""""""""""""""""""""""""""""""""     ;
;   \   ____\__         												    ;
;    \ (=\     \        													;
;     \_)_\     \     												     /  ;
;          \     \                                                        / ;
;           )     )  _                                                _  (  ;
;          (     (,-' `-..__                                    __..-' `-,) ;
;           \_.-''          ``-..____                  ____..-''          ``;
;            `-._                    ``--...____...--''                    _;
;                `-.._                                                _..-' ;
;                     `-..__         	shmulik knows all      __..-'       ;
;                           ``-..____                  ____..-''            ;
;                                    ``--...____...--''                     ;
;                             
;---------------------------------
arrow2_clicked macro
	add [color_change], 3 
		;1.offset standing 2.offset moving_right 3.offset jumping 4.part_color 5.chance_color
				push offset standing
				push offset moving_right
				push offset jumping
				mov al, [backround_color_pixel]
				mov ah, 0 
				push ax
				mov al, [color_change]
				mov ah,	0 
				push ax 
				call change_all_sprites
				mov al,[color_change]
				mov [backround_color_pixel], al 
				mov ah, 0 
				push 80 * 320 + 50  
				push 30 
				push 30 
				push ax 
				call filler 
				print_big_image
				
endm 
;---------------------------------
arrow1_clicked macro
;1.offset standing 2.offset moving_right 3.offset jumping 4.part_color 5.chance_color
			sub [color_change], 3 
			push offset standing
			push offset moving_right
			push offset jumping
			mov al, [backround_color_pixel]
			mov ah, 0 
			push ax
			mov al, [color_change]
			mov ah,0 
			push ax 
			call change_all_sprites
			mov al,[color_change]
			mov [backround_color_pixel], al 
			mov ah, 0 
			push 80 * 320 + 50  
			push 30 
			push 30 
			push ax 
			call filler 
			print_big_image
			jmp not_pressing_on_arrows
endm
;---------------------------------
print_default_stair macro 
	push offset default_stair
	push 194 * 320 
	push 320 
	push 4 
	call save_to_data

	push 194 * 320 
	push 320 
	push 4 
	push 13 
	call filler 
endm 	
;---------------------------------
print_default_stair_backround macro  
	push offset ob1 
	push offset ob2 
	push offset ob3 
	push [ob1_location]
	push [ob2_location]
	push [ob3_location]
	call delete_all_obstacles
	
	push offset default_stair
	push 194*320 
	push 320 
	push 4 
	call print_image
	
	;1.offset ob1 2.offset ob2 3.offset ob3 4.ob1_location 5.ob2_location 6.ob3_location 
;7.ob1_length 8.ob2_length 9.ob3_length
	push offset ob1 
	push offset ob2 
	push offset ob3 
	push [ob1_location]
	push [ob2_location]
	push [ob3_location]
	push [ob1_length]
	push [ob2_length]
	push [ob3_length]
	call print_all_obstacles
endm  
;---------------------------------
check_if_alive macro
	cmp [char_pos], 144 * 320 
	jna alive1
	cmp [did_jump], 0 
	je alive1
	jmp menu_prep
	alive1:
endm 
;---------------------------------
print_big_image macro 
		push offset standing
		push 150  
		push 4  
		push 35 
		push 50 
		call big_image
endm
;----------------------------------
graphic_screen macro	
	mov ax, 13h 
	int 10h 
endm 	
;----------------------------------
text_screen macro
	mov ax, 3  
	int 10h 
endm 
;----------------------------------
mouse_information macro	
	push ax 
	mov ax, 3 
	int 33h 
	pop ax 
endm
;----------------------------------
hide_mouse macro
	mov ax, 2 
	int 33h
endm
;---------------------------------- 
display_mouse macro
	mov ax, 0 
	int 33h 
	mov ax, 1 
	int 33h 	
endm
;-----------------------------------
wait_for_mouse_click macro
	push bx 
	wait_for_click:
		mouse_information
		cmp bx, 1 
		jne wait_for_click
	pop bx 
endm 
;-----------------------------------
check_if_space macro 
	cmp si, 2 
	jne not_jumping
	cmp [jump_number], 0 
	je not_jumping
	jmp something_pressed
	not_jumping:
endm 
;-----------------------------------
print_default_char macro 
	mov [char_pos], 320 * 143 + 140  
	
	push offset standing
	push [char_pos]
	push 35 
	push 50 
	push offset next_char_pos
	call save_and_print
endm 
;------------------------------------
ideal
model small
stack 100h
dataseg

header db 54 dup (0)
palette db 256*4 dup (0)
scrline db 320 dup (0)
filename1 db 'game.bmp',0 ;menu backround
filename2 db 'iii.bmp',0 ;game backround
filename3 db 'tuto.bmp',0;tutorial backround
filename4 db 'root.bmp',0; 
filehandle dw ?
is_moving dw 0 
when_to_move db 0 
jump_number dw 0
user_last_key_used dw ?  
boolean_parameter dw ?
char_pos dw 320 * 155 + 140  
mouse_loc dw ? 
next_char_pos db 35*50 dup (0)
change_color_pixel_location dw ? 
backround_color_pixel db ? 
color_change db ?
did_jump db ?
already_print_stair db ? 
ob1_location dw ?
ob1_length dw ?
ob1 db 4*120 dup (0)

ob2_location dw ?
ob2_length dw ?
ob2 db 4*120 dup (0)

ob3_location dw ?
ob3_length dw ? 
ob3 db 4*120 dup (0)

default_stair db 4 * 320 dup (0)

include "default.asm"
minibuf db 7 dup (0)
codeseg

esc_key db 0 
proc openfile
; open file
	push bp
	mov bp, sp
	push ax
	push dx
	
	mov ah, 3dh
	xor al, al
	mov dx, [bp+4]	;offset filename
	int 21h
	mov [bp+6], ax 	;[filehandle]
	
	pop dx
	pop ax
	pop bp
	ret 2
endp openfile
;//////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////
proc readheader
; read bmp file header, 54 bytes
	
	mov ah, 3fh
	mov bx, [filehandle]
	mov cx, 54
	mov dx, offset header
	int 21h
	
	ret
endp readheader
;////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////
proc readpalette
; read bmp file color palette, 256 colors * 4 bytes (400h)
	push bp
	mov bp, sp
	push ax
	push cx
	push dx
	
	mov ah, 3fh
	mov cx, 400h
	mov dx, [bp+4]	;offset palette
	int 21h
	
	pop dx
	pop cx
	pop ax
	pop bp
	ret 2
endp readpalette
;///////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////
;1.char_pos
proc check_if_on_left_border
	;--------get--------;
	;bp + 4 - char_pos
	;-------------------;
	
	;-------return------;
	;1 - on left border
	;0 - not on left border
	;-------------------;
	push bp 
	mov bp,sp 
	push ax cx bx 
 	
	mov cx, 200 
	mov bx, 0 
	mov ax, [bp + 4]
	
	check_left_side:
		cmp ax, bx 
		je on_left_border
		add bx, 320 
	loop check_left_side
		mov [word ptr bp + 4], 0 
		jmp finish_checking_left
	on_left_border:
		mov [word ptr bp + 4], 1
	finish_checking_left:
		pop bx cx ax bp 
		ret 
endp check_if_on_left_border
;///////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////
;1.char_pos
proc check_if_on_right_border
	push bp 
	mov bp,sp 
	push ax cx bx 
 	
	mov cx, 200 
	mov bx, 320  
	
	mov ax, [bp + 4]
	add ax, 32 
	
	check_right_side:
		cmp ax, bx 
		je on_right_border
		add bx, 320 
	loop check_right_side
		mov [word ptr bp + 4], 0 
		jmp finish_checking_right 
	on_right_border:
		mov [word ptr bp + 4], 1
	finish_checking_right:
		pop bx cx ax bp 
		ret 
endp check_if_on_right_border
;///////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////
proc copypal
; copy the colors palette to the video memory
; the number of the first color should be sent to port 3c8h
; the palette is sent to port 3c9h
	push bp
	mov bp, sp
	push ax
	push cx
	push dx
	push si
	
	mov si, [bp+4]	;offset palette
	mov cx, 256
	mov dx, 3c8h
	mov al, 0
	; copy starting color to port 3c8h
	out dx, al
	; copy palette itself to port 3c9h
	inc dx
	palloop:
		; note: colors in a bmp file are saved as bgr values rather than rgb.
		mov al, [si+2] ; get red value.
		shr al, 2 ; max. is 255, but video palette maximal
		; value is 63. therefore dividing by 4.
		out dx, al ; send it.
		mov al, [si+1] ; get green value.
		shr al, 2
		out dx, al ; send it.
		mov al, [si] ; get blue value.
		shr al, 2
		out dx, al ; send it.
		add si, 4 ; point to next color.
		; (there is a null chr. after every color.)
	loop palloop
	
	pop si
	pop dx
	pop cx
	pop ax
	pop bp
	ret 2
endp copypal

proc copybitmap
; bmp graphics are saved upside-down.
; read the graphic line by line (200 lines in vga format),
; displaying the lines from bottom to top.
	push bp
	mov bp, sp
	push ax
	push cx
	push dx
	push di
	push si
	
	mov ax, 0a000h
	mov es, ax
	mov cx,200
	printbmploop:
		push cx
		; di = cx*320, point to the correct screen line
		mov di,cx
		shl cx,6
		shl di,8
		add di,cx
		; read one line
		mov ah,3fh
		mov cx,320
		mov dx,	[bp+4]	;offset scrline
		int 21h
		; copy one line into video memory
		cld ; clear direction flag, for movsb
		mov cx,320
		mov si,	[bp+4]		;offset scrline 
		rep movsb ; copy line to the screen
		 ;rep movsb is same as the following code:
		 ;mov es:di, ds:si
		 ;inc si
		 ;inc di
		 ;dec cx
		;loop until cx=0
		pop cx
	loop printbmploop
	
	pop si
	pop di
	pop dx
	pop cx
	pop ax
	pop bp
	ret 2
endp copybitmap
;////////////////////////////////////////////
;////////////////////////////////////////////
;1.lvl
proc delay
	push ax cx 
	
	mov ax, 5 ;ax * cx rotaions
	
	delay_again:
		mov cx, 0ffffh
		lop:
		loop lop 
		dec ax 
		cmp ax, 0 
		jne delay_again
	pop cx ax 
	ret 
endp delay                          
;////////////////////////////////////////////
;////////////////////////////////////////////
;1. min border 2.max border (maximum number can be 255) 3.user_last_key_used

;---------get------------;
;bp + 4 -user_last_key_used;
;bp + 6 - max border     ; 
;bp + 8 - min border     ;
;------------------------;

;----------returns-------;
;random number in border ;
;------------------------;
proc random_number_in_border 
	push bp
	mov bp,sp
	push ax
	push dx				
	push cx
	push bx
	push si 
		
		mov si, [bp + 4]
		;bp + 4 - if value		  ;
;bp + 6 - replacing value ;
;bp + 8 - pushed value    ;
		
		push 0 
		push 50 
		push si 
		call change_value_if
		pop si 
		
		push 1 
		push 150 
		push si
		call change_value_if
		pop si 
		
		mov ah,0
		int 1ah	
		add dx, si 	;put in dx and cx number of tickes from 12:00 
		mov dh, 0 	;dl - random number between 0 - 255 
		mov bx,[bp+6] ;bx = max border - min border 
		sub bx,[bp+8]
		try_again:
			;--------------------------
			cmp dl,[bp+6]
			ja too_high
			cmp dl,[bp+8]					;check if random number in border
			jb too_low
			jmp all_good
			;--------------------------
			too_high:
				sub dx, bx 
			jmp try_again
			
			too_low:						;change the value according to its size 
				add dx,bx
			jmp try_again
			;--------------------------
		all_good:
			xor dh,dh 
			mov [bp+8], dx
			
			pop si 
			pop bx
			pop cx 						;num in border 
			pop dx
			pop ax
			pop bp
			ret 4 
endp random_number_in_border
;return a random number between border numbers
;////////////////////////////////////////////
;////////////////////////////////////////////
;1.change_color_pixel_location 2.backround_color_pixel
proc _right_arrow
	push bp
	mov bp,sp 
	push ax bx 
	
	push [bp + 6]
	push 4 
	push 4 
	push [bp + 4]
	call filler 
	
	add [word ptr bp + 6], 4 
	mov bx, [bp + 6]
	inc bx 
	mov al, [es:bx]
	mov ah,0 
	
	mov [bp + 4], ax 
	
	push [bp + 6]
	push 4 
	push 4 
	push 255 
	call filler 
	pop bx ax bp 
	ret 
endp _right_arrow
;////////////////////////////////////////////
;////////////////////////////////////////////
;1.change_color_pixel_location 2.backround_color_pixel
proc _left_arrow
	push bp
	mov bp,sp 
	push ax bx 
	
	push [bp + 6]
	push 4 
	push 4 
	push [bp + 4]
	call filler 
	
	sub [word ptr bp + 6], 4 
	mov bx, [bp + 6]
	inc bx 
	mov al, [es:bx]
	mov ah,0 
	
	mov [bp + 4], ax 
	
	push [bp + 6]
	push 4 
	push 4 
	push 255 
	call filler 
	pop bx ax bp 
	ret 
endp _left_arrow
;////////////////////////////////////////////
;////////////////////////////////////////////
;1.change_color_pixel_location 2.backround_color_pixel
proc _up_arrow
	push bp
	mov bp,sp 
	push ax bx 
	
	push [bp + 6]
	push 4 
	push 4 
	push [bp + 4]
	call filler 
	
	sub [word ptr bp + 6], 4 * 320  
	mov bx, [bp + 6] 
	mov al, [es:bx]
	mov ah,0 
	
	mov [bp + 4], ax 
	
	push [bp + 6]
	push 4 
	push 4 
	push 255 
	call filler 
	pop bx ax bp 
	ret
endp _up_arrow
;////////////////////////////////////////////
;1.change_color_pixel_location 2.backround_color_pixel
proc _down_arrow
	push bp
	mov bp,sp 
	push ax bx 
	
	push [bp + 6]
	push 4 
	push 4 
	push [bp + 4]
	call filler 
	
	add [word ptr bp + 6], 4 * 320  
	mov bx, [bp + 6] 
	mov al, [es:bx]
	mov ah,0 
	
	mov [bp + 4], ax 
	
	push [bp + 6]
	push 4 
	push 4 
	push 255 
	call filler 
	pop bx ax bp 
	ret
endp _down_arrow
;////////////////////////////////////////////
;////////////////////////////////////////////
;put a value of 0 in each pixel in the screen 
proc clean_all 
	push ax
	push di
	push cx
	mov ax,2h 
	int 33h 
	mov di,0 
	mov cx,64000
	clean_next_pixel:
		mov [byte ptr es:di], 0 
		inc di 
	loop clean_next_pixel
	mov ax,1h 
	int 33h 
	pop cx
	pop di
	pop ax
	ret 
endp clean_all
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1.offset standing 2.offset moving_right 3.offset jumping 4.part_color 5.chance_color
proc change_all_sprites
	push bp 
	mov bp,sp 
	
	push [bp + 12]
	push 35 
	push 50 
	push [bp + 6]
	push [bp + 4]
	call change_part
	
	push [bp + 10]
	push 35 
	push 50 
	push [bp + 6]
	push [bp + 4]
	call change_part
	
	
	push [bp + 8]
	push 35 
	push 50 
	push [bp + 6]
	push [bp + 4]
	call change_part
	
	pop bp 
	ret 10 
endp change_all_sprites
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1.offset_image 2.width 3.length 4.part_color 5.change_color
proc change_part
	push bp
	mov bp,sp 
	push ax bx cx dx si di 
	
	mov si,[bp + 12]
	mov di, 0 
	
	mov dx, 0 
	save_next_char_line3:
		mov cx, 0 
		save_next_pixel3:
			add si, di 
			mov al, [si]
			
			mov ah, 0 
			;1.pushed value 2.replacing value 3.if value
			push ax 
			push [bp + 4]
			push [bp + 6]
			call change_value_if
			pop ax 
	
			mov [si], al
			sub si, di 
			
			inc di 
			inc cx
			cmp cx, [bp + 10]
			jne save_next_pixel3
		
		inc dx 
		cmp dx, [bp + 8]
		jne save_next_char_line3
		
		pop di si dx cx bx ax bp 
		ret 10 	
	
endp change_part
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1.pushed value 2.replacing value 3.if value
proc change_value_if        
;this proc gets a value that we check.
;than it check if the value is equal to the if value.
;if yes it will change the value to the replacing value.
;if not it will not do anything to the value.

;------------get----------;
;bp + 4 - if value		  ;
;bp + 6 - replacing value ;
;bp + 8 - pushed value    ;
;-------------------------;

;--------return-----------;
;   a value that is not   ; 
;   equal to the if value ;
;-------------------------;	 

	push bp 
	mov bp ,sp 
	
	push ax  
	
	mov ax, [bp + 8] 
	;------------------
	cmp ax, [bp + 4] ;check if pushed value is equal to if value
	jne no_need_to_change
	;------------------
	;----------------
	mov ax, [bp + 6] ;chance the value 
	;----------------
	no_need_to_change:
	mov [bp + 8], ax 
	
	pop ax bp
	ret 4 
endp change_value_if
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1 offset image 2.print location on the screen 3.width 4.length 
proc print_image
;this proc is printing an image from an array of numbers from 0 to 255 
;it is starting the printing from the top left location of the image
;than each cell value is being paint into its location of the screen 
;each cell that being copyed, the value in location that being painted is saved in another saving array
;the width is used to know when to lower the printing one line    

;-----------------get--------------------;	
;bp + 4 - length						 ;
;bp + 6 - width 						 ;
;bp + 8 - top left location of the image ;
;bp + 10 - offset array  (what image)	 ;
;----------------------------------------;

;--------------return--------------------;
;              nothing					 ;			
;----------------------------------------;

	push bp
	mov bp,sp
	push ax bx cx dx di si 
	
	mov si,[bp + 10]
	mov di, 0 
	mov bx,[bp + 8]
	mov dx, 0 
	
	next_line_of_char:
		mov cx, 0
		next_pixel_on_line:
			add si, di 
			mov al, [si]
			sub si,di 
			
	
			cmp al, 102 
			je skip_printing
			mov [es:bx], al
			skip_printing:
				inc bx   
				inc cx 
				inc di 
				cmp cx, [bp + 6]
				jne next_pixel_on_line
			
			add bx, 320   
			sub bx, [bp + 6]
			
			inc dx
			cmp dx, [bp + 4]
			jne next_line_of_char
			
			pop si di dx cx bx ax bp 
			ret 8 
endp print_image
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1 offset image, 2.print location on the screen 3.width 4.length 
proc print_image_mirrored
	push bp
	mov bp,sp
	push ax bx cx dx di si 
	
	mov si,[bp + 10]
	mov di, [bp + 6] 
	mov bx,[bp + 8]
	mov dx, 0 
	
	next_line_of_char1:
		mov cx, 0
		next_pixel_on_line1:
			add si, di 
			mov al, [si]
			sub si,di 
				
			cmp al, 102 
			je skip_printing1
			mov [es:bx], al
			skip_printing1:
				inc bx 
				inc cx
				dec	di 
				cmp cx, [bp + 6]
				jne next_pixel_on_line1
			add di,[bp + 6]
			add di,[bp + 6] 
			
			add bx, 320   
			sub bx, [bp + 6]
			
			inc dx
			cmp dx, [bp + 4]
			jne next_line_of_char1
			
			pop si di dx cx bx ax bp 
			ret 8
endp print_image_mirrored
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1.offset image 2.location 3.how many times bigger 4.width 5.length
proc big_image
	push bp 
	mov bp, sp 
	
	push ax bx cx dx si di 
	
	mov si, [bp + 12]
	mov di, 0 
	mov bx, [bp + 10]
	mov dx, 0 
	print_next_line_of_big_image:
		mov cx, 0 
		print_line_of_big_pictur:
			add si, di 
			mov al, [si] 
			sub si, di
			
			cmp al,102 
			je orange
			mov ah, 0 
			push bx 
			push [bp + 8]
			push [bp + 8]
			push ax 
			call filler
			orange:
			
			add bx, [bp + 8]
			inc di
		
			inc cx	
			cmp cx, [bp + 6]
			jne print_line_of_big_pictur
		mov ax, 320   
		push dx 
		mul  [word ptr bp + 8]
		pop dx
		add bx, ax 
		
		mov ax, [bp + 8]
		push dx 
		mul [word ptr bp + 6]
		pop dx
		
		sub bx, ax 
		
		inc dx
		cmp dx, [bp + 4]
		jne print_next_line_of_big_image
		
		pop di si dx cx bx ax bp 
		ret 10 
endp big_image
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1.top left location 2.length 3.width 4.color 
proc filler
	push bp
	mov bp, sp
	push ax
	push di
	push dx
	push cx  
	mov ax,2h 
	int 33h 
	mov cx,0 
	mov di , [bp+10] ;top left location
		next_line:
			mov dx, 0 
			mov ax,[bp+4] ;color 
			
			fill_line:
				mov [es:di],ax
				inc di
				inc dx
			cmp dx,[bp+8] ;length
			jne fill_line
			
			;-----------------------
			sub di,[bp+8] ;length
			add di,320					;next line
			;-----------------------
			inc cx
		cmp cx,[bp+6] ;width
		jne next_line
	mov ax,1h 
	int 33h
	pop  cx
	pop dx
	pop di
	pop ax
	pop bp
	ret 8 
endp filler
;/////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////
;1.top_left location of border 2.length 3.width 4.location
proc check_if_in_border
;this proc is checking if the location is insite an rectangle that its 
;top left corner ios top_left location of border and its length 
;and width are similar to what you recive from the user

;----------------get-------------------;
;bp + 4 - top left location of border  ;
;bp + 6	- length					   ;	
;bp + 8 - width						   ;	
;bp + 10 - location					   ;	
;--------------------------------------;

;------------return--------------------;
; 1 - if location is in border         ;
; 0 - if location is not in border     ;
;--------------------------------------;
	push bp
	mov bp,sp
	push ax
	push dx
	push bx
	push di 
	push si 
	
	mov bx, 320 
	mov ax, [bp + 4]
	mov dx, 0 
	div bx 
	
	mov di,ax ;y_location 
	mov si,dx ;x_location 
	
	mov bx, 320 
	mov ax, [bp + 10]
	mov dx, 0 
	div bx 
	
	cmp si, dx
	jb not_in_border
	add dx, [bp + 8]
	
	cmp si, dx 
	jnb not_in_border
	
	cmp di, ax 
	jb not_in_border
	add ax, [bp + 6]
	
	cmp di, ax
	jnb not_in_border
	
	mov [word ptr bp + 10], 1
	jmp finished_checking_border
	not_in_border:
		mov [word ptr bp + 10], 0 	
	finished_checking_border:
	pop si di bx dx ax bp  
	ret 6 
endp check_if_in_border
;/////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////
;1.top_left_location 2.length 3.width 4.mouse location
proc is_pressing
;this proc is checking if 1.the location is in the border?, 2.the mouse is clicked?.
;both of those statements have to occur so the proc will return 1 unless the proc will return 0.

;-------------------------get---------------------------------;
;bp + 4 - top_left_location 								  ;
;bp + 6 - length											  ;
;bp + 8 - width												  ;
;bp + 10 - location (most of the times mouse location)   	  ;
;-------------------------------------------------------------;		
	
;---------------------retunr----------------------------------;
; 1 - if the mouse was click when it was in the border		  ;
; 0 - if 1 != true                                            ;
;-------------------------------------------------------------;	
	
	push bp
	mov bp, sp 
	push ax bx 
	
	mov bx, 0 
	;-----------------------
	push [bp + 10]          
	push [bp + 8]			
	push [bp + 6]			;check if mouse location in border 
	push [bp + 4]			
	call check_if_in_border  
	pop ax 					
	;-----------------------
	cmp ax, 0 
	je false				;if not return 0 and finish the proc  
	;-----------------------
	mov ax, 3 
	int 33h 				
	cmp bx, 1 				;if the bx != 1 it means the user is not pressing on left click => return 0 and finish the proc 
	jne false				;if bx = 1 it means the user is pressing on left click => return 1 and finish the proc 
	;-----------------------
	mov [word ptr bp + 10], 1 
	jmp sof_is_pressing_proc 
	
	false:
		mov [word ptr bp + 10], 0 
	sof_is_pressing_proc:
		pop bx ax bp 
		ret 6 
endp is_pressing
;/////////////////////////////////////////////////////////////
;1.mouse_loc
proc mouse_location
	push bp
	mov bp,sp
	push ax
	push dx
	push cx
	
	mov ax,3h 
	int 33h 
	shr cx,1 
	mov ax,320
	mul dx
	mov dx,ax
	add dx, cx
	mov [bp+4],dx
	
	pop cx
	pop dx
	pop ax
	pop bp
	ret
endp mouse_location
;////////////////////////////////////////////////////////////////
;1.offset filename
proc draw_pic 
	push bp 
	mov bp,sp 	
	mov ax, 02h
	int 33h
	; process bmp file
	push [filehandle]
	push [bp+4]
	call openfile
	pop [filehandle]
	call readheader
	push offset palette
	call readpalette
	push offset palette
	call copypal
	push offset scrline
	call copybitmap
	mov ax, 01h
	int 33h
	pop bp
	ret 2 
endp draw_pic
;///////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////

;///////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////	
;1.offset saving array 2.location 3.width 4.length 
proc save_to_data
	;this proc is saving the pixels colors 
	;inside the saving array. 
	push bp
	mov bp,sp 
	push ax bx cx dx si di 
	
	mov si,[bp + 10]
	mov di, 0 
	mov bx, [bp + 8]
	
	mov dx, 0 
	save_next_char_line:
		mov cx, 0 
		save_next_pixel:
			
			mov al,[es:bx]
					
			add si, di 
			mov [si], al 
			sub si, di 
			
			inc di 
			inc bx 
			inc cx
			cmp cx, [bp + 6]
			jne save_next_pixel
		add bx, 320 
		sub bx, [bp + 6]
		
		inc dx 
		cmp dx, [bp + 4]
		jne save_next_char_line
		
		pop di si dx cx bx ax bp 
		ret 8	
endp save_to_data
;///////////////////////////////////////////////////////////
;1.offset image 2.location 3.width 4.length 5.offset data array
proc save_and_print
	push bp 
	mov bp,sp  
	;----save-block-of-data-----;
	push [bp + 4] ;data array 	; 
	push [bp + 10];location		;  
	push [bp + 8] ;width		; 
	push [bp + 6] ;length		; 
	call save_to_data 			;
	;---------------------------;
	;-------print-image---------;
	push [bp + 12];offset image ;
	push [bp + 10];location 	;
	push [bp + 8] ;width		;
	push [bp + 6] ;length		;
	call print_image			;
	;---------------------------;
	pop bp 
	ret 10 
endp save_and_print
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.char_pos 2.jump_number 3.offset image 4.offset next_char_pos
proc physics
	push bp 
	mov bp, sp 
	push ax
	
	push [bp + 10]
	push [bp + 8]
	call check_if_in_air
	pop ax
		
	cmp ax, 0
	je on_ground
	
	
	push [bp + 4]
	push [bp + 10]
	push 35 
	push 50 
	call print_image
	;1.offset image 2.location 3.width 4.length 5.offset data array
	add [word ptr bp + 10],  2 * 320 
	
	push [bp + 6]
	push [bp + 10]
	push 35 
	push 50 
	push [bp + 4]
	call save_and_print
	
	on_ground:
		pop ax bp 
		ret 6 
endp physics
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.char_pos 2.jump_number
proc check_if_in_air
;this proc is taking 35 pixels under the 
;character lowest line and compering each of the to 
;the border color 
	
;------get--------;
;bp + 4 - jump_number;
;bp + 6 - char_pos;
;-----------------;

;-----return------;
;1 - if in air 	  ;
;0 - if not in air;
;-----------------;	
	push bp 
	mov bp, sp 
	push ax bx cx dx   
	
	mov ax, [bp + 6]
	add ax, 51 * 320 
	mov cx, 320   
	mov bx, 200 * 320 
	
	check_if_on_floor:
		cmp ax, bx 
		je on_floor
		inc bx 
	loop check_if_on_floor
	
	mov cx, 35 
	
	check_if_on_obstacle:
		mov bx, ax 
		mov dl, [es:bx]
		cmp dl, 13 
		je on_floor
		inc ax 
	loop check_if_on_obstacle
		
		cmp [word ptr bp + 4], 0 
		jne on_floor
		
		mov [word ptr bp + 6], 1 
		jmp finish_checking_air
	on_floor:
		mov [word ptr bp + 6], 0  
	finish_checking_air:
		pop dx cx bx ax bp 
		ret 2 
endp check_if_in_air
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.ob1_length 2.ob2_length 3.ob3_length 4.offset ob1 5.offset ob2 6.offset ob3 7.ob1_location 8.ob2_location 9.ob3_location 10.user_last_key_used 
proc create_three_obstacles
	
;---get---------------;
;ob1_length - bp + 22
;ob2_length - bp + 20
;ob3_length - bp + 18 
;offset ob1 - bp + 16 
;offset ob2 - bp + 14 
;offset ob3 - bp + 12 
;ob1_location - bp + 10 
;ob2_location - bp + 8
;ob3_location - bp + 6
;user_last_key_used - bp + 4
;-----------------------------;
	
;--------return--------------;
;1.ob3_location
;2.ob2_location
;3.ob1_location
;4.ob3_length
;5.ob2_length
;6.ob1_length
;----------------------------;	
	
	push bp 
	mov bp,sp 
	push ax bx cx dx 
	;1. min border 2.max border (maximum number can be 255) 3.user_last_key_used
	;-------length----------;
	push 10 
	push 119 
	push [bp + 4]
	call random_number_in_border
	pop dx 
	;-----------------------;
	mov [bp + 22], dx 
	mov [bp + 20], dx 
	mov [bp + 18], dx 
	;-----------------------;
	mov bx, 320 
	sub bx, dx 
	;-------location--------;
	push 0 
	push bx 
	push [bp + 4]
	call random_number_in_border
	pop bx  
	;-----------------------;
	
	
	;1.offset saving array 2.location 3.width 4.length 
	
	add bx , 20 * 320 
	;-------save and print ob1------;
	mov [bp + 10], bx
	
	push [bp + 16] ;offset ob1 
	push [bp + 10] ;ob1_location
	push 120 
	push 4 
	call save_to_data
	
	push [bp + 10]
	push dx 
	push 4 
	push 13 
	call filler 
	;---------------------------------;
	add bx, 80 * 320 
	;-------save and print ob2--------;
	mov [bp + 8], bx 
	push [bp + 14]
	push [bp + 8]
	push 120 
	push 4 
	call save_to_data
	
	push [bp + 8]
	push dx 
	push 4 
	push 13 
	call filler 
	;---------------------------------;
	add bx, 80 * 320 
	;-------save and print ob3--------;
	mov [bp + 6], bx 
	
	push [bp + 12]
	push [bp + 6]
	push 120 
	push 4 
	call save_to_data
	
	push [bp + 6]
	push dx 
	push 4 
	push 13 
	call filler 
	;---------------------------------;
	mov ax, [bp + 10]
	mov [bp + 16], ax 
	mov ax, [bp + 8]
	mov [bp + 14], ax 
	mov ax, [bp + 6]
	mov [bp + 12],ax
	
	pop dx cx bx ax bp 
	ret 8 
endp create_three_obstacles
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.ob1_location 2.ob1_length 3.char_pos 4.user_last_key_used
proc generate_for_ob
	push bp 
	mov bp,sp 
	push ax bx dx  
	;---------get---------------
	;bp + 10 - ob1_location
	;bp + 8 - ob1_length
	;bp + 6 - char_pos
	;bp + 4 - user_last_key_used
	;---------------------------
	;--------return-------------
	;1.ob1_length
	;2.ob1_location
	;---------------------------
	cmp [word ptr bp + 10], 190 * 320 
	jna ready_ob
	push 30 					;generate length 
	push 119 
	push [bp + 4]
	call random_number_in_border
	pop [bp + 8]
	
	mov ax, 320 
	sub ax, [bp + 8]		
	
	push 0 
	push ax 
	push [bp + 4]
	call random_number_in_border		;generate location 
	pop [bp + 10]
	

	mov bx, 320 
	mov ax, [bp + 6] ;charlocation
	mov dx, 0 							
	div bx 
	mov bx, dx 
		
		cmp bx,[bp + 10]
		jne continue_ob
		add [word ptr bp + 10], 1 
		jmp ready_ob
		continue_ob:
		cmp bx, [bp + 10]
		ja char_gadol_ob
		char_katan_ob:
			xor dx, [bp + 10]
			xor [bp + 10], dx 
			xor dx,[bp + 10]
			
			sub dx, [bp + 10]
			cmp dx, 80  
			jna ready_ob
			add [word ptr bp + 10], 80 
			mov dx, bx 
			jmp char_katan_ob
		char_gadol_ob:
			sub dx, [bp + 10]
			cmp dx, 80
			jna ready_ob
			sub [word ptr bp + 10], 80  
			mov dx, bx 
			jmp char_gadol_ob
			ready_ob:
		
		pop dx bx ax bp 
		ret 4  
endp generate_for_ob
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.char_pos 2.ob1_location 3.ob2_location 4.ob3_location 5.offset next_char_pos 6.offset ob1 7.offset ob2 
;8.offset ob3 9.ob1_length 10.ob2_length 11.ob3_length 12.how_many_pixels 
 
proc move_obstacles
	
	;--------------get--------------;
	;bp + 28 - user_last_key_used 	;
	;bp + 26 - char_pos				;
	;bp + 24 - ob1_location			;
	;bp + 22 - ob2_location			;
	;bp + 20 - ob3_location 		;
	;bp + 18 - offset next_char_pos	;
	;bp + 16 - offset ob1 			;
	;bp + 14 - offset ob2 			;
	;bp + 12 - offset ob3 			;
	;bp + 10 - ob1_length 			;
	;bp + 8 - ob2_length			;
	;bp + 6 - ob3_length 			;
	;bp + 4 - how_many_pixels		;
	;-------------------------------;
	
	;------------return-------------;
	;1.ob3_location					;
	;2.ob2_location					;
	;3.ob1_location					;
	;4.ob3_length					;
	;5.ob2_length					;
	;6.ob3_length					;
	;-------------------------------;
	push bp 
	mov bp, sp 
	push ax 
	
	mov ax, [bp + 4] ;how_many_pixels
	
	;=========ob1===========
		push [bp + 16] ;offset ob1 
		push [bp + 24] ;ob1_location
		push 120
		push 4 
		call print_image
		
		push [bp + 26] ;char_pos
		push [bp + 24] ;ob1_location
		push [bp + 22] ;ob2_location
		push [bp + 20] ;ob3_location
		push [bp + 18] ;offset next_char_pos
		push [bp + 16] ;offset ob1 
		push [bp + 14] ;offset ob2 
		push [bp + 12] ;offset ob3 
		add [bp + 24], ax    
		
		push [bp + 24]
		push [bp + 10]
		push [bp + 26]
		push [bp + 28]
		call generate_for_ob
		pop [bp + 10]
		pop [bp + 24]
		
		push [bp + 16] ;offset ob1 		
		push [bp + 24] ;new ob1_location 
		push 120 
		push 4 
		call save_original_backround
			
		push [bp + 24]
		push [bp + 10]
		push 4 
		push 13 
		call filler 
	;=======================
	
	;=========ob2===========
		push [bp + 14] ;offset ob2 
		push [bp + 22] ;ob2_location
		push 120
		push 4 
		call print_image
		
		push [bp + 26] ;char_pos
		push [bp + 24] ;ob1_location
		push [bp + 22] ;ob2_location
		push [bp + 20] ;ob3_location
		push [bp + 18] ;offset next_char_pos
		push [bp + 16] ;offset ob1 
		push [bp + 14] ;offset ob2 
		push [bp + 12] ;offset ob3 
		add [bp + 22], ax   
		
		push [bp + 22]
		push [bp + 8]
		push [bp + 26]
		push [bp + 28]
		call generate_for_ob
		pop [bp + 8]
		pop [bp + 22]
		
		push [bp + 14] ;offset ob2 		
		push [bp + 22] ;new ob2_location 
		push 120 
		push 4 
		call save_original_backround
			
		push [bp + 22]
		push [bp + 8]
		push 4 
		push 13 
		call filler 
	;=======================
	
	;=========ob3===========
		push [bp + 12] ;offset ob3 
		push [bp + 20] ;ob3_location
		push 120
		push 4 
		call print_image
		
		push [bp + 26] ;char_pos
		push [bp + 24] ;ob1_location
		push [bp + 22] ;ob2_location
		push [bp + 20] ;ob3_location
		push [bp + 18] ;offset next_char_pos
		push [bp + 16] ;offset ob1 
		push [bp + 14] ;offset ob2 
		push [bp + 12] ;offset ob3 
		add [bp + 20], ax   
		
		push [bp + 20]
		push [bp + 6]
		push [bp + 26]
		push [bp + 28]
		call generate_for_ob
		pop [bp + 6]
		pop [bp + 20]
		
		push [bp + 12] ;offset ob3 		
		push [bp + 20] ;new ob3_location 
		push 120 
		push 4 
		call save_original_backround
			
		push [bp + 20]
		push [bp + 6]
		push 4 
		push 13 
		call filler 
	;=======================
	
			;--------------get--------------;
	;bp + 28 - user_last_key_used 	;
	;bp + 26 - char_pos				;
	;bp + 24 - ob1_location			;
	;bp + 22 - ob2_location			;
	;bp + 20 - ob3_location 		;
	;bp + 18 - offset next_char_pos	;
	;bp + 16 - offset ob1 			;
	;bp + 14 - offset ob2 			;
	;bp + 12 - offset ob3 			;
	;bp + 10 - ob1_length 			;
	;bp + 8 - ob2_length			;
	;bp + 6 - ob3_length 			;
	;bp + 4 - how_many_pixels		;
	;-------------------------------;
	
	;------------return-------------;
	;1.ob3_location					;
	;2.ob2_location					;
	;3.ob1_location					;
	;4.ob3_length					;
	;5.ob2_length					;
	;6.ob3_length					;
	;-------------------------------;
	mov ax, [bp + 24]
	mov [bp + 28], ax 
	mov ax, [bp + 22]
	mov [bp + 26], ax 
	mov ax, [bp + 20]
	mov [bp + 24], ax 
	mov ax, [bp + 10]
	mov [bp + 22], ax 
	mov ax,[bp + 8]
	mov [bp + 20], ax 
	mov ax, [bp + 6]
	mov [bp + 18], ax 

	pop ax bp 
	ret 14 
endp move_obstacles
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.char_pos 2.ob1_location 3.ob2_location 4.ob3_location 5.offset next_char_pos 6.offset ob1 7.offset ob2 
;8.offset ob3 9.offset saving array 10.location 11.width 12.length 
proc save_original_backround
	;this proc is saving the pixels colors 
	;inside the saving array. 
	;--------------get--------------;
	;bp + 26 - char_pos				;
	;bp + 24 - ob1_location			;
	;bp + 22 - ob2_location			;
	;bp + 20 - ob3_location 		;
	;bp + 18 - offset next_char_pos	;
	;bp + 16 - offset ob1 			;
	;bp + 14 - offset ob2 			;
	;bp + 12 - offset ob3 			;
	;bp + 10 - offset saving array 	;
	;bp + 8 - location				;
	;bp + 6 - width 				;
	;bp + 4 - length				;
	;-------------------------------;
	
	push bp
	mov bp,sp 
	push ax bx cx dx si di 
	
	mov si,[bp + 10] ;offset saving array 
	mov di, 0 
	mov bx, [bp + 8] ;location 
	
	mov dx, 0 
	save_next_char_line1:
		mov cx, 0 
		save_next_pixel1:
			
			
			push [bp + 26] ;char_pos
			push [bp + 24] ;ob1_location 
			push [bp + 22] ;ob2_location
			push [bp + 20] ;ob3_location
			push [bp + 18] ;offset next_char_pos
			push [bp + 16] ;offset ob1
			push [bp + 14] ;offset ob2 
			push [bp + 12] ;offset ob3 
			push bx ;new location 
			call save_original_pixel
			pop ax 
			mov ah, 0 
			
			add si, di 
			mov [si], al 
			sub si, di 
			
			inc di 
			inc bx 
			inc cx
			cmp cx, [bp + 6]
			jne save_next_pixel1
		add bx, 320 
		sub bx, [bp + 6]
		
		inc dx 
		cmp dx, [bp + 4]
		jne save_next_char_line1
		
		pop di si dx cx bx ax bp 
		ret 24 
endp save_original_backround
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.char_pos 2.ob1_location 3.ob2_location 4.ob3_location 5.offset next_char_pos 6.offset ob1 7.offset ob2 
;8.offset ob3 9.location
proc save_original_pixel
	push bp
	mov bp, sp 
	push ax di   
;-------------get---------------;	
;bp + 20 - char_pos				;
;bp + 18 - ob1_location			;
;bp + 16 - ob2_location			;
;bp + 14 - ob3_location			;
;bp + 12 - offset next_char_pos	;
;bp + 10 - offset ob1 			;
;bp + 8 - offset ob2 			;
;bp + 6 - offset ob3 			;
;bp + 4 - location 				;
;-------------------------------;	
 
;-----------return--------------;
;original backround pixel_color	;
;-------------------------------;	
	push [bp + 20] ;char_pos
	push 35 
	push 50 
	push [bp + 4]
	call check_if_in_border
	pop ax 
	
	cmp ax, 0 
	je check_ob1
		push [bp + 20]
		push 35 
		push [bp + 4]
		call increase_in_border
		pop di 
		
		add di,[bp + 12];offset char 		;char
		mov al, [di]
		mov ah, 0  
		jmp finish_save_original
	check_ob1:
		push [bp + 18]
		push 120 
		push 4 			
		push [bp + 4]
		call check_if_in_border
		pop ax 
		
		cmp ax, 0 
		je check_ob2 
		push [bp + 18]
		push 120 
		push [bp + 4]
		call increase_in_border
		pop di 
		
		add di, [bp + 10] ;ob1 
		mov al,[di]
		mov ah, 0 
		jmp finish_save_original
		check_ob2:
			push [bp + 16]
			push 120 
			push 4 
			push [bp + 4]
			call check_if_in_border
			pop ax 
			
			cmp ax, 0 
			je check_ob3
			push [bp + 16]
			push 120 
			push [bp + 4]
			call increase_in_border
			pop di 
			
			add di,[bp + 8] 
			mov al,[di]
			mov ah, 0 
			jmp finish_save_original
			check_ob3:
				push [bp + 14]
				push 120 
				push 4 
				push [bp + 4]
				call check_if_in_border
				pop ax 
		
				cmp ax, 0
				je not_in_any_border
				push [bp + 14]
				push 120 
				push [bp + 4]
				call increase_in_border
				pop di 
				
				add di,[bp + 6] 
				mov al,[di]
				mov ah, 0 
				jmp finish_save_original
				not_in_any_border:
					mov di,[bp + 4]
					mov al, [es:di]
					mov ah, 0 
					finish_save_original:
						mov [bp + 20], ax 
						pop di ax bp 
						ret 16 
endp save_original_pixel
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.first value 2.width 3.goal value 
proc increase_in_border
	;this proc returns the number of pixels 
	;that need to be added inside a border to reach another value. 
	;first value < goal value
	;ex: |--------|
	;	 |-*++++++|
	; 	 |++++++++|
	;	 |+++++*--|
	;	 |--------|  	
	push bp 
	mov bp,sp 
	push ax bx cx dx 
	mov dx, 0 
	mov cx, 0 
	mov bx, [bp + 8]
	
	count_in_border:
		cmp bx, [bp + 4]
		je finish_increase_in_border
		inc dx 
		inc bx
		inc cx 
		cmp cx, [bp + 6]
		jne count_in_border
	
		sub bx, [bp + 6]
		add bx, 320 
		mov cx, 0 
		jmp count_in_border
	
		finish_increase_in_border:
			mov [bp + 8], dx 
			pop dx cx bx ax bp 
			ret 4 
endp increase_in_border
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
proc change_handler
    xor     ax, ax
    mov     es, ax
    cli                              ; interrupts disabled
    push    [word ptr es:9*4+2]      ; save old keyboard (9) isr address - interrupt service routine(isr)
    push    [word ptr es:9*4]
	                                 ; put my keyboard (9) isr address: procedure 	
    mov     [word ptr es:9*4], offset my_isr
	                                 ; put cs in isr address
    mov     [es:9*4+2],        cs
    sti                               ; interrupts enabled

    call    my_program                     ; program that use the interrupt  lines 43 - 83

    cli                               ; interrupts disabled
    pop     [word ptr es:9*4]         ; restore isr address
    pop     [word ptr es:9*4+2]
    sti                               ; interrupts enabled

    ret
endp change_handler
;///////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////
;1.offset ob1 2.offset ob2 3.offset ob3 4.ob1_location 5.ob2_location 6.ob3_location 

proc delete_all_obstacles
	push bp 
	mov bp, sp 

;bp + 4 - ob3_location
;bp + 6 - ob2_location
;bp + 8 - ob1_location
;bp + 10 - offset ob3
;bp + 12 - offset ob2
;bp + 14 - offset ob1 

push [bp + 14]
push [bp + 8]
push 120 
push 4 
call print_image

push [bp + 12]
push [bp + 6]
push 120 
push 4 
call print_image

push [bp + 10]
push [bp + 4]
push 120 
push 4 
call print_image

pop bp 
ret 12 
endp delete_all_obstacles
;///////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////
;1.offset ob1 2.offset ob2 3.offset ob3 4.ob1_location 5.ob2_location 6.ob3_location 
;7.ob1_length 8.ob2_length 9.ob3_length
proc print_all_obstacles
	push bp 
	mov bp,sp 
	;bp + 4 - ob3_length
	;bp + 6 - ob2_length
	;bp + 8 - ob1_length
	;bp + 10 - ob3_location
;bp + 12 - ob2_location
;bp + 14 - ob1_location
;bp + 16 - offset ob3
;bp + 18 - offset ob2
;bp + 20 - offset ob1 
	
	
	;1.offset saving array 2.location 3.width 4.length 
	push [bp + 20]
	push [bp + 14]
	push 120 
	push 4 
	call save_to_data
	
	push [bp + 18]
	push [bp + 12]
	push 120 
	push 4 
	call save_to_data
	
	push [bp + 16]
	push [bp + 10]
	push 120 
	push 4 
	call save_to_data
	
	push [bp + 14]
	push [bp + 8]
	push 4 
	push 13 
	call filler 
	
	push [bp + 12]
	push [bp + 6]
	push 4 
	push 13
	call filler 
	
	push [bp + 10]
	push [bp + 4]
	push 4 
	push 13 
	call filler 
	
	pop bp 
	ret 18 
endp print_all_obstacles
;///////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////
;ob1_length ob2_length ob3_length 1.ob1_location 2.ob2_location 3.ob3_location 4.offset ob1 5.offset ob2 
;6.offset ob3 7.char_pos 8.offset image 9.width 10.length 11.offset next_char_pos
proc _a
;keybind
;-------------get---------------;
;bp + 4 - offset next_char_pos 	;
;bp + 6 - length			   	;
;bp + 8 - width			       	;
;bp + 10 - offset image  	   	;
;bp + 12 - char_pos		 		;
;bp + 14 - offset ob3 			;
;bp + 16 - offset ob2 			;
;bp + 18 - offset ob1 			;
;bp + 20 - ob3_location			;
;bp + 22 - ob2_location			;
;bp + 24 - ob1_location			;
;bp + 26 - ob3_length			;
;bp + 28 - ob2_length			;
;bp + 30 - ob1_length	 		;
;-------------------------------;

;-----------return--------------;
;1.char_pos		   			    ;		
;-------------------------------;	
	push bp 
	mov bp,sp 
	push ax 
	
	push [bp + 4]
	push [bp + 12]
	push 35
	push 50 
	call print_image
	;1.offset ob1 2.offset ob2 3.offset ob3 4.ob1_location 5.ob2_location 6.ob3_location 
	push [bp + 18]
	push [bp + 16]
	push [bp + 14]
	push [bp + 24]
	push [bp + 22]
	push [bp + 20]
	call delete_all_obstacles
	
	sub [word ptr bp + 12], 4
	push [bp + 4]
	push [bp + 12]
	push 35
	push 50 
	call save_to_data
	
	push [bp + 18]
	push [bp + 16]
	push [bp + 14]
	push [bp + 24]
	push [bp + 22]
	push [bp + 20]
	push [bp + 30]
	push [bp + 28]
	push [bp + 26]
	call print_all_obstacles
	
	push [bp + 10]
	push [bp + 12]
	push [bp + 8]
	push [bp + 6]
	call print_image_mirrored
	mov ax, [bp + 12]
	mov [bp + 30], ax
	
	pop ax bp 
	ret 26 
endp _a
;///////////////////////////////////////////////////////////////////////////////////////////////
;1.char_pos 2.offset image 3.width 4.length 5.offset next_char_pos
proc _d
;keybind
;-------------get---------------;
;bp + 4 - offset next_char_pos  ;
;bp + 6 - length			    ;
;bp + 8 - width			        ;
;bp + 10 - offset image  	    ;
;bp + 12 - char_pos		 		;
;bp + 14 - offset ob3 			;
;bp + 16 - offset ob2 			;
;bp + 18 - offset ob1 			;
;bp + 20 - ob3_location			;
;bp + 22 - ob2_location			;
;bp + 24 - ob1_location			;
;bp + 26 - ob3_length			;
;bp + 28 - ob2_length			;
;bp + 30 - ob1_length	 		;
;-----------return--------------;
;1.char_pos		   			   ;		
;------------------------------;	
	push bp 
	mov bp,sp 
	push ax 
	
	push [bp + 4]
	push [bp + 12]
	push 35
	push 50 
	call print_image
	;1.offset ob1 2.offset ob2 3.offset ob3 4.ob1_location 5.ob2_location 6.ob3_location 
	push [bp + 18]
	push [bp + 16]
	push [bp + 14]
	push [bp + 24]
	push [bp + 22]
	push [bp + 20]
	call delete_all_obstacles
	
	add [word ptr bp + 12], 4
	push [bp + 4]
	push [bp + 12]
	push 35
	push 50 
	call save_to_data
	
	push [bp + 18]
	push [bp + 16]
	push [bp + 14]
	push [bp + 24]
	push [bp + 22]
	push [bp + 20]
	push [bp + 30]
	push [bp + 28]
	push [bp + 26]
	call print_all_obstacles
	
	push [bp + 10]
	push [bp + 12]
	push [bp + 8]
	push [bp + 6]
	call print_image 
	mov ax, [bp + 12]
	mov [bp + 30], ax 
	
	pop ax bp 
	ret 26 
endp _d
;///////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////////

;1.ob1_length 2.ob2_length 3.ob3_length 4.ob1_location 5.ob2_location 6.ob3_location 7.offset ob1 8.offset ob2 
;9.offset ob3 =+1.char_pos 2.jump_number 3.offset jumping 4.offset next_char_pos
proc _space
	push bp 
	mov bp,sp
	push ax 
	;bp + 4 - offset next_char_pos
	;bp + 6 - offset jumping
	;bp + 8 - jump_number
	;bp + 10 - char_pos
	;bp + 12 - offset ob3
	;bp + 14 - offset ob2 
	;bp + 16 - offset ob1 
	;bp + 18 - ob3_location
	;bp + 20 - ob2_location
	;bp + 22 - ob1_location
	;bp + 24 - ob3_length
	;bp + 26 - ob2_length
	;bp + 28 - ob1_length
	
	;1.ob1_length 2.ob2_length 3.ob3_length 4.ob1_location 5.ob2_location 6.ob3_location 7.offset ob1 8.offset ob2 
;9.offset ob3 10.char_pos 11.offset imgae 12.offset next_char_pos
	push [bp + 28]
	push [bp + 26]
	push [bp + 24]
	push [bp + 22]
	push [bp + 20]
	push [bp + 18]
	push [bp + 16]
	push [bp + 14]
	push [bp + 12]
	push [bp + 10]
	push [bp + 6]
	push [bp + 4]
	call jump_up
	pop [bp + 10]
	
	inc [word ptr bp + 8]
	
	push [bp + 8]
	push 0 
	push 20 
	call change_value_if
	pop [bp + 8]
	
	mov ax, [bp + 10]
	mov [bp + 28], ax 
	mov ax, [bp + 8]
	mov [bp + 26], ax 
	
	pop ax bp 
	ret 22 
endp _space
;///////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////
;1.ob1_length 2.ob2_length 3.ob3_length 4.ob1_location 5.ob2_location 6.ob3_location 7.offset ob1 8.offset ob2 
;9.offset ob3 10.char_pos 11.offset imgae 12.offset next_char_pos
proc jump_up
	push bp 
	mov bp,sp
	push ax 
	;bp + 4 - offset next_char_pos
	;bp + 6 - offset image 
	;bp + 8 - char_pos
	;bp + 10 - offset ob3 
	;bp + 12 - offset ob2 
	;bp + 14 - offset ob1 
	;bp + 16 - ob3_location
	;bp + 18 - ob2_location
	;bp + 20 - ob1_location
	;bp + 22 - ob3_length
	;bp + 24 - ob2_length
	;bp + 26 - ob1_length
	
	push [bp + 4]
	push [bp + 8]
	push 35 
	push 50 
	call print_image
	
	;1.offset ob1 2.offset ob2 3.offset ob3 4.ob1_location 5.ob2_location 6.ob3_location 
	push [bp + 14]
	push [bp + 12]
	push [bp + 10]
	push [bp + 20]
	push [bp + 18]
	push [bp + 16]
	call delete_all_obstacles
	
	cmp [word ptr bp + 8], 4 * 320 
	jna cant_jump
	sub [word ptr bp + 8], 4 * 320 
	cant_jump:
	push [bp + 4]
	push [bp + 8]
	push 35 
	push 50 
	call save_to_data
	
;1.offset ob1 2.offset ob2 3.offset ob3 4.ob1_location 5.ob2_location 6.ob3_location 
;7.ob1_length 8.ob2_length 9.ob3_length
	push [bp + 14]
	push [bp + 12]
	push [bp + 10]
	push [bp + 20]
	push [bp + 18]
	push [bp + 16]
	push [bp + 26]
	push [bp + 24]
	push [bp + 22]
	call print_all_obstacles
	
	push [bp + 6]
	push [bp + 8]
	push 35 
	push 50 
	call print_image
	mov ax, [bp + 8]
	mov [bp + 26], ax 
	
	pop ax bp 
	ret 22 
endp jump_up
;/////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////

;/////////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////
proc my_isr               
 ; my isr for keyboard   
	push    ax
	push    bx
    push    cx
    push    dx
	push    di
	push    si
                        ; read keyboard scan code
    in      al, 60h
	
						; update keyboard state
    xor     bh, bh
    mov     bl, al
    and     bl, 7fh     ; bx = scan code
	
	cmp bl, 20h        ; if click on d (index 0 in array mini_buff)
	jne check1
	mov bl,0
	jmp end_check
check1:
	cmp bl, 1eh		    ; if click on a (index 1 in array mini_buff)
	jne check2
	mov bl,1
	jmp end_check
check2:
	cmp bl, 39h	    ; if click on space (index 2 in array mini_buff)
	jne check3 
	mov bl,2
	jmp end_check
check3:
	cmp bl, 48h 	;up 
	jne check4 
	mov bl,3 
	jmp end_check
check4:
	cmp bl, 4bh 
	jne check5 		;left  
	mov bl,4  
	jmp end_check
check5:
	cmp bl, 4dh 	;right  
	jne check6 
	mov bl, 5 
	jmp end_check
check6:
	mov bl, 50h 
	jne check7 
	mov bl, 6		;down  
	jmp end_check
check7:
	cmp bl, 1h		    ; if click on esc
	jne end_check
	mov [byte ptr cs:esc_key], 1
	
end_check:
    push cx
	mov cx, 7
    shr al, cl              ; al = 0 if pressed, 1 if released
	pop cx
    xor al, 1               ; al = 1 if pressed, 0 if released
    mov [cs:minibuf+bx], al   
	
	; save pressed buttons in array mini_buff
	
	
                                ; send eoi to xt keyboard
    in      al, 61h
    mov     ah, al
    or      al, 80h
    out     61h, al
    mov     al, ah
    out     61h, al

                                ; send eoi to master pic
    mov     al, 20h
    out     20h, al
	
    pop     si
    pop     di                       ;
    pop     dx
    pop     cx
    pop     bx
    pop     ax
   
    iret
endp my_isr
;////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////
proc my_program
	mov ax,0a000h
	mov es,ax
	
	graphic_screen
	
	menu_prep:
		
		;---------------------
		push offset filename1 
		call draw_pic			;draw backround
		;---------------------
		;---------------------
		display_mouse			;displaying mouse model
		;---------------------
		menu:
			
			push [mouse_loc]
			call mouse_location
			pop [mouse_loc]
			
			;----------------------------;
			push 119*320+213             ;
			push 80 		             ;
			push 27 	                 ;
			push [mouse_loc]             ;
			call is_pressing             ;check if user 
			pop [boolean_parameter]      ;pressing on play 
			                             ;
			cmp [boolean_parameter],   1  ;go to game_prep
			jne  stay_in_main1           ;
			jmp game_prep                ;
			;----------------------------;
			stay_in_main1:
			;----------------------------;
			push 156 * 320 + 213 		 ;
			push 81     				 ;
			push 27 					 ;
			push [mouse_loc]			 ;
			call is_pressing			 ;
			pop [boolean_parameter]		 ; 
										 ; 
			cmp [boolean_parameter],  1  ; 
			jne stay_in_main2            ;
			jmp customize_prep			 ;				  
			;----------------------------; 
			stay_in_main2:
			;------------------------------;
			push 290                       ;
 			push 30 					   ;	
			push 26 				       ;
			push [mouse_loc]			   ;
			call is_pressing 			   ;
			pop [boolean_parameter]		   ;
										   ;	
			cmp [boolean_parameter], 1     ;
			jne stay_in_main3			   ; 
			text_screen 				   ;
			call clean_all				   ;
			mov ah,4ch					   ;
			int 21h						   ;
			stay_in_main3:				   ;	 
			;------------------------------;
		jmp menu
		
	game_prep:
		;---------------------
		push offset filename2	
		call draw_pic		;draw o;game backroun
		
		print_default_char
		;---------------------
		push [ob1_length]
		push [ob2_length]
		push [ob3_length]
		push offset ob1 
		push offset ob2 
		push offset ob3 
		push [ob1_location]
		push [ob2_location]
		push [ob3_location]
		push [user_last_key_used]
		call create_three_obstacles
		pop [ob3_location]
		pop [ob2_location]
		pop [ob1_location]
		pop [ob3_length]
		pop [ob2_length]
		pop [ob1_length]
		;---------------------
		hide_mouse 			;hide the mouse model
		;---------------------
		print_default_stair
		mov [jump_number], 0 
		mov [is_moving], 0 
		mov [when_to_move], 0 
		mov [did_jump], 0 
		mov [already_print_stair], 0 
		mov si, 0
	game:
	
		call delay
		;----------------
		mouse_information
		cmp bx, 2		 
		jne stay_in_game1
	;check if the user want to exit 
		jmp menu_prep
		stay_in_game1:
		;----------------
		
			;1.char_pos 2.ob1_location 3.ob2_location 4.ob3_location 5.offset next_char_pos 6.offset ob1 7.offset ob2 
;8.offset ob3 9.ob1_length 10.ob2_length 11.ob3_length 12.how_many_pixels 
			check_if_alive
			;---------------------------;
			cmp [when_to_move], 5 
			je move_all_the_obstacles
			jmp do_not_move
			move_all_the_obstacles:
			mov [when_to_move], 0 
			inc [when_to_move]
			push [user_last_key_used]
			push [char_pos]
			push [ob1_location]
			push [ob2_location]
			push [ob3_location]
			push offset next_char_pos
			push offset ob1 
			push offset ob2 
			push offset ob3 
			push [ob1_length]
			push [ob2_length]
			push [ob3_length]
			push 4 * 320 
			call move_obstacles
			pop [ob3_length]
			pop [ob2_length]
			pop [ob1_length]
			pop [ob3_location]
			pop [ob2_location]
			pop [ob1_location]
			
		
			
			
			do_not_move:
			inc [when_to_move]
			;--------------------------;	
			push [char_pos]
			push [jump_number]
			push  offset jumping
			push offset next_char_pos
			call physics
			pop [char_pos]
				
			check_if_space
			mov ah, [cs:offset minibuf + si]	
			cmp ah, 0
			jne something_pressed
			jmp not_pressed
			something_pressed:
			mov [user_last_key_used], si	
			
			mov [is_moving], 0ffffh
			check_d:
				cmp si, 0 
				jne check_a
				
				mov [user_last_key_used], si 
				
				push [char_pos]
				call check_if_on_right_border
				pop [boolean_parameter]  
				
				cmp [boolean_parameter], 1 
				je check_a
				
				push [ob1_length]
				push [ob2_length]
				push [ob3_length]
				push [ob1_location]
				push [ob2_location]
				push [ob3_location]
				push offset ob1 
				push offset ob2 
				push offset ob3 
				push [char_pos]
				push offset moving_right
				push 35 
				push 50 
				push offset next_char_pos
				call _d
				pop [char_pos]
			check_a :
				cmp si,1 
				jne check_space
				
				mov [user_last_key_used], si 
				
				push [char_pos]
				call check_if_on_left_border
				pop [boolean_parameter]
				
				cmp [boolean_parameter], 1
				je check_space
			;1.ob1_location 2.ob2_location 3.ob3_location 4.offset ob1 5.offset ob2 
;6.offset ob3 7.char_pos 8.offset image 9.width 10.length 11.offset next_char_pos
				
				push [ob1_length]
				push [ob2_length]
				push [ob3_length]
				push [ob1_location]
				push [ob2_location]
				push [ob3_location]
				push offset ob1 
				push offset ob2 
				push offset ob3 
				push [char_pos]
				push offset moving_right
				push 35 
				push 50 
				push offset next_char_pos
				call _a
				pop [char_pos]
			check_space:
				cmp [jump_number], 0 
				jne skip_checking_if_pressed
				;------------------------------;
				push [char_pos]
				push [jump_number]
				call check_if_in_air
				pop [boolean_parameter]		;disable flying 
				cmp [boolean_parameter], 1 	;jump only when on ground 
				jne sttt
				jmp not_pressed

				sttt:;(if in air go to not_pressed)
				;-----------------------------;
				cmp si, 2 
				je skip_checking_if_pressed
				jmp not_pressed
				skip_checking_if_pressed:
				

				;1.ob1_length 2.ob2_length 3.ob3_length 4.ob1_location 5.ob2_location 6.ob3_location 7.offset ob1 8.offset ob2 
;9.offset ob3 =+1.char_pos 2.jump_number 3.offset jumping 4.offset next_char_pos
					
					mov [did_jump], 1 
					cmp [already_print_stair], 1
					jne do_not_skip
					jmp skip
					do_not_skip:
					mov [already_print_stair],1
					print_default_stair_backround
					skip:
					
					push [ob1_length]
					push [ob2_length]
					push [ob3_length]
					push [ob1_location]
					push [ob2_location]
					push [ob3_location]
					push offset ob1 
					push offset ob2 
					push offset ob3 
					push [char_pos]
					push [jump_number]
					push offset jumping
					push offset next_char_pos
					call _space
					pop [jump_number]
					pop [char_pos]
			not_pressed:;  63935
			inc [is_moving]
			
			cmp [is_moving], 3 
			jne nothing_else
			
			
			push offset next_char_pos
			push [char_pos]
			push 35 
			push 50 
			call print_image
			
			push offset standing
			push [char_pos]
			push 35 
			push 50 
			call print_image
			mov [is_moving], 0 
			nothing_else:
			inc si
			cmp si, 3 
			jne t_game
			mov si, 0 
			t_game:
	jmp game
	
		
		
	customize_prep:	
			
			push offset filename4
			call draw_pic
		
		print_big_image
		
		
		mov [backround_color_pixel], 0 
		mov [change_color_pixel_location],320 * 196 + 146 
		mov [color_change], 120 
		mov si, 3 
	
	customize:
		call delay 
		
		push [mouse_loc]
		call mouse_location
		pop [mouse_loc]	
		
		;---------------------
		mouse_information
		cmp bx, 2 
		jne stay_in_customize1
		jmp menu_prep
		stay_in_customize1:
		;---------------------
			push 36 * 320 + 10 
			push 42 
			push 20 
			push [mouse_loc]
			call is_pressing
			pop [boolean_parameter]
			
			cmp [boolean_parameter], 0  
			jne arrow1
			jmp check_arrow2
			arrow1:  
				arrow1_clicked
			check_arrow2:
				push 34 * 320 + 70 
				push 45 
				push 20 
				push [mouse_loc]
				call is_pressing
				pop [boolean_parameter]
	
				cmp [boolean_parameter], 0 
				jne arrow2
				jmp not_pressing_on_arrows
				arrow2:
					arrow2_clicked
				not_pressing_on_arrows:
				mov ah, [cs:offset minibuf + si]	
				cmp ah, 0
				jne check_up_arrow
				jmp not_pressed1
;change_color_pixel_location dw ? 
;	backround_color_pixel dw ? 
;		
			
		check_up_arrow:
			cmp si, 3 
			jne check_left_arrow
			print_big_image
			mov al, [backround_color_pixel]
			mov ah, 0 
			push [change_color_pixel_location]
			push ax 
			call _up_arrow
			pop ax 
			pop [change_color_pixel_location]
			mov [backround_color_pixel], al
		check_left_arrow:
			cmp si, 4 
			jne check_right_arrow
			print_big_image
			mov al, [backround_color_pixel]
			mov ah, 0 
			;------------------------------------
			push [change_color_pixel_location]
			push ax 
			call _left_arrow					;left_arrow_bind
			pop ax 
			pop [change_color_pixel_location]
			;------------------------------------
			mov [backround_color_pixel], al 
		check_right_arrow:
			cmp si, 5 
			jne check_down_arrow
			print_big_image
			
			mov al ,[backround_color_pixel]
			mov ah, 0 
			push [change_color_pixel_location]
			push ax 
			call _right_arrow
			pop ax 
			pop [change_color_pixel_location]
			
			mov [backround_color_pixel], al 
		check_down_arrow:
			;cmp si,6 
			;jne not_pressed1
			;mov al ,[backround_color_pixel]
			;mov ah, 0 
			;push [change_color_pixel_location]
			;push ax 
			;call _down_arrow
			;pop ax 
			
			mov al,[backround_color_pixel]
			mov ah, 0 
			
			push 80 * 320 + 50  
			push 30 
			push 30 
			push ax 
			call filler 
			not_pressed1:
			inc si
			cmp si, 7 
			jne t_game1 
			mov si, 3 
			t_game1:	
	jmp customize
	
	ret
endp my_program
start:
	 
	mov ax,@data
	mov ds,ax
	
	call change_handler
	
	
mov ax, 4c00h
int 21h
end start
;===========================================================================;
;                                                                           ;
;                                 _                                         ;
;                              ==(w{==========-      /===-                  ;
;                                ||  (.--.)         /===-_---~~~~~~~----__  ;
;                                | \_,|**|,__      |===-~___            _,-';
;                   -==\\        `\ ' `--'   ),    `//~\\   ~~~~`--._.-~    ;
;               ______-==|        /`\_. .__/\ \    | |  \\          _-~`    ;
;         __--~~~  ,-/-==\\      (   | .  |~~~~|   | |   `\       ,'        ;
;      _-~       /'    |  \\     )__/==0==-\<>/   / /      \     /          ;
;    .'        /       |   \\      /~\___/~~\/  /' /        \   /           ;
;   /  ____  /         |    \`\.__/-~~   \  |_/'  /          \/'            ;
;  /-'~    ~~~~~---__  |     ~-/~         ( )   /'        _--~`             ;
;                    \_|      /        _) | ;  ),   __--~~                  ;
;                      '~~--_/      _-~/- |/ \   '-~ \                      ;
;                     {\__--_/}    / \\_>-|)<__\      \                     ;
;                     /'   (_/  _-~  | |__>--<__|      |                    ;
;                    |   _/) )-~     | |__>--<__|      |                    ;
;                    / /~ ,_/       / /__>---<__/      |                    ;
;                   o-o _//        /-~_>---<__-~      /                     ;
;                   (^(~          /~_>---<__-      _-~                      ;
;                  ,/|           /__>--<__/     _-~                         ;
;               ,//('(          |__>--<__|     /                  .--_      ;
;              ( ( '))          |__>--<__|    |                 /' _-_~\    ;
;           `-)) )) (           |__>--<__|    | 			  /'  /   ~\`\  ;
;          ,/,'//( (             \__>--<__\    \            /'  //      ||  ;
;        ,( ( ((, ))              ~-__>--<_~-_  ~--__---~'/'/  /'       vv  ;
;      `~/  )` ) ,/|                 ~-_~>--<_/-__      __-~ _/             ;
;    ._-~//( )/ )) `                    ~~-'_/_/ /~~~~~__--~                ;
;     ;'( ')/ ,)(                              ~~~~~~~~                     ;
;    ' ') '( (/                                                             ;
;                                                                           ;
;                                                                           ;
;===========================================================================;