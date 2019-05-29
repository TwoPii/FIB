// Controller module
// David_Harris@hmc.edu 12/26/00
// 
// Modified by YOUR NAME HERE on TODAYS DATE
// for Lab 4.
//
// This module describes a controller for a 
// multicycle MIPS processor like that given
// in Patterson & Hennessy,
// Computer Organization & Design (3rd Ed.)
// It contains the control FSM and the additional
// and/or logic for branching.  It does not
// contain the alucontrol logic.

// Using busses would be cleaner, but is not supported
// well by the Electric Silicon Compiler.

// Updated 12/31/02 dh with pcen
// Update  1/14/04 dh with corrected LB and SB opcodes
// Rolled back these updates

// This is missing the logic for the ADDI instruction.
// Add next state and output logic to support ADDI.

module controller(ph1, ph2, reset, 
			op0, op1, op2, op3, op4, op5,
			zero,
			memread, memwrite, pchange, regwrite,
			irwrite0, irwrite1, irwrite2, irwrite3,
			aluop0, aluop1, alusrca, alusrcb0, alusrcb1, 
			pcsource0, pcsource1, iord, memtoreg, regdst);

	input			ph1, ph2;
	input			reset;
	input			op0, op1, op2, op3, op4, op5;
	input			zero;

	output 		memread;
	output		memwrite;
	output		irwrite0, irwrite1, irwrite2, irwrite3;
	output		pchange;
	output		regwrite;
	output		aluop0, aluop1;
	output 	 	alusrca;
	output		alusrcb0, alusrcb1;
	output		pcsource0, pcsource1;
	output		iord;
	output		memtoreg;
	output		regdst;

	// multicycle state machine state definitions
	parameter	FETCH1 = 4'b0000;
	parameter	FETCH2 = 4'b0001;
	parameter	FETCH3 = 4'b0010;
	parameter	FETCH4 = 4'b0011;
	parameter	DECODE = 4'b0100;
	parameter	MEMADR = 4'b0101;
	parameter	LBRD   = 4'b0110;
	parameter	LBWR   = 4'b0111;
	parameter	SBWR   = 4'b1000;
	parameter	RTYPEEX= 4'b1001;
	parameter	RTYPEWR= 4'b1010;
	parameter	BEQEX  = 4'b1011;
	parameter	JEX    = 4'b1100;
	parameter	ADDIWRITE = 4'b1101;

	// instruction opcodes
	parameter	LB	= 6'b010000;
	parameter	SB	= 6'b011000;
	parameter	RTYPE = 6'b000000;
	parameter	BEQ	= 6'b000100;
	parameter	J	= 6'b000010;
	parameter	ADDI	= 6'b001000;	

	// internal signals
	reg		[3:0]	nextstate_s2;
	reg		[3:0]	state_s1, state_s2;
	reg			memread, memwrite, regwrite;
	reg			pcwrite, pcwritecond;
	reg			irwrite3, irwrite2, irwrite1, irwrite0;
	reg			alusrca;
	reg			aluop1, aluop0;
	reg			alusrcb1, alusrcb0;
	reg			pcsource1, pcsource0;
	reg			iord, memtoreg, regdst;

	// state register
	always @(ph2 or nextstate_s2) // master latch
		if (ph2) state_s1 <= nextstate_s2;
	always @(ph1 or state_s1) // slave latch 
		if (ph1) state_s2 <= state_s1;

	// next state logic
	always @(state_s2 or op5 or op4 or op3 or op2 or op1 or op0 or reset)
		// state transition table given in Figure 5.42
		if (reset) nextstate_s2 <= FETCH1; // synchronous reset
  		else case (state_s2)
			FETCH1: nextstate_s2 <= FETCH2;
			FETCH2: nextstate_s2 <= FETCH3;
			FETCH3: nextstate_s2 <= FETCH4;
			FETCH4: nextstate_s2 <= DECODE;
			DECODE: case ({op5, op4, op3, op2, op1, op0})
				LB: nextstate_s2 <= MEMADR;
				SB: nextstate_s2 <= MEMADR;
				RTYPE: nextstate_s2 <= RTYPEEX;
				ADDI: nextstate_s2 <= MEMADR;
				BEQ: nextstate_s2 <= BEQEX;
				J: nextstate_s2 <= JEX;
				default: nextstate_s2 <= FETCH1;
			endcase
			MEMADR: case ({op5, op4, op3, op2, op1, op0}) // synopsys full_case
				LB: nextstate_s2 <= LBRD;
				SB: nextstate_s2 <= SBWR;
				ADDI: nextstate_s2 <= ADDIWRITE;
				// no default needed because of full_case directive
			endcase
			LBRD: nextstate_s2 <= LBWR;
			LBWR: nextstate_s2 <= FETCH1;
			SBWR: nextstate_s2 <= FETCH1;
			RTYPEEX: nextstate_s2 <= RTYPEWR;
			RTYPEWR: nextstate_s2 <= FETCH1;
			BEQEX: nextstate_s2 <= FETCH1;
			JEX: nextstate_s2 <= FETCH1;
			ADDIWRITE: nextstate_s2 <= FETCH1;
			default: nextstate_s2 <= FETCH1;
		endcase

	// output logic
	always @(state_s2)
		begin
			// provide default values for signals not specified
			memread <= 0;
			memwrite <= 0;
			irwrite3 <= 0;	irwrite2 <= 0;
			irwrite1 <= 0;	irwrite0 <= 0;
			pcwrite <= 0;
			pcwritecond <= 0;
			regwrite <= 0;
			alusrca <= 0;
			alusrcb1 <= 0; 	alusrcb0 <= 0;
			aluop1 <= 0; 	aluop0 <= 0;
			pcsource1 <= 0; 	pcsource0 <= 0;
			iord <= 0;
			memtoreg <= 0;
			regdst <= 0;

			// specify outputs according to Figure 5.42
			case (state_s2)
				FETCH1: begin
					memread <= 1;
					alusrca <= 0;
					iord <= 0;
					irwrite3 <= 1; // endianness
					alusrcb1 <= 0; 	alusrcb0 <= 1;
					aluop1 <= 0; 	aluop0 <= 0;
					pcwrite <= 1; 
					pcsource1 <= 0; 	pcsource0 <= 0;
					end
				FETCH2: begin
					memread <= 1;
					alusrca <= 0;
					iord <= 0;
					irwrite2 <= 1; // endianness
					alusrcb1 <= 0; 	alusrcb0 <= 1;
					aluop1 <= 0; 	aluop0 <= 0;
					pcwrite <= 1; 
					pcsource1 <= 0; 	pcsource0 <= 0;
					end
				FETCH3: begin
					memread <= 1;
					alusrca <= 0;
					iord <= 0;
					irwrite1 <= 1; // endianness
					alusrcb1 <= 0; 	alusrcb0 <= 1;
					aluop1 <= 0; 	aluop0 <= 0;
					pcwrite <= 1; 
					pcsource1 <= 0; 	pcsource0 <= 0;
					end
				FETCH4: begin
					memread <= 1;
					alusrca <= 0;
					iord <= 0;
					irwrite0 <= 1; // endianness
					alusrcb1 <= 0; 	alusrcb0 <= 1;
					aluop1 <= 0; 	aluop0 <= 0;
					pcwrite <= 1; 
					pcsource1 <= 0; 	pcsource0 <= 0;
					end
				DECODE: begin
					alusrca <= 0;
					alusrcb1 <= 1; 	alusrcb0 <= 1;
					aluop1 <= 0; 	aluop0 <= 0;
					end
				MEMADR: begin
					alusrca <= 1;
					alusrcb1 <= 1; 	alusrcb0 <= 0;
					aluop1 <= 0; 	aluop0 <= 0;
					end
				LBRD: begin
					memread <= 1;
					iord <= 1;
					end
				LBWR: begin
					regdst <= 0;
					regwrite <= 1;
					memtoreg <= 1;
					end
				SBWR: begin
					memwrite <= 1;
					iord <= 1;
					end
				RTYPEEX: begin
					alusrca <= 1;
					alusrcb1 <= 0; 	alusrcb0 <= 0;
					aluop1 <= 1; 	aluop0 <= 0;
					end
				RTYPEWR: begin
					regdst <= 1;
					regwrite <= 1;
					memtoreg <= 0;
					end
				BEQEX: begin
					alusrca <= 1;
					alusrcb1 <= 0; 	alusrcb0 <= 0;
					aluop1 <= 0; 	aluop0 <= 1;
					pcwritecond <= 1;
					pcsource1 <= 0; 	pcsource0 <= 1;
					end
				JEX: begin
					pcwrite <= 1;
					aluop0 <= 1;// not logically required, but a hack
							// to ensure aluop0 and pcsource0
							// aren't always identical.  If they
							// were identical, Synopysis would 
							// optimize one away, which confuses 
							// the Silicon Compiler.
					pcsource1 <= 1; 	pcsource0 <= 0;
					end
				ADDIWRITE: begin
					regdst <= 0;
					regwrite <= 1;
					memtoreg <= 0;
					end
				default: begin
					end
			endcase
		end

	// compute pchange, the write enable for the program counter
	assign pchange = pcwrite | (pcwritecond & zero);

endmodule