;/////////////////////////////////////////////////////////////////////////////////
;// Code Generator: BoostC Compiler - http://www.sourceboost.com
;// Version       : 6.95
;// License Type  : Full License
;// Limitations   : PIC12,PIC16 max code size:Unlimited, max RAM banks:Unlimited, Non commercial use only
;/////////////////////////////////////////////////////////////////////////////////

	include "P16F72.inc"
; Heap block 0, size:59 (0x00000044 - 0x0000007E)
__HEAP_BLOCK0_BANK               EQU	0x00000000
__HEAP_BLOCK0_START_OFFSET       EQU	0x00000044
__HEAP_BLOCK0_END_OFFSET         EQU	0x0000007E
; Heap block 1, size:32 (0x000000A0 - 0x000000BF)
__HEAP_BLOCK1_BANK               EQU	0x00000001
__HEAP_BLOCK1_START_OFFSET       EQU	0x00000020
__HEAP_BLOCK1_END_OFFSET         EQU	0x0000003F
; Heap block 2, size:0 (0x00000000 - 0x00000000)
__HEAP_BLOCK2_BANK               EQU	0x00000000
__HEAP_BLOCK2_START_OFFSET       EQU	0x00000000
__HEAP_BLOCK2_END_OFFSET         EQU	0x00000000
; Heap block 3, size:0 (0x00000000 - 0x00000000)
__HEAP_BLOCK3_BANK               EQU	0x00000000
__HEAP_BLOCK3_START_OFFSET       EQU	0x00000000
__HEAP_BLOCK3_END_OFFSET         EQU	0x00000000
gbl_status                       EQU	0x00000003 ; bytes:1
gbl_16_LSR                       EQU	0x00000020 ; bytes:4
gbl_float_detect_tininess        EQU	0x00000039 ; bytes:1
gbl_float_rounding_mode          EQU	0x0000003A ; bytes:1
gbl_float_exception_flags        EQU	0x0000003B ; bytes:1
gbl_17_gbl_aSig                  EQU	0x00000024 ; bytes:4
gbl_17_gbl_bSig                  EQU	0x00000028 ; bytes:4
gbl_17_gbl_zSig                  EQU	0x0000002C ; bytes:4
gbl_17_gbl_aExp                  EQU	0x0000003C ; bytes:1
gbl_17_gbl_bExp                  EQU	0x0000003D ; bytes:1
gbl_17_gbl_zExp                  EQU	0x00000037 ; bytes:2
gbl_17_gbl_aSign                 EQU	0x0000003E ; bytes:1
gbl_17_gbl_bSign                 EQU	0x0000003F ; bytes:1
gbl_17_gbl_zSign                 EQU	0x00000040 ; bytes:1
gbl_17_gbl_zSigZero              EQU	0x00000041 ; bytes:1
gbl_17_gbl_ret                   EQU	0x00000030 ; bytes:4
gbl_indf                         EQU	0x00000000 ; bytes:1
gbl_tmr0                         EQU	0x00000001 ; bytes:1
gbl_pcl                          EQU	0x00000002 ; bytes:1
gbl_fsr                          EQU	0x00000004 ; bytes:1
gbl_porta                        EQU	0x00000005 ; bytes:1
gbl_portb                        EQU	0x00000006 ; bytes:1
gbl_portc                        EQU	0x00000007 ; bytes:1
gbl_pclath                       EQU	0x0000000A ; bytes:1
gbl_intcon                       EQU	0x0000000B ; bytes:1
gbl_pir1                         EQU	0x0000000C ; bytes:1
gbl_tmr1l                        EQU	0x0000000E ; bytes:1
gbl_tmr1h                        EQU	0x0000000F ; bytes:1
gbl_t1con                        EQU	0x00000010 ; bytes:1
gbl_tmr2                         EQU	0x00000011 ; bytes:1
gbl_t2con                        EQU	0x00000012 ; bytes:1
gbl_sspbuf                       EQU	0x00000013 ; bytes:1
gbl_sspcon                       EQU	0x00000014 ; bytes:1
gbl_ccpr1l                       EQU	0x00000015 ; bytes:1
gbl_ccpr1h                       EQU	0x00000016 ; bytes:1
gbl_ccp1con                      EQU	0x00000017 ; bytes:1
gbl_adres                        EQU	0x0000001E ; bytes:1
gbl_adcon0                       EQU	0x0000001F ; bytes:1
gbl_option_reg                   EQU	0x00000081 ; bytes:1
gbl_trisa                        EQU	0x00000085 ; bytes:1
gbl_trisb                        EQU	0x00000086 ; bytes:1
gbl_trisc                        EQU	0x00000087 ; bytes:1
gbl_pie1                         EQU	0x0000008C ; bytes:1
gbl_pcon                         EQU	0x0000008E ; bytes:1
gbl_pr2                          EQU	0x00000092 ; bytes:1
gbl_sspadd                       EQU	0x00000093 ; bytes:1
gbl_sspstat                      EQU	0x00000094 ; bytes:1
gbl_adcon1                       EQU	0x0000009F ; bytes:1
gbl_pmdatl                       EQU	0x0000010C ; bytes:1
gbl_pmadrl                       EQU	0x0000010D ; bytes:1
gbl_pmdath                       EQU	0x0000010E ; bytes:1
gbl_pmadrh                       EQU	0x0000010F ; bytes:1
gbl_pmcon1                       EQU	0x0000018C ; bytes:1
delay_ms_00000_arg_del           EQU	0x00000043 ; bytes:1
delay_s_00000_arg_del            EQU	0x00000042 ; bytes:1
Int1Context                      EQU	0x0000007F ; bytes:1
Int1BContext                     EQU	0x00000034 ; bytes:3
	ORG 0x00000000
	GOTO	_startup
	ORG 0x00000004
	MOVWF Int1Context
	SWAPF STATUS, W
	BCF STATUS, RP0
	BCF STATUS, RP1
	MOVWF Int1BContext
	SWAPF PCLATH, W
	MOVWF Int1BContext+D'1'
	SWAPF FSR, W
	MOVWF Int1BContext+D'2'
	BCF PCLATH,3
	BCF PCLATH,4
	GOTO	interrupt
	ORG 0x00000010
