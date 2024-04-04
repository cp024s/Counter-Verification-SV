module counter(
        input clk,
        input [3:0]d_in,
        input load,
        input rst,
        input up_dn,

        output reg[3:0]count
		);

always @(posedge clk)
        begin
                if(rst)
                        count <= 4'b0000;
                else if(load)
                        count <=d_in;
                else if(up_dn==0)
                        begin
                                if(count >12)
                                        count <= 4'b0;
                                else
                                        count <= count +1'b1;
                                end
                else
                        begin
                                if((count>10)||(count<2))
                                        count <= 4'd10;
                                else
                                        count <= count-1'b1;
                        end
        end
endmodule: counter
