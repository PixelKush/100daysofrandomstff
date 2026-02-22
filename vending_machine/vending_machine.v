module vending_machine(
    input wire clk,
    input wire rst,
    input wire [1:0]coin_in, // 00:no coin, 01:5 rupees, 10= 10 rupee coin and pepsi only of price 15
    output reg [1:0]state; 
    output reg  change, out;
);
 parameter s = 2'b00 , s2 = 2'b01 ,s3 = 2'b10; // product output state is s4
 reg [1:0]current_State,next_State;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_State <= s1;
    end else begin
        current_State <= next_State;
    end
end

always @(*)begin

    case (current_State)
        s1: begin
            if (coin_in == 2'b01) next_state = s2;
            else if (coin_in == 2'b10) next_State = s3;
            else next_State = s1;
        end
        s2: begin // 5 rupee already inserted
            if (coin_in == 2'b01) next_state = s3;
            else if (coin_in == 2'b10) begin 
                next_State = s1; // 15 rupees reached, output product
                out = 1; // output product
                change = 0; //return 0 rupee
            end 
            else next_State =s2;
        end
        s3: begin //` 10 rupee already inserted
            if (coin_in == 2'b01) //inserting 5 rupee coin after 10 rupee coin
            begin 
                next_State = s1;
                out =1;
                change = 0;
            else if (coin_in == 2'b10)// inserting 10 rupee coin after 10 rupee
            begin
                next_State = s1;
                change = 1;
                out = 1;
            end
            else next_State = s3;
            end
        end //
    endcase 
    end



endmodule