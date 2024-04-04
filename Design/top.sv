// ------------------------------------------------------------ TOP MODULE -----------------------------------------------------
 module top();
        import count_pkg::*; // Ellame ore code ah irundha import panna venaam
        reg clk;

        count_if DUV_IF(clk);

        test test_h;

        counter DUV(.clk(clk),
                    .d_in(DUV_IF.d_in),
                    .load(DUV_IF.load),
                    .up_dn(DUV_IF.up_dn),
                    .rst(DUV_IF.rst),
                    .count(DUV_IF.count)
					);
					
// CLOCK GEN
        initial begin
                clk = 1'b0;
                forever
                        #10 clk = ~clk; //clock generation
        end

        initial begin
                if($test$plusargs("TEST"))
                begin
                        test_h = new(DUV_IF, DUV_IF, DUV_IF);
						int no_of_transactions = 200;	
                        test_h.build();
                        test_h.run();
                        $finish;
                end
        end
endmodule: top
