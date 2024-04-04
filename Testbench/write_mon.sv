
// ------------------------------------------------------------ CLASS WRITE MONITOR -----------------------------------------------------
class count_wr_mon;

        virtual count_if.WR_MON_MP wr_mon_if;

        count_trans data2rm;
        count_trans wr_data;

        mailbox #(count_trans)mon2rm;

        function new(virtual count_if.WR_MON_MP wr_mon_if, mailbox #(count_trans)mon2rm);
                begin
                        this.wr_mon_if = wr_mon_if;
                        this.mon2rm    = mon2rm;
                        this.wr_data   = new;
                end
        endfunction: new

        virtual task monitor();
                begin   @(wr_mon_if.wr_mon_cb);
                        begin
                                wr_data.up_dn = wr_mon_if.wr_mon_cb.up_dn;
                                wr_data.load  = wr_mon_if.wr_mon_cb.load;
                                wr_data.d_in   = wr_mon_if.wr_mon_cb.d_in;
                                wr_data.display(" ----- From Write monitor -----");
                        end
                end
        endtask: monitor

        virtual task start();
                fork forever
                        begin
                                monitor();
                                data2rm = new(wr_data);
                                mon2rm.put(data2rm);
                        end
                join_none
        endtask
endclass: count_wr_mon
