//----------------------------------------------------------------------------
// Radio Panel 14.May.2009
//----------------------------------------------------------------------------

#include <m8c.h>
#include "PSoCAPI.h"
#include "hbheader.h"
#include "stdlib.h"

#define SLAVE_ADDRESS 19

BYTE    txBuffer[32];  
BYTE    rxBuffer[32]; 
BYTE	lastport;
BYTE 	adc_res[16] = {0}; 
BYTE	ekran_res[4] = {0};  // [0]=NAV ACT, [1]=NAV STB
BYTE	sol_intkisim=0, sol_decisim=0, sag_intkisim=0, sag_decisim=0;

BYTE    status;  
BYTE *ptr;
//char *intRet;
char intRet[8];

WORD cnt;
WORD acnt;
WORD Timeout_d;
void  I2Oku(void), I2Yaz(void);
void Int_tostring(int val);

#pragma interrupt_handler Counter8_1_ISR, encoder_isr
void Counter8_1_ISR(void); void encoder_isr(void);

void dly(long int mS), init_environment(void);

void Counter8_1_ISR() {Counter8_1_DisableInt(); Counter8_1_Stop(); DELAY_CLR;}

void encoder_isr(void){
}
		
void init_environment()
{  	PRT1DR |= 0xA0;		//release et pinleri
	I2CHW_1_Start(); I2CHW_1_EnableSlave(); I2CHW_1_EnableInt();
	I2CHW_1_InitRamRead(txBuffer,32);
    I2CHW_1_InitWrite(rxBuffer,32);
	M8C_EnableGInt;	M8C_EnableIntMask (INT_MSK0, INT_MSK0_GPIO); LED7SEG_1_Start();
    
    ekran_res[0]=34; lastport=0;
    ekran_res[1]=38;
    ekran_res[2]=1;
    ekran_res[3]=1;
    }

void init_delay_counter(long int mSn, long int DC)
{   Counter8_1_WritePeriod(mSn); Counter8_1_WriteCompareValue(DC); Counter8_1_EnableInt();DELAY_SET; Counter8_1_Start();}
/* ---------------------------------------------------------------------- */

void main()
{
// ADF LIMITS   = 0100.0-1799.9

	init_environment();
	LED7SEG_1_DP(1, 3); 	LED7SEG_1_DP(1, 7);
	SOLBIRME; SAGBIRME;
	
 	while(1)  {
			//txBuffer[0]=
			BYTE dummy1;
//						LED7SEG_1_DispInt(1234, 1, 4);
//						LED7SEG_1_DispInt(5678, 5, 4);
			I2Oku();
//DIKKAT REMARKLI SATIRLAR ALPS marka ICIN KONULDU. HEM HIGH HEM LOW DARBESI ICIN
// ADF LIMITS   = 0100.0-1799.9
//			sayiyaz();
			dummy1 = PRT3DR^lastport;	//durumu degisen pin varmi?
//if (ekran_res[0]==255) {ekran_res[0]=0;}
//if (ekran_res[1]==255) {ekran_res[0]=0;}

			if (dummy1 & BSET_0) {		//0. pinin durumu degismis
				lastport=PRT3DR;
				switch  (PRT3DR & 0b00000011) {	//bu encoder hangi yone donuyor?
						case 1: if (PRT7DR & BSET_0) {
									if (ekran_res[2]==0) {ekran_res[2]=99;} else {ekran_res[2]--; }}
								else {
									if (ekran_res[0]==10) {ekran_res[0]=179;} else {ekran_res[0]--; }}
								break;
						
						case 3: if (PRT7DR & BSET_0) {
									if (ekran_res[2]==99) {ekran_res[2]=0;} else {ekran_res[2]++; }}
								else {
									if (ekran_res[0]==179) {ekran_res[0]=10;} else {ekran_res[0]++; }}
								break;
						
						}}
			if (dummy1 & BSET_2) {		//2. pinin durumu degismis
				lastport=PRT3DR;
				switch  (PRT3DR & 0b00001100) {	//bu encoder hangi yone donuyor?
						case 4: if (PRT7DR & BSET_7) {
									if (ekran_res[3]==0) {ekran_res[3]=99;} else {ekran_res[3]--; }}
								else {
									if (ekran_res[1]==10) {ekran_res[1]=179;} else {ekran_res[1]--; }}
								break;
						
						case 12: if (PRT7DR & BSET_7) {
									if (ekran_res[3]==99) {ekran_res[3]=0;} else {ekran_res[3]++; }}
								else {
									if (ekran_res[1]==179) {ekran_res[1]=10;} else {ekran_res[1]++; }}
								break;
						
						}}

if (ekran_res[0]>=100) {LED7SEG_1_DispInt((ekran_res[0]-100), 1, 2); SOLBIR; } else {SOLBIRME; LED7SEG_1_DispInt(ekran_res[0], 1, 2);}
if (ekran_res[1]>=100) {LED7SEG_1_DispInt((ekran_res[1]-100), 5, 2); SAGBIR; } else {SAGBIRME; LED7SEG_1_DispInt(ekran_res[1], 5, 2);}

			txBuffer[2]=ekran_res[0];	//sol 179 hanesi
			txBuffer[0]=ekran_res[1];	//sag 179 hanesi
			txBuffer[3]=ekran_res[2];	//sol 9.9 hanesi
			txBuffer[1]=ekran_res[3];	//sag 9.9 hanesi			
						
			LED7SEG_1_DispInt(ekran_res[2], 3, 2);
			LED7SEG_1_DispInt(ekran_res[3], 7, 2);
						
			I2Yaz();

	
}//while kapa	
}//main kapa

void dly(long int mS){init_delay_counter(mS,mS/2); while (DELAY_INVOKE);{}}

void I2Yaz()
{
		status = I2CHW_1_bReadI2CStatus();
		if( status & I2CHW_RD_COMPLETE )
		{
			I2CHW_1_ClrRdStatus();
			I2CHW_1_InitRamRead(txBuffer,32);}}

void I2Oku()
{
        status = I2CHW_1_bReadI2CStatus();  
        if( status & I2CHW_WR_COMPLETE )  
        {
	        I2CHW_1_ClrWrStatus();  
	        I2CHW_1_InitWrite(rxBuffer,32);}}
