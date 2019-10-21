	cpu LMM
	.module main.c
	.area data(ram, con, rel)
_STATUS::
	.word 0
	.dbfile ./hbheader.h
	.dbsym e STATUS _STATUS I
	.area data(ram, con, rel)
	.dbfile ./hbheader.h
	.area data(ram, con, rel)
	.dbfile ./hbheader.h
_adc_res::
	.byte 0
	.word 0,0,0,0,0
	.byte 0,0,0,0,0
	.dbfile ./main.c
	.dbsym e adc_res _adc_res A[16:16]c
	.area data(ram, con, rel)
	.dbfile ./main.c
	.area data(ram, con, rel)
	.dbfile ./main.c
_ekran_res::
	.byte 0
	.byte 0,0,0
	.dbsym e ekran_res _ekran_res A[4:4]c
	.area data(ram, con, rel)
	.dbfile ./main.c
	.area data(ram, con, rel)
	.dbfile ./main.c
_sol_intkisim::
	.byte 0
	.dbsym e sol_intkisim _sol_intkisim c
	.area data(ram, con, rel)
	.dbfile ./main.c
	.area data(ram, con, rel)
	.dbfile ./main.c
_sol_decisim::
	.byte 0
	.dbsym e sol_decisim _sol_decisim c
	.area data(ram, con, rel)
	.dbfile ./main.c
	.area data(ram, con, rel)
	.dbfile ./main.c
_sag_intkisim::
	.byte 0
	.dbsym e sag_intkisim _sag_intkisim c
	.area data(ram, con, rel)
	.dbfile ./main.c
	.area data(ram, con, rel)
	.dbfile ./main.c
_sag_decisim::
	.byte 0
	.dbsym e sag_decisim _sag_decisim c
	.area data(ram, con, rel)
	.dbfile ./main.c
	.area text(rom, con, rel)
	.dbfile ./main.c
	.dbfunc e Counter8_1_ISR _Counter8_1_ISR fV
_Counter8_1_ISR::
	.dbline -1
	or F,-64
	push A
	mov A,REG[0xd0]
	push A
	mov A,REG[0xd3]
	push A
	mov A,REG[0xd4]
	push A
	mov A,REG[0xd5]
	push A
	mov REG[0xd0],>__r0
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	mov A,[__r4]
	push A
	mov A,[__r5]
	push A
	mov A,[__r6]
	push A
	mov A,[__r7]
	push A
	mov A,[__r8]
	push A
	mov A,[__r9]
	push A
	mov A,[__r10]
	push A
	mov A,[__r11]
	push A
	mov A,[__rX]
	push A
	mov A,[__rY]
	push A
	mov A,[__rZ]
	push A
	.dbline 35
; //----------------------------------------------------------------------------
; // Radio Panel 14.May.2009
; //----------------------------------------------------------------------------
; 
; #include <m8c.h>
; #include "PSoCAPI.h"
; #include "hbheader.h"
; #include "stdlib.h"
; 
; #define SLAVE_ADDRESS 19
; 
; BYTE    txBuffer[32];  
; BYTE    rxBuffer[32]; 
; BYTE	lastport;
; BYTE 	adc_res[16] = {0}; 
; BYTE	ekran_res[4] = {0};  // [0]=NAV ACT, [1]=NAV STB
; BYTE	sol_intkisim=0, sol_decisim=0, sag_intkisim=0, sag_decisim=0;
; 
; BYTE    status;  
; BYTE *ptr;
; //char *intRet;
; char intRet[8];
; 
; WORD cnt;
; WORD acnt;
; WORD Timeout_d;
; void  I2Oku(void), I2Yaz(void);
; void Int_tostring(int val);
; 
; #pragma interrupt_handler Counter8_1_ISR, encoder_isr
; void Counter8_1_ISR(void); void encoder_isr(void);
; 
; void dly(long int mS), init_environment(void);
; 
; void Counter8_1_ISR() {Counter8_1_DisableInt(); Counter8_1_Stop(); DELAY_CLR;}
	.dbline 35
	push X
	xcall _Counter8_1_DisableInt
	.dbline 35
	xcall _Counter8_1_Stop
	pop X
	.dbline 35
	mov REG[0xd0],>_STATUS
	mov A,[_STATUS+1]
	and A,-2
	mov REG[0xd0],>__r0
	mov [__r1],A
	mov REG[0xd0],>_STATUS
	mov A,[_STATUS]
	mov REG[0xd0],>__r0
	mov [__r0],A
	mov A,[__r1]
	push A
	mov A,[__r0]
	mov REG[0xd0],>_STATUS
	mov [_STATUS],A
	pop A
	mov [_STATUS+1],A
	.dbline -2
	.dbline 35
