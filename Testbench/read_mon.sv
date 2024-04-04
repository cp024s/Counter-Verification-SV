
// ------------------------------------------------------------ CLASS READ MONITOR -----------------------------------------------------

class count_read_mon;
        virtual count_if.RD_MON_MP rdmon_if;

        count_trans data2sb;
        count_trans rd_data;

        mailbox #(count_trans) mon2sb;

        function new( virtual count_if.RD_MON_MP rd_mon_if, mailbox #(count_trans)mon2sb);
        begin
                this.rd_mon_if = rd_mon_if;
                this.mon2sb    = mon2sb;
                this.rd_data   = new;
        end
        endfunction: new

        virtual task monitor();
        begin
                @(rd_mon_if.rd_mon_cb);
                begin
                        rd_data.count = rd_mon_if.rd_mon_cb.count;
                        rd_data.display = ("---- From Read monitor ----");
                end
        end
        endtask

        virtual task start();
            fork forever
                begin
                    monitor();
                    data2sb = new rd_data;
                    mon2sb.put(data2sb);
                    end
            join_none
        endtask
endclass: count_read_mon
