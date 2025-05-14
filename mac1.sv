module mac1 (
    input logic clk,
    input logic rst_n, 
    // mac input ready signal
    input logic in_ready_mac1,
    // mac inputs for Node-0, Node-1, Node-2, Node-3
    input logic signed [6:0] x0, x1, x2, x3,
    // Weights 
    input logic signed [4:0] w04, w14, w24, w34, 
    input logic signed [4:0] w05, w15, w25, w35,
    input logic signed [4:0] w06, w16, w26, w36,
    input logic signed [4:0] w07, w17, w27, w37,
    // mac output ready signal
    output logic out_ready_mac1,
    // mac outputs 
    logic signed [12:0] neuron4, neuron5, neuron6, neuron7
);

    // Pipeline stage 1: Compute MAC
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            neuron4 <= 0;
            neuron5 <= 0;
            neuron6 <= 0;
            neuron7 <= 0;
            out_ready_mac1 <= 0;
        end else if (in_ready_mac1) begin
            neuron4 <= x0 * w04 + x1 * w14 + x2 * w24 + x3 * w34;
            neuron5 <= x0 * w05 + x1 * w15 + x2 * w25 + x3 * w35;
            neuron6 <= x0 * w06 + x1 * w16 + x2 * w26 + x3 * w36;
            neuron7 <= x0 * w07 + x1 * w17 + x2 * w27 + x3 * w37;
            out_ready_mac1 <= 1;
        end else begin
            out_ready_mac1 <= 0;
        end
    end

endmodule

