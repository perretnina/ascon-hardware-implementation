//importer le package ascon pour obtenir les définitions de type_state et la constante 
import ascon_pack::*;

module state_registre(
	input logic clock_i,
	input logic resetb_i,
	input logic enable_p_i,
	input type_state xe_a_reg_i, //entrée de state register= état courant
	input type_state memoire_i, //mémoire
	output type_state reg_a_mux_o //sortie de state register
);

//registre d'état : mémorisation 
always_ff @(posedge clock_i or negedge resetb_i) begin
	if (resetb_i == 1'b0) //si le reset est actif alors on met le registre à 0
		reg_a_mux_o <= '{64'h0, 64'h0, 64'h0, 64'h0, 64'h0}; 

	else //si le le reset est inactif alors on mémorise la sortie de permutation 
		if (enable_p_i == 1'b1)
			reg_a_mux_o <= xe_a_reg_i; //état courant
		else
			reg_a_mux_o <= memoire_i; //mémoire
end

endmodule : state_registre


