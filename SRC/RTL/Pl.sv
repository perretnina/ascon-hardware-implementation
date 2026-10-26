//importer le package ascon pour obtenir les définitions de type_state et la constante 
import ascon_pack::*;

//module Pl : couche de diffusion linéaire
module Pl (
	input type_state Pl_in_i,
	output type_state Pl_out_o
);

//fonction rotation cyclique : on veut que les bits décalés à droite "reviennent" à gauchze (rotation) 

function automatic logic [63:0] rotation_cyclique(input logic[63:0] x, input int n);
	return (x >> n) | (x << (64-n)); // on effectue le décalage à droite puis on "recolle" à gauche les bits "perdus" lors du décalage 
endfunction

//déclaration

assign Pl_out_o[0] = Pl_in_i[0] ^ rotation_cyclique(Pl_in_i[0], 19) ^ rotation_cyclique(Pl_in_i[0], 28);

assign Pl_out_o[1] = Pl_in_i[1] ^ rotation_cyclique(Pl_in_i[1], 61) ^ rotation_cyclique(Pl_in_i[1], 39);

assign Pl_out_o[2] = Pl_in_i[2] ^ rotation_cyclique(Pl_in_i[2], 1) ^ rotation_cyclique(Pl_in_i[2], 6);

assign Pl_out_o[3] = Pl_in_i[3] ^ rotation_cyclique(Pl_in_i[3], 10) ^ rotation_cyclique(Pl_in_i[3], 17);

assign Pl_out_o[4] = Pl_in_i[4] ^ rotation_cyclique(Pl_in_i[4], 7) ^ rotation_cyclique(Pl_in_i[4], 41);

endmodule : Pl
