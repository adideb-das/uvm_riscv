module Control_Unit(
	
    input [31:0] inst_data,
    output [1:0] alusrc,
    output memtoreg,
    output regwrite,
    output [3:0] memwrite,
    output [2:0] branch,
    output [1:0] aluop,
	 output [1:0] regin,
	 output [2:0] imm,
	 output[3:0] mul_div_op,
	 output opinvalid
    );
	 
	 
	 
	 
	 
	 
	 
	 
	 
logic [6:0] opcode;
logic [2:0] funct3;








assign opcode = inst_data[6:0];
assign funct3 = inst_data[14:12];







// to check if opcode is invalid
assign opinvalid = ~((opcode == 7'b0110111) || (opcode == 7'b0010111) || ((opcode == 7'b1100111) && (funct3==0))|| ((opcode == 7'b1100011) && (funct3 != 2) && (funct3 !=3) )|| (opcode == 7'b1101111) || ((opcode == 7'b0000011) && (funct3!=3) && (funct3!=6) && (funct3!=7)) || ((opcode == 7'b0100011) && ((funct3 ==0) || (funct3 == 1) || (funct3 == 2)) ) || (opcode == 7'b0010011 )|| (opcode == 7'b0110011) );
                          //LUI             //AUIPC                    //JAL                                               //branch                                                     //JAL                // load                                                                  //store                                                                              ALUI                                       	



	
								  
assign branch=  (opcode == 7'b1100011 && funct3 == 3'b000)? 3'b010:
					 (opcode == 7'b1100011 && funct3 == 3'b101)? 3'b010:
					 (opcode == 7'b1100011 && funct3 == 3'b111)? 3'b010:
					 (opcode == 7'b1100011 && funct3 == 3'b001)? 3'b001:
					 (opcode == 7'b1100011 && funct3 == 3'b100)? 3'b001:
					 (opcode == 7'b1100011 && funct3 == 3'b110)? 3'b001:
					 (opcode == 7'b1101111 )? 3'b011 : 
					 (opcode == 7'b1100111 )? 3'b100 : 3'b000;

					 
					 
					 
					 

assign memtoreg = (opcode == 7'b0000011);




					
assign memwrite=(opcode == 7'b0100011 && funct3 == 3'b010)? 4'b1111:
					 (opcode == 7'b0100011 && funct3 == 3'b001)? 4'b0011:
					 (opcode == 7'b0100011 && funct3 == 3'b000)? 4'b0001:4'b0000;
					 


					 
					 
					 
assign regwrite=(opinvalid || 
                 opcode == 7'b0110011 ||
					  opcode == 7'b0000011 || 
					  opcode == 7'b0010011 ||
					  opcode == 7'b1101111 ||
					  opcode == 7'b1100111 ||
					  opcode == 7'b0010111 || 
					  opcode == 7'b0110111);




					  
					  
assign alusrc[0] = (opcode == 7'b0100011 || opcode == 7'b0000011 || opcode == 7'b0010011 || opcode == 7'b0010111 || opcode == 7'b1100111);
assign alusrc[1] = (opcode == 7'b0010111 );






assign aluop[1] = (opcode == 7'b0110011 || opcode == 7'b0010011 );
assign aluop[0] = (opcode == 7'b1100011 );






assign regin = (opcode == 7'b0110111) ? 2'b00 :
					(opcode == 7'b1101111 || opcode == 7'b1100111) ? 2'b10 : 2'b01;

	

	
					
					
assign imm = (opcode == 7'b0100011) ? 3'b001 :
				 (opcode == 7'b0110111 || opcode == 7'b0010111) ? 3'b010 :
				 (opcode == 7'b1101111) ? 3'b011 :
				 (opcode == 7'b1100011) ? 3'b100 :
				 (opcode == 7'b0000011 && (funct3 == 3'b100 || funct3 == 3'b101)) ? 3'b101 : 3'b000;
				 
				 
	


	



assign mul_div_op = (opcode != 7'b0110011) ? 4'b1111 :
                    (funct3 == 3'b000) ? 4'b0000 :
						        (funct3 == 3'b001) ? 4'b0001 :
						        (funct3 == 3'b010) ? 4'b0010 :
						        (funct3 == 3'b011) ? 4'b0011 :
						        (funct3 == 3'b100) ? 4'b0100 :
						        (funct3 == 3'b101) ? 4'b0101 :
						        (funct3 == 3'b110) ? 4'b0110 :4'b0111 ;


			


			
				 
endmodule
