//Lemmings1
//https://hdlbits.01xz.net/wiki/Lemmings1
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

  parameter LEFT=0, RIGHT=1;
    reg state, next_state;

    always @(*) begin
        next_state= (bump_left)&(~bump_right);     // State transition logic
    end

    always @(posedge clk, posedge areset) begin
        if (areset)
            state<=LEFT;
        else if ((bump_left&bump_right)==1)
             state<=~state;
        else if ((bump_left==0)&(bump_right==0))
            state<=state;
        else
            state<=next_state;
    end
        // State flip-flops with asynchronous reset
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    // Output logic
    // assign walk_left = (state == ...);
    // assign walk_right = (state == ...);

endmodule