delay_ms_00000
; { delay_ms ; function begin
	MOVF delay_ms_00000_arg_del, F
	BTFSS STATUS,Z
	GOTO	label1
	RETURN
label1
	MOVLW 0xF5
label2
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	ADDLW 0xFF
	BTFSS STATUS,Z
	GOTO	label2
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	DECFSZ delay_ms_00000_arg_del, F
	GOTO	label1
	RETURN
; } delay_ms function end

	ORG 0x00000038
delay_s_00000
; { delay_s ; function begin
label3
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del
	CALL delay_ms_00000
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del
	CALL delay_ms_00000
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del
	CALL delay_ms_00000
	MOVLW 0xFA
	MOVWF delay_ms_00000_arg_del
	CALL delay_ms_00000
	DECFSZ delay_s_00000_arg_del, F
	GOTO	label3
	RETURN
; } delay_s function end

	ORG 0x00000047
main
; { main ; function begin
	MOVLW 0x07
	BSF STATUS, RP0
	BCF STATUS, RP1
	MOVWF gbl_adcon1
	MOVLW 0xC0
	MOVWF gbl_option_reg
label4
	BSF STATUS, RP0
	CLRF gbl_trisc
	MOVLW 0x01
	BCF STATUS, RP0
	MOVWF gbl_portc
	MOVWF delay_s_00000_arg_del
	CALL delay_s_00000
	BSF STATUS, RP0
	CLRF gbl_trisc
	BCF STATUS, RP0
	CLRF gbl_portc
	MOVLW 0x01
	MOVWF delay_s_00000_arg_del
	CALL delay_s_00000
	GOTO	label4
; } main function end

	ORG 0x0000005C
_startup
	MOVLW 0xD5
	BCF STATUS, RP0
	BCF STATUS, RP1
	MOVWF gbl_16_LSR
	MOVLW 0xC4
	MOVWF gbl_16_LSR+D'1'
	MOVLW 0xBB
	MOVWF gbl_16_LSR+D'2'
	MOVLW 0xDC
	MOVWF gbl_16_LSR+D'3'
	CLRF gbl_17_gbl_aSig
	CLRF gbl_17_gbl_aSig+D'1'
	CLRF gbl_17_gbl_aSig+D'2'
	CLRF gbl_17_gbl_aSig+D'3'
	CLRF gbl_17_gbl_bSig
	CLRF gbl_17_gbl_bSig+D'1'
	CLRF gbl_17_gbl_bSig+D'2'
	CLRF gbl_17_gbl_bSig+D'3'
	CLRF gbl_17_gbl_zSig
	CLRF gbl_17_gbl_zSig+D'1'
	CLRF gbl_17_gbl_zSig+D'2'
	CLRF gbl_17_gbl_zSig+D'3'
	CLRF gbl_17_gbl_aExp
	CLRF gbl_17_gbl_bExp
	CLRF gbl_17_gbl_zExp
	CLRF gbl_17_gbl_zExp+D'1'
	CLRF gbl_17_gbl_aSign
	CLRF gbl_17_gbl_bSign
	CLRF gbl_17_gbl_zSign
	CLRF gbl_17_gbl_zSigZero
	CLRF gbl_17_gbl_ret
	CLRF gbl_17_gbl_ret+D'1'
	CLRF gbl_17_gbl_ret+D'2'
	CLRF gbl_17_gbl_ret+D'3'
	CLRF gbl_float_rounding_mode
	CLRF gbl_float_exception_flags
	CLRF gbl_float_detect_tininess
	BCF PCLATH,3
	BCF PCLATH,4
	GOTO	main
	ORG 0x00000084
interrupt
; { interrupt ; function begin
	BCF STATUS, RP0
	BCF STATUS, RP1
	SWAPF Int1BContext+D'2', W
	MOVWF FSR
	SWAPF Int1BContext+D'1', W
	MOVWF PCLATH
	SWAPF Int1BContext, W
	MOVWF STATUS
	SWAPF Int1Context, F
	SWAPF Int1Context, W
	RETFIE
; } interrupt function end

	ORG 0x00002007
	DW 0x3FAA
	END
