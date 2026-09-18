// Go about the color wheel blinking an rgb LED at 60 degree intervals

module top (
    input  logic clk, 
    // output logic LED    
    output logic RGB_R = 0,
    output logic RGB_G = 1,
    output logic RGB_B = 1
);

    // Clock every 0.5s -> change to be (1/6)s to get full cycle every second
    parameter BLINK_INTERVAL = 2000000;
    logic [$clog2(BLINK_INTERVAL) - 1:0] count = 0;

    //cycle through 6 colors
    logic [2:0] color_idx = 0;

    always_ff @(posedge clk) begin
        if (count == BLINK_INTERVAL - 1) begin
            count <= 0;
            if (color_idx == 5) begin
                color_idx <= 0; // If Magenta, loop back to Red
            end
            else begin
                color_idx <= color_idx + 1; // Otherwise, move to the next color
            end
            if (color_idx == 0) begin //// Is it more expensive to assign all three instead of just the changes, or is it negligible?
                // set rgb to red -> useful reset in case somethings mucks up elsewhere, but probably unecessary
                RGB_R <= 0;
                RGB_G <= 1;
                RGB_B <= 1;
            end
            else if (color_idx == 1) begin
                // set rgb to yellow
                RGB_G <= 0;
            end
            else if (color_idx == 2) begin
                // set rgb to green
                RGB_R <= 1;
            end
            else if (color_idx == 3) begin
                // set rgb to cyan
                RGB_B <= 0;
            end
            else if (color_idx == 4) begin
                // set rgb to blue
                RGB_G <= 1;
            end
            else if (color_idx == 5) begin
                // set rgb to magenta
                RGB_R <= 0;
            end
        end
        else begin
            count <= count + 1;
        end
    end

endmodule

//// nX is the convention for paths? -> useful for debugging glitches?