//importer le package ascon pour obtenir les définitions de type_state et la constante 
import ascon_pack::*;

//module FSM
module FSM_Moore(

	//entrées

	input logic clock_i,
	input logic resetb_i,
	input logic start_i, 
	input logic data_valid_i,
	

	//round
	output logic active_round_o,
	output logic init_round_p8_o,
	output logic init_round_p12_o, 

	input logic [3:0] round_i,
	
	//entrées de permutation
	output logic init_o,
	output logic enable_cipher_o,
	output logic enable_tag_o,
	output logic enable_p_o,
	output logic [1:0] enable_xe_o,
	output logic enable_xb_o,

	//sorties de ascontop
	output logic end_o,
	output logic cipher_valid_o,
	output logic end_init_o,
	output logic end_da_o,
	output logic end_cipher_o
);

//Définition des états 
typedef enum {
	//Liste des états
	Idle_init,
	Conf_init,
	End_conf_init,
	Init,
	End_init,

	Idle_da, 
	Conf_da,
	End_conf_da,
	Da,
	End_da,

	Idle_tc1,
	Conf_tc1,
	End_conf_tc1,
	Tc1,

	Idle_tc2,
	Conf_tc2,
	End_conf_tc2,
	Tc2,
	End_tc2,

	Idle_fin,
	Conf_fin,
	End_conf_fin,
	Fin,
	End_fin,

	Stop
} state_t;

state_t Ep, Ef;

//Process séquentiel 
always_ff @(posedge clock_i or negedge resetb_i) begin : seq0
	if(resetb_i==1'b0)
		Ep <= Idle_init;
	else
		Ep <= Ef;
end : seq0;

//1er process combinatoire : Comb0

always_comb begin : comb0

case (Ep)

//Phase initialisation ---------------------------------------------------------------
	
	Idle_init : 
		if(start_i==1'b1)
			Ef=Conf_init;
		else
			Ef=Idle_init;

	Conf_init :
		Ef=End_conf_init;


	End_conf_init :
		Ef = Init;


	Init :
		if(round_i==4'ha)
			Ef=End_init;
		else
			Ef=Init;

	End_init :
		Ef=Idle_da;

//Phase donnée associée -------------------------------------------------------------

	Idle_da :
		if(data_valid_i==1'b1)
			Ef=Conf_da;
		else
			Ef=Idle_da;

	Conf_da :
		Ef=End_conf_da;


	End_conf_da :
		Ef = Da;

	Da :
		if(round_i==4'ha)
			Ef=End_da;
		else
			Ef=Da;

	End_da :
		Ef=Idle_tc1;

//Phase texte clair 1

	Idle_tc1 :
		if(data_valid_i==1'b1)
			Ef=Conf_tc1; 
		else
			Ef=Idle_tc1;

	Conf_tc1 :
		Ef=End_conf_tc1;


	End_conf_tc1 :
		Ef = Tc1;


	Tc1 :
		if(round_i==4'hb)
			Ef=Idle_tc2;
		else
			Ef=Tc1;

//Phase texte clair 2 -----------------------------------------------------------------

	Idle_tc2 :
		if(data_valid_i==1'b1)
			Ef=Conf_tc2; 
		else
			Ef=Idle_tc2;

	Conf_tc2 :
		Ef=End_conf_tc2;


	End_conf_tc2 :
		Ef = Tc2;

	Tc2 :
		if(round_i==4'ha)
			Ef=End_tc2;
		else
			Ef=Tc2;
	End_tc2 :
		Ef=Idle_fin;

//Phase finalisation ------------------------------------------------------------------

	Idle_fin :
		if(data_valid_i==1'b1)
			Ef=Conf_fin;
		else
			Ef=Idle_fin;

	Conf_fin :
		Ef=End_conf_fin;


	End_conf_fin :
		Ef = Fin;

	Fin :
		if(round_i==4'ha)
			Ef=End_fin;
		else
			Ef=Fin;

	End_fin :
		Ef=Stop;

	Stop :
		Ef=Stop;

	default: Ef=Idle_init;

endcase
end //: comb0;

//2e process combinatoire : Comb1

always_comb begin : comb1

case (Ep)

//Phase d'initialisation------------------------------------------------------------

	Idle_init:
	begin
		active_round_o = 1'b0;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end
	
	Conf_init :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b1; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	End_conf_init :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b1;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	Init : 
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	End_init :
	begin
		active_round_o = 1'b0;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b01;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b1;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

//Phase donnée associée --------------------------------------------------------------
	
	Idle_da :
	begin
		active_round_o = 1'b0;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	Conf_da :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b1;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	End_conf_da :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b1;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	Da :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	End_da : 
	begin
		active_round_o = 1'b0;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b10;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b1;
		end_cipher_o = 1'b0;
	end

//Phase texte clair 1 ----------------------------------------------------

	Idle_tc1 :
	begin
		active_round_o = 1'b0;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	Conf_tc1 :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b1;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	End_conf_tc1 :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b1;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b1;

		end_o = 1'b0;
		cipher_valid_o = 1'b1;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	Tc1 : 
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

//Phase texte clair 2 -----------------------------------------------------------------

	Idle_tc2 :
	begin
		active_round_o = 1'b0;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	Conf_tc2 :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b1;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	End_conf_tc2 :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b1;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b1;

		end_o = 1'b0;
		cipher_valid_o = 1'b1;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	Tc2 :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	End_tc2 :
	begin
		active_round_o = 1'b0;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b11;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

//Phase finalisation -----------------------------------------------------------------
	
	Idle_fin : 
	begin
		active_round_o = 1'b0;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	Conf_fin :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b1; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	End_conf_fin :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b1;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b1;

		end_o = 1'b0;
		cipher_valid_o = 1'b1;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b1;
	end

	Fin :
	begin
		active_round_o = 1'b1;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	End_fin : 
	begin
		active_round_o = 1'b0;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b1;
		enable_p_o = 1'b1;
		enable_xe_o = 2'b01;
		enable_xb_o = 1'b0;

		end_o = 1'b1;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	Stop : //état Stop = état qui boucle sur lui-même pour finir la FSM
	begin
		active_round_o = 1'b0;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

	default : 
	begin
		active_round_o = 1'b0;
		init_round_p8_o = 1'b0;
		init_round_p12_o = 1'b0; 

		init_o = 1'b0;
		enable_cipher_o = 1'b0;
		enable_tag_o = 1'b0;
		enable_p_o = 1'b0;
		enable_xe_o = 2'b00;
		enable_xb_o = 1'b0;

		end_o = 1'b0;
		cipher_valid_o = 1'b0;
		end_init_o = 1'b0;
		end_da_o = 1'b0;
		end_cipher_o = 1'b0;
	end

endcase
end //: comb1;

endmodule : FSM_Moore
