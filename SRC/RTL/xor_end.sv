//importer le package ascon pour obtenir les définitions de type_state et la constante 
import ascon_pack::*;

module xor_end(
	input logic [1:0] enable_xe_i, //signal de sélection du mux
	input logic [127:0] key_i,
	input type_state pl_a_xe_i, //entrée = état courant
	output type_state xe_a_reg_o //sortie 
); 

//les lignes 3 et 4 de l'état courant sont XORées
always_comb begin
case(enable_xe_i) 
	2'b00: 
		xe_a_reg_o = pl_a_xe_i; //0 : entrée=sortie (on ne fait rien)
	2'b01: begin
		xe_a_reg_o[0] = pl_a_xe_i[0];
		xe_a_reg_o[1] = pl_a_xe_i[1];
		xe_a_reg_o[2] = pl_a_xe_i[2];
		xe_a_reg_o[3] = pl_a_xe_i[3]^key_i[63:0];
		xe_a_reg_o[4] = pl_a_xe_i[4]^key_i[127:64];
		end

	2'b10: begin
		xe_a_reg_o[0] = pl_a_xe_i[0];
		xe_a_reg_o[1] = pl_a_xe_i[1];
		xe_a_reg_o[2] = pl_a_xe_i[2];
		xe_a_reg_o[3] = pl_a_xe_i[3];
		xe_a_reg_o[4] = pl_a_xe_i[4]^64'h8000000000000000;
		end

	2'b11: begin
		xe_a_reg_o[0] = pl_a_xe_i[0];
		xe_a_reg_o[1] = pl_a_xe_i[1];
		xe_a_reg_o[2] = pl_a_xe_i[2]^key_i[63:0];
		xe_a_reg_o[3] = pl_a_xe_i[3]^key_i[127:64];
		xe_a_reg_o[4] = pl_a_xe_i[4];
		end


	default: xe_a_reg_o = pl_a_xe_i; 
endcase 
end 

endmodule : xor_end
