;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME:   ADCINC12_1.asm
;;  Version: 5.3, Updated on 2006/06/12 at 15:06:52
;;  Generated by PSoC Designer ver 4.4  b1884 : 14 Jan, 2007
;;
;;  DESCRIPTION: ADCINC12 12 bit incremental A/D converter User Module
;;               software implementation file for 22/24/25/26/27xxx PSoC
;;               family of devices.
;;
;;  NOTE: User Module APIs conform to the fastcall16 convention for marshalling
;;        arguments and observe the associated "Registers are volatile" policy.
;;        This means it is the caller's responsibility to preserve any values
;;        in the X and A registers that are still needed after the API functions
;;        returns. For Large Memory Model devices it is also the caller's 
;;        responsibility to perserve any value in the CUR_PP, IDX_PP, MVR_PP and 
;;        MVW_PP registers. Even though some of these registers may not be modified
;;        now, there is no guarantee that will remain the case in future releases.        
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress MicroSystems 2000-2003. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "ADCINC12_1.inc"
include "m8c.inc"
include "memory.inc"

;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------
export  ADCINC12_1_Start
export _ADCINC12_1_Start
export  ADCINC12_1_SetPower
export _ADCINC12_1_SetPower
export  ADCINC12_1_Stop
export _ADCINC12_1_Stop
export  ADCINC12_1_GetSamples
export _ADCINC12_1_GetSamples
export  ADCINC12_1_StopAD
export _ADCINC12_1_StopAD
export  ADCINC12_1_fIsData
export _ADCINC12_1_fIsData
export  ADCINC12_1_fIsDataAvailable
export _ADCINC12_1_fIsDataAvailable
export  ADCINC12_1_iGetData
export _ADCINC12_1_iGetData
export  ADCINC12_1_ClearFlag
export _ADCINC12_1_ClearFlag

;-----------------------------------------------
;  EQUATES
;-----------------------------------------------
LowByte:   equ 1
HighByte:  equ 0

AREA UserModules (ROM, REL)
.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINC12_1_Start
;  FUNCTION NAME: ADCINC12_1_SetPower
;
;  DESCRIPTION:
;     Applies power setting to the module's analog PSoC block.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:
;    A  contains the power setting
;
;  RETURNS: none
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 ADCINC12_1_Start:
_ADCINC12_1_Start:
 ADCINC12_1_SetPower:
_ADCINC12_1_SetPower:
   RAM_PROLOGUE RAM_USE_CLASS_2
   push X                              ;save X
   mov  X,SP                           ;X will point at next pushed value
   and  A,03h
   push A                              ;X points at copy of A
   mov  A,reg[ADCINC12_1_AtoDcr3]
   and  A,~03h                         ;clear power bits
   or   A,[ X ]
   mov  reg[ADCINC12_1_AtoDcr3],A
   pop  A
   pop  X
   RAM_EPILOGUE RAM_USE_CLASS_2
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINC12_1_Stop
;
;  DESCRIPTION:
;    Removes power from the module's analog PSoC Block
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: none
;
;  RETURNS: none
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 ADCINC12_1_Stop:
_ADCINC12_1_Stop:
   RAM_PROLOGUE RAM_USE_CLASS_1
   and reg[ADCINC12_1_AtoDcr3], ~03h
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINC12_1_Get_Samples
;
;  DESCRIPTION:
;    Starts the A/D convertor and will place data is memory.  A flag
;    is set whenever a new data value is available.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:
;    A  passes the number of samples to be taken.  (0 is continous)
;
;  RETURNS:
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
 ADCINC12_1_GetSamples:
_ADCINC12_1_GetSamples:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADCINC12_1_bIncrC
   mov [ADCINC12_1_bIncrC],A                     ;number of samples
   or  reg[ADCINC12_1_TimerIntReg],ADCINC12_1_TimerMask
   or  reg[ADCINC12_1_CounterIntReg], ADCINC12_1_CounterMask
                                                 ;Enable both interrupts
   mov [ADCINC12_1_cTimerU],1                    ;Force the Timer to do one cycle of rest
IF ADCINC12_1_NoAZ
   or  reg[ADCINC12_1_AtoDcr2],20h               ;force the Integrator into reset
ENDIF
   or  reg[ADCINC12_1_AtoDcr3],10h
   mov [ADCINC12_1_cCounterU],(-(1<<(ADCINC12_1_NUMBITS - 7)));Initialize Counter
   mov reg[ADCINC12_1_TimerDR1],ffh
   mov reg[ADCINC12_1_CounterDR1],ffh
   mov reg[ADCINC12_1_TimerCR0],01h              ;enable the Timer
   mov [ADCINC12_1_fIncr],00h                    ;A/D Data Ready Flag is reset
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINC12_1_StopAD
;
;  DESCRIPTION:
;    Completely shuts down the A/D is an orderly manner.  Both the
;    Timer and COunter interrupts are disabled.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:  none
;
;  RETURNS:  none
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
 ADCINC12_1_StopAD:
_ADCINC12_1_StopAD:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADCINC12_1_bIncrC   
   mov reg[ADCINC12_1_TimerCR0],00h              ;disable the Timer
   mov reg[ADCINC12_1_CounterCR0],00h            ;disable the Counter
   nop
   nop
   ;Disable both interrupts
   M8C_DisableIntMask ADCINC12_1_TimerIntReg, ADCINC12_1_TimerMask 
   M8C_DisableIntMask ADCINC12_1_CounterIntReg, ADCINC12_1_CounterMask )
IF ADCINC12_1_NoAZ
   or  reg[ADCINC12_1_AtoDcr2],20h               ;reset Integrator
ENDIF
   or  reg[ADCINC12_1_AtoDcr3],10h
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINC12_1_fIsDataAvailable
;
;  DESCRIPTION:
;    This function returns a non-zero value when the ADC conversion
;    is complete.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: none
;
;  RETURNS:
;    A returns conversion status  A  = 0, conversion not complete
;                                 A != 0, Data available
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
 ADCINC12_1_fIsData:
_ADCINC12_1_fIsData:
 ADCINC12_1_fIsDataAvailable:
_ADCINC12_1_fIsDataAvailable:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADCINC12_1_bIncrC   
   mov A,[ADCINC12_1_fIncr]
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINC12_1_iGetData
;
;  DESCRIPTION:
;    Returns the data from the A/D.  Does not check if data is available.
;    Is set whenever a new data value is available.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: none
;
;  RETURNS:
;    Returns 16 bit ADC result  X contains MSB
;                               A contains LSB
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
 ADCINC12_1_iGetData:
_ADCINC12_1_iGetData:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADCINC12_1_bIncrC   
   mov X,[(ADCINC12_1_iIncr + HighByte)]
   mov A,[(ADCINC12_1_iIncr + LowByte)]
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: ADCINC12_1_ClearFlag
;
;  DESCRIPTION:
;    Clears data ready flag.
;
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: none
;
;  RETURNS:  none
;
;  SIDE EFFECTS:
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;          
;    Currently only the page pointer registers listed below are modified: 
;          CUR_PP
;
 ADCINC12_1_ClearFlag:
_ADCINC12_1_ClearFlag:
   RAM_PROLOGUE RAM_USE_CLASS_4
   RAM_SETPAGE_CUR >ADCINC12_1_bIncrC   
   mov [ADCINC12_1_fIncr],00h
   RAM_EPILOGUE RAM_USE_CLASS_4
   ret
.ENDSECTION

; End of File ADCINC12_1.asm
