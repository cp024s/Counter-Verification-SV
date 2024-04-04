
// ------------------------------------------------------------ CLASS ENVIRONMENT -----------------------------------------------------
class count_env;
        virtual count_if.DRV_MP drv_if;
        virtual count_if.WR_MON_MP wr_mon_if;
        virtual count_if.RD_MON_MP rdmon_if;

        mailbox #(count_trans) gen2dr = new;
        mailbox #(count_trans) rm2sb  = new;
        mailbox #(count_trans) mon2sb = new;
        mailbox #(count_trans) mon2rm = new;

        count_gen       gen_h;
        count_wr_mon    wr_mon_h;
        count_read_mon  rd_mon_h;
        count_drv       drv_h;
        count_sb        sb_h;
        count_model     mod_h;

        function new(virtual count_if.DRV_MP drv_if,
                     virtual count_if.WR_MON_MP wr_mon_if,
                     virtual count_if.RD_MON_MP rd_mon_if );

                this.drv_if     = drv_if;
                this.wr_mon_if  = wr_mon_if;
                this.rd_mon_if  = rd_mon_if;
    endfunction: new

        virtual task build();
                 gen_h    = new(gen2dr);
                 drv_h    = new(drv_if, gen2dr);
                 wr_mon_h = new(wr_mon_if, mon2rm);
                 rd_mon_h = new(rdmon_if, mon2sb);
                 sb_h     = new(rm_2sb, mon2sb);
                 mod_h    = new(mon2rm, rm2sb);
        endtask: build

        virtual task reset_duv();
                @(drv_if.dr_cb);
                drv_if.dr_cb.rst <=1'b0;
                repeat(2)
                        @(drv_if.dr_cb);
                        drv_if.dr_cb.rst <=1'b1;
        endtask: reset_duv

        virtual task start();
                gen_h.start;
                drv_h.start;
                wr_mon_h.start;
                rd_mon_h.start;
                sb_h.start;
                mod_h.start;
        endtask: start

        virtual task stop();
                wait(sb_h.DONE.triggered);
        endtask: stop

        virtual task run();
                reset_duv();
                start();
                stop();
                sh_h.report();
        endtask: run
endclass: count_env