L1:
	mov REG[0xD0],>__r0
	pop A
	mov [__rZ],A
	pop A
	mov [__rY],A
	pop A
	mov [__rX],A
	pop A
	mov [__r11],A
	pop A
	mov [__r10],A
	pop A
	mov [__r9],A
	pop A
	mov [__r8],A
	pop A
	mov [__r7],A
	pop A
	mov [__r6],A
	pop A
	mov [__r5],A
	pop A
	mov [__r4],A
	pop A
	mov [__r3],A
	pop A
	mov [__r2],A
	pop A
	mov [__r1],A
	pop A
	mov [__r0],A
	pop A
	mov REG[213],A
	pop A
	mov REG[212],A
	pop A
	mov REG[211],A
	pop A
	mov REG[208],A
	pop A
	.dbline 0 ; func end
	reti
	.dbend
	.dbfunc e encoder_isr _encoder_isr fV
_encoder_isr::
	.dbline -1
	.dbline 37
; 
; void encoder_isr(void){
	.dbline -2
	.dbline 38
; }
L2:
	.dbline 0 ; func end
	reti
	.dbend
	.dbfunc e init_environment _init_environment fV
_init_environment::
	.dbline -1
	.dbline 41
; 		
; void init_environment()
; {  	PRT1DR |= 0xA0;		//release et pinleri
	.dbline 41
	or REG[0x4],-96
	.dbline 42
; 	I2CHW_1_Start(); I2CHW_1_EnableSlave(); I2CHW_1_EnableInt();
	push X
	xcall _I2CHW_1_Start
	.dbline 42
	xcall _I2CHW_1_EnableSlave
	.dbline 42
	xcall _I2CHW_1_EnableInt
	.dbline 43
; 	I2CHW_1_InitRamRead(txBuffer,32);
	mov A,32
	push A
	mov A,>_txBuffer
	push A
	mov A,<_txBuffer
	push A
	xcall _I2CHW_1_InitRamRead
	add SP,-3
	.dbline 44
;     I2CHW_1_InitWrite(rxBuffer,32);
	mov A,32
	push A
	mov A,>_rxBuffer
	push A
	mov A,<_rxBuffer
	push A
	xcall _I2CHW_1_InitWrite
	add SP,-3
	pop X
	.dbline 45
; 	M8C_EnableGInt;	M8C_EnableIntMask (INT_MSK0, INT_MSK0_GPIO); LED7SEG_1_Start();
		or  F, 01h

	.dbline 45
	or REG[0xe0],32
	.dbline 45
	xcall _LED7SEG_1_Start
	.dbline 47
;     
;     ekran_res[0]=34; lastport=0;
	mov REG[0xd0],>_ekran_res
	mov [_ekran_res],34
	.dbline 47
	mov REG[0xd0],>_lastport
	mov [_lastport],0
	.dbline 48
;     ekran_res[1]=38;
	mov REG[0xd0],>_ekran_res
	mov [_ekran_res+1],38
	.dbline 49
;     ekran_res[2]=1;
	mov [_ekran_res+2],1
	.dbline 50
;     ekran_res[3]=1;
	mov [_ekran_res+3],1
	.dbline -2
	.dbline 51
;     }
L3:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e init_delay_counter _init_delay_counter fV
;             DC -> X-11
;            mSn -> X-7
_init_delay_counter::
	.dbline -1
	push X
	mov X,SP
	.dbline 54
