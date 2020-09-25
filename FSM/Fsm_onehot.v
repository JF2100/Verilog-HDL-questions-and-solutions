//Fsm_onehot
//https://hdlbits.01xz.net/wiki/Fsm_onehot
module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    parameter s0=10'b0000000001,s1=10'b0000000010,s2=10'b0000000100,s3=10'b0000001000,s4=10'b0000010000;
    parameter s5=10'b0000100000,s6=10'b0001000000,s7=10'b0010000000,s8=10'b0100000000,s9=10'b1000000000, sreset=10'b0000000000;

    always@(*)
        begin
            next_state=sreset;
            if(state[0])
                begin
                if(in)
                next_state[1]=1;
                else
                    next_state[0]=1; end
            if(state[1])
                begin
                if(in)
                    next_state[2]=1;
                else
                    next_state[0]=1; end
            if(state[2])
                begin
                if(in)
                    next_state[3]=1;
                else
                    next_state[0]=1; end
            if(state[3])
                begin
                if(in)
                    next_state[4]=1;
                else
                    next_state[0]=1; end
            if(state[4])
                begin
                if(in)
                    next_state[5]=1;
                else
                    next_state[0]=1; end
            if(state[5])
                begin
                if(in)
                    next_state[6]=1;
                else
                    next_state[8]=1; end
            if(state[6])
                begin
                if(in)
                    next_state[7]=1;
                else
                    next_state[9]=1; end
            if(state[7])
                begin
                if(in)
                    next_state[7]=1;
                else
                    next_state[0]=1; end
            if(state[8])
                begin
                if(in)
                    next_state[1]=1;
                else
                    next_state[0]=1; end
            if(state[9])
                begin
                if(in)
                    next_state[1]=1;
                else
                    next_state[0]=1; end
         end
                assign out1=state[8]|state[9];
                assign out2=state[7]|state[9];
               
endmodule


