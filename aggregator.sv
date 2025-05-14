module aggregator #(
    parameter INPUT_WIDTH   = 5,   // Width of the input operands
    parameter OUTPUT_WIDTH  = 7   // Width of the output
) (
    input  logic clk, rst_n,
    // Aggregator input ready signal
    input  logic in_ready_aggregator,
    // Aggregator inputs for Node-0, Node-1, Node-2, Node-3
    input  logic signed [INPUT_WIDTH-1:0] x0_node0, x1_node0, x2_node0, x3_node0,
    input  logic signed [INPUT_WIDTH-1:0] x0_node1, x1_node1, x2_node1, x3_node1,
    input  logic signed [INPUT_WIDTH-1:0] x0_node2, x1_node2, x2_node2, x3_node2,
    input  logic signed [INPUT_WIDTH-1:0] x0_node3, x1_node3, x2_node3, x3_node3,
    // Aggregator outputs for Node-0, Node-1, Node-2, Node-3
    output logic signed [OUTPUT_WIDTH-1:0] agg_0_node0, agg_1_node0, agg_2_node0, agg_3_node0,
    output logic signed [OUTPUT_WIDTH-1:0] agg_0_node1, agg_1_node1, agg_2_node1, agg_3_node1,
    output logic signed [OUTPUT_WIDTH-1:0] agg_0_node2, agg_1_node2, agg_2_node2, agg_3_node2,  
    output logic signed [OUTPUT_WIDTH-1:0] agg_0_node3, agg_1_node3, agg_2_node3, agg_3_node3,
    // Aggregator output ready signal  
    output logic out_ready_aggregator
);
    
    //--------------------------------------------------------------------------
    // Aggregation logic
    //--------------------------------------------------------------------------
    //
    // For each Node-j, we sum up the features from itself and its neighbors.
    //   - Node-0 aggregates Node0 + Node1 + Node2
    //   - Node-1 aggregates Node1 + Node0 + Node3
    //   - Node-2 aggregates Node2 + Node0 + Node3
    //   - Node-3 aggregates Node3 + Node1 + Node2
    //
    //--------------------------------------------------------------------------

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            agg_0_node0 <= 0;
            agg_1_node0 <= 0;
            agg_2_node0 <= 0;
            agg_3_node0 <= 0;

            agg_0_node1 <= 0;
            agg_1_node1 <= 0;
            agg_2_node1 <= 0;
            agg_3_node1 <= 0;

            agg_0_node2 <= 0;
            agg_1_node2 <= 0;
            agg_2_node2 <= 0;
            agg_3_node2 <= 0;

            agg_0_node3 <= 0;
            agg_1_node3 <= 0;
            agg_2_node3 <= 0;
            agg_3_node3 <= 0;

            out_ready_aggregator <= 0;
        end
        else if (in_ready_aggregator) begin
            agg_0_node0 <= x0_node0 + x0_node1 + x0_node2;
            agg_1_node0 <= x1_node0 + x1_node1 + x1_node2;
            agg_2_node0 <= x2_node0 + x2_node1 + x2_node2;
            agg_3_node0 <= x3_node0 + x3_node1 + x3_node2;

            agg_0_node1 <= x0_node1 + x0_node0 + x0_node3;
            agg_1_node1 <= x1_node1 + x1_node0 + x1_node3;
            agg_2_node1 <= x2_node1 + x2_node0 + x2_node3;
            agg_3_node1 <= x3_node1 + x3_node0 + x3_node3;

            agg_0_node2 <= x0_node2 + x0_node0 + x0_node3;
            agg_1_node2 <= x1_node2 + x1_node0 + x1_node3;
            agg_2_node2 <= x2_node2 + x2_node0 + x2_node3;
            agg_3_node2 <= x3_node2 + x3_node0 + x3_node3;

            agg_0_node3 <= x0_node3 + x0_node1 + x0_node2;
            agg_1_node3 <= x1_node3 + x1_node1 + x1_node2;
            agg_2_node3 <= x2_node3 + x2_node1 + x2_node2;
            agg_3_node3 <= x3_node3 + x3_node1 + x3_node2;

            out_ready_aggregator <= 1;
        end
        else begin
            out_ready_aggregator <= 0;
        end
    end 

endmodule
