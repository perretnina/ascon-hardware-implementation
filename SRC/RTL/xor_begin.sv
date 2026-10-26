//importer le package ascon pour obtenir les définitions de type_state et la constante 
import ascon_pack::*;

module xor_begin(
	input logic enable_xb_i, //signal de sélection du mux
	input logic [127:0] data_i,
	input type_state mux_a_xb_i, //entrée
	output type_state xb_a_pc_o //sortie
);

//les lignes 0 et 1 de l'état courant sont XORées
assign  xb_a_pc_o[0] = (enable_xb_i == 1'b1) ?  mux_a_xb_i[0]^data_i[63:0] :  mux_a_xb_i[0];
assign  xb_a_pc_o[1] = (enable_xb_i == 1'b1) ?  mux_a_xb_i[1]^data_i[127:64] :  mux_a_xb_i[1];
assign  xb_a_pc_o[2] = mux_a_xb_i[2];
assign  xb_a_pc_o[3] = mux_a_xb_i[3];
assign  xb_a_pc_o[4] = mux_a_xb_i[4];

endmodule : xor_begin
