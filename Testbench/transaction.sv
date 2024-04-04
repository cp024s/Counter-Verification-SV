// ------------------------------------------------------------ CLASS TRANSACTION -----------------------------------------------------
class count_trans;
        // input random data
        rand logic [3:0]d_in;
        rand logic load;
        rand logic up_dn;
        logic rst;

        //output data
        logic [3:0] count;

        constraint c1 {d_in inside {[2:8]};}
        constraint c2 {load dist {1:=30, 0:=70};}
        constraint c4 {up_dn dist {0:=50, 1:=50};}

        virtual function void display(input string s);
                begin
                        $display("------------------------%s-----------------",s);
                        $display("Up down = %d",up_dn);
                        $display("Load    = %d",load);
                        $display("Data_in = %d",d_in);
                        $display("Count   = %d",count);
                        $display("Reset   = %d",rst);
                        $display("---------------------------------------------");
                end
        endfunction: display
endclass: count_trans
