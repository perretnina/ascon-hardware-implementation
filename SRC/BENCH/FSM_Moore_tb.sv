`timescale 1ns / 1ps

//importer le package ascon pour obtenir la définition de type_state
import ascon_pack::*;

module FSM_Moore_tb (
//partie déclarative vide
);

logic clock_i_s;
logic resetb_i_s;
logic start_i_s; 
logic data_valid_i_s;
	
logic active_round_o_s;
logic init_round_p8_o_s;
logic init_round_p12_o_s;

logic [3:0] round_i_s;

logic init_o_s;
logic enable_cipher_o_s;
logic enable_tag_o_s;
logic enable_p_o_s;
logic [1:0] enable_xe_o_s;
logic enable_xb_o_s;

logic end_o_s;
logic cipher_valid_o_s;
logic end_init_o_s;
logic end_da_o_s;
logic end_cipher_o_s;

//DUT : instanciation composant 
FSM_Moore DUT (
	.clock_i(clock_i_s),
	.resetb_i(resetb_i_s),
	.start_i(start_i_s),
	.data_valid_i(data_valid_i_s),
	.active_round_o(active_round_o_s),
	.init_round_p8_o(init_round_p8_o_s),
	.init_round_p12_o(init_round_p12_o_s),
	.round_i(round_i_s),
	.init_o(init_o_s),
	.enable_cipher_o(enable_cipher_o_s),
	.enable_tag_o(enable_tag_o_s),
	.enable_p_o(enable_p_o_s),
	.enable_xe_o(enable_xe_o_s),
	.enable_xb_o(enable_xb_o_s),
	.end_o(end_o_s),
	.cipher_valid_o(cipher_valid_o_s),
	.end_init_o(end_init_o_s),
	.end_da_o(end_da_o_s),
	.end_cipher_o(end_cipher_o_s)
);



//génération horloge
initial begin
clock_i_s=0;
forever #5 clock_i_s = ~clock_i_s;
end

//génération stimuli
initial begin

//Initialisation ---------------------------------------------------------------------

	resetb_i_s = 0; 
	start_i_s = 0;
	data_valid_i_s= 0;
	round_i_s= 0;

	#50;

	resetb_i_s= 1; //on réinitialise

	#20;

	start_i_s = 1; //sortie de idle

	#50;
			
	repeat (11) begin //permutations (12)
		round_i_s = round_i_s + 1;
		#20;
	end

//Donnée associée ---------------------------------------------------------------------
	
	data_valid_i_s = 1'b1; //début de la phase donnée associée

	#20;

	data_valid_i_s = 1'b0;
	round_i_s=4'b0100; //initialisation du compteur de permutations à 4 (car on fait 8 permutations)

	#20;

	repeat (7) begin //8 permutations
		round_i_s = round_i_s + 1;
		#20;
	end

//Texte clair 1 -----------------------------------------------------------------------

	data_valid_i_s = 1'b1; //début de la phase tc1

	#20;

	data_valid_i_s = 1'b0;
	round_i_s=4'b0100; //initialisation du compteur à 4 (car on fait 8 permutations)

	#20;

	repeat (7) begin //8 permutations
		round_i_s = round_i_s + 1;
		#20;
	end

//Texte clair 2 -----------------------------------------------------------------------


	data_valid_i_s = 1'b1; //début de la phase tc2

	#20;

	data_valid_i_s = 1'b0;
	round_i_s=4'b0100; //initialsiation du compteur à 4 (8 permutations)

	#20;

	repeat (7) begin 
		round_i_s = round_i_s + 1;
		#20;
	end

//Finalisation ------------------------------------------------------------------------

	data_valid_i_s = 1'b1; //début de la phase finalisation (plaintext3 -> cipher3)

	#20;

	data_valid_i_s = 1'b0;
	round_i_s = 0; 

	#20;

	repeat (11) begin  //12 permutations
		round_i_s = round_i_s + 1;
		#20;
	end

end

endmodule : FSM_Moore_tb
