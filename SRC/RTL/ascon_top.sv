//importer le package ascon pour obtenir les définitions de type_state et la constante 
import ascon_pack::*;

//module 
module ascon_top (
	//entrées
	input logic clock_i,
	input logic resetb_i, 
	input logic start_i,
	input logic data_valid_i,
	input logic [127:0] data_i,
	input logic [127:0] key_i,
	input logic [127:0] nonce_i,

	//sorties
	output logic end_o,
	output logic end_init_o,
	output logic end_da_o,
	output logic end_cipher_o,
	output logic cipher_valid_o,
	output logic [127:0] cipher_o,
	output logic [127:0] tag_o
);
	
//Déclaration des signaux internes
logic init_round_p12_s;
logic init_round_p8_s;
logic active_round_s;
logic [3:0] round_s;

logic init_s;
logic enable_xb_s;
logic [1:0] enable_xe_s;
logic enable_p_s;
logic enable_tag_s;
logic enable_cipher_s;


//Instanciation -------------------------------------------------------
//3 modules : FSM_Moore, round(compteur_double_init) et Permutation

//FSM

FSM_Moore FSM_Moore_1 (
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.start_i(start_i),
	.data_valid_i(data_valid_i),
	
	.active_round_o(active_round_s),
	.init_round_p8_o(init_round_p8_s),
	.init_round_p12_o(init_round_p12_s), 

	.round_i(round_s),
	
	.init_o(init_s),
	.enable_cipher_o(enable_cipher_s),
	.enable_tag_o(enable_tag_s),
	.enable_p_o(enable_p_s),
	.enable_xe_o(enable_xe_s),
	.enable_xb_o(enable_xb_s),

	.end_o(end_o),
	.cipher_valid_o(cipher_valid_o),
	.end_init_o(end_init_o),
	.end_da_o(end_da_o),
	.end_cipher_o(end_cipher_o)
);

//Permutation
Permutation Permutation_1(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.init_i(init_s),
	.round_i(round_s),
	.enable_xe_i(enable_xe_s),
	.enable_xb_i(enable_xb_s),	
	.data_i(data_i),
	.key_i(key_i),
	.nonce_i(nonce_i),
	.enable_p_i(enable_p_s), 
	.enable_cipher_i(enable_cipher_s), 
	.enable_tag_i(enable_tag_s),
	.tag_o(tag_o),
	.cipher_o(cipher_o)
);

//Round

compteur_double_init compteur_double_init_1 (
    .clock_i(clock_i),
    .resetb_i(resetb_i),
    .en_i(active_round_s),
    .init_a_i(init_round_p12_s),
    .init_b_i(init_round_p8_s),
    .cpt_o(round_s)

);

endmodule : ascon_top
