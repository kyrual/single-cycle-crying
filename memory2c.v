module memory2c (data_out, data_in, addr, enable, wr, createdump, clk, rst);

   output  [31:0] data_out;
   input [31:0]   data_in;
   input [31:0]   addr;
   input          enable;
   input          wr;
   input          createdump;
   input          clk;
   input          rst;

   wire [31:0]    data_out;
   
   reg [7:0]      mem [0:65535];
   reg            loaded;
   reg [16:0]     largest;

   integer        mcd;
   integer        i;


   //    assign data_temp_0 = mem[addr];
   //    assign data_temp_2 = mem[{addr+8'h1];
   assign         data_out = (enable & (~wr))? {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}: 0;
   initial begin
      loaded = 0;
      largest = 0;
      for (i = 0; i< 65536; i=i+1) begin
         mem[i] = 8'd0;
      end
   end

   always @(posedge clk) begin
      if (rst) begin
         // first init to 0, then load loadfile_all.img
         if (!loaded) begin
            $readmemh("loadfile_all.img", mem);
            loaded = 1;
         end
      end
      else begin
         if (enable & wr) begin
	        mem[addr+3] = data_in[31:24];  // The actual write
	        mem[addr+2] = data_in[23:16];  // The actual write
	        mem[addr+1] = data_in[15:8];   // The actual write
	        mem[addr+0] = data_in[7:0];    // The actual write
            if ({1'b0, addr} > largest) largest = addr;  // avoid negative numbers
         end
         if (createdump) begin
            mcd = $fopen("dumpfile", "w");
            for (i=0; i<=largest+1; i=i+1) begin
               $fdisplay(mcd,"%4h %2h", i, mem[i]);
            end
            $fclose(mcd);
         end
      end
   end
endmodule