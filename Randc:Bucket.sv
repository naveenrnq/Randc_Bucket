// Constraint 1: Generate random Value
// Constarint 2: Changing constraint on the go
// Check for repeatitions
// As soon as constraint is modified previous values are lost

class generator;

  randc bit [3:0] a,b;  // rand or randc
  bit [3:0] y;

  int min;
  int max;
 
  function void pre_randomize(input int min, input int max);
    this.min = min;
    this.max = max;
  endfunction

  constraint data {
                    a inside {[min:max]};
                    b inside {[min:max]};
                   }
  
  function void post_randomize();
    $display("Value of a: %0d and b: %0d", a,b);
  endfunction
   
endclass




module tb;
 generator g;
 int i = 0;

 
 initial begin
   g = new();

   $display("SPACE 1");
   g.pre_randomize(3,12); // Creating 1st randc space

   // Create 6 random samples at the delay of 10ns
   for(i = 0; i < 6; i++) begin 
     g.randomize(); 
     #10; 
   end

   $display("SPACE 2");
   g.pre_randomize(3,12); // Creating 2nd randc space on go
                         // We are using intersecting values to check for repeatition
   for(i = 0; i < 6; i++) begin 
     g.randomize(); 
     #10; 
   end


 end

endmodule
