//ece241_2013_q4
//https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q4
module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [2:0] state, next_state;
    parameter A=0,B=1,C=2,D=3,E=4,F=5;
    always@(posedge clk) begin
        if (reset)
            state<=A;
        else 
            state<=next_state;
    end
    
    always @ (*) begin
        case (state)
            0:next_state=(s==3'b001)?1:0;
            1:next_state=(s==3'b011)?2:(s==3'b000)?0:1;
            2:next_state=(s==3'b001)?5:(s==3'b111)?3:2;
            3:next_state=(s==3'b011)?4:3;
            4:next_state=(s==3'b001)?5:(s==3'b111)?3:4;
            5:next_state=(s==3'b011)?2:(s==3'b000)?0:5;
            default next_state=0;
        endcase
    end
    assign fr1=(state==0)|(state==1)|(state==2)|(state==4)|(state==5);
    assign fr2=(state==0)|(state==1)|(state==5);
    assign fr3=(state==0);
    assign dfr=(state==0)|(state==4)|(state==5);
 
endmodule

