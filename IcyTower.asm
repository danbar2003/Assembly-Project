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
;                     `-..__         	SHMULIK KNOWS ALL      __..-'       ;
;                           ``-..____                  ____..-''            ;
;                                    ``--...____...--''                     ;
;                             
;---------------------------------
ARROW2_CLICKED MACRO
	ADD [COLOR_CHANGE], 3 
				PUSH OFFSET STANDING
				PUSH OFFSET MOVING_RIGHT
				PUSH OFFSET JUMPING
				MOV AL, [BACKROUND_COLOR_PIXEL]
				MOV AH, 0 
				PUSH AX
				MOV AL, [COLOR_CHANGE]
				MOV AH,	0 
				PUSH AX 
				CALL CHANGE_ALL_SPRITES
				MOV AL,[COLOR_CHANGE]
				MOV [BACKROUND_COLOR_PIXEL], AL 
				MOV AH, 0 
				PUSH 80 * 320 + 50  
				PUSH 30 
				PUSH 30 
				PUSH AX 
				CALL FILLER 
				PRINT_BIG_IMAGE
				
ENDM 
;---------------------------------
ARROW1_CLICKED MACRO
			SUB [COLOR_CHANGE], 3 
			PUSH OFFSET STANDING
			PUSH OFFSET MOVING_RIGHT
			PUSH OFFSET JUMPING
			MOV AL, [BACKROUND_COLOR_PIXEL]
			MOV AH, 0 
			PUSH AX
			MOV AL, [COLOR_CHANGE]
			MOV AH,0 
			PUSH AX 
			CALL CHANGE_ALL_SPRITES
			MOV AL,[COLOR_CHANGE]
			MOV [BACKROUND_COLOR_PIXEL], AL 
			MOV AH, 0 
			PUSH 80 * 320 + 50  
			PUSH 30 
			PUSH 30 
			PUSH AX 
			CALL FILLER 
			PRINT_BIG_IMAGE
			JMP NOT_PRESSING_ON_ARROWS
ENDM
;---------------------------------
PRINT_DEFAULT_STAIR MACRO 
	PUSH OFFSET DEFAULT_STAIR
	PUSH 194 * 320 
	PUSH 320 
	PUSH 4 
	CALL SAVE_TO_DATA

	PUSH 194 * 320 
	PUSH 320 
	PUSH 4 
	PUSH 13 
	CALL FILLER 
ENDM 	
;---------------------------------
PRINT_DEFAULT_STAIR_BACKROUND MACRO  
	PUSH OFFSET OB1 
	PUSH OFFSET OB2 
	PUSH OFFSET OB3 
	PUSH [OB1_LOCATION]
	PUSH [OB2_LOCATION]
	PUSH [OB3_LOCATION]
	CALL DELETE_ALL_OBSTACLES
	
	PUSH OFFSET DEFAULT_STAIR
	PUSH 194*320 
	PUSH 320 
	PUSH 4 
	CALL PRINT_IMAGE
	
	;1.OFFSET OB1 2.OFFSET OB2 3.OFFSET OB3 4.OB1_LOCATION 5.OB2_LOCATION 6.OB3_LOCATION 
;7.OB1_LENGTH 8.OB2_LENGTH 9.OB3_LENGTH
	PUSH OFFSET OB1 
	PUSH OFFSET OB2 
	PUSH OFFSET OB3 
	PUSH [OB1_LOCATION]
	PUSH [OB2_LOCATION]
	PUSH [OB3_LOCATION]
	PUSH [OB1_LENGTH]
	PUSH [OB2_LENGTH]
	PUSH [OB3_LENGTH]
	CALL PRINT_ALL_OBSTACLES
ENDM  
;---------------------------------
CHECK_IF_ALIVE MACRO
	CMP [CHAR_POS], 144 * 320 
	JNA ALIVE1
	CMP [DID_JUMP], 0 
	JE ALIVE1
	JMP MENU_PREP
	ALIVE1:
ENDM 
;---------------------------------
PRINT_BIG_IMAGE MACRO 
		PUSH OFFSET STANDING
		PUSH 150  
		PUSH 4  
		PUSH 35 
		PUSH 50 
		CALL BIG_IMAGE
ENDM
;----------------------------------
GRAPHIC_SCREEN MACRO	
	MOV AX, 13H 
	INT 10H 
ENDM 	
;----------------------------------
TEXT_SCREEN MACRO
	MOV AX, 3  
	INT 10H 
ENDM 
;----------------------------------
MOUSE_INFORMATION MACRO	
	PUSH AX 
	MOV AX, 3 
	INT 33H 
	POP AX 
ENDM
;----------------------------------
HIDE_MOUSE MACRO
	MOV AX, 2 
	INT 33H
ENDM
;---------------------------------- 
DISPLAY_MOUSE MACRO
	MOV AX, 0 
	INT 33H 
	MOV AX, 1 
	INT 33H 	
ENDM
;-----------------------------------
WAIT_FOR_MOUSE_CLICK MACRO
	PUSH BX 
	WAIT_FOR_CLICK:
		MOUSE_INFORMATION
		CMP BX, 1 
		JNE WAIT_FOR_CLICK
	POP BX 
ENDM 
;-----------------------------------
CHECK_IF_SPACE MACRO 
	CMP SI, 2 
	JNE NOT_JUMPING
	CMP [JUMP_NUMBER], 0 
	JE NOT_JUMPING
	JMP SOMETHING_PRESSED
	NOT_JUMPING:
ENDM 
;-----------------------------------
PRINT_DEFAULT_CHAR MACRO 
	MOV [CHAR_POS], 320 * 143 + 140  
	
	PUSH OFFSET STANDING
	PUSH [CHAR_POS]
	PUSH 35 
	PUSH 50 
	PUSH OFFSET NEXT_CHAR_POS
	CALL SAVE_AND_PRINT
ENDM 
;------------------------------------
IDEAL
MODEL SMALL
STACK 100H
DATASEG

HEADER DB 54 DUP (0)
PALETTE DB 256*4 DUP (0)
SCRLINE DB 320 DUP (0)
FILENAME1 DB 'GAME.BMP',0 ;MENU BACKROUND
FILENAME2 DB 'III.BMP',0 ;GAME BACKROUND
FILENAME3 DB 'TUTO.BMP',0;TUTORIAL BACKROUND
FILENAME4 DB 'ROOT.BMP',0; 
FILEHANDLE DW ?
IS_MOVING DW 0 
WHEN_TO_MOVE DB 0 
JUMP_NUMBER DW 0
USER_LAST_KEY_USED DW ?  
BOOLEAN_PARAMETER DW ?
CHAR_POS DW 320 * 155 + 140  
MOUSE_LOC DW ? 
NEXT_CHAR_POS DB 35*50 DUP (0)
CHANGE_COLOR_PIXEL_LOCATION DW ? 
BACKROUND_COLOR_PIXEL DB ? 
COLOR_CHANGE DB ?
DID_JUMP DB ?
ALREADY_PRINT_STAIR DB ? 
OB1_LOCATION DW ?
OB1_LENGTH DW ?
OB1 DB 4*120 DUP (0)

OB2_LOCATION DW ?
OB2_LENGTH DW ?
OB2 DB 4*120 DUP (0)

OB3_LOCATION DW ?
OB3_LENGTH DW ? 
OB3 DB 4*120 DUP (0)

DEFAULT_STAIR DB 4 * 320 DUP (0)

INCLUDE "DEFAULT.ASM"
MINIBUF DB 7 DUP (0)
CODESEG

ESC_KEY DB 0 
PROC OPENFILE
; OPEN FILE
	PUSH BP
	MOV BP, SP
	PUSH AX
	PUSH DX
	
	MOV AH, 3DH
	XOR AL, AL
	MOV DX, [BP+4]	;OFFSET FILENAME
	INT 21H
	MOV [BP+6], AX 	;[FILEHANDLE]
	
	POP DX
	POP AX
	POP BP
	RET 2
ENDP OPENFILE
;//////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////
PROC READHEADER
; READ BMP FILE HEADER, 54 BYTES
	
	MOV AH, 3FH
	MOV BX, [FILEHANDLE]
	MOV CX, 54
	MOV DX, OFFSET HEADER
	INT 21H
	
	RET
ENDP READHEADER
;////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////
PROC READPALETTE
; READ BMP FILE COLOR PALETTE, 256 COLORS * 4 BYTES (400H)
	PUSH BP
	MOV BP, SP
	PUSH AX
	PUSH CX
	PUSH DX
	
	MOV AH, 3FH
	MOV CX, 400H
	MOV DX, [BP+4]	;OFFSET PALETTE
	INT 21H
	
	POP DX
	POP CX
	POP AX
	POP BP
	RET 2
ENDP READPALETTE
;///////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////
;1.CHAR_POS
PROC CHECK_IF_ON_LEFT_BORDER
	;--------GET--------;
	;BP + 4 - CHAR_POS
	;-------------------;
	
	;-------RETURN------;
	;1 - ON LEFT BORDER
	;0 - NOT ON LEFT BORDER
	;-------------------;
	PUSH BP 
	MOV BP,SP 
	PUSH AX CX BX 
 	
	MOV CX, 200 
	MOV BX, 0 
	MOV AX, [BP + 4]
	
	CHECK_LEFT_SIDE:
		CMP AX, BX 
		JE ON_LEFT_BORDER
		ADD BX, 320 
	LOOP CHECK_LEFT_SIDE
		MOV [WORD PTR BP + 4], 0 
		JMP FINISH_CHECKING_LEFT
	ON_LEFT_BORDER:
		MOV [WORD PTR BP + 4], 1
	FINISH_CHECKING_LEFT:
		POP BX CX AX BP 
		RET 
ENDP CHECK_IF_ON_LEFT_BORDER
;///////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////
;1.CHAR_POS
PROC CHECK_IF_ON_RIGHT_BORDER
	PUSH BP 
	MOV BP,SP 
	PUSH AX CX BX 
 	
	MOV CX, 200 
	MOV BX, 320  
	
	MOV AX, [BP + 4]
	ADD AX, 32 
	
	CHECK_RIGHT_SIDE:
		CMP AX, BX 
		JE ON_RIGHT_BORDER
		ADD BX, 320 
	LOOP CHECK_RIGHT_SIDE
		MOV [WORD PTR BP + 4], 0 
		JMP FINISH_CHECKING_RIGHT 
	ON_RIGHT_BORDER:
		MOV [WORD PTR BP + 4], 1
	FINISH_CHECKING_RIGHT:
		POP BX CX AX BP 
		RET 
ENDP CHECK_IF_ON_RIGHT_BORDER
;///////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////
PROC COPYPAL
; COPY THE COLORS PALETTE TO THE VIDEO MEMORY
; THE NUMBER OF THE FIRST COLOR SHOULD BE SENT TO PORT 3C8H
; THE PALETTE IS SENT TO PORT 3C9H
	PUSH BP
	MOV BP, SP
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH SI
	
	MOV SI, [BP+4]	;OFFSET PALETTE
	MOV CX, 256
	MOV DX, 3C8H
	MOV AL, 0
	; COPY STARTING COLOR TO PORT 3C8H
	OUT DX, AL
	; COPY PALETTE ITSELF TO PORT 3C9H
	INC DX
	PALLOOP:
		; NOTE: COLORS IN A BMP FILE ARE SAVED AS BGR VALUES RATHER THAN RGB.
		MOV AL, [SI+2] ; GET RED VALUE.
		SHR AL, 2 ; MAX. IS 255, BUT VIDEO PALETTE MAXIMAL
		; VALUE IS 63. THEREFORE DIVIDING BY 4.
		OUT DX, AL ; SEND IT.
		MOV AL, [SI+1] ; GET GREEN VALUE.
		SHR AL, 2
		OUT DX, AL ; SEND IT.
		MOV AL, [SI] ; GET BLUE VALUE.
		SHR AL, 2
		OUT DX, AL ; SEND IT.
		ADD SI, 4 ; POINT TO NEXT COLOR.
		; (THERE IS A NULL CHR. AFTER EVERY COLOR.)
	LOOP PALLOOP
	
	POP SI
	POP DX
	POP CX
	POP AX
	POP BP
	RET 2
ENDP COPYPAL

PROC COPYBITMAP
; BMP GRAPHICS ARE SAVED UPSIDE-DOWN.
; READ THE GRAPHIC LINE BY LINE (200 LINES IN VGA FORMAT),
; DISPLAYING THE LINES FROM BOTTOM TO TOP.
	PUSH BP
	MOV BP, SP
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH DI
	PUSH SI
	
	MOV AX, 0A000H
	MOV ES, AX
	MOV CX,200
	PRINTBMPLOOP:
		PUSH CX
		; DI = CX*320, POINT TO THE CORRECT SCREEN LINE
		MOV DI,CX
		SHL CX,6
		SHL DI,8
		ADD DI,CX
		; READ ONE LINE
		MOV AH,3FH
		MOV CX,320
		MOV DX,	[BP+4]	;OFFSET SCRLINE
		INT 21H
		; COPY ONE LINE INTO VIDEO MEMORY
		CLD ; CLEAR DIRECTION FLAG, FOR MOVSB
		MOV CX,320
		MOV SI,	[BP+4]		;OFFSET SCRLINE 
		REP MOVSB ; COPY LINE TO THE SCREEN
		 ;REP MOVSB IS SAME AS THE FOLLOWING CODE:
		 ;MOV ES:DI, DS:SI
		 ;INC SI
		 ;INC DI
		 ;DEC CX
		;LOOP UNTIL CX=0
		POP CX
	LOOP PRINTBMPLOOP
	
	POP SI
	POP DI
	POP DX
	POP CX
	POP AX
	POP BP
	RET 2
ENDP COPYBITMAP
;////////////////////////////////////////////
;////////////////////////////////////////////
;1.LVL
PROC DELAY
	PUSH AX CX 
	
	MOV AX, 5 ;AX * CX ROTAIONS
	
	DELAY_AGAIN:
		MOV CX, 0FFFFH
		LOP:
		LOOP LOP 
		DEC AX 
		CMP AX, 0 
		JNE DELAY_AGAIN
	POP CX AX 
	RET 
ENDP DELAY                          
;////////////////////////////////////////////
;////////////////////////////////////////////
;1. MIN BORDER 2.MAX BORDER (MAXIMUM NUMBER CAN BE 255) 3.USER_LAST_KEY_USED

;---------GET------------;
;BP + 4 -USER_LAST_KEY_USED;
;BP + 6 - MAX BORDER     ; 
;BP + 8 - MIN BORDER     ;
;------------------------;

;----------RETURNS-------;
;RANDOM NUMBER IN BORDER ;
;------------------------;
PROC RANDOM_NUMBER_IN_BORDER 
	PUSH BP
	MOV BP,SP
	PUSH AX
	PUSH DX				
	PUSH CX
	PUSH BX
	PUSH SI 
		
		MOV SI, [BP + 4]
		;BP + 4 - IF VALUE		  ;
;BP + 6 - REPLACING VALUE ;
;BP + 8 - PUSHED VALUE    ;
		
		PUSH 0 
		PUSH 50 
		PUSH SI 
		CALL CHANGE_VALUE_IF
		POP SI 
		
		PUSH 1 
		PUSH 150 
		PUSH SI
		CALL CHANGE_VALUE_IF
		POP SI 
		
		MOV AH,0
		INT 1AH	
		ADD DX, SI 	;PUT IN DX AND CX NUMBER OF TICKES FROM 12:00 
		MOV DH, 0 	;DL - RANDOM NUMBER BETWEEN 0 - 255 
		MOV BX,[BP+6] ;BX = MAX BORDER - MIN BORDER 
		SUB BX,[BP+8]
		TRY_AGAIN:
			;--------------------------
			CMP DL,[BP+6]
			JA TOO_HIGH
			CMP DL,[BP+8]					;CHECK IF RANDOM NUMBER IN BORDER
			JB TOO_LOW
			JMP ALL_GOOD
			;--------------------------
			TOO_HIGH:
				SUB DX, BX 
			JMP TRY_AGAIN
			
			TOO_LOW:						;CHANGE THE VALUE ACCORDING TO ITS SIZE 
				ADD DX,BX
			JMP TRY_AGAIN
			;--------------------------
		ALL_GOOD:
			XOR DH,DH 
			MOV [BP+8], DX
			
			POP SI 
			POP BX
			POP CX 						;NUM IN BORDER 
			POP DX
			POP AX
			POP BP
			RET 4 
ENDP RANDOM_NUMBER_IN_BORDER
;////////////////////////////////////////////
;////////////////////////////////////////////
;1.CHANGE_COLOR_PIXEL_LOCATION 2.BACKROUND_COLOR_PIXEL
PROC _RIGHT_ARROW
	PUSH BP
	MOV BP,SP 
	PUSH AX BX 
	
	PUSH [BP + 6]
	PUSH 4 
	PUSH 4 
	PUSH [BP + 4]
	CALL FILLER 
	
	ADD [WORD PTR BP + 6], 4 
	MOV BX, [BP + 6]
	INC BX 
	MOV AL, [ES:BX]
	MOV AH,0 
	
	MOV [BP + 4], AX 
	
	PUSH [BP + 6]
	PUSH 4 
	PUSH 4 
	PUSH 255 
	CALL FILLER 
	POP BX AX BP 
	RET 
ENDP _RIGHT_ARROW
;////////////////////////////////////////////
;////////////////////////////////////////////
;1.CHANGE_COLOR_PIXEL_LOCATION 2.BACKROUND_COLOR_PIXEL
PROC _LEFT_ARROW
	PUSH BP
	MOV BP,SP 
	PUSH AX BX 
	
	PUSH [BP + 6]
	PUSH 4 
	PUSH 4 
	PUSH [BP + 4]
	CALL FILLER 
	
	SUB [WORD PTR BP + 6], 4 
	MOV BX, [BP + 6]
	INC BX 
	MOV AL, [ES:BX]
	MOV AH,0 
	
	MOV [BP + 4], AX 
	
	PUSH [BP + 6]
	PUSH 4 
	PUSH 4 
	PUSH 255 
	CALL FILLER 
	POP BX AX BP 
	RET 
ENDP _LEFT_ARROW
;////////////////////////////////////////////
;////////////////////////////////////////////
;1.CHANGE_COLOR_PIXEL_LOCATION 2.BACKROUND_COLOR_PIXEL
PROC _UP_ARROW
	PUSH BP
	MOV BP,SP 
	PUSH AX BX 
	
	PUSH [BP + 6]
	PUSH 4 
	PUSH 4 
	PUSH [BP + 4]
	CALL FILLER 
	
	SUB [WORD PTR BP + 6], 4 * 320  
	MOV BX, [BP + 6] 
	MOV AL, [ES:BX]
	MOV AH,0 
	
	MOV [BP + 4], AX 
	
	PUSH [BP + 6]
	PUSH 4 
	PUSH 4 
	PUSH 255 
	CALL FILLER 
	POP BX AX BP 
	RET
ENDP _UP_ARROW
;////////////////////////////////////////////
;1.CHANGE_COLOR_PIXEL_LOCATION 2.BACKROUND_COLOR_PIXEL
PROC _DOWN_ARROW
	PUSH BP
	MOV BP,SP 
	PUSH AX BX 
	
	PUSH [BP + 6]
	PUSH 4 
	PUSH 4 
	PUSH [BP + 4]
	CALL FILLER 
	
	ADD [WORD PTR BP + 6], 4 * 320  
	MOV BX, [BP + 6] 
	MOV AL, [ES:BX]
	MOV AH,0 
	
	MOV [BP + 4], AX 
	
	PUSH [BP + 6]
	PUSH 4 
	PUSH 4 
	PUSH 255 
	CALL FILLER 
	POP BX AX BP 
	RET
ENDP _DOWN_ARROW
;////////////////////////////////////////////
;////////////////////////////////////////////
;PUT A VALUE OF 0 IN EACH PIXEL IN THE SCREEN 
PROC CLEAN_ALL 
	PUSH AX
	PUSH DI
	PUSH CX
	MOV AX,2H 
	INT 33H 
	MOV DI,0 
	MOV CX,64000
	CLEAN_NEXT_PIXEL:
		MOV [BYTE PTR ES:DI], 0 
		INC DI 
	LOOP CLEAN_NEXT_PIXEL
	MOV AX,1H 
	INT 33H 
	POP CX
	POP DI
	POP AX
	RET 
ENDP CLEAN_ALL
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1.OFFSET STANDING 2.OFFSET MOVING_RIGHT 3.OFFSET JUMPING 4.PART_COLOR 5.CHANCE_COLOR
PROC CHANGE_ALL_SPRITES
	PUSH BP 
	MOV BP,SP 
	
	PUSH [BP + 12]
	PUSH 35 
	PUSH 50 
	PUSH [BP + 6]
	PUSH [BP + 4]
	CALL CHANGE_PART
	
	PUSH [BP + 10]
	PUSH 35 
	PUSH 50 
	PUSH [BP + 6]
	PUSH [BP + 4]
	CALL CHANGE_PART
	
	
	PUSH [BP + 8]
	PUSH 35 
	PUSH 50 
	PUSH [BP + 6]
	PUSH [BP + 4]
	CALL CHANGE_PART
	
	POP BP 
	RET 10 
ENDP CHANGE_ALL_SPRITES
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1.OFFSET_IMAGE 2.WIDTH 3.LENGTH 4.PART_COLOR 5.CHANGE_COLOR
PROC CHANGE_PART
	PUSH BP
	MOV BP,SP 
	PUSH AX BX CX DX SI DI 
	
	MOV SI,[BP + 12]
	MOV DI, 0 
	
	MOV DX, 0 
	SAVE_NEXT_CHAR_LINE3:
		MOV CX, 0 
		SAVE_NEXT_PIXEL3:
			ADD SI, DI 
			MOV AL, [SI]
			
			MOV AH, 0 
			;1.PUSHED VALUE 2.REPLACING VALUE 3.IF VALUE
			PUSH AX 
			PUSH [BP + 4]
			PUSH [BP + 6]
			CALL CHANGE_VALUE_IF
			POP AX 
	
			MOV [SI], AL
			SUB SI, DI 
			
			INC DI 
			INC CX
			CMP CX, [BP + 10]
			JNE SAVE_NEXT_PIXEL3
		
		INC DX 
		CMP DX, [BP + 8]
		JNE SAVE_NEXT_CHAR_LINE3
		
		POP DI SI DX CX BX AX BP 
		RET 10 	
	
ENDP CHANGE_PART
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1.PUSHED VALUE 2.REPLACING VALUE 3.IF VALUE
PROC CHANGE_VALUE_IF        
;THIS PROC GETS A VALUE THAT WE CHECK.
;THAN IT CHECK IF THE VALUE IS EQUAL TO THE IF VALUE.
;IF YES IT WILL CHANGE THE VALUE TO THE REPLACING VALUE.
;IF NOT IT WILL NOT DO ANYTHING TO THE VALUE.

;------------GET----------;
;BP + 4 - IF VALUE		  ;
;BP + 6 - REPLACING VALUE ;
;BP + 8 - PUSHED VALUE    ;
;-------------------------;

;--------RETURN-----------;
;   A VALUE THAT IS NOT   ; 
;   EQUAL TO THE IF VALUE ;
;-------------------------;	 

	PUSH BP 
	MOV BP ,SP 
	
	PUSH AX  
	
	MOV AX, [BP + 8] 
	;------------------
	CMP AX, [BP + 4] ;CHECK IF PUSHED VALUE IS EQUAL TO IF VALUE
	JNE NO_NEED_TO_CHANGE
	;------------------
	;----------------
	MOV AX, [BP + 6] ;CHANCE THE VALUE 
	;----------------
	NO_NEED_TO_CHANGE:
	MOV [BP + 8], AX 
	
	POP AX BP
	RET 4 
ENDP CHANGE_VALUE_IF
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1 OFFSET IMAGE 2.PRINT LOCATION ON THE SCREEN 3.WIDTH 4.LENGTH 
PROC PRINT_IMAGE
;THIS PROC IS PRINTING AN IMAGE FROM AN ARRAY OF NUMBERS FROM 0 TO 255 
;IT IS STARTING THE PRINTING FROM THE TOP LEFT LOCATION OF THE IMAGE
;THAN EACH CELL VALUE IS BEING PAINT INTO ITS LOCATION OF THE SCREEN 
;EACH CELL THAT BEING COPYED, THE VALUE IN LOCATION THAT BEING PAINTED IS SAVED IN ANOTHER SAVING ARRAY
;THE WIDTH IS USED TO KNOW WHEN TO LOWER THE PRINTING ONE LINE    

;-----------------GET--------------------;	
;BP + 4 - LENGTH						 ;
;BP + 6 - WIDTH 						 ;
;BP + 8 - TOP LEFT LOCATION OF THE IMAGE ;
;BP + 10 - OFFSET ARRAY  (WHAT IMAGE)	 ;
;----------------------------------------;

;--------------RETURN--------------------;
;              NOTHING					 ;			
;----------------------------------------;

	PUSH BP
	MOV BP,SP
	PUSH AX BX CX DX DI SI 
	
	MOV SI,[BP + 10]
	MOV DI, 0 
	MOV BX,[BP + 8]
	MOV DX, 0 
	
	NEXT_LINE_OF_CHAR:
		MOV CX, 0
		NEXT_PIXEL_ON_LINE:
			ADD SI, DI 
			MOV AL, [SI]
			SUB SI,DI 
			
	
			CMP AL, 102 
			JE SKIP_PRINTING
			MOV [ES:BX], AL
			SKIP_PRINTING:
				INC BX   
				INC CX 
				INC DI 
				CMP CX, [BP + 6]
				JNE NEXT_PIXEL_ON_LINE
			
			ADD BX, 320   
			SUB BX, [BP + 6]
			
			INC DX
			CMP DX, [BP + 4]
			JNE NEXT_LINE_OF_CHAR
			
			POP SI DI DX CX BX AX BP 
			RET 8 
ENDP PRINT_IMAGE
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1 OFFSET IMAGE, 2.PRINT LOCATION ON THE SCREEN 3.WIDTH 4.LENGTH 
PROC PRINT_IMAGE_MIRRORED
	PUSH BP
	MOV BP,SP
	PUSH AX BX CX DX DI SI 
	
	MOV SI,[BP + 10]
	MOV DI, [BP + 6] 
	MOV BX,[BP + 8]
	MOV DX, 0 
	
	NEXT_LINE_OF_CHAR1:
		MOV CX, 0
		NEXT_PIXEL_ON_LINE1:
			ADD SI, DI 
			MOV AL, [SI]
			SUB SI,DI 
				
			CMP AL, 102 
			JE SKIP_PRINTING1
			MOV [ES:BX], AL
			SKIP_PRINTING1:
				INC BX 
				INC CX
				DEC	DI 
				CMP CX, [BP + 6]
				JNE NEXT_PIXEL_ON_LINE1
			ADD DI,[BP + 6]
			ADD DI,[BP + 6] 
			
			ADD BX, 320   
			SUB BX, [BP + 6]
			
			INC DX
			CMP DX, [BP + 4]
			JNE NEXT_LINE_OF_CHAR1
			
			POP SI DI DX CX BX AX BP 
			RET 8
ENDP PRINT_IMAGE_MIRRORED
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1.OFFSET IMAGE 2.LOCATION 3.HOW MANY TIMES BIGGER 4.WIDTH 5.LENGTH
PROC BIG_IMAGE
	PUSH BP 
	MOV BP, SP 
	
	PUSH AX BX CX DX SI DI 
	
	MOV SI, [BP + 12]
	MOV DI, 0 
	MOV BX, [BP + 10]
	MOV DX, 0 
	PRINT_NEXT_LINE_OF_BIG_IMAGE:
		MOV CX, 0 
		PRINT_LINE_OF_BIG_PICTUR:
			ADD SI, DI 
			MOV AL, [SI] 
			SUB SI, DI
			
			CMP AL,102 
			JE ORANGE
			MOV AH, 0 
			PUSH BX 
			PUSH [BP + 8]
			PUSH [BP + 8]
			PUSH AX 
			CALL FILLER
			ORANGE:
			
			ADD BX, [BP + 8]
			INC DI
		
			INC CX	
			CMP CX, [BP + 6]
			JNE PRINT_LINE_OF_BIG_PICTUR
		MOV AX, 320   
		PUSH DX 
		MUL  [WORD PTR BP + 8]
		POP DX
		ADD BX, AX 
		
		MOV AX, [BP + 8]
		PUSH DX 
		MUL [WORD PTR BP + 6]
		POP DX
		
		SUB BX, AX 
		
		INC DX
		CMP DX, [BP + 4]
		JNE PRINT_NEXT_LINE_OF_BIG_IMAGE
		
		POP DI SI DX CX BX AX BP 
		RET 10 
ENDP BIG_IMAGE
;///////////////////////////////////////////////
;///////////////////////////////////////////////
;1.TOP LEFT LOCATION 2.LENGTH 3.WIDTH 4.COLOR 
PROC FILLER
	PUSH BP
	MOV BP, SP
	PUSH AX
	PUSH DI
	PUSH DX
	PUSH CX  
	MOV AX,2H 
	INT 33H 
	MOV CX,0 
	MOV DI , [BP+10] ;TOP LEFT LOCATION
		NEXT_LINE:
			MOV DX, 0 
			MOV AX,[BP+4] ;COLOR 
			
			FILL_LINE:
				MOV [ES:DI],AX
				INC DI
				INC DX
			CMP DX,[BP+8] ;LENGTH
			JNE FILL_LINE
			
			;-----------------------
			SUB DI,[BP+8] ;LENGTH
			ADD DI,320					;NEXT LINE
			;-----------------------
			INC CX
		CMP CX,[BP+6] ;WIDTH
		JNE NEXT_LINE
	MOV AX,1H 
	INT 33H
	POP  CX
	POP DX
	POP DI
	POP AX
	POP BP
	RET 8 
ENDP FILLER
;/////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////
;1.TOP_LEFT LOCATION OF BORDER 2.LENGTH 3.WIDTH 4.LOCATION
PROC CHECK_IF_IN_BORDER
;THIS PROC IS CHECKING IF THE LOCATION IS INSITE AN RECTANGLE THAT ITS 
;TOP LEFT CORNER IOS TOP_LEFT LOCATION OF BORDER AND ITS LENGTH 
;AND WIDTH ARE SIMILAR TO WHAT YOU RECIVE FROM THE USER

;----------------GET-------------------;
;BP + 4 - TOP LEFT LOCATION OF BORDER  ;
;BP + 6	- LENGTH					   ;	
;BP + 8 - WIDTH						   ;	
;BP + 10 - LOCATION					   ;	
;--------------------------------------;

;------------RETURN--------------------;
; 1 - IF LOCATION IS IN BORDER         ;
; 0 - IF LOCATION IS NOT IN BORDER     ;
;--------------------------------------;
	PUSH BP
	MOV BP,SP
	PUSH AX
	PUSH DX
	PUSH BX
	PUSH DI 
	PUSH SI 
	
	MOV BX, 320 
	MOV AX, [BP + 4]
	MOV DX, 0 
	DIV BX 
	
	MOV DI,AX ;Y_LOCATION 
	MOV SI,DX ;X_LOCATION 
	
	MOV BX, 320 
	MOV AX, [BP + 10]
	MOV DX, 0 
	DIV BX 
	
	CMP SI, DX
	JB NOT_IN_BORDER
	ADD DX, [BP + 8]
	
	CMP SI, DX 
	JNB NOT_IN_BORDER
	
	CMP DI, AX 
	JB NOT_IN_BORDER
	ADD AX, [BP + 6]
	
	CMP DI, AX
	JNB NOT_IN_BORDER
	
	MOV [WORD PTR BP + 10], 1
	JMP FINISHED_CHECKING_BORDER
	NOT_IN_BORDER:
		MOV [WORD PTR BP + 10], 0 	
	FINISHED_CHECKING_BORDER:
	POP SI DI BX DX AX BP  
	RET 6 
ENDP CHECK_IF_IN_BORDER
;/////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////
;1.TOP_LEFT_LOCATION 2.LENGTH 3.WIDTH 4.MOUSE LOCATION
PROC IS_PRESSING
;THIS PROC IS CHECKING IF 1.THE LOCATION IS IN THE BORDER?, 2.THE MOUSE IS CLICKED?.
;BOTH OF THOSE STATEMENTS HAVE TO OCCUR SO THE PROC WILL RETURN 1 UNLESS THE PROC WILL RETURN 0.

;-------------------------GET---------------------------------;
;BP + 4 - TOP_LEFT_LOCATION 								  ;
;BP + 6 - LENGTH											  ;
;BP + 8 - WIDTH												  ;
;BP + 10 - LOCATION (MOST OF THE TIMES MOUSE LOCATION)   	  ;
;-------------------------------------------------------------;		
	
;---------------------RETUNR----------------------------------;
; 1 - IF THE MOUSE WAS CLICK WHEN IT WAS IN THE BORDER		  ;
; 0 - IF 1 != TRUE                                            ;
;-------------------------------------------------------------;	
	
	PUSH BP
	MOV BP, SP 
	PUSH AX BX 
	
	MOV BX, 0 
	;-----------------------
	PUSH [BP + 10]          
	PUSH [BP + 8]			
	PUSH [BP + 6]			;CHECK IF MOUSE LOCATION IN BORDER 
	PUSH [BP + 4]			
	CALL CHECK_IF_IN_BORDER  
	POP AX 					
	;-----------------------
	CMP AX, 0 
	JE FALSE				;IF NOT RETURN 0 AND FINISH THE PROC  
	;-----------------------
	MOV AX, 3 
	INT 33H 				
	CMP BX, 1 				;IF THE BX != 1 IT MEANS THE USER IS NOT PRESSING ON LEFT CLICK => RETURN 0 AND FINISH THE PROC 
	JNE FALSE				;IF BX = 1 IT MEANS THE USER IS PRESSING ON LEFT CLICK => RETURN 1 AND FINISH THE PROC 
	;-----------------------
	MOV [WORD PTR BP + 10], 1 
	JMP SOF_IS_PRESSING_PROC 
	
	FALSE:
		MOV [WORD PTR BP + 10], 0 
	SOF_IS_PRESSING_PROC:
		POP BX AX BP 
		RET 6 
ENDP IS_PRESSING
;/////////////////////////////////////////////////////////////
;1.MOUSE_LOC
PROC MOUSE_LOCATION
	PUSH BP
	MOV BP,SP
	PUSH AX
	PUSH DX
	PUSH CX
	
	MOV AX,3H 
	INT 33H 
	SHR CX,1 
	MOV AX,320
	MUL DX
	MOV DX,AX
	ADD DX, CX
	MOV [BP+4],DX
	
	POP CX
	POP DX
	POP AX
	POP BP
	RET
ENDP MOUSE_LOCATION
;////////////////////////////////////////////////////////////////
;1.OFFSET FILENAME
PROC DRAW_PIC 
	PUSH BP 
	MOV BP,SP 	
	MOV AX, 02H
	INT 33H
	; PROCESS BMP FILE
	PUSH [FILEHANDLE]
	PUSH [BP+4]
	CALL OPENFILE
	POP [FILEHANDLE]
	CALL READHEADER
	PUSH OFFSET PALETTE
	CALL READPALETTE
	PUSH OFFSET PALETTE
	CALL COPYPAL
	PUSH OFFSET SCRLINE
	CALL COPYBITMAP
	MOV AX, 01H
	INT 33H
	POP BP
	RET 2 
ENDP DRAW_PIC
;///////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////

;///////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////	
;1.OFFSET SAVING ARRAY 2.LOCATION 3.WIDTH 4.LENGTH 
PROC SAVE_TO_DATA
	;THIS PROC IS SAVING THE PIXELS COLORS 
	;INSIDE THE SAVING ARRAY. 
	PUSH BP
	MOV BP,SP 
	PUSH AX BX CX DX SI DI 
	
	MOV SI,[BP + 10]
	MOV DI, 0 
	MOV BX, [BP + 8]
	
	MOV DX, 0 
	SAVE_NEXT_CHAR_LINE:
		MOV CX, 0 
		SAVE_NEXT_PIXEL:
			
			MOV AL,[ES:BX]
					
			ADD SI, DI 
			MOV [SI], AL 
			SUB SI, DI 
			
			INC DI 
			INC BX 
			INC CX
			CMP CX, [BP + 6]
			JNE SAVE_NEXT_PIXEL
		ADD BX, 320 
		SUB BX, [BP + 6]
		
		INC DX 
		CMP DX, [BP + 4]
		JNE SAVE_NEXT_CHAR_LINE
		
		POP DI SI DX CX BX AX BP 
		RET 8	
ENDP SAVE_TO_DATA
;///////////////////////////////////////////////////////////
;1.OFFSET IMAGE 2.LOCATION 3.WIDTH 4.LENGTH 5.OFFSET DATA ARRAY
PROC SAVE_AND_PRINT
	PUSH BP 
	MOV BP,SP  
	;----SAVE-BLOCK-OF-DATA-----;
	PUSH [BP + 4] ;DATA ARRAY 	; 
	PUSH [BP + 10];LOCATION		;  
	PUSH [BP + 8] ;WIDTH		; 
	PUSH [BP + 6] ;LENGTH		; 
	CALL SAVE_TO_DATA 			;
	;---------------------------;
	;-------PRINT-IMAGE---------;
	PUSH [BP + 12];OFFSET IMAGE ;
	PUSH [BP + 10];LOCATION 	;
	PUSH [BP + 8] ;WIDTH		;
	PUSH [BP + 6] ;LENGTH		;
	CALL PRINT_IMAGE			;
	;---------------------------;
	POP BP 
	RET 10 
ENDP SAVE_AND_PRINT
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.CHAR_POS 2.JUMP_NUMBER 3.OFFSET IMAGE 4.OFFSET NEXT_CHAR_POS
PROC PHYSICS
	PUSH BP 
	MOV BP, SP 
	PUSH AX
	
	PUSH [BP + 10]
	PUSH [BP + 8]
	CALL CHECK_IF_IN_AIR
	POP AX
		
	CMP AX, 0
	JE ON_GROUND
	
	
	PUSH [BP + 4]
	PUSH [BP + 10]
	PUSH 35 
	PUSH 50 
	CALL PRINT_IMAGE
	;1.OFFSET IMAGE 2.LOCATION 3.WIDTH 4.LENGTH 5.OFFSET DATA ARRAY
	ADD [WORD PTR BP + 10],  2 * 320 
	
	PUSH [BP + 6]
	PUSH [BP + 10]
	PUSH 35 
	PUSH 50 
	PUSH [BP + 4]
	CALL SAVE_AND_PRINT
	
	ON_GROUND:
		POP AX BP 
		RET 6 
ENDP PHYSICS
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.CHAR_POS 2.JUMP_NUMBER
PROC CHECK_IF_IN_AIR
;THIS PROC IS TAKING 35 PIXELS UNDER THE 
;CHARACTER LOWEST LINE AND COMPERING EACH OF THE TO 
;THE BORDER COLOR 
	
;------GET--------;
;BP + 4 - JUMP_NUMBER;
;BP + 6 - CHAR_POS;
;-----------------;

;-----RETURN------;
;1 - IF IN AIR 	  ;
;0 - IF NOT IN AIR;
;-----------------;	
	PUSH BP 
	MOV BP, SP 
	PUSH AX BX CX DX   
	
	MOV AX, [BP + 6]
	ADD AX, 51 * 320 
	MOV CX, 320   
	MOV BX, 200 * 320 
	
	CHECK_IF_ON_FLOOR:
		CMP AX, BX 
		JE ON_FLOOR
		INC BX 
	LOOP CHECK_IF_ON_FLOOR
	
	MOV CX, 35 
	
	CHECK_IF_ON_OBSTACLE:
		MOV BX, AX 
		MOV DL, [ES:BX]
		CMP DL, 13 
		JE ON_FLOOR
		INC AX 
	LOOP CHECK_IF_ON_OBSTACLE
		
		CMP [WORD PTR BP + 4], 0 
		JNE ON_FLOOR
		
		MOV [WORD PTR BP + 6], 1 
		JMP FINISH_CHECKING_AIR
	ON_FLOOR:
		MOV [WORD PTR BP + 6], 0  
	FINISH_CHECKING_AIR:
		POP DX CX BX AX BP 
		RET 2 
ENDP CHECK_IF_IN_AIR
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.OB1_LENGTH 2.OB2_LENGTH 3.OB3_LENGTH 4.OFFSET OB1 5.OFFSET OB2 6.OFFSET OB3 7.OB1_LOCATION 8.OB2_LOCATION 9.OB3_LOCATION 10.USER_LAST_KEY_USED 
PROC CREATE_THREE_OBSTACLES
	
;---GET---------------;
;OB1_LENGTH - BP + 22
;OB2_LENGTH - BP + 20
;OB3_LENGTH - BP + 18 
;OFFSET OB1 - BP + 16 
;OFFSET OB2 - BP + 14 
;OFFSET OB3 - BP + 12 
;OB1_LOCATION - BP + 10 
;OB2_LOCATION - BP + 8
;OB3_LOCATION - BP + 6
;USER_LAST_KEY_USED - BP + 4
;-----------------------------;
	
;--------RETURN--------------;
;1.OB3_LOCATION
;2.OB2_LOCATION
;3.OB1_LOCATION
;4.OB3_LENGTH
;5.OB2_LENGTH
;6.OB1_LENGTH
;----------------------------;	
	
	PUSH BP 
	MOV BP,SP 
	PUSH AX BX CX DX 
	;1. MIN BORDER 2.MAX BORDER (MAXIMUM NUMBER CAN BE 255) 3.USER_LAST_KEY_USED
	;-------LENGTH----------;
	PUSH 10 
	PUSH 119 
	PUSH [BP + 4]
	CALL RANDOM_NUMBER_IN_BORDER
	POP DX 
	;-----------------------;
	MOV [BP + 22], DX 
	MOV [BP + 20], DX 
	MOV [BP + 18], DX 
	;-----------------------;
	MOV BX, 320 
	SUB BX, DX 
	;-------LOCATION--------;
	PUSH 0 
	PUSH BX 
	PUSH [BP + 4]
	CALL RANDOM_NUMBER_IN_BORDER
	POP BX  
	;-----------------------;
	
	
	;1.OFFSET SAVING ARRAY 2.LOCATION 3.WIDTH 4.LENGTH 
	
	ADD BX , 20 * 320 
	;-------SAVE AND PRINT OB1------;
	MOV [BP + 10], BX
	
	PUSH [BP + 16] ;OFFSET OB1 
	PUSH [BP + 10] ;OB1_LOCATION
	PUSH 120 
	PUSH 4 
	CALL SAVE_TO_DATA
	
	PUSH [BP + 10]
	PUSH DX 
	PUSH 4 
	PUSH 13 
	CALL FILLER 
	;---------------------------------;
	ADD BX, 80 * 320 
	;-------SAVE AND PRINT OB2--------;
	MOV [BP + 8], BX 
	PUSH [BP + 14]
	PUSH [BP + 8]
	PUSH 120 
	PUSH 4 
	CALL SAVE_TO_DATA
	
	PUSH [BP + 8]
	PUSH DX 
	PUSH 4 
	PUSH 13 
	CALL FILLER 
	;---------------------------------;
	ADD BX, 80 * 320 
	;-------SAVE AND PRINT OB3--------;
	MOV [BP + 6], BX 
	
	PUSH [BP + 12]
	PUSH [BP + 6]
	PUSH 120 
	PUSH 4 
	CALL SAVE_TO_DATA
	
	PUSH [BP + 6]
	PUSH DX 
	PUSH 4 
	PUSH 13 
	CALL FILLER 
	;---------------------------------;
	MOV AX, [BP + 10]
	MOV [BP + 16], AX 
	MOV AX, [BP + 8]
	MOV [BP + 14], AX 
	MOV AX, [BP + 6]
	MOV [BP + 12],AX
	
	POP DX CX BX AX BP 
	RET 8 
ENDP CREATE_THREE_OBSTACLES
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.OB1_LOCATION 2.OB1_LENGTH 3.CHAR_POS 4.USER_LAST_KEY_USED
PROC GENERATE_FOR_OB
	;---------GET---------------
	;BP + 10 - OB1_LOCATION
	;BP + 8 - OB1_LENGTH
	;BP + 6 - CHAR_POS
	;BP + 4 - USER_LAST_KEY_USED
	;---------------------------
	;--------RETURN-------------
	;1.OB1_LENGTH
	;2.OB1_LOCATION
	;---------------------------	
	PUSH BP 
	MOV BP,SP 
	PUSH AX BX DX		
	
	CMP [WORD PTR BP + 10], 190 * 320 
	JNA READY_OB
	
	PUSH 30 					 
	PUSH 119 
	PUSH [BP + 4]		;GENERATE LENGTH
	CALL RANDOM_NUMBER_IN_BORDER
	POP [BP + 8]
	
	MOV AX, 320 
	SUB AX, [BP + 8]		
	
	PUSH 0 
	PUSH AX 
	PUSH [BP + 4]
	CALL RANDOM_NUMBER_IN_BORDER		;GENERATE LOCATION 
	POP [BP + 10]
	

	MOV BX, 320 
	MOV AX, [BP + 6] ;CHAR LOCATION
	MOV DX, 0 							
	DIV BX 
	MOV BX, DX 
		
		CMP BX,[BP + 10] 
		JNE CONTINUE_OB	;IF CHAR_LOC NOT EQUAL TO OB LOC 
		ADD [WORD PTR BP + 10], 1 
		JMP READY_OB
		CONTINUE_OB: ;CHAR LOC != OB_LOC
		CMP BX, [BP + 10]
		JA CHAR_GADOL_OB
		CHAR_KATAN_OB:
			XOR DX, [BP + 10]
			XOR [BP + 10], DX 
			XOR DX,[BP + 10]
			
			SUB DX, [BP + 10]
			CMP DX, 80  
			JNA READY_OB
			SUB [WORD PTR BP + 10], 80 
			MOV DX, BX 
			JMP CHAR_KATAN_OB
		CHAR_GADOL_OB:
			SUB DX, [BP + 10]
			CMP DX, 80
			JNA READY_OB
			ADD [WORD PTR BP + 10], 80  
			MOV DX, BX 
			JMP CHAR_GADOL_OB
			READY_OB:
		
		POP DX BX AX BP 
		RET 4  
ENDP GENERATE_FOR_OB
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.CHAR_POS 2.OB1_LOCATION 3.OB2_LOCATION 4.OB3_LOCATION 5.OFFSET NEXT_CHAR_POS 6.OFFSET OB1 7.OFFSET OB2 
;8.OFFSET OB3 9.OB1_LENGTH 10.OB2_LENGTH 11.OB3_LENGTH 12.HOW_MANY_PIXELS 
 
PROC MOVE_OBSTACLES
	
	;--------------GET--------------;
	;BP + 28 - USER_LAST_KEY_USED 	;
	;BP + 26 - CHAR_POS				;
	;BP + 24 - OB1_LOCATION			;
	;BP + 22 - OB2_LOCATION			;
	;BP + 20 - OB3_LOCATION 		;
	;BP + 18 - OFFSET NEXT_CHAR_POS	;
	;BP + 16 - OFFSET OB1 			;
	;BP + 14 - OFFSET OB2 			;
	;BP + 12 - OFFSET OB3 			;
	;BP + 10 - OB1_LENGTH 			;
	;BP + 8 - OB2_LENGTH			;
	;BP + 6 - OB3_LENGTH 			;
	;BP + 4 - HOW_MANY_PIXELS		;
	;-------------------------------;
	
	;------------RETURN-------------;
	;1.OB3_LOCATION					;
	;2.OB2_LOCATION					;
	;3.OB1_LOCATION					;
	;4.OB3_LENGTH					;
	;5.OB2_LENGTH					;
	;6.OB3_LENGTH					;
	;-------------------------------;
	PUSH BP 
	MOV BP, SP 
	PUSH AX 
	
	MOV AX, [BP + 4] ;HOW_MANY_PIXELS
	
	;=========OB1===========
		PUSH [BP + 16] ;OFFSET OB1 
		PUSH [BP + 24] ;OB1_LOCATION
		PUSH 120
		PUSH 4 
		CALL PRINT_IMAGE
		
		PUSH [BP + 26] ;CHAR_POS
		PUSH [BP + 24] ;OB1_LOCATION
		PUSH [BP + 22] ;OB2_LOCATION
		PUSH [BP + 20] ;OB3_LOCATION
		PUSH [BP + 18] ;OFFSET NEXT_CHAR_POS
		PUSH [BP + 16] ;OFFSET OB1 
		PUSH [BP + 14] ;OFFSET OB2 
		PUSH [BP + 12] ;OFFSET OB3 
		ADD [BP + 24], AX    
		
		PUSH [BP + 24]
		PUSH [BP + 10]
		PUSH [BP + 26]
		PUSH [BP + 28]
		CALL GENERATE_FOR_OB
		POP [BP + 10]
		POP [BP + 24]
		
		PUSH [BP + 16] ;OFFSET OB1 		
		PUSH [BP + 24] ;NEW OB1_LOCATION 
		PUSH 120 
		PUSH 4 
		CALL SAVE_ORIGINAL_BACKROUND
			
		PUSH [BP + 24]
		PUSH [BP + 10]
		PUSH 4 
		PUSH 13 
		CALL FILLER 
	;=======================
	
	;=========OB2===========
		PUSH [BP + 14] ;OFFSET OB2 
		PUSH [BP + 22] ;OB2_LOCATION
		PUSH 120
		PUSH 4 
		CALL PRINT_IMAGE
		
		PUSH [BP + 26] ;CHAR_POS
		PUSH [BP + 24] ;OB1_LOCATION
		PUSH [BP + 22] ;OB2_LOCATION
		PUSH [BP + 20] ;OB3_LOCATION
		PUSH [BP + 18] ;OFFSET NEXT_CHAR_POS
		PUSH [BP + 16] ;OFFSET OB1 
		PUSH [BP + 14] ;OFFSET OB2 
		PUSH [BP + 12] ;OFFSET OB3 
		ADD [BP + 22], AX   
		
		PUSH [BP + 22]
		PUSH [BP + 8]
		PUSH [BP + 26]
		PUSH [BP + 28]
		CALL GENERATE_FOR_OB
		POP [BP + 8]
		POP [BP + 22]
		
		PUSH [BP + 14] ;OFFSET OB2 		
		PUSH [BP + 22] ;NEW OB2_LOCATION 
		PUSH 120 
		PUSH 4 
		CALL SAVE_ORIGINAL_BACKROUND
			
		PUSH [BP + 22]
		PUSH [BP + 8]
		PUSH 4 
		PUSH 13 
		CALL FILLER 
	;=======================
	
	;=========OB3===========
		PUSH [BP + 12] ;OFFSET OB3 
		PUSH [BP + 20] ;OB3_LOCATION
		PUSH 120
		PUSH 4 
		CALL PRINT_IMAGE
		
		PUSH [BP + 26] ;CHAR_POS
		PUSH [BP + 24] ;OB1_LOCATION
		PUSH [BP + 22] ;OB2_LOCATION
		PUSH [BP + 20] ;OB3_LOCATION
		PUSH [BP + 18] ;OFFSET NEXT_CHAR_POS
		PUSH [BP + 16] ;OFFSET OB1 
		PUSH [BP + 14] ;OFFSET OB2 
		PUSH [BP + 12] ;OFFSET OB3 
		ADD [BP + 20], AX   
		
		PUSH [BP + 20]
		PUSH [BP + 6]
		PUSH [BP + 26]
		PUSH [BP + 28]
		CALL GENERATE_FOR_OB
		POP [BP + 6]
		POP [BP + 20]
		
		PUSH [BP + 12] ;OFFSET OB3 		
		PUSH [BP + 20] ;NEW OB3_LOCATION 
		PUSH 120 
		PUSH 4 
		CALL SAVE_ORIGINAL_BACKROUND
			
		PUSH [BP + 20]
		PUSH [BP + 6]
		PUSH 4 
		PUSH 13 
		CALL FILLER 
	;=======================
	
			;--------------GET--------------;
	;BP + 28 - USER_LAST_KEY_USED 	;
	;BP + 26 - CHAR_POS				;
	;BP + 24 - OB1_LOCATION			;
	;BP + 22 - OB2_LOCATION			;
	;BP + 20 - OB3_LOCATION 		;
	;BP + 18 - OFFSET NEXT_CHAR_POS	;
	;BP + 16 - OFFSET OB1 			;
	;BP + 14 - OFFSET OB2 			;
	;BP + 12 - OFFSET OB3 			;
	;BP + 10 - OB1_LENGTH 			;
	;BP + 8 - OB2_LENGTH			;
	;BP + 6 - OB3_LENGTH 			;
	;BP + 4 - HOW_MANY_PIXELS		;
	;-------------------------------;
	
	;------------RETURN-------------;
	;1.OB3_LOCATION					;
	;2.OB2_LOCATION					;
	;3.OB1_LOCATION					;
	;4.OB3_LENGTH					;
	;5.OB2_LENGTH					;
	;6.OB3_LENGTH					;
	;-------------------------------;
	MOV AX, [BP + 24]
	MOV [BP + 28], AX 
	MOV AX, [BP + 22]
	MOV [BP + 26], AX 
	MOV AX, [BP + 20]
	MOV [BP + 24], AX 
	MOV AX, [BP + 10]
	MOV [BP + 22], AX 
	MOV AX,[BP + 8]
	MOV [BP + 20], AX 
	MOV AX, [BP + 6]
	MOV [BP + 18], AX 

	POP AX BP 
	RET 14 
ENDP MOVE_OBSTACLES
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.CHAR_POS 2.OB1_LOCATION 3.OB2_LOCATION 4.OB3_LOCATION 5.OFFSET NEXT_CHAR_POS 6.OFFSET OB1 7.OFFSET OB2 
;8.OFFSET OB3 9.OFFSET SAVING ARRAY 10.LOCATION 11.WIDTH 12.LENGTH 
PROC SAVE_ORIGINAL_BACKROUND
	;THIS PROC IS SAVING THE PIXELS COLORS 
	;INSIDE THE SAVING ARRAY. 
	;--------------GET--------------;
	;BP + 26 - CHAR_POS				;
	;BP + 24 - OB1_LOCATION			;
	;BP + 22 - OB2_LOCATION			;
	;BP + 20 - OB3_LOCATION 		;
	;BP + 18 - OFFSET NEXT_CHAR_POS	;
	;BP + 16 - OFFSET OB1 			;
	;BP + 14 - OFFSET OB2 			;
	;BP + 12 - OFFSET OB3 			;
	;BP + 10 - OFFSET SAVING ARRAY 	;
	;BP + 8 - LOCATION				;
	;BP + 6 - WIDTH 				;
	;BP + 4 - LENGTH				;
	;-------------------------------;
	
	PUSH BP
	MOV BP,SP 
	PUSH AX BX CX DX SI DI 
	
	MOV SI,[BP + 10] ;OFFSET SAVING ARRAY 
	MOV DI, 0 
	MOV BX, [BP + 8] ;LOCATION 
	
	MOV DX, 0 
	SAVE_NEXT_CHAR_LINE1:
		MOV CX, 0 
		SAVE_NEXT_PIXEL1:
			
			
			PUSH [BP + 26] ;CHAR_POS
			PUSH [BP + 24] ;OB1_LOCATION 
			PUSH [BP + 22] ;OB2_LOCATION
			PUSH [BP + 20] ;OB3_LOCATION
			PUSH [BP + 18] ;OFFSET NEXT_CHAR_POS
			PUSH [BP + 16] ;OFFSET OB1
			PUSH [BP + 14] ;OFFSET OB2 
			PUSH [BP + 12] ;OFFSET OB3 
			PUSH BX ;NEW LOCATION 
			CALL SAVE_ORIGINAL_PIXEL
			POP AX 
			MOV AH, 0 
			
			ADD SI, DI 
			MOV [SI], AL 
			SUB SI, DI 
			
			INC DI 
			INC BX 
			INC CX
			CMP CX, [BP + 6]
			JNE SAVE_NEXT_PIXEL1
		ADD BX, 320 
		SUB BX, [BP + 6]
		
		INC DX 
		CMP DX, [BP + 4]
		JNE SAVE_NEXT_CHAR_LINE1
		
		POP DI SI DX CX BX AX BP 
		RET 24 
ENDP SAVE_ORIGINAL_BACKROUND
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.CHAR_POS 2.OB1_LOCATION 3.OB2_LOCATION 4.OB3_LOCATION 5.OFFSET NEXT_CHAR_POS 6.OFFSET OB1 7.OFFSET OB2 
;8.OFFSET OB3 9.LOCATION
PROC SAVE_ORIGINAL_PIXEL
	PUSH BP
	MOV BP, SP 
	PUSH AX DI   
;-------------GET---------------;	
;BP + 20 - CHAR_POS				;
;BP + 18 - OB1_LOCATION			;
;BP + 16 - OB2_LOCATION			;
;BP + 14 - OB3_LOCATION			;
;BP + 12 - OFFSET NEXT_CHAR_POS	;
;BP + 10 - OFFSET OB1 			;
;BP + 8 - OFFSET OB2 			;
;BP + 6 - OFFSET OB3 			;
;BP + 4 - LOCATION 				;
;-------------------------------;	
 
;-----------RETURN--------------;
;ORIGINAL BACKROUND PIXEL_COLOR	;
;-------------------------------;	
	PUSH [BP + 20] ;CHAR_POS
	PUSH 35 
	PUSH 50 
	PUSH [BP + 4]
	CALL CHECK_IF_IN_BORDER
	POP AX 
	
	CMP AX, 0 
	JE CHECK_OB1
		PUSH [BP + 20]
		PUSH 35 
		PUSH [BP + 4]
		CALL INCREASE_IN_BORDER
		POP DI 
		
		ADD DI,[BP + 12];OFFSET CHAR 		;CHAR
		MOV AL, [DI]
		MOV AH, 0  
		JMP FINISH_SAVE_ORIGINAL
	CHECK_OB1:
		PUSH [BP + 18]
		PUSH 120 
		PUSH 4 			
		PUSH [BP + 4]
		CALL CHECK_IF_IN_BORDER
		POP AX 
		
		CMP AX, 0 
		JE CHECK_OB2 
		PUSH [BP + 18]
		PUSH 120 
		PUSH [BP + 4]
		CALL INCREASE_IN_BORDER
		POP DI 
		
		ADD DI, [BP + 10] ;OB1 
		MOV AL,[DI]
		MOV AH, 0 
		JMP FINISH_SAVE_ORIGINAL
		CHECK_OB2:
			PUSH [BP + 16]
			PUSH 120 
			PUSH 4 
			PUSH [BP + 4]
			CALL CHECK_IF_IN_BORDER
			POP AX 
			
			CMP AX, 0 
			JE CHECK_OB3
			PUSH [BP + 16]
			PUSH 120 
			PUSH [BP + 4]
			CALL INCREASE_IN_BORDER
			POP DI 
			
			ADD DI,[BP + 8] 
			MOV AL,[DI]
			MOV AH, 0 
			JMP FINISH_SAVE_ORIGINAL
			CHECK_OB3:
				PUSH [BP + 14]
				PUSH 120 
				PUSH 4 
				PUSH [BP + 4]
				CALL CHECK_IF_IN_BORDER
				POP AX 
		
				CMP AX, 0
				JE NOT_IN_ANY_BORDER
				PUSH [BP + 14]
				PUSH 120 
				PUSH [BP + 4]
				CALL INCREASE_IN_BORDER
				POP DI 
				
				ADD DI,[BP + 6] 
				MOV AL,[DI]
				MOV AH, 0 
				JMP FINISH_SAVE_ORIGINAL
				NOT_IN_ANY_BORDER:
					MOV DI,[BP + 4]
					MOV AL, [ES:DI]
					MOV AH, 0 
					FINISH_SAVE_ORIGINAL:
						MOV [BP + 20], AX 
						POP DI AX BP 
						RET 16 
ENDP SAVE_ORIGINAL_PIXEL
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
;1.FIRST VALUE 2.WIDTH 3.GOAL VALUE 
PROC INCREASE_IN_BORDER
	;THIS PROC RETURNS THE NUMBER OF PIXELS 
	;THAT NEED TO BE ADDED INSIDE A BORDER TO REACH ANOTHER VALUE. 
	;FIRST VALUE < GOAL VALUE
	;EX: |--------|
	;	 |-*++++++|
	; 	 |++++++++|
	;	 |+++++*--|
	;	 |--------|  	
	PUSH BP 
	MOV BP,SP 
	PUSH AX BX CX DX 
	MOV DX, 0 
	MOV CX, 0 
	MOV BX, [BP + 8]
	
	COUNT_IN_BORDER:
		CMP BX, [BP + 4]
		JE FINISH_INCREASE_IN_BORDER
		INC DX 
		INC BX
		INC CX 
		CMP CX, [BP + 6]
		JNE COUNT_IN_BORDER
	
		SUB BX, [BP + 6]
		ADD BX, 320 
		MOV CX, 0 
		JMP COUNT_IN_BORDER
	
		FINISH_INCREASE_IN_BORDER:
			MOV [BP + 8], DX 
			POP DX CX BX AX BP 
			RET 4 
ENDP INCREASE_IN_BORDER
;////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////
PROC CHANGE_HANDLER
    XOR     AX, AX
    MOV     ES, AX
    CLI                              ; INTERRUPTS DISABLED
    PUSH    [WORD PTR ES:9*4+2]      ; SAVE OLD KEYBOARD (9) ISR ADDRESS - INTERRUPT SERVICE ROUTINE(ISR)
    PUSH    [WORD PTR ES:9*4]
	                                 ; PUT MY KEYBOARD (9) ISR ADDRESS: PROCEDURE 	
    MOV     [WORD PTR ES:9*4], OFFSET MY_ISR
	                                 ; PUT CS IN ISR ADDRESS
    MOV     [ES:9*4+2],        CS
    STI                               ; INTERRUPTS ENABLED

    CALL    MY_PROGRAM                     ; PROGRAM THAT USE THE INTERRUPT  LINES 43 - 83

    CLI                               ; INTERRUPTS DISABLED
    POP     [WORD PTR ES:9*4]         ; RESTORE ISR ADDRESS
    POP     [WORD PTR ES:9*4+2]
    STI                               ; INTERRUPTS ENABLED

    RET
ENDP CHANGE_HANDLER
;///////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////
;1.OFFSET OB1 2.OFFSET OB2 3.OFFSET OB3 4.OB1_LOCATION 5.OB2_LOCATION 6.OB3_LOCATION 

PROC DELETE_ALL_OBSTACLES
	PUSH BP 
	MOV BP, SP 

;BP + 4 - OB3_LOCATION
;BP + 6 - OB2_LOCATION
;BP + 8 - OB1_LOCATION
;BP + 10 - OFFSET OB3
;BP + 12 - OFFSET OB2
;BP + 14 - OFFSET OB1 

PUSH [BP + 14]
PUSH [BP + 8]
PUSH 120 
PUSH 4 
CALL PRINT_IMAGE

PUSH [BP + 12]
PUSH [BP + 6]
PUSH 120 
PUSH 4 
CALL PRINT_IMAGE

PUSH [BP + 10]
PUSH [BP + 4]
PUSH 120 
PUSH 4 
CALL PRINT_IMAGE

POP BP 
RET 12 
ENDP DELETE_ALL_OBSTACLES
;///////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////
;1.OFFSET OB1 2.OFFSET OB2 3.OFFSET OB3 4.OB1_LOCATION 5.OB2_LOCATION 6.OB3_LOCATION 
;7.OB1_LENGTH 8.OB2_LENGTH 9.OB3_LENGTH
PROC PRINT_ALL_OBSTACLES
	PUSH BP 
	MOV BP,SP 
	;BP + 4 - OB3_LENGTH
	;BP + 6 - OB2_LENGTH
	;BP + 8 - OB1_LENGTH
	;BP + 10 - OB3_LOCATION
;BP + 12 - OB2_LOCATION
;BP + 14 - OB1_LOCATION
;BP + 16 - OFFSET OB3
;BP + 18 - OFFSET OB2
;BP + 20 - OFFSET OB1 
	
	
	;1.OFFSET SAVING ARRAY 2.LOCATION 3.WIDTH 4.LENGTH 
	PUSH [BP + 20]
	PUSH [BP + 14]
	PUSH 120 
	PUSH 4 
	CALL SAVE_TO_DATA
	
	PUSH [BP + 18]
	PUSH [BP + 12]
	PUSH 120 
	PUSH 4 
	CALL SAVE_TO_DATA
	
	PUSH [BP + 16]
	PUSH [BP + 10]
	PUSH 120 
	PUSH 4 
	CALL SAVE_TO_DATA
	
	PUSH [BP + 14]
	PUSH [BP + 8]
	PUSH 4 
	PUSH 13 
	CALL FILLER 
	
	PUSH [BP + 12]
	PUSH [BP + 6]
	PUSH 4 
	PUSH 13
	CALL FILLER 
	
	PUSH [BP + 10]
	PUSH [BP + 4]
	PUSH 4 
	PUSH 13 
	CALL FILLER 
	
	POP BP 
	RET 18 
ENDP PRINT_ALL_OBSTACLES
;///////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////
;OB1_LENGTH OB2_LENGTH OB3_LENGTH 1.OB1_LOCATION 2.OB2_LOCATION 3.OB3_LOCATION 4.OFFSET OB1 5.OFFSET OB2 
;6.OFFSET OB3 7.CHAR_POS 8.OFFSET IMAGE 9.WIDTH 10.LENGTH 11.OFFSET NEXT_CHAR_POS
PROC _A
;KEYBIND
;-------------GET---------------;
;BP + 4 - OFFSET NEXT_CHAR_POS 	;
;BP + 6 - LENGTH			   	;
;BP + 8 - WIDTH			       	;
;BP + 10 - OFFSET IMAGE  	   	;
;BP + 12 - CHAR_POS		 		;
;BP + 14 - OFFSET OB3 			;
;BP + 16 - OFFSET OB2 			;
;BP + 18 - OFFSET OB1 			;
;BP + 20 - OB3_LOCATION			;
;BP + 22 - OB2_LOCATION			;
;BP + 24 - OB1_LOCATION			;
;BP + 26 - OB3_LENGTH			;
;BP + 28 - OB2_LENGTH			;
;BP + 30 - OB1_LENGTH	 		;
;-------------------------------;

;-----------RETURN--------------;
;1.CHAR_POS		   			    ;		
;-------------------------------;	
	PUSH BP 
	MOV BP,SP 
	PUSH AX 
	
	PUSH [BP + 4]
	PUSH [BP + 12]
	PUSH 35
	PUSH 50 
	CALL PRINT_IMAGE
	;1.OFFSET OB1 2.OFFSET OB2 3.OFFSET OB3 4.OB1_LOCATION 5.OB2_LOCATION 6.OB3_LOCATION 
	PUSH [BP + 18]
	PUSH [BP + 16]
	PUSH [BP + 14]
	PUSH [BP + 24]
	PUSH [BP + 22]
	PUSH [BP + 20]
	CALL DELETE_ALL_OBSTACLES
	
	SUB [WORD PTR BP + 12], 4
	PUSH [BP + 4]
	PUSH [BP + 12]
	PUSH 35
	PUSH 50 
	CALL SAVE_TO_DATA
	
	PUSH [BP + 18]
	PUSH [BP + 16]
	PUSH [BP + 14]
	PUSH [BP + 24]
	PUSH [BP + 22]
	PUSH [BP + 20]
	PUSH [BP + 30]
	PUSH [BP + 28]
	PUSH [BP + 26]
	CALL PRINT_ALL_OBSTACLES
	
	PUSH [BP + 10]
	PUSH [BP + 12]
	PUSH [BP + 8]
	PUSH [BP + 6]
	CALL PRINT_IMAGE_MIRRORED
	MOV AX, [BP + 12]
	MOV [BP + 30], AX
	
	POP AX BP 
	RET 26 
ENDP _A
;///////////////////////////////////////////////////////////////////////////////////////////////
;1.CHAR_POS 2.OFFSET IMAGE 3.WIDTH 4.LENGTH 5.OFFSET NEXT_CHAR_POS
PROC _D
;KEYBIND
;-------------GET---------------;
;BP + 4 - OFFSET NEXT_CHAR_POS  ;
;BP + 6 - LENGTH			    ;
;BP + 8 - WIDTH			        ;
;BP + 10 - OFFSET IMAGE  	    ;
;BP + 12 - CHAR_POS		 		;
;BP + 14 - OFFSET OB3 			;
;BP + 16 - OFFSET OB2 			;
;BP + 18 - OFFSET OB1 			;
;BP + 20 - OB3_LOCATION			;
;BP + 22 - OB2_LOCATION			;
;BP + 24 - OB1_LOCATION			;
;BP + 26 - OB3_LENGTH			;
;BP + 28 - OB2_LENGTH			;
;BP + 30 - OB1_LENGTH	 		;
;-----------RETURN--------------;
;1.CHAR_POS		   			   ;		
;------------------------------;	
	PUSH BP 
	MOV BP,SP 
	PUSH AX 
	
	PUSH [BP + 4]
	PUSH [BP + 12]
	PUSH 35
	PUSH 50 
	CALL PRINT_IMAGE
	;1.OFFSET OB1 2.OFFSET OB2 3.OFFSET OB3 4.OB1_LOCATION 5.OB2_LOCATION 6.OB3_LOCATION 
	PUSH [BP + 18]
	PUSH [BP + 16]
	PUSH [BP + 14]
	PUSH [BP + 24]
	PUSH [BP + 22]
	PUSH [BP + 20]
	CALL DELETE_ALL_OBSTACLES
	
	ADD [WORD PTR BP + 12], 4
	PUSH [BP + 4]
	PUSH [BP + 12]
	PUSH 35
	PUSH 50 
	CALL SAVE_TO_DATA
	
	PUSH [BP + 18]
	PUSH [BP + 16]
	PUSH [BP + 14]
	PUSH [BP + 24]
	PUSH [BP + 22]
	PUSH [BP + 20]
	PUSH [BP + 30]
	PUSH [BP + 28]
	PUSH [BP + 26]
	CALL PRINT_ALL_OBSTACLES
	
	PUSH [BP + 10]
	PUSH [BP + 12]
	PUSH [BP + 8]
	PUSH [BP + 6]
	CALL PRINT_IMAGE 
	MOV AX, [BP + 12]
	MOV [BP + 30], AX 
	
	POP AX BP 
	RET 26 
ENDP _D
;///////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////////

;1.OB1_LENGTH 2.OB2_LENGTH 3.OB3_LENGTH 4.OB1_LOCATION 5.OB2_LOCATION 6.OB3_LOCATION 7.OFFSET OB1 8.OFFSET OB2 
;9.OFFSET OB3 =+1.CHAR_POS 2.JUMP_NUMBER 3.OFFSET JUMPING 4.OFFSET NEXT_CHAR_POS
PROC _SPACE
	PUSH BP 
	MOV BP,SP
	PUSH AX 
	;BP + 4 - OFFSET NEXT_CHAR_POS
	;BP + 6 - OFFSET JUMPING
	;BP + 8 - JUMP_NUMBER
	;BP + 10 - CHAR_POS
	;BP + 12 - OFFSET OB3
	;BP + 14 - OFFSET OB2 
	;BP + 16 - OFFSET OB1 
	;BP + 18 - OB3_LOCATION
	;BP + 20 - OB2_LOCATION
	;BP + 22 - OB1_LOCATION
	;BP + 24 - OB3_LENGTH
	;BP + 26 - OB2_LENGTH
	;BP + 28 - OB1_LENGTH
	
	;1.OB1_LENGTH 2.OB2_LENGTH 3.OB3_LENGTH 4.OB1_LOCATION 5.OB2_LOCATION 6.OB3_LOCATION 7.OFFSET OB1 8.OFFSET OB2 
;9.OFFSET OB3 10.CHAR_POS 11.OFFSET IMGAE 12.OFFSET NEXT_CHAR_POS
	PUSH [BP + 28]
	PUSH [BP + 26]
	PUSH [BP + 24]
	PUSH [BP + 22]
	PUSH [BP + 20]
	PUSH [BP + 18]
	PUSH [BP + 16]
	PUSH [BP + 14]
	PUSH [BP + 12]
	PUSH [BP + 10]
	PUSH [BP + 6]
	PUSH [BP + 4]
	CALL JUMP_UP
	POP [BP + 10]
	
	INC [WORD PTR BP + 8]
	
	PUSH [BP + 8]
	PUSH 0 
	PUSH 20 
	CALL CHANGE_VALUE_IF
	POP [BP + 8]
	
	MOV AX, [BP + 10]
	MOV [BP + 28], AX 
	MOV AX, [BP + 8]
	MOV [BP + 26], AX 
	
	POP AX BP 
	RET 22 
ENDP _SPACE
;///////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////
;1.OB1_LENGTH 2.OB2_LENGTH 3.OB3_LENGTH 4.OB1_LOCATION 5.OB2_LOCATION 6.OB3_LOCATION 7.OFFSET OB1 8.OFFSET OB2 
;9.OFFSET OB3 10.CHAR_POS 11.OFFSET IMGAE 12.OFFSET NEXT_CHAR_POS
PROC JUMP_UP
	PUSH BP 
	MOV BP,SP
	PUSH AX 
	;BP + 4 - OFFSET NEXT_CHAR_POS
	;BP + 6 - OFFSET IMAGE 
	;BP + 8 - CHAR_POS
	;BP + 10 - OFFSET OB3 
	;BP + 12 - OFFSET OB2 
	;BP + 14 - OFFSET OB1 
	;BP + 16 - OB3_LOCATION
	;BP + 18 - OB2_LOCATION
	;BP + 20 - OB1_LOCATION
	;BP + 22 - OB3_LENGTH
	;BP + 24 - OB2_LENGTH
	;BP + 26 - OB1_LENGTH
	
	PUSH [BP + 4]
	PUSH [BP + 8]
	PUSH 35 
	PUSH 50 
	CALL PRINT_IMAGE
	
	;1.OFFSET OB1 2.OFFSET OB2 3.OFFSET OB3 4.OB1_LOCATION 5.OB2_LOCATION 6.OB3_LOCATION 
	PUSH [BP + 14]
	PUSH [BP + 12]
	PUSH [BP + 10]
	PUSH [BP + 20]
	PUSH [BP + 18]
	PUSH [BP + 16]
	CALL DELETE_ALL_OBSTACLES
	
	CMP [WORD PTR BP + 8], 4 * 320 
	JNA CANT_JUMP
	SUB [WORD PTR BP + 8], 4 * 320 
	CANT_JUMP:
	PUSH [BP + 4]
	PUSH [BP + 8]
	PUSH 35 
	PUSH 50 
	CALL SAVE_TO_DATA
	
;1.OFFSET OB1 2.OFFSET OB2 3.OFFSET OB3 4.OB1_LOCATION 5.OB2_LOCATION 6.OB3_LOCATION 
;7.OB1_LENGTH 8.OB2_LENGTH 9.OB3_LENGTH
	PUSH [BP + 14]
	PUSH [BP + 12]
	PUSH [BP + 10]
	PUSH [BP + 20]
	PUSH [BP + 18]
	PUSH [BP + 16]
	PUSH [BP + 26]
	PUSH [BP + 24]
	PUSH [BP + 22]
	CALL PRINT_ALL_OBSTACLES
	
	PUSH [BP + 6]
	PUSH [BP + 8]
	PUSH 35 
	PUSH 50 
	CALL PRINT_IMAGE
	MOV AX, [BP + 8]
	MOV [BP + 26], AX 
	
	POP AX BP 
	RET 22 
ENDP JUMP_UP
;/////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////

;/////////////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////////////////////////////
PROC MY_ISR               
 ; MY ISR FOR KEYBOARD   
	PUSH    AX
	PUSH    BX
    PUSH    CX
    PUSH    DX
	PUSH    DI
	PUSH    SI
                        ; READ KEYBOARD SCAN CODE
    IN      AL, 60H
	
						; UPDATE KEYBOARD STATE
    XOR     BH, BH
    MOV     BL, AL
    AND     BL, 7FH     ; BX = SCAN CODE
	
	CMP BL, 20H        ; IF CLICK ON D (INDEX 0 IN ARRAY MINI_BUFF)
	JNE CHECK1
	MOV BL,0
	JMP END_CHECK
CHECK1:
	CMP BL, 1EH		    ; IF CLICK ON A (INDEX 1 IN ARRAY MINI_BUFF)
	JNE CHECK2
	MOV BL,1
	JMP END_CHECK
CHECK2:
	CMP BL, 39H	    ; IF CLICK ON SPACE (INDEX 2 IN ARRAY MINI_BUFF)
	JNE CHECK3 
	MOV BL,2
	JMP END_CHECK
CHECK3:
	CMP BL, 48H 	;UP 
	JNE CHECK4 
	MOV BL,3 
	JMP END_CHECK
CHECK4:
	CMP BL, 4BH 
	JNE CHECK5 		;LEFT  
	MOV BL,4  
	JMP END_CHECK
CHECK5:
	CMP BL, 4DH 	;RIGHT  
	JNE CHECK6 
	MOV BL, 5 
	JMP END_CHECK
CHECK6:
	MOV BL, 50H 
	JNE CHECK7 
	MOV BL, 6		;DOWN  
	JMP END_CHECK
CHECK7:
	CMP BL, 1H		    ; IF CLICK ON ESC
	JNE END_CHECK
	MOV [BYTE PTR CS:ESC_KEY], 1
	
END_CHECK:
    PUSH CX
	MOV CX, 7
    SHR AL, CL              ; AL = 0 IF PRESSED, 1 IF RELEASED
	POP CX
    XOR AL, 1               ; AL = 1 IF PRESSED, 0 IF RELEASED
    MOV [CS:MINIBUF+BX], AL   
	
	; SAVE PRESSED BUTTONS IN ARRAY MINI_BUFF
	
	
                                ; SEND EOI TO XT KEYBOARD
    IN      AL, 61H
    MOV     AH, AL
    OR      AL, 80H
    OUT     61H, AL
    MOV     AL, AH
    OUT     61H, AL

                                ; SEND EOI TO MASTER PIC
    MOV     AL, 20H
    OUT     20H, AL
	
    POP     SI
    POP     DI                       ;
    POP     DX
    POP     CX
    POP     BX
    POP     AX
   
    IRET
ENDP MY_ISR
;////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////
PROC MY_PROGRAM
	MOV AX,0A000H
	MOV ES,AX
	
	GRAPHIC_SCREEN
	
	MENU_PREP:
		
		;---------------------
		PUSH OFFSET FILENAME1 
		CALL DRAW_PIC			;DRAW BACKROUND
		;---------------------
		;---------------------
		DISPLAY_MOUSE			;DISPLAYING MOUSE MODEL
		;---------------------
		MENU:
			
			PUSH [MOUSE_LOC]
			CALL MOUSE_LOCATION
			POP [MOUSE_LOC]
			
			;----------------------------;
			PUSH 119*320+213             ;
			PUSH 80 		             ;
			PUSH 27 	                 ;
			PUSH [MOUSE_LOC]             ;
			CALL IS_PRESSING             ;CHECK IF USER 
			POP [BOOLEAN_PARAMETER]      ;PRESSING ON PLAY 
			                             ;
			CMP [BOOLEAN_PARAMETER],   1  ;GO TO GAME_PREP
			JNE  STAY_IN_MAIN1           ;
			JMP GAME_PREP                ;
			;----------------------------;
			STAY_IN_MAIN1:
			;----------------------------;
			PUSH 156 * 320 + 213 		 ;
			PUSH 81     				 ;
			PUSH 27 					 ;
			PUSH [MOUSE_LOC]			 ;
			CALL IS_PRESSING			 ;
			POP [BOOLEAN_PARAMETER]		 ; 
										 ; 
			CMP [BOOLEAN_PARAMETER],  1  ; 
			JNE STAY_IN_MAIN2            ;
			JMP CUSTOMIZE_PREP			 ;				  
			;----------------------------; 
			STAY_IN_MAIN2:
			;------------------------------;
			PUSH 290                       ;
 			PUSH 30 					   ;	
			PUSH 26 				       ;
			PUSH [MOUSE_LOC]			   ;
			CALL IS_PRESSING 			   ;
			POP [BOOLEAN_PARAMETER]		   ;
										   ;	
			CMP [BOOLEAN_PARAMETER], 1     ;
			JNE STAY_IN_MAIN3			   ; 
			TEXT_SCREEN 				   ;
			CALL CLEAN_ALL				   ;
			MOV AH,4CH					   ;
			INT 21H						   ;
			STAY_IN_MAIN3:				   ;	 
			;------------------------------;
		JMP MENU
		
	GAME_PREP:
		;---------------------
		PUSH OFFSET FILENAME2	
		CALL DRAW_PIC		;DRAW O;GAME BACKROUN
		
		PRINT_DEFAULT_CHAR
		;---------------------
		PUSH [OB1_LENGTH]
		PUSH [OB2_LENGTH]
		PUSH [OB3_LENGTH]
		PUSH OFFSET OB1 
		PUSH OFFSET OB2 
		PUSH OFFSET OB3 
		PUSH [OB1_LOCATION]
		PUSH [OB2_LOCATION]
		PUSH [OB3_LOCATION]
		PUSH [USER_LAST_KEY_USED]
		CALL CREATE_THREE_OBSTACLES
		POP [OB3_LOCATION]
		POP [OB2_LOCATION]
		POP [OB1_LOCATION]
		POP [OB3_LENGTH]
		POP [OB2_LENGTH]
		POP [OB1_LENGTH]
		;---------------------
		HIDE_MOUSE 			;HIDE THE MOUSE MODEL
		;---------------------
		PRINT_DEFAULT_STAIR
		MOV [JUMP_NUMBER], 0 
		MOV [IS_MOVING], 0 
		MOV [WHEN_TO_MOVE], 0 
		MOV [DID_JUMP], 0 
		MOV [ALREADY_PRINT_STAIR], 0 
		MOV SI, 0
	GAME:
	
		CALL DELAY
		;----------------
		MOUSE_INFORMATION
		CMP BX, 2		 
		JNE STAY_IN_GAME1
	;CHECK IF THE USER WANT TO EXIT 
		JMP MENU_PREP
		STAY_IN_GAME1:
		;----------------
		
			;1.CHAR_POS 2.OB1_LOCATION 3.OB2_LOCATION 4.OB3_LOCATION 5.OFFSET NEXT_CHAR_POS 6.OFFSET OB1 7.OFFSET OB2 
;8.OFFSET OB3 9.OB1_LENGTH 10.OB2_LENGTH 11.OB3_LENGTH 12.HOW_MANY_PIXELS 
			CHECK_IF_ALIVE
			;---------------------------;
			CMP [WHEN_TO_MOVE], 5 
			JE MOVE_ALL_THE_OBSTACLES
			JMP DO_NOT_MOVE
			MOVE_ALL_THE_OBSTACLES:
			MOV [WHEN_TO_MOVE], 0 
			INC [WHEN_TO_MOVE]
			PUSH [USER_LAST_KEY_USED]
			PUSH [CHAR_POS]
			PUSH [OB1_LOCATION]
			PUSH [OB2_LOCATION]
			PUSH [OB3_LOCATION]
			PUSH OFFSET NEXT_CHAR_POS
			PUSH OFFSET OB1 
			PUSH OFFSET OB2 
			PUSH OFFSET OB3 
			PUSH [OB1_LENGTH]
			PUSH [OB2_LENGTH]
			PUSH [OB3_LENGTH]
			PUSH 4 * 320 
			CALL MOVE_OBSTACLES
			POP [OB3_LENGTH]
			POP [OB2_LENGTH]
			POP [OB1_LENGTH]
			POP [OB3_LOCATION]
			POP [OB2_LOCATION]
			POP [OB1_LOCATION]
				
			DO_NOT_MOVE:
			INC [WHEN_TO_MOVE]
			;--------------------------;	
			PUSH [CHAR_POS]
			PUSH [JUMP_NUMBER]
			PUSH  OFFSET JUMPING
			PUSH OFFSET NEXT_CHAR_POS
			CALL PHYSICS
			POP [CHAR_POS]
				
			CHECK_IF_SPACE
			MOV AH, [CS:OFFSET MINIBUF + SI]	
			CMP AH, 0
			JNE SOMETHING_PRESSED
			JMP NOT_PRESSED
			SOMETHING_PRESSED:
			MOV [USER_LAST_KEY_USED], SI	
			
			MOV [IS_MOVING], 0FFFFH
			CHECK_D:
				CMP SI, 0 
				JNE CHECK_A
				
				MOV [USER_LAST_KEY_USED], SI 
				
				PUSH [CHAR_POS]
				CALL CHECK_IF_ON_RIGHT_BORDER
				POP [BOOLEAN_PARAMETER]  
				
				CMP [BOOLEAN_PARAMETER], 1 
				JE CHECK_A
				
				PUSH [OB1_LENGTH]
				PUSH [OB2_LENGTH]
				PUSH [OB3_LENGTH]
				PUSH [OB1_LOCATION]
				PUSH [OB2_LOCATION]
				PUSH [OB3_LOCATION]
				PUSH OFFSET OB1 
				PUSH OFFSET OB2 
				PUSH OFFSET OB3 
				PUSH [CHAR_POS]
				PUSH OFFSET MOVING_RIGHT
				PUSH 35 
				PUSH 50 
				PUSH OFFSET NEXT_CHAR_POS
				CALL _D
				POP [CHAR_POS]
			CHECK_A :
				CMP SI,1 
				JNE CHECK_SPACE
				
				MOV [USER_LAST_KEY_USED], SI 
				
				PUSH [CHAR_POS]
				CALL CHECK_IF_ON_LEFT_BORDER
				POP [BOOLEAN_PARAMETER]
				
				CMP [BOOLEAN_PARAMETER], 1
				JE CHECK_SPACE
			;1.OB1_LOCATION 2.OB2_LOCATION 3.OB3_LOCATION 4.OFFSET OB1 5.OFFSET OB2 
;6.OFFSET OB3 7.CHAR_POS 8.OFFSET IMAGE 9.WIDTH 10.LENGTH 11.OFFSET NEXT_CHAR_POS
				
				PUSH [OB1_LENGTH]
				PUSH [OB2_LENGTH]
				PUSH [OB3_LENGTH]
				PUSH [OB1_LOCATION]
				PUSH [OB2_LOCATION]
				PUSH [OB3_LOCATION]
				PUSH OFFSET OB1 
				PUSH OFFSET OB2 
				PUSH OFFSET OB3 
				PUSH [CHAR_POS]
				PUSH OFFSET MOVING_RIGHT
				PUSH 35 
				PUSH 50 
				PUSH OFFSET NEXT_CHAR_POS
				CALL _A
				POP [CHAR_POS]
			CHECK_SPACE:
				CMP [JUMP_NUMBER], 0 
				JNE SKIP_CHECKING_IF_PRESSED
				;------------------------------;
				PUSH [CHAR_POS]
				PUSH [JUMP_NUMBER]
				CALL CHECK_IF_IN_AIR
				POP [BOOLEAN_PARAMETER]		;DISABLE FLYING 
				CMP [BOOLEAN_PARAMETER], 1 	;JUMP ONLY WHEN ON GROUND 
				JNE STTT
				JMP NOT_PRESSED

				STTT:;(IF IN AIR GO TO NOT_PRESSED)
				;-----------------------------;
				CMP SI, 2 
				JE SKIP_CHECKING_IF_PRESSED
				JMP NOT_PRESSED
				SKIP_CHECKING_IF_PRESSED:
				

				;1.OB1_LENGTH 2.OB2_LENGTH 3.OB3_LENGTH 4.OB1_LOCATION 5.OB2_LOCATION 6.OB3_LOCATION 7.OFFSET OB1 8.OFFSET OB2 
;9.OFFSET OB3 =+1.CHAR_POS 2.JUMP_NUMBER 3.OFFSET JUMPING 4.OFFSET NEXT_CHAR_POS
					
					MOV [DID_JUMP], 1 
					CMP [ALREADY_PRINT_STAIR], 1
					JNE DO_NOT_SKIP
					JMP SKIP
					DO_NOT_SKIP:
					MOV [ALREADY_PRINT_STAIR],1
					PRINT_DEFAULT_STAIR_BACKROUND
					SKIP:
					
					PUSH [OB1_LENGTH]
					PUSH [OB2_LENGTH]
					PUSH [OB3_LENGTH]
					PUSH [OB1_LOCATION]
					PUSH [OB2_LOCATION]
					PUSH [OB3_LOCATION]
					PUSH OFFSET OB1 
					PUSH OFFSET OB2 
					PUSH OFFSET OB3 
					PUSH [CHAR_POS]
					PUSH [JUMP_NUMBER]
					PUSH OFFSET JUMPING
					PUSH OFFSET NEXT_CHAR_POS
					CALL _SPACE
					POP [JUMP_NUMBER]
					POP [CHAR_POS]
			NOT_PRESSED:;  63935
			INC [IS_MOVING]
			
			CMP [IS_MOVING], 3 
			JNE NOTHING_ELSE
			
			
			PUSH OFFSET NEXT_CHAR_POS
			PUSH [CHAR_POS]
			PUSH 35 
			PUSH 50 
			CALL PRINT_IMAGE
			
			PUSH OFFSET STANDING
			PUSH [CHAR_POS]
			PUSH 35 
			PUSH 50 
			CALL PRINT_IMAGE
			MOV [IS_MOVING], 0 
			NOTHING_ELSE:
			INC SI
			CMP SI, 3 
			JNE T_GAME
			MOV SI, 0 
			T_GAME:
	JMP GAME
	
		
		
	CUSTOMIZE_PREP:	
			
			PUSH OFFSET FILENAME4
			CALL DRAW_PIC
		
		PRINT_BIG_IMAGE
		
		
		MOV [BACKROUND_COLOR_PIXEL], 0 
		MOV [CHANGE_COLOR_PIXEL_LOCATION],320 * 196 + 146 
		MOV [COLOR_CHANGE], 120 
		MOV SI, 3 
	
	CUSTOMIZE:
		CALL DELAY 
		
		PUSH [MOUSE_LOC]
		CALL MOUSE_LOCATION
		POP [MOUSE_LOC]	
		
		;---------------------
		MOUSE_INFORMATION
		CMP BX, 2 
		JNE STAY_IN_CUSTOMIZE1
		JMP MENU_PREP
		STAY_IN_CUSTOMIZE1:
		;---------------------
			PUSH 36 * 320 + 10 
			PUSH 42 
			PUSH 20 
			PUSH [MOUSE_LOC]
			CALL IS_PRESSING
			POP [BOOLEAN_PARAMETER]
			
			CMP [BOOLEAN_PARAMETER], 0  
			JNE ARROW1
			JMP CHECK_ARROW2
			ARROW1:  
				ARROW1_CLICKED
			CHECK_ARROW2:
				PUSH 34 * 320 + 70 
				PUSH 45 
				PUSH 20 
				PUSH [MOUSE_LOC]
				CALL IS_PRESSING
				POP [BOOLEAN_PARAMETER]
	
				CMP [BOOLEAN_PARAMETER], 0 
				JNE ARROW2
				JMP NOT_PRESSING_ON_ARROWS
				ARROW2:
					ARROW2_CLICKED
				NOT_PRESSING_ON_ARROWS:
				MOV AH, [CS:OFFSET MINIBUF + SI]	
				CMP AH, 0
				JNE CHECK_UP_ARROW
				JMP NOT_PRESSED1
;CHANGE_COLOR_PIXEL_LOCATION DW ? 
;	BACKROUND_COLOR_PIXEL DW ? 
;		
			
		CHECK_UP_ARROW:
			CMP SI, 3 
			JNE CHECK_LEFT_ARROW
			PRINT_BIG_IMAGE
			MOV AL, [BACKROUND_COLOR_PIXEL]
			MOV AH, 0 
			PUSH [CHANGE_COLOR_PIXEL_LOCATION]
			PUSH AX 
			CALL _UP_ARROW
			POP AX 
			POP [CHANGE_COLOR_PIXEL_LOCATION]
			MOV [BACKROUND_COLOR_PIXEL], AL
		CHECK_LEFT_ARROW:
			CMP SI, 4 
			JNE CHECK_RIGHT_ARROW
			PRINT_BIG_IMAGE
			MOV AL, [BACKROUND_COLOR_PIXEL]
			MOV AH, 0 
			;------------------------------------
			PUSH [CHANGE_COLOR_PIXEL_LOCATION]
			PUSH AX 
			CALL _LEFT_ARROW					;LEFT_ARROW_BIND
			POP AX 
			POP [CHANGE_COLOR_PIXEL_LOCATION]
			;------------------------------------
			MOV [BACKROUND_COLOR_PIXEL], AL 
		CHECK_RIGHT_ARROW:
			CMP SI, 5 
			JNE CHECK_DOWN_ARROW
			PRINT_BIG_IMAGE
			
			MOV AL ,[BACKROUND_COLOR_PIXEL]
			MOV AH, 0 
			PUSH [CHANGE_COLOR_PIXEL_LOCATION]
			PUSH AX 
			CALL _RIGHT_ARROW
			POP AX 
			POP [CHANGE_COLOR_PIXEL_LOCATION]
			
			MOV [BACKROUND_COLOR_PIXEL], AL 
		CHECK_DOWN_ARROW:
			;CMP SI,6 
			;JNE NOT_PRESSED1
			;MOV AL ,[BACKROUND_COLOR_PIXEL]
			;MOV AH, 0 
			;PUSH [CHANGE_COLOR_PIXEL_LOCATION]
			;PUSH AX 
			;CALL _DOWN_ARROW
			;POP AX 
			
			MOV AL,[BACKROUND_COLOR_PIXEL]
			MOV AH, 0 
			
			PUSH 80 * 320 + 50  
			PUSH 30 
			PUSH 30 
			PUSH AX 
			CALL FILLER 
			NOT_PRESSED1:
			INC SI
			CMP SI, 7 
			JNE T_GAME1 
			MOV SI, 3 
			T_GAME1:	
	JMP CUSTOMIZE
	
	RET
ENDP MY_PROGRAM
START:
	 
	MOV AX,@DATA
	MOV DS,AX
	
	CALL CHANGE_HANDLER
	
	
MOV AX, 4C00H
INT 21H
END START
;===========================================================================;
;                                                                           ;
;                                 _                                         ;
;                              ==(W{==========-      /===-                  ;
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
;                   O-O _//        /-~_>---<__-~      /                     ;
;                   (^(~          /~_>---<__-      _-~                      ;
;                  ,/|           /__>--<__/     _-~                         ;
;               ,//('(          |__>--<__|     /                  .--_      ;
;              ( ( '))          |__>--<__|    |                 /' _-_~\    ;
;           `-)) )) (           |__>--<__|    | 			  /'  /   ~\`\  ;
;          ,/,'//( (             \__>--<__\    \            /'  //      ||  ;
;        ,( ( ((, ))              ~-__>--<_~-_  ~--__---~'/'/  /'       VV  ;
;      `~/  )` ) ,/|                 ~-_~>--<_/-__      __-~ _/             ;
;    ._-~//( )/ )) `                    ~~-'_/_/ /~~~~~__--~                ;
;     ;'( ')/ ,)(                              ~~~~~~~~                     ;
;    ' ') '( (/                                                             ;
;                                                                           ;
;                                                                           ;
;===========================================================================
