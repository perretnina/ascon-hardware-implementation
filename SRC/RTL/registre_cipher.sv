// Import ascon package
import ascon_pack::*;

module registre_cipher

(
	input  logic clock_i,
	input  logic resetb_i,
	input  logic enable_cipher_i, //write enable
	input  type_state registre_i, //entrée = état courant
	input logic [127:0] memoire_cipher_i, //mémoire 

	output logic[127:0] cipher_o //sortie de cipher register
);

always_ff @(posedge clock_i or negedge resetb_i) begin
        if (!resetb_i)
            cipher_o <= 128'h0;
        else if (enable_cipher_i)
            cipher_o <= {registre_i[1],registre_i[0]}; //état courant lignes 1 et 0
	else
		cipher_o <= memoire_cipher_i; //mémoire de cipher register
    end
    
endmodule : registre_cipher
