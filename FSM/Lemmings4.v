//Lemmings4
//https://hdlbits.01xz.net/wiki/Lemmings4
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

    parameter w_left=4'b0001, w_right=4'b0010, dig_left=4'b0011, dig_right=4'b0100, fall_left=4'b0101, fall_right=4'b0110, splatter=4'b0111,keep_fall_left=4'b0000,keep_fall_right=4'b1000;
    reg [3:0] state, next_state;
    reg [7:0] count;
    always@(posedge clk or posedge areset)
        begin
            if (areset)
                begin
                state<=w_left;
                count<=0;  
                end
                
            else
                begin
                    state<=next_state;
                    if ((count>8'd19)&&(ground))
                        state<=splatter;
                    else if (next_state==keep_fall_right|next_state==keep_fall_left)
                        count<=count+1;
                    else begin
                        count<=0;  
                    end
                end
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
                    else 
                        begin 
                            next_state<=keep_fall_left;  
                        end
                end
                keep_fall_left:
                    if(ground)
                        next_state<=w_left;
                    else 
                        begin 
                            next_state<=keep_fall_left;  
                        end
                fall_right: begin
                    if(ground)
                        next_state<=w_right;
                    else begin
                        next_state<=keep_fall_right;
                        end
                end
                keep_fall_right:
                        if(ground)
                        next_state<=w_right;
                        else begin
                        next_state<=keep_fall_right;
                        end
                splatter: begin
                    next_state<=splatter; 
                end
                default: next_state<=state;
            endcase
        end
        
    
    always@(*)
        begin
            if(state==fall_left|state==fall_right|state==keep_fall_right|state==keep_fall_left) begin digging<=0; walk_left<=0; walk_right<=0; aaah<=1; end
            else if (state==dig_left|state==dig_right) begin digging<=1; walk_left<=0; walk_right<=0; aaah<=0; end
            else if (state==w_left) begin digging<=0; walk_left<=1; walk_right<=0; aaah<=0; end
            else if (state==w_right) begin digging<=0; walk_left<=0; walk_right<=1; aaah<=0; end
            else if (state==splatter) begin digging<=0; walk_left<=0; walk_right<=0; aaah<=0; end
            else begin digging<=0; walk_left<=0; walk_right<=0; aaah<=0; end
        end  

endmodule


