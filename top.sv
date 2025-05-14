module top (
    // Node-0, Node-1, Node-2, Node-3 inputs
    input  logic signed [4:0] x0_node0, x1_node0, x2_node0, x3_node0,
    input  logic signed [4:0] x0_node1, x1_node1, x2_node1, x3_node1,
    input  logic signed [4:0] x0_node2, x1_node2, x2_node2, x3_node2,
    input  logic signed [4:0] x0_node3, x1_node3, x2_node3, x3_node3,

    // DNN weights
    input  logic signed [4:0] w04, w14, w24, w34,
    input  logic signed [4:0] w05, w15, w25, w35,
    input  logic signed [4:0] w06, w16, w26, w36,
    input  logic signed [4:0] w07, w17, w27, w37,
    input  logic signed [4:0] w48, w58, w68, w78,
    input  logic signed [4:0] w49, w59, w69, w79,

    input  logic in_ready, // Input ready signal
    input  logic clk,
    input  logic rst_n,

    // Node-0, Node-1, Node-2, Node-3 outputs
    output logic signed [20:0] out0_node0, out1_node0,
    output logic signed [20:0] out0_node1, out1_node1,
    output logic signed [20:0] out0_node2, out1_node2,
    output logic signed [20:0] out0_node3, out1_node3,

    output logic out10_ready_node0, out11_ready_node0,
    output logic out10_ready_node1, out11_ready_node1,
    output logic out10_ready_node2, out11_ready_node2,
    output logic out10_ready_node3, out11_ready_node3
);

    //--------------------------------------------------------------------------
    // Aggregator 1
    //--------------------------------------------------------------------------

    logic signed [6:0] agg1_0_node0, agg1_1_node0, agg1_2_node0, agg1_3_node0;
    logic signed [6:0] agg1_0_node1, agg1_1_node1, agg1_2_node1, agg1_3_node1;
    logic signed [6:0] agg1_0_node2, agg1_1_node2, agg1_2_node2, agg1_3_node2;
    logic signed [6:0] agg1_0_node3, agg1_1_node3, agg1_2_node3, agg1_3_node3;
    logic agg1_ready;

    aggregator #(.INPUT_WIDTH(5), .OUTPUT_WIDTH(7)) agg1 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_aggregator (in_ready),
        .x0_node0 (x0_node0), .x1_node0 (x1_node0), .x2_node0 (x2_node0), .x3_node0 (x3_node0),
        .x0_node1 (x0_node1), .x1_node1 (x1_node1), .x2_node1 (x2_node1), .x3_node1 (x3_node1),
        .x0_node2 (x0_node2), .x1_node2 (x1_node2), .x2_node2 (x2_node2), .x3_node2 (x3_node2),
        .x0_node3 (x0_node3), .x1_node3 (x1_node3), .x2_node3 (x2_node3), .x3_node3 (x3_node3),
        .agg_0_node0 (agg1_0_node0), .agg_1_node0 (agg1_1_node0), .agg_2_node0 (agg1_2_node0), .agg_3_node0 (agg1_3_node0),
        .agg_0_node1 (agg1_0_node1), .agg_1_node1 (agg1_1_node1), .agg_2_node1 (agg1_2_node1), .agg_3_node1 (agg1_3_node1),
        .agg_0_node2 (agg1_0_node2), .agg_1_node2 (agg1_1_node2), .agg_2_node2 (agg1_2_node2), .agg_3_node2 (agg1_3_node2),
        .agg_0_node3 (agg1_0_node3), .agg_1_node3 (agg1_1_node3), .agg_2_node3 (agg1_2_node3), .agg_3_node3 (agg1_3_node3),      
        .out_ready_aggregator (agg1_ready)
    );

    //--------------------------------------------------------------------------
    // Layer1 (mac) of DNN for each node of GNN
    //--------------------------------------------------------------------------

    // For Node-0
    logic mac1_node0_ready;
    logic signed [12:0] y04, y05, y06, y07;
    mac1 mac1_node0 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_mac1 (agg1_ready),
        .x0 (agg1_0_node0), .x1 (agg1_1_node0), .x2 (agg1_2_node0), .x3 (agg1_3_node0),
        .w04 (w04), .w14 (w14), .w24 (w24), .w34 (w34),
        .w05 (w05), .w15 (w15), .w25 (w25), .w35 (w35),
        .w06 (w06), .w16 (w16), .w26 (w26), .w36 (w36),
        .w07 (w07), .w17 (w17), .w27 (w27), .w37 (w37),
        .out_ready_mac1 (mac1_node0_ready),
        .neuron4 (y04), .neuron5 (y05), .neuron6 (y06), .neuron7 (y07)
    );
        
    // For Node-1
    logic mac1_node1_ready;
    logic signed [12:0] y14, y15, y16, y17;
    mac1 mac1_node1 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_mac1 (agg1_ready),
        .x0 (agg1_0_node1), .x1 (agg1_1_node1), .x2 (agg1_2_node1), .x3 (agg1_3_node1),
        .w04 (w04), .w14 (w14), .w24 (w24), .w34 (w34),
        .w05 (w05), .w15 (w15), .w25 (w25), .w35 (w35),
        .w06 (w06), .w16 (w16), .w26 (w26), .w36 (w36),
        .w07 (w07), .w17 (w17), .w27 (w27), .w37 (w37),
        .out_ready_mac1 (mac1_node1_ready),
        .neuron4 (y14), .neuron5 (y15), .neuron6 (y16), .neuron7 (y17)
    );

    // For Node-2
    logic mac1_node2_ready;
    logic signed [12:0] y24, y25, y26, y27;
    mac1 mac1_node2 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_mac1 (agg1_ready),
        .x0 (agg1_0_node2), .x1 (agg1_1_node2), .x2 (agg1_2_node2), .x3 (agg1_3_node2),
        .w04 (w04), .w14 (w14), .w24 (w24), .w34 (w34),
        .w05 (w05), .w15 (w15), .w25 (w25), .w35 (w35),
        .w06 (w06), .w16 (w16), .w26 (w26), .w36 (w36),
        .w07 (w07), .w17 (w17), .w27 (w27), .w37 (w37),
        .out_ready_mac1 (mac1_node2_ready),
        .neuron4 (y24), .neuron5 (y25), .neuron6 (y26), .neuron7 (y27)
    );

    // For Node-3
    logic mac1_node3_ready;
    logic signed [12:0] y34, y35, y36, y37;
    mac1 mac1_node3 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_mac1 (agg1_ready),
        .x0 (agg1_0_node3), .x1 (agg1_1_node3), .x2 (agg1_2_node3), .x3 (agg1_3_node3),
        .w04 (w04), .w14 (w14), .w24 (w24), .w34 (w34),
        .w05 (w05), .w15 (w15), .w25 (w25), .w35 (w35),
        .w06 (w06), .w16 (w16), .w26 (w26), .w36 (w36),
        .w07 (w07), .w17 (w17), .w27 (w27), .w37 (w37),
        .out_ready_mac1 (mac1_node3_ready),
        .neuron4 (y34), .neuron5 (y35), .neuron6 (y36), .neuron7 (y37)
    );

    logic mac1_ready;
    assign mac1_ready = mac1_node0_ready & mac1_node1_ready & mac1_node2_ready & mac1_node3_ready;

    //--------------------------------------------------------------------------
    // Layer1 (relu) of DNN for each node of GNN
    //--------------------------------------------------------------------------

    // For Node-0
    logic relu_node0_ready;
    logic signed [12:0] z04, z05, z06, z07;
    relu relu_node0 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_relu (mac1_ready),
        .neuron4 (y04), .neuron5 (y05), .neuron6 (y06), .neuron7 (y07),
        .relu4 (z04), .relu5 (z05), .relu6 (z06), .relu7 (z07),
        .out_ready_relu (relu_node0_ready)
    );

    // For Node-1
    logic relu_node1_ready;
    logic signed [12:0] z14, z15, z16, z17;
    relu relu_node1 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_relu (mac1_ready),
        .neuron4 (y14), .neuron5 (y15), .neuron6 (y16), .neuron7 (y17),
        .relu4 (z14), .relu5 (z15), .relu6 (z16), .relu7 (z17),
        .out_ready_relu (relu_node1_ready)
    );

    // For Node-2
    logic relu_node2_ready;
    logic signed [12:0] z24, z25, z26, z27;
    relu relu_node2 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_relu (mac1_ready),
        .neuron4 (y24), .neuron5 (y25), .neuron6 (y26), .neuron7 (y27),
        .relu4 (z24), .relu5 (z25), .relu6 (z26), .relu7 (z27),
        .out_ready_relu (relu_node2_ready)
    );

    // For Node-3
    logic relu_node3_ready;
    logic signed [12:0] z34, z35, z36, z37;
    relu relu_node3 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_relu (mac1_ready),
        .neuron4 (y34), .neuron5 (y35), .neuron6 (y36), .neuron7 (y37),
        .relu4 (z34), .relu5 (z35), .relu6 (z36), .relu7 (z37),
        .out_ready_relu (relu_node3_ready)
    );

    logic relu_ready;
    assign relu_ready = relu_node0_ready & relu_node1_ready & relu_node2_ready & relu_node3_ready;
    
    //--------------------------------------------------------------------------
    // Aggregator 2
    //--------------------------------------------------------------------------

    logic signed [14:0] agg2_0_node0, agg2_1_node0, agg2_2_node0, agg2_3_node0;
    logic signed [14:0] agg2_0_node1, agg2_1_node1, agg2_2_node1, agg2_3_node1;
    logic signed [14:0] agg2_0_node2, agg2_1_node2, agg2_2_node2, agg2_3_node2;
    logic signed [14:0] agg2_0_node3, agg2_1_node3, agg2_2_node3, agg2_3_node3;
    logic agg2_ready;
    aggregator #(.INPUT_WIDTH(13), .OUTPUT_WIDTH(15)) agg2 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_aggregator (relu_ready),
        .x0_node0 (z04), .x1_node0 (z05), .x2_node0 (z06), .x3_node0 (z07),
        .x0_node1 (z14), .x1_node1 (z15), .x2_node1 (z16), .x3_node1 (z17),
        .x0_node2 (z24), .x1_node2 (z25), .x2_node2 (z26), .x3_node2 (z27),
        .x0_node3 (z34), .x1_node3 (z35), .x2_node3 (z36), .x3_node3 (z37),
        .agg_0_node0 (agg2_0_node0), .agg_1_node0 (agg2_1_node0), .agg_2_node0 (agg2_2_node0), .agg_3_node0 (agg2_3_node0),
        .agg_0_node1 (agg2_0_node1), .agg_1_node1 (agg2_1_node1), .agg_2_node1 (agg2_2_node1), .agg_3_node1 (agg2_3_node1),
        .agg_0_node2 (agg2_0_node2), .agg_1_node2 (agg2_1_node2), .agg_2_node2 (agg2_2_node2), .agg_3_node2 (agg2_3_node2),
        .agg_0_node3 (agg2_0_node3), .agg_1_node3 (agg2_1_node3), .agg_2_node3 (agg2_2_node3), .agg_3_node3 (agg2_3_node3),      
        .out_ready_aggregator (agg2_ready)
    );

    //--------------------------------------------------------------------------
    // Layer2 (mac2) of DNN for each node of GNN
    //--------------------------------------------------------------------------

    mac2 mac2_node0 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_mac2 (agg2_ready),
        .relu4 (agg2_0_node0), .relu5 (agg2_1_node0), .relu6 (agg2_2_node0), .relu7 (agg2_3_node0),
        .w48 (w48), .w58 (w58), .w68 (w68), .w78 (w78),
        .w49 (w49), .w59 (w59), .w69 (w69), .w79 (w79),
        .out0_ready (out10_ready_node0), .out1_ready (out11_ready_node0),
        .out0 (out0_node0), .out1 (out1_node0)
    );

    mac2 mac2_node1 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_mac2 (agg2_ready),
        .relu4 (agg2_0_node1), .relu5 (agg2_1_node1), .relu6 (agg2_2_node1), .relu7 (agg2_3_node1),
        .w48 (w48), .w58 (w58), .w68 (w68), .w78 (w78),
        .w49 (w49), .w59 (w59), .w69 (w69), .w79 (w79),
        .out0_ready (out10_ready_node1), .out1_ready (out11_ready_node1),
        .out0 (out0_node1), .out1 (out1_node1)
    );

    mac2 mac2_node2 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_mac2 (agg2_ready),
        .relu4 (agg2_0_node2), .relu5 (agg2_1_node2), .relu6 (agg2_2_node2), .relu7 (agg2_3_node2),
        .w48 (w48), .w58 (w58), .w68 (w68), .w78 (w78),
        .w49 (w49), .w59 (w59), .w69 (w69), .w79 (w79),
        .out0_ready (out10_ready_node2), .out1_ready (out11_ready_node2),
        .out0 (out0_node2), .out1 (out1_node2)
    );

    mac2 mac2_node3 (
        .clk (clk),
        .rst_n (rst_n),
        .in_ready_mac2 (agg2_ready),
        .relu4 (agg2_0_node3), .relu5 (agg2_1_node3), .relu6 (agg2_2_node3), .relu7 (agg2_3_node3),
        .w48 (w48), .w58 (w58), .w68 (w68), .w78 (w78),
        .w49 (w49), .w59 (w59), .w69 (w69), .w79 (w79),
        .out0_ready (out10_ready_node3), .out1_ready (out11_ready_node3),
        .out0 (out0_node3), .out1 (out1_node3)
    );

endmodule