; 
; void init_delay_counter(long int mSn, long int DC)
; {   Counter8_1_WritePeriod(mSn); Counter8_1_WriteCompareValue(DC); Counter8_1_EnableInt();DELAY_SET; Counter8_1_Start();}
	.dbline 54
	mov REG[0xd0],>__r0
	mov A,[X-4]
	push X
	xcall _Counter8_1_WritePeriod
	pop X
	.dbline 54
	mov REG[0xd0],>__r0
	mov A,[X-8]
	push X
	xcall _Counter8_1_WriteCompareValue
	.dbline 54
	xcall _Counter8_1_EnableInt
	pop X
	.dbline 54
	mov REG[0xd0],>_STATUS
	or [_STATUS+1],1
	.dbline 54
	push X
	xcall _Counter8_1_Start
	pop X
	.dbline -2
	.dbline 54
L7:
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l DC -11 L
	.dbsym l mSn -7 L
	.dbend
	.dbfunc e main _main fV
;         dummy1 -> X+0
_main::
	.dbline -1
	push X
	mov X,SP
	add SP,3
	.dbline 58
; /* ---------------------------------------------------------------------- */
; 
; void main()
; {
	.dbline 61
; // ADF LIMITS   = 0100.0-1799.9
; 
; 	init_environment();
	xcall _init_environment
	.dbline 62
; 	LED7SEG_1_DP(1, 3); 	LED7SEG_1_DP(1, 7);
	push X
	mov X,3
	mov A,1
	xcall _LED7SEG_1_DP
	.dbline 62
	mov X,7
	mov A,1
	xcall _LED7SEG_1_DP
	pop X
	.dbline 63
; 	SOLBIRME; SAGBIRME;
	mov A,REG[0x10]
	mov REG[0xd0],>__r0
	mov [__r0],A
	and [__r0],-65
	mov A,[__r0]
	mov REG[0x10],A
	.dbline 63
	mov A,REG[0x10]
	mov [__r0],A
	and [__r0],127
	mov A,[__r0]
	mov REG[0x10],A
	xjmp L10
L9:
	.dbline 65
; 	
;  	while(1)  {
	.dbline 70
; 			//txBuffer[0]=
; 			BYTE dummy1;
; //						LED7SEG_1_DispInt(1234, 1, 4);
; //						LED7SEG_1_DispInt(5678, 5, 4);
; 			I2Oku();
	xcall _I2Oku
	.dbline 74
; //DIKKAT REMARKLI SATIRLAR ALPS marka ICIN KONULDU. HEM HIGH HEM LOW DARBESI ICIN
; // ADF LIMITS   = 0100.0-1799.9
; //			sayiyaz();
; 			dummy1 = PRT3DR^lastport;	//durumu degisen pin varmi?
	mov A,REG[0xc]
	mov REG[0xd0],>__r0
	mov [__r0],A
	mov REG[0xd0],>_lastport
	mov A,[_lastport]
	mov REG[0xd0],>__r0
	xor [__r0],A
	mov A,[__r0]
	mov [X+0],A
	.dbline 78
; //if (ekran_res[0]==255) {ekran_res[0]=0;}
; //if (ekran_res[1]==255) {ekran_res[0]=0;}
; 
; 			if (dummy1 & BSET_0) {		//0. pinin durumu degismis
	tst [X+0],1
	jz L12
	.dbline 78
	.dbline 79
; 				lastport=PRT3DR;
	mov A,REG[0xc]
	mov REG[0xd0],>_lastport
	mov [_lastport],A
	.dbline 80
	mov A,REG[0xc]
	mov REG[0xd0],>__r0
	and A,3
	mov [X+2],A
	mov [X+1],0
	cmp [X+1],0
	jnz X3
	cmp [X+2],1
	jz L17
X3:
	cmp [X+1],0
	jnz X4
	cmp [X+2],3
	jz L27
X4:
	xjmp L14
X0:
	.dbline 80
; 				switch  (PRT3DR & 0b00000011) {	//bu encoder hangi yone donuyor?
L17:
	.dbline 81
; 						case 1: if (PRT7DR & BSET_0) {
	tst REG[0x1c],1
	jz L18
	.dbline 81
	.dbline 82
	mov REG[0xd0],>_ekran_res
	cmp [_ekran_res+2],0
	jnz L20
	.dbline 82
	.dbline 82
	mov [_ekran_res+2],99
	.dbline 82
	xjmp L15
L20:
	.dbline 82
; 									if (ekran_res[2]==0) {ekran_res[2]=99;} else {ekran_res[2]--; }}
	.dbline 82
	mov REG[0xd0],>_ekran_res
	dec [_ekran_res+2]
	.dbline 82
	.dbline 82
	xjmp L15
L18:
	.dbline 83
; 								else {
	.dbline 84
	mov REG[0xd0],>_ekran_res
	cmp [_ekran_res],10
	jnz L25
	.dbline 84
	.dbline 84
	mov [_ekran_res],-77
	.dbline 84
	xjmp L15
L25:
	.dbline 84
; 									if (ekran_res[0]==10) {ekran_res[0]=179;} else {ekran_res[0]--; }}
	.dbline 84
	mov REG[0xd0],>_ekran_res
	dec [_ekran_res]
	.dbline 84
	.dbline 84
	.dbline 85
; 								break;
	xjmp L15
L27:
	.dbline 87
; 						
; 						case 3: if (PRT7DR & BSET_0) {
	tst REG[0x1c],1
	jz L28
	.dbline 87
	.dbline 88
	mov REG[0xd0],>_ekran_res
	cmp [_ekran_res+2],99
	jnz L30
	.dbline 88
	.dbline 88
	mov [_ekran_res+2],0
	.dbline 88
	xjmp L15
L30:
	.dbline 88
; 									if (ekran_res[2]==99) {ekran_res[2]=0;} else {ekran_res[2]++; }}
	.dbline 88
	mov REG[0xd0],>_ekran_res
	inc [_ekran_res+2]
	.dbline 88
	.dbline 88
	xjmp L15
L28:
	.dbline 89
; 								else {
	.dbline 90
	mov REG[0xd0],>_ekran_res
	cmp [_ekran_res],-77
	jnz L35
	.dbline 90
	.dbline 90
	mov [_ekran_res],10
	.dbline 90
	xjmp L15
L35:
	.dbline 90
; 									if (ekran_res[0]==179) {ekran_res[0]=10;} else {ekran_res[0]++; }}
	.dbline 90
	mov REG[0xd0],>_ekran_res
	inc [_ekran_res]
	.dbline 90
	.dbline 90
	.dbline 91
; 								break;
L14:
L15:
	.dbline 93
; 						
; 						}}
L12:
	.dbline 94
; 			if (dummy1 & BSET_2) {		//2. pinin durumu degismis
	tst [X+0],4
	jz L37
	.dbline 94
	.dbline 95
; 				lastport=PRT3DR;
	mov A,REG[0xc]
	mov REG[0xd0],>_lastport
	mov [_lastport],A
	.dbline 96
; 				switch  (PRT3DR & 0b00001100) {	//bu encoder hangi yone donuyor?
	mov A,REG[0xc]
	mov REG[0xd0],>__r0
	and A,12
	mov [X+2],A
	mov [X+1],0
	mov A,[X+2]
	sub A,4
	mov [__rY],A
	mov A,[X+1]
	xor A,-128
	sbb A,(0 ^ 0x80)
	jc L39
	or A,[__rY]
	jz L42
X5:
L68:
	cmp [X+1],0
	jnz X6
	cmp [X+2],12
	jz L55
X6:
	xjmp L39
X1:
	.dbline 96
L42:
	.dbline 97
; 						case 4: if (PRT7DR & BSET_7) {
	tst REG[0x1c],-128
	jz L43
	.dbline 97
	.dbline 98
	mov REG[0xd0],>_ekran_res
	cmp [_ekran_res+3],0
	jnz L45
	.dbline 98
	.dbline 98
	mov [_ekran_res+3],99
	.dbline 98
	xjmp L40
L45:
	.dbline 98
; 									if (ekran_res[3]==0) {ekran_res[3]=99;} else {ekran_res[3]--; }}
	.dbline 98
	mov REG[0xd0],>_ekran_res
	dec [_ekran_res+3]
	.dbline 98
	.dbline 98
	xjmp L40
L43:
	.dbline 99
; 								else {
	.dbline 100
	mov REG[0xd0],>_ekran_res
	cmp [_ekran_res+1],10
	jnz L50
	.dbline 100
	.dbline 100
	mov [_ekran_res+1],-77
	.dbline 100
	xjmp L40
L50:
	.dbline 100
; 									if (ekran_res[1]==10) {ekran_res[1]=179;} else {ekran_res[1]--; }}
	.dbline 100
	mov REG[0xd0],>_ekran_res
	dec [_ekran_res+1]
	.dbline 100
	.dbline 100
	.dbline 101
; 								break;
	xjmp L40
L55:
	.dbline 103
; 						
; 						case 12: if (PRT7DR & BSET_7) {
	tst REG[0x1c],-128
	jz L56
	.dbline 103
	.dbline 104
	mov REG[0xd0],>_ekran_res
	cmp [_ekran_res+3],99
	jnz L58
	.dbline 104
	.dbline 104
	mov [_ekran_res+3],0
	.dbline 104
	xjmp L40
L58:
	.dbline 104
; 									if (ekran_res[3]==99) {ekran_res[3]=0;} else {ekran_res[3]++; }}
	.dbline 104
	mov REG[0xd0],>_ekran_res
	inc [_ekran_res+3]
	.dbline 104
	.dbline 104
	xjmp L40
L56:
	.dbline 105
; 								else {
	.dbline 106
	mov REG[0xd0],>_ekran_res
	cmp [_ekran_res+1],-77
	jnz L63
	.dbline 106
	.dbline 106
	mov [_ekran_res+1],10
	.dbline 106
	xjmp L40
L63:
	.dbline 106
; 									if (ekran_res[1]==179) {ekran_res[1]=10;} else {ekran_res[1]++; }}
	.dbline 106
	mov REG[0xd0],>_ekran_res
	inc [_ekran_res+1]
	.dbline 106
	.dbline 106
	.dbline 107
; 								break;
L39:
L40:
	.dbline 109
; 						
; 						}}
L37:
	.dbline 111
	mov REG[0xd0],>_ekran_res
	cmp [_ekran_res],100
	jc L69
X7:
	.dbline 111
	.dbline 111
	push X
	mov A,2
	push A
	mov A,1
	push A
	mov REG[0xd0],>_ekran_res
	mov A,[_ekran_res]
	mov REG[0xd0],>__r0
	mov [__r1],A
	mov [__r0],0
	sub [__r1],100
	sbb [__r0],0
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	xcall _LED7SEG_1_DispInt
	add SP,-4
	pop X
	.dbline 111
	or REG[0x10],64
	.dbline 111
	xjmp L70
L69:
	.dbline 111
; 
; if (ekran_res[0]>=100) {LED7SEG_1_DispInt((ekran_res[0]-100), 1, 2); SOLBIR; } else {SOLBIRME; LED7SEG_1_DispInt(ekran_res[0], 1, 2);}
	.dbline 111
	mov A,REG[0x10]
	mov REG[0xd0],>__r0
	mov [__r0],A
	and [__r0],-65
	mov A,[__r0]
	mov REG[0x10],A
	.dbline 111
	push X
	mov A,2
	push A
	mov A,1
	push A
	mov REG[0xd0],>_ekran_res
	mov A,[_ekran_res]
	mov REG[0xd0],>__r0
	mov [__r1],A
	mov A,0
	push A
	mov A,[__r1]
	push A
	xcall _LED7SEG_1_DispInt
	add SP,-4
	pop X
	.dbline 111
L70:
	.dbline 112
	mov REG[0xd0],>_ekran_res
	cmp [_ekran_res+1],100
	jc L71
X8:
	.dbline 112
	.dbline 112
	push X
	mov A,2
	push A
	mov A,5
	push A
	mov REG[0xd0],>_ekran_res
	mov A,[_ekran_res+1]
	mov REG[0xd0],>__r0
	mov [__r1],A
	mov [__r0],0
	sub [__r1],100
	sbb [__r0],0
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	xcall _LED7SEG_1_DispInt
	add SP,-4
	pop X
	.dbline 112
	or REG[0x10],-128
	.dbline 112
	xjmp L72
L71:
	.dbline 112
; if (ekran_res[1]>=100) {LED7SEG_1_DispInt((ekran_res[1]-100), 5, 2); SAGBIR; } else {SAGBIRME; LED7SEG_1_DispInt(ekran_res[1], 5, 2);}
	.dbline 112
	mov A,REG[0x10]
	mov REG[0xd0],>__r0
	mov [__r0],A
	and [__r0],127
	mov A,[__r0]
	mov REG[0x10],A
	.dbline 112
	push X
	mov A,2
	push A
	mov A,5
	push A
	mov REG[0xd0],>_ekran_res
	mov A,[_ekran_res+1]
	mov REG[0xd0],>__r0
	mov [__r1],A
	mov A,0
	push A
	mov A,[__r1]
	push A
	xcall _LED7SEG_1_DispInt
	add SP,-4
	pop X
	.dbline 112
L72:
	.dbline 114
	mov REG[0xd0],>_ekran_res
	mov A,[_ekran_res]
	mov REG[0xd0],>_txBuffer
	mov [_txBuffer+2],A
	.dbline 115
	mov REG[0xd0],>_ekran_res
	mov A,[_ekran_res+1]
	mov REG[0xd0],>_txBuffer
	mov [_txBuffer],A
	.dbline 116
	mov REG[0xd0],>_ekran_res
	mov A,[_ekran_res+2]
	mov REG[0xd0],>_txBuffer
	mov [_txBuffer+3],A
	.dbline 117
	mov REG[0xd0],>_ekran_res
	mov A,[_ekran_res+3]
	mov REG[0xd0],>_txBuffer
	mov [_txBuffer+1],A
	.dbline 119
	push X
	mov A,2
	push A
	mov A,3
	push A
	mov REG[0xd0],>_ekran_res
	mov A,[_ekran_res+2]
	mov REG[0xd0],>__r0
	mov [__r1],A
	mov A,0
	push A
	mov A,[__r1]
	push A
	xcall _LED7SEG_1_DispInt
	add SP,-4
	.dbline 120
	mov A,2
	push A
	mov A,7
	push A
	mov REG[0xd0],>_ekran_res
	mov A,[_ekran_res+3]
	mov REG[0xd0],>__r0
	mov [__r1],A
	mov A,0
	push A
	mov A,[__r1]
	push A
	xcall _LED7SEG_1_DispInt
	add SP,-4
	pop X
	.dbline 122
	xcall _I2Yaz
	.dbline 125
L10:
	.dbline 65
	xjmp L9
X2:
	.dbline -2
	.dbline 126
; 
; 			txBuffer[2]=ekran_res[0];	//sol 179 hanesi
; 			txBuffer[0]=ekran_res[1];	//sag 179 hanesi
; 			txBuffer[3]=ekran_res[2];	//sol 9.9 hanesi
; 			txBuffer[1]=ekran_res[3];	//sag 9.9 hanesi			
; 						
; 			LED7SEG_1_DispInt(ekran_res[2], 3, 2);
; 			LED7SEG_1_DispInt(ekran_res[3], 7, 2);
; 						
; 			I2Yaz();
; 
; 	
; }//while kapa	
; }//main kapa
L8:
	add SP,-3
	pop X
	.dbline 0 ; func end
	jmp .
	.dbsym l dummy1 0 c
	.dbend
	.dbfunc e dly _dly fV
