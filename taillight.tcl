if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -work work [pwd]/sig.vhd

vsim sig

add wave *

force clk 0 0, 1 13.5 -repeat 27
force L 0 0, 1 100
force L 0 0, 0 300
force R 0 0, 1 300
force R 0 0, 0 600
force H 0 0, 1 600

view structure
view signals

run 1000

view -undock wave
wave zoomfull