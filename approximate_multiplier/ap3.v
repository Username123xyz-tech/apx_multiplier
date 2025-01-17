module approximate_multiplier_4x4 (
    input [3:0] A,  // 4-bit input A
    input [3:0] B,  // 4-bit input B
    output [7:0] P  // 8-bit output P
);
    wire [3:0] P0, P1;
    wire [7:0] sum;

    // Partial products with approximations
    assign P0 = A[1:0] * B[1:0]; // Lower 2 bits of A and B
    assign P1 = A[3:2] * B[3:2]; // Upper 2 bits of A and B

    // Approximate addition of partial products
    assign sum = {P1, 4'b0000};  // Shift upper partial product by 4 bits
    assign P = sum + P0;         // Add lower partial product

endmodule




