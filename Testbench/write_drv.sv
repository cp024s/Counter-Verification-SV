
// ------------------------------------------------------------ CLASS WRITE DRIVER -----------------------------------------------------
class count_drv;
        virtual count_if.DRV_MP drv_if;

        count_trans data2duv;
        mailbox #(count_trans)gen2dr;

        function new(virtual count_if.DRV_MP drv_if, mailbox #(count_trans)gen2dr);
        begin
                this.drv_if = drv_if;
                this.gen2dr= gen2dr;
        end
        endfunction

        virtual task drive();
                begin @(drv_if.dr_cb);
                        drv_if.dr_cb.load   <= data2duv.load;
                        drv_if.dr_cb.d_in   <= data2duv.d_in;
                        drv_if.dr_cb.up_dn  <= data2duv.up_dn;
                end
        endtask: drive

        virtual task start();
                fork forever
                        begin
                                gen2dr.get(data2duv);
                                drive();
                        end
                join_none
        endtask: start
endclass: count_drv