;             mS -> X-7
_dly::
	.dbline -1
	push X
	mov X,SP
	.dbline 128
	.dbline 128
	mov REG[0xd0],>__r0
	mov A,0
	push A
	push A
	push A
	mov A,2
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	xcall __divmod_32X32_32
	pop A
	mov [__r3],A
	pop A
	mov [__r2],A
	pop A
	mov [__r1],A
	pop A
	add SP,-4
	push A
	mov A,[__r1]
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	xcall _init_delay_counter
	add SP,-8
L85:
	.dbline 128
L86:
	.dbline 128
; 
; void dly(long int mS){init_delay_counter(mS,mS/2); while (DELAY_INVOKE);{}}
	mov REG[0xd0],>_STATUS
	mov A,[_STATUS+1]
	and A,1
	mov REG[0xd0],>__r0
	mov [__r1],A
	mov REG[0xd0],>_STATUS
	mov A,[_STATUS]
	and A,0
	mov REG[0xd0],>__r0
	cmp A,0
	jnz L85
	cmp [__r1],0
	jnz L85
X9:
	.dbline 128
	.dbline 128
	.dbline -2
	.dbline 128
L84:
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l mS -7 L
	.dbend
	.dbfunc e I2Yaz _I2Yaz fV
_I2Yaz::
	.dbline -1
	.dbline 131
	.dbline 132
	push X
	xcall _I2CHW_1_bReadI2CStatus
	pop X
	mov REG[0xd0],>_status
	mov [_status],A
	.dbline 133
	tst [_status],4
	jz L89
	.dbline 134
	.dbline 135
	push X
	xcall _I2CHW_1_ClrRdStatus
	.dbline 136
	mov A,32
	push A
	mov A,>_txBuffer
	push A
	mov A,<_txBuffer
	push A
	xcall _I2CHW_1_InitRamRead
	add SP,-3
	pop X
	.dbline 136
