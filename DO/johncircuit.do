# add all the signals to the Wave window

# inputs
add wave clk
add wave reset
add wave threshold
add wave ent_sensor
add wave ext_sensor
add wave p1
add wave p2
add wave p1_reg
add wave p2_reg
add wave op
add wave r_next
add wave r_reg

# outputs
add wave disp_out
add wave max_capacity

# initialize all signals
force reset 1
force ent_sensor 0
force ext_sensor 0
force clk 0
run 2

# set threshold
force threshold 00000100
run 2

# deassert reset
force reset 0

# increment the counter
# 1 | 1
force clk 1
run 2
force ent_sensor 1
force clk 0
run 2
force clk 1
run 2
force ent_sensor 0
force clk 0
run 2

# 2 | 2
force clk 1
run 2
force ent_sensor 1
force clk 0
run 2
force clk 1
run 2
force ent_sensor 0
force clk 0
run 2

# 3 | 3
force clk 1
run 2
force ent_sensor 1
force clk 0
run 2
force clk 1
run 2
force ent_sensor 0
force clk 0
run 2

# 4 | 4
force clk 1
run 2
force ent_sensor 1
force clk 0
run 2
force clk 1
run 2
force ent_sensor 0
force clk 0
run 2

# 5 | 4
force clk 1
run 2
force ent_sensor 1
force clk 0
run 2
force clk 1
run 2
force ent_sensor 0
force clk 0
run 2

# if someone enters and another leaves at the same time
# 5 | 4
force clk 1
run 2
force ent_sensor 1
force ext_sensor 1
force clk 0
run 2
force clk 1
run 2
force ent_sensor 0
force ext_sensor 0
force clk 0
run 2

# if no one enters or leaves
# 5 | 4
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2

# decrement the counter to 0
# 4 | 4
force clk 1
run 2
force ext_sensor 1
force clk 0
run 2
force clk 1
run 2
force ext_sensor 0
force clk 0
run 2

# 3 | 3
force clk 1
run 2
force ext_sensor 1
force clk 0
run 2
force clk 1
run 2
force ext_sensor 0
force clk 0
run 2

# 2 | 2
force clk 1
run 2
force ext_sensor 1
force clk 0
run 2
force clk 1
run 2
force ext_sensor 0
force clk 0
run 2

# 1 | 1
force clk 1
run 2
force ext_sensor 1
force clk 0
run 2
force clk 1
run 2
force ext_sensor 0
force clk 0
run 2

# 0 | 0
force clk 1
run 2
force ext_sensor 1
force clk 0
run 2
force clk 1
run 2
force ext_sensor 0
force clk 0
run 2

# test the underflow protection
force clk 1
run 2
force ext_sensor 1
force clk 0
run 2
force clk 1
run 2
force ext_sensor 0
force clk 0
run 2

# reset the counter
force reset 1
run 2