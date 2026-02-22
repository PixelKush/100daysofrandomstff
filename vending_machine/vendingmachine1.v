module vending_machine(
    input wire clk,
    input wire rst,
    input wire [1:0] coin_in,   // 00: no coin, 01:5, 10:10
    output reg out,
    output reg change
);

parameter s1 = 2'b00,  // 0 rs
          s2 = 2'b01,  // 5 rs
          s3 = 2'b10;  // 10 rs

reg [1:0] current_state, next_state;


--------------------------------------------------
// 1️⃣ State Register
--------------------------------------------------
always @(posedge clk or posedge rst) begin
    if (rst)
        current_state <= s1;
    else
        current_state <= next_state;
end

--------------------------------------------------
// 2️⃣ Next State Logic
--------------------------------------------------
always @(*) begin
    case (current_state)
        s1: begin
            if (coin_in == 2'b01)
                next_state = s2;
            else if (coin_in == 2'b10)
                next_state = s3;
            else
                next_state = s1;
        end

        s2: begin
            if (coin_in == 2'b01)
                next_state = s3;
            else if (coin_in == 2'b10)
                next_state = s1;   // 15 reached
            else
                next_state = s2;
        end

        s3: begin
            if (coin_in == 2'b01)   // 10 + 5
                next_state = s1;
            else if (coin_in == 2'b10) // 10 + 10
                next_state = s1;
            else
                next_state = s3;
        end

        default: next_state = s1;
    endcase
end

--------------------------------------------------
// 3️⃣ Output Logic (Moore + Mealy style)
--------------------------------------------------
always @(*) begin
    out = 0;
    change = 0;

    case (current_state)
        s2: begin
            if (coin_in == 2'b10) begin
                out = 1;       // 5 + 10
            end
        end

        s3: begin
            if (coin_in == 2'b01) begin
                out = 1;       // 10 + 5
            end
            else if (coin_in == 2'b10) begin
                out = 1;       // 10 + 10
                change = 1;    // return 5
            end
        end
    endcase
end

endmodule