L89:
	.dbline -2
	.dbline 136
; 
; void I2Yaz()
; {
; 		status = I2CHW_1_bReadI2CStatus();
; 		if( status & I2CHW_RD_COMPLETE )
; 		{
; 			I2CHW_1_ClrRdStatus();
; 			I2CHW_1_InitRamRead(txBuffer,32);}}
L88:
	.dbline 0 ; func end
	ret
	.dbend
	.dbfunc e I2Oku _I2Oku fV
_I2Oku::
	.dbline -1
	.dbline 139
	.dbline 140
	push X
	xcall _I2CHW_1_bReadI2CStatus
	pop X
	mov REG[0xd0],>_status
	mov [_status],A
	.dbline 141
	tst [_status],64
	jz L92
	.dbline 142
	.dbline 143
	push X
	xcall _I2CHW_1_ClrWrStatus
	.dbline 144
	mov A,32
	push A
	mov A,>_rxBuffer
	push A
	mov A,<_rxBuffer
	push A
	xcall _I2CHW_1_InitWrite
	add SP,-3
	pop X
	.dbline 144
L92:
	.dbline -2
	.dbline 144
; 
; void I2Oku()
; {
;         status = I2CHW_1_bReadI2CStatus();  
;         if( status & I2CHW_WR_COMPLETE )  
;         {
; 	        I2CHW_1_ClrWrStatus();  
; 	        I2CHW_1_InitWrite(rxBuffer,32);}}
L91:
	.dbline 0 ; func end
	ret
	.dbend
	.area data(ram, con, rel)
	.dbfile ./main.c
_Timeout_d::
	.byte 0,0
	.dbsym e Timeout_d _Timeout_d i
	.area data(ram, con, rel)
	.dbfile ./main.c
_acnt::
	.byte 0,0
	.dbsym e acnt _acnt i
	.area data(ram, con, rel)
	.dbfile ./main.c
_cnt::
	.byte 0,0
	.dbsym e cnt _cnt i
	.area data(ram, con, rel)
	.dbfile ./main.c
_intRet::
	.byte 0,0,0,0,0,0,0,0
	.dbsym e intRet _intRet A[8:8]c
	.area data(ram, con, rel)
	.dbfile ./main.c
_ptr::
	.byte 0,0
	.dbsym e ptr _ptr pc
	.area data(ram, con, rel)
	.dbfile ./main.c
_lastport::
	.byte 0
	.dbsym e lastport _lastport c
	.area data(ram, con, rel)
	.dbfile ./main.c
_rxBuffer::
	.word 0,0,0,0,0
	.word 0,0,0,0,0
	.word 0,0,0,0,0
	.byte 0,0
	.dbsym e rxBuffer _rxBuffer A[32:32]c
	.area data(ram, con, rel)
	.dbfile ./main.c
_txBuffer::
	.word 0,0,0,0,0
	.word 0,0,0,0,0
	.word 0,0,0,0,0
	.byte 0,0
	.dbsym e txBuffer _txBuffer A[32:32]c
	.area data(ram, con, rel)
	.dbfile ./main.c
_mevcut::
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0
	.dbfile ./hbheader.h
	.dbsym e mevcut _mevcut A[64:32]I
	.area data(ram, con, rel)
	.dbfile ./hbheader.h
_status::
	.byte 0
	.dbfile ./main.c
	.dbsym e status _status c
	.area data(ram, con, rel)
	.dbfile ./main.c
_dummy::
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.byte 0,0,0,0
	.dbfile ./hbheader.h
	.dbsym e dummy _dummy A[64:32]I
