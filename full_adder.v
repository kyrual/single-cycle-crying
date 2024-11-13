`timescale 1us/ 100s

module full_adder(A, B, Cin, S, Cout);
    input A, B, Cin;
    output S, Cout;

    wire AxB, AnB, AxBnCin;

    assign AxB = A ^ B;
    assign AnB = A & B;
    assign AxBnCin = AxB & Cin;

    assign S = AxB ^ Cin;
    assign Cout = AxBnCin | AnB;
endmodule

