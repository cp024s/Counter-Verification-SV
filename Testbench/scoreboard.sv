
// ------------------------------------------------------------ CLASS SCOREBOARD -----------------------------------------------------
class count_sb;
        count_trans rm_data;
        count_trans sb_data;

        event DONE;

        static int ref_data;
//      static int rm_data;
        static int data_verified;

        mailbox #(count_trans) ref2sb;
        mailbox #(count_trans) rdm2sb;

        function new (mailbox #(count_trans)ref2sb, mailbox #(count_trans)rdm2sb);
                this.ref2sb = ref2sb;
                this.rdm2sb = rdm2sb;

        endfunction: new

        virtual task start();
                fork forever
                        begin
                                ref2sb.get(rm_data);
                                ref_data++;
                                rdm2sb.get(sb_data);
                                check(sb_data);
                        end
                join_none
        endtask

        virtual task check(count_trans r_data);
                begin
                        if(rm_data.count == rdata.count)
                                $display("Count matches");
                        else
                                $display(" Count not matching");
        end
        data_verified++;

        if(data_verified >= no_of_transactions +2)
                begin
                        -> DONE;  // IDK WHAT TO DO
                end
        endtask

        virtual function void report();
                $display("------------------ SCORE BOARD REPORT --------------------------");
                $display("Data generated = %d",rm_data);
                $display("Data Verified  = %d",data_verified);
                $display("----------------------------------------------------------------");
        endfunction: report
endclass: count_sb
