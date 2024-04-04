
// ------------------------------------------------------------ CLASS REFERENCE MODEL -----------------------------------------------------

class count_model;
        count_trans w_data;

        static logic[3:0]ref_count = 0;

        mailbox #(count_trans) wrmon2rm;
        mailbox #(count_trans) rm2sb;

        function new( mailbox #(count_trans) wrmon2sb, mailbox #(count_trans) rm2rb);
                this.wrmon2sb = wrmon2sb;
                this.rm2sb    = rm2sb;
        endfunction: new

        virtual task count_mod(count_trans counter_mod);
                begin
                        if(counter_mod.load)
                                ref_count <= model_counter.w_data;
                                wait(counter_mod.load == 0)
                                begin
                                        if(ref_count >12)
                                                ref_count <=4'b0;
                                        else
                                                ref_count <= ref_count +1'b1;
                                end
                        else if(counter_mod.up_dn == 1)
                                begin
                                        if((ref-count > 10)||(ref_count <2))
                                                ref_count <= 4'd10;
                                        else
                                                ref_count <= ref_count -1'b1;
                                end
                        end
                end
        endtask: count_mod

        virtual task start();
                fork begin
                        forever begin
                                wrmon2rm.get(w_data);
                                count_mod(w_data);
                                w_data.count = ref_count;
                                rm2sb.put(w_data);
                        end
                end
                join_none
        endtask
endclass

