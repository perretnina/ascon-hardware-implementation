//importer le package ascon pour obtenir les définitions de type_state et la constante 
import ascon_pack::*;

module Pc(
	input type_state Pc_in_i,
	input logic [3:0] round_i,
	output type_state Pc_out_o);

//déclaration interne 

logic [7:0] Cr_s;

assign Cr_s = round_constant[round_i]; //round_constant est définie dasn ascon_pack

assign Pc_out_o[0] = Pc_in_i[0];
assign Pc_out_o[1] = Pc_in_i[1];
assign Pc_out_o[2][63:8] = Pc_in_i[2][63:8]; //bits de poids fort restent inchangés 
assign Pc_out_o[2][7:0] = Pc_in_i[2][7:0]^Cr_s; //XOR sur les bits de poids faible avec la constante
assign Pc_out_o[3] = Pc_in_i[3];
assign Pc_out_o[4] = Pc_in_i[4];

endmodule : Pc
