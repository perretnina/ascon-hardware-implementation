//importer le package ascon pour obtenir les définitions de type_state et la constante 
import ascon_pack::*;


//composant sbox
module sbox(
	input logic [4:0] sbox_in_i,
	output logic [4:0] sbox_out_o
	);

//partie comportementale
	always @(sbox_in_i) begin : Ps_behav
		case(sbox_in_i)
		0: 
			sbox_out_o=5'h04;
		1:
			sbox_out_o=5'h0B;
		2:
			sbox_out_o=5'h1F;
		3:
			sbox_out_o=5'h14;
		4:
			sbox_out_o=5'h1A;
		5:
			sbox_out_o=5'h15;
		6: 
			sbox_out_o=5'h09;
		7: 
			sbox_out_o=5'h02;
		8:
			sbox_out_o=5'h1B;
		9: 
			sbox_out_o=5'h05;
		10: 
			sbox_out_o=5'h08;
		11:
			sbox_out_o=5'h12;
		12:
			sbox_out_o=5'h1D;
		13:
			sbox_out_o=5'h03;
		14:
			sbox_out_o=5'h06;
		15:
			sbox_out_o=5'h1C;
		16:
			sbox_out_o=5'h1E;
		17:
			sbox_out_o=5'h13;
		18:
			sbox_out_o=5'h07;
		19:
			sbox_out_o=5'h0E;
		20:
			sbox_out_o=5'h00;
		21:
			sbox_out_o=5'h0D;
		22:
			sbox_out_o=5'h11;
		23:
			sbox_out_o=5'h18;
		24:
			sbox_out_o=5'h10;
		25:
			sbox_out_o=5'h0C;
		26:
			sbox_out_o=5'h01;
		27:
			sbox_out_o=5'h19;
		28:
			sbox_out_o=5'h16;
		29:
			sbox_out_o=5'h0A;
		30:
			sbox_out_o=5'h0F;
		31:
			sbox_out_o=5'h17;		
		endcase
	end : Ps_behav

endmodule : sbox

//module Ps
module Ps(
	input type_state Ps_in_i,
	output type_state Ps_out_o
	);

genvar i; //déclaration paramètre utilisé dans la boucle

//partie générative
generate
	for (i=0; i< 64; i++) begin : boucle
		sbox sbox_inst(
    			.sbox_in_i({Ps_in_i[0][i], Ps_in_i[1][i], Ps_in_i[2][i], Ps_in_i[3][i], Ps_in_i[4][i]}),
    			.sbox_out_o({Ps_out_o[0][i], Ps_out_o[1][i], Ps_out_o[2][i], Ps_out_o[3][i], Ps_out_o[4][i]})
);

	end : boucle
endgenerate 

endmodule : Ps
