module relu (
    input logic clk,
    input logic rst_n, 
    // relu input ready signal
    input logic in_ready_relu,
    // relu inputs
    input logic signed [12:0] neuron4, neuron5, neuron6, neuron7,
    // relu output ready signal
    output logic out_ready_relu,
    // relu outputs
    output logic signed [12:0] relu4, relu5, relu6, relu7 
);

    // Pipeline stage 2: ReLU activation
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            relu4 <= 0;
            relu5 <= 0;
            relu6 <= 0;
            relu7 <= 0;
            out_ready_relu <= 0;
        end else if (in_ready_relu) begin
            relu4 <= neuron4[12] ? 13'sd0 : neuron4;
            relu5 <= neuron5[12] ? 13'sd0 : neuron5;
            relu6 <= neuron6[12] ? 13'sd0 : neuron6;
            relu7 <= neuron7[12] ? 13'sd0 : neuron7;
            out_ready_relu <= 1;
        end else begin
            out_ready_relu <= 0;
        end
    end
    
 endmodule