// ------------------------------------------------------------ PACKAGES -----------------------------------------------------
package count_pkg;
	int no_of_transactions =1;
	
	// add .sv extension while splitting files
	`include"count_trans"
	`include"count_gen"
	`include"count_drv"
	`include"count_read_mon"
	`include"count_wr_mon"
	`include"count_model"
	`include"count_sb"
	`include"count_env"
	`include"count_test"
endpackage: counter_pkg
