# 4X4 approximate multiplier

## overview
This repository contains the Verilog implementation of a 4x4 approximate multiplier optimized for reduced power and area. The design ensures that the Mean Relative Error (MRE) is less than 10%.

## Approximation technique
The approximation technique used my 4x4 approximate multiplier module is based on reducing hardware complexity by carefully selecting and simplifying the partial products and their subsequent addition.
1) In an accurate 4X4 multiplier, All bits of both inputs (A and B) are multiplied to generate 16 partial products. These partial products are then summed to produce the final 8-bit result. In the approximate design, we intentionally ignore certain partial products to simplify the computation.
2) here, we are using only two partial products.
   P0 = A[1:0] * B[1:0] and P1 = P1 = A[3:2] * B[3:2]
   P0 Multiplies the least significant 2 bits (LSBs) of A and B. Captures the lower-order contribution to the final result.
   P1 Multiplies the most significant 2 bits (MSBs) of A and B. Captures the higher-order contribution to the final result.
   we omit the middle cross-terms (like A[3:2] * B[1:0] or A[1:0] * B[3:2]), trading accuracy for reduced hardware complexity.
3) the partial products are added using an approximate addition scheme.
   P1 represents the higher-order bits, so it is shifted left by 4 bits ({P1, 4'b0000}) to align with the higher significance level.
   The shifted P1 is added to P0 to produce the final result P.
4) aprroximations introduced are that the cross-terms are ignored. These cross-terms typically contribute to the middle-order bits of the result, so their omission increases relative error but reduces hardware complexity. The addition of partial products is approximate because no carry is propagated between the shifted P1 and P0.

## file structure
- ap3.v : verilog code of 4X4 approximate multiplier
- multiplier_tb.v : testbench to verify the design
- results : contains synthesis results
## Error analysis
- mean relative error (MRE) : 7.03%
## screenshots
power report : "C:\Users\patel\Downloads\project_ss\power.png"
utilisation report: "C:\Users\patel\Downloads\project_ss\utilisation.png"
