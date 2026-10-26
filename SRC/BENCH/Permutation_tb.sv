`timescale 1ns / 1ps

//importer le package ascon pour obtenir la définition de type_state
import ascon_pack::*;

module Permutation_tb(
//partie déclarative vide
);

logic clock_i_s;
logic resetb_i_s;
logic init_i_s;
logic [3:0] round_i_s;
logic [1:0] enable_xe_i_s; //pour xor_end

logic enable_xb_i_s;	//pour xor_begin
logic [127:0] data_i_s;
logic [127:0] key_i_s;
logic [127:0] nonce_i_s;
logic enable_p_i_s; //write enable du registre 

logic enable_cipher_i_s;
logic enable_tag_i_s;
logic [127:0] tag_o_s;
logic [127:0] cipher_o_s;

//DUT : instanciation composant 
Permutation DUT (
	.clock_i(clock_i_s),
	.resetb_i(resetb_i_s),
	.init_i(init_i_s),
	.round_i(round_i_s),
	.enable_xe_i(enable_xe_i_s),

	.enable_xb_i(enable_xb_i_s),
	.data_i(data_i_s),
	.key_i(key_i_s),
	.nonce_i(nonce_i_s),
	.enable_p_i(enable_p_i_s),

	.enable_cipher_i(enable_cipher_i_s),
	.enable_tag_i(enable_tag_i_s),
	.tag_o(tag_o_s),
	.cipher_o(cipher_o_s)
);

//génération horloge
initial begin
clock_i_s=0;
forever #5 clock_i_s = ~clock_i_s;
end

//génération stimuli
initial begin
	
	resetb_i_s=0; //réinitialisation
	init_i_s=1; //signal d'initialisation inactif
	round_i_s=0; //premier tour de permutation
	enable_xe_i_s=2'b00;
	enable_xb_i_s = 0;
	data_i_s = 128'h00000001626F42206F74206563696C41;
	key_i_s = 128'h691AED630E81901F6CB10AD9CA912F80;
	nonce_i_s = 128'h46487B3E06D9D7A80C4C36A20853217C;
	enable_p_i_s =0;
	enable_tag_i_s=0;
	enable_cipher_i_s=0;

	#2;
	resetb_i_s=1; //relachement du reset après 10ns
	enable_p_i_s =1;
	#5;
	init_i_s=0; 
	
//initialisation
	repeat(10)
	begin
		round_i_s ++;
	#10;
	end
	
	enable_xe_i_s = 2'b01;
	round_i_s ++;
	#10;
	enable_xe_i_s = 2'b00;
//da
	round_i_s = 4'h4;
	enable_xb_i_s = 1;
	#10;
	enable_xb_i_s = 0;
	repeat(6)
	begin
		round_i_s ++;
	#10;
	end
	
	enable_xe_i_s=2'b10;
	round_i_s ++;
	#10;
	enable_xe_i_s = 2'b00;

//tc1
	enable_xb_i_s = 1;
	enable_cipher_i_s=1;
	round_i_s = 4'h4;
	data_i_s = 128'h704F2065726964207475657620657551;
	#10;
	enable_xb_i_s = 0;
	enable_cipher_i_s=0;
	repeat(7)
	begin
		round_i_s ++;
	#10;
	end
	
//tc2

	round_i_s = 4'h4;
	enable_xb_i_s = 1;
	enable_cipher_i_s=1;
	data_i_s = 128'h766E49206561727574614E2061747265;
	#10;
	enable_xb_i_s = 0;
	enable_cipher_i_s=0;
	repeat(6)
	begin
		round_i_s ++;
	#10;
	end
	
	enable_xe_i_s=2'b11;
	round_i_s ++;
	#10;
	enable_xe_i_s = 2'b00;

//finalisation

	round_i_s = 0;
	enable_xb_i_s = 1;
	enable_cipher_i_s=1;
	data_i_s = 128'h013F206172656E754D20746E75696E65;
	#10;
	enable_xb_i_s = 0;
	enable_cipher_i_s=0;
	repeat(10)
	begin
		round_i_s ++;
	#10;
	end
	
	enable_xe_i_s=2'b01;
	enable_tag_i_s=1;
	round_i_s ++;
	#10;
	enable_xe_i_s = 2'b00;
	enable_tag_i_s=0;

	
end

endmodule : Permutation_tb
