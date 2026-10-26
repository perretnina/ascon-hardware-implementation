//importer le package ascon pour obtenir les définitions de type_state et la constante 
import ascon_pack::*;


//module Permutation 
module Permutation(
	//entrées
	input logic clock_i,
	input logic resetb_i,
	input logic init_i,
	input logic [3:0] round_i,
	input logic [1:0] enable_xe_i, //pour xor_end
	input logic enable_xb_i,	//pour xor_begin
	input logic [127:0] data_i,
	input logic [127:0] key_i,
	input logic [127:0] nonce_i,
	input logic enable_p_i, //write enable du registre state
	input logic enable_cipher_i, // write enable du registre cipher
	input logic enable_tag_i, //write enable du registre tag
	//sorties
	output logic [127:0] tag_o,
	output logic [127:0] cipher_o
);

//signaux internes typestate 
type_state state_in_s; //entrée départ 
type_state mux_a_xb_s; //mux à xor begin
type_state xb_a_pc_s; //xor begin au module Pc
type_state pc_a_ps_s; //module Pc à Ps
type_state ps_a_pl_s; //module Ps à Pl
type_state pl_a_xe_s; // module Pl à xor end
type_state xe_a_reg_s; //xor end à state register
type_state memoire_s; //memoire de state register
type_state memoire_cipher_s; //mémoire de cipher register
type_state memoire_tag_s; //mémoire de tag register
type_state reg_a_mux_s; //state register à mux d'entrée

// depart : IV, Key, nonce
assign state_in_s[0] = 64'h00001000808c0001;// IV
assign state_in_s[1] = key_i[63:0];
assign state_in_s[2] = key_i[127:64];
assign state_in_s[3] = nonce_i[63:0];
assign state_in_s[4] = nonce_i[127:64];

//multiplexeur 
assign mux_a_xb_s = (init_i ==1'b1) ? state_in_s : reg_a_mux_s;

//xor begin
xor_begin xor_begin_inst (
	.enable_xb_i(enable_xb_i),
	.data_i(data_i),
	.mux_a_xb_i(mux_a_xb_s),
	.xb_a_pc_o(xb_a_pc_s)
);

//registre cipher

 registre_cipher registre_cipher_inst(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.enable_cipher_i(enable_cipher_i),
	.registre_i(xb_a_pc_s),
	.memoire_cipher_i(memoire_cipher_s),
	.cipher_o(cipher_o)
);

//instanciation des composants : p = Pc -> Ps -> Pl

    //addition de constante
    Pc Pc_inst (
        .Pc_in_i(xb_a_pc_s),
	.round_i(round_i),
	.Pc_out_o(pc_a_ps_s)
   );

    //substitution
    Ps Ps_inst (
        .Ps_in_i(pc_a_ps_s),
        .Ps_out_o(ps_a_pl_s)
    );

    //diffusion
    Pl Pl_inst (
        .Pl_in_i(ps_a_pl_s),
        .Pl_out_o(pl_a_xe_s)
    );

//xor end
 xor_end xor_end_inst(
	.enable_xe_i(enable_xe_i),
	.key_i(key_i),
	.pl_a_xe_i(pl_a_xe_s),
	.xe_a_reg_o(xe_a_reg_s)
);

//Registre tag
 registre_tag registre_tag_inst(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.enable_tag_i(enable_tag_i),
	.registre_i(xe_a_reg_s),
	.memoire_tag_i(memoire_tag_s),
	.tag_o(tag_o)
);

//Registre state
	state_registre state_registre_inst(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.enable_p_i(enable_p_i),
	.xe_a_reg_i(xe_a_reg_s),
	.memoire_i(memoire_s),
	.reg_a_mux_o(reg_a_mux_s)
);

assign memoire_s = (enable_p_i ==1'b1) ? reg_a_mux_s : memoire_s;


endmodule : Permutation
