module mac2 (
    input logic clk,
    input logic rst_n, 
    // mac input ready signal
    input logic in_ready_mac2, 
    // mac inputs
    input logic signed [14:0] relu4, relu5, relu6, relu7,
    // Weights
    input logic signed [4:0] w48, w58, w68, w78,
    input logic signed [4:0] w49, w59, w69, w79,
    // mac output ready signal
    output logic out0_ready, out1_ready,
    // mac outputs 
    output logic signed [20:0] out0, out1 
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out0 <= 0;
            out1 <= 0;
            out0_ready <= 0;
            out1_ready <= 0;
        end else if (in_ready_mac2) begin
            out0 <= relu4 * w48 + relu5 * w58 + relu6 * w68 + relu7 * w78;
            out1 <= relu4 * w49 + relu5 * w59 + relu6 * w69 + relu7 * w79;
            out0_ready <= 1;
            out1_ready <= 1;
        end
        else begin
            out0_ready <= 0;
            out1_ready <= 0;
        end
    end

endmodule

