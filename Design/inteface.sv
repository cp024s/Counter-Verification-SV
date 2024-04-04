// ------------------------------------------------------------ COUNTER INTERFACE -----------------------------------------------------
interface count_if(input bit clk);
        logic [3:0]d_in;
        logic [3:0]count;
        logic load;
        logic up_dn;
        logic rst;
//DRIVER CLOSKING BLOCK
        clocking dr_cb@(posedge clk);
                default input #1 output #1;
                output d_in;
                output load;
                output up_dn;
        endclocking
//WRITE MONITOR CLOCKING BLOCK
        clocking wr_mon_cb@(posedge clk);
                default input #1 output #1;
                input d_in;
                input load;
                input up_dn;
        endclocking
// READ MONITOR CLOCKING BLOCK
        clocking rd_mon_cb@(posedge clk);
                default input #1 output #1;
                input count;
        endclocking
		 
//MODPORT DECLARATION
        modport DRV_MP(clocking dr_cb);
        modport WR_MON_MP(clocking wr_mon_cb);
        modport RD_MON_MP(clocking rd_mon_cb);
endinterface: count_if
