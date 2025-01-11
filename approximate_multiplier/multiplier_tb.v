module multiplier_tb;

    // Input and output variables
    reg [3:0] A, B;            // 4-bit operands
    wire [7:0] approx_result;  // Output of the approximate multiplier
    reg [7:0] exact_result;    // Exact result
    integer counter;           // Loop counter
    real total_error;          // Accumulator for total relative error
    real mean_relative_error;  // Mean relative error
    real relative_error;       // Relative error for a single test

    // Instantiate the approximate multiplier
    approximate_multiplier_4x4 uut (
        .A(A),
        .B(B),
        .P(approx_result) // Match port name in the module
    );

    initial begin
        // Initialize error accumulator
        total_error = 0.0;

        // Debug: Print header
        $display("Starting testbench with mean relative error calculation...");

        // Iterate through all 256 combinations of A and B
        for (counter = 0; counter < 256; counter = counter + 1) begin
            // Decode A and B from the counter
            A = counter[7:4];  // Upper 4 bits represent A
            B = counter[3:0];  // Lower 4 bits represent B

            // Compute the exact result
            exact_result = A * B;

            // Wait for the multiplier to process
            #1; // Adjust delay if necessary

            // Compute the absolute difference manually
            if (exact_result != 0) begin
                relative_error = (approx_result > exact_result) ? 
                                 (approx_result - exact_result) / exact_result : 
                                 (exact_result - approx_result) / exact_result;

                // Accumulate relative error
                total_error = total_error + relative_error;
            end

            // Debug: Print progress
            $display("Test A=%d, B=%d | Approx=%d, Exact=%d | RelError=%0.4f",
                     A, B, approx_result, exact_result, relative_error);
        end

        // Calculate mean relative error (as a percentage)
        mean_relative_error = (total_error / 256) * 100;

        // Display results
        $display("Mean Relative Error: %0.2f%%", mean_relative_error);

        // End simulation
        $stop;
    end

endmodule

