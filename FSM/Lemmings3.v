//Lemmings3
//https://hdlbits.01xz.net/wiki/Lemmings3
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    parameter w_left=3'b001, w_right=3'b010, dig_left=3'b011, dig_right=3'b100, fall_left=3'b101, fall_right=3'b110;
    reg [2:0] state, next_state;
    always@(posedge clk or posedge areset)
        begin
            if (areset)
                state<=w_left;
            else
                state<=next_state;
        end
    always@(*)
        begin
            case (state)
                w_left: begin
                    if(!ground)
                        next_state<=fall_left;
                    else if (dig)
                        next_state<=dig_left;
                    else if (bump_left)
                        next_state<=w_right;
                        else
                        next_state<=state;
                end
                w_right: begin
                    if(!ground)
                        next_state<=fall_right;
                    else if (dig)
                        next_state<=dig_right;
                    else if (bump_right)
                        next_state<=w_left;
                    else
                    next_state<=state;
                end
                dig_left: begin
                    if(!ground)
                        next_state<=fall_left;
                    else next_state<=state;
                end
                dig_right: begin
                    if(!ground)
                        next_state<=fall_right;
                    else next_state<=state;
                end
                fall_left: begin
                    if(ground)
                        next_state<=w_left;
                    else next_state<=state;
                    
                end
                fall_right: begin
                    if(ground)
                        next_state<=w_right;
                    else next_state<=state;
                    
                end
                default: next_state<=state;
            endcase
        end
        
    
    always@(*)
        begin
            if(state==fall_left|state==fall_right) begin digging<=0; walk_left<=0; walk_right<=0; aaah<=1; end
            else if (state==dig_left|state==dig_right) begin digging<=1; walk_left<=0; walk_right<=0; aaah<=0; end
            else if (state==w_left) begin digging<=0; walk_left<=1; walk_right<=0; aaah<=0; end
            else if (state==w_right) begin digging<=0; walk_left<=0; walk_right<=1; aaah<=0; end
            else begin digging<=0; walk_left<=0; walk_right<=0; aaah<=0; end
        end  

endmodule

