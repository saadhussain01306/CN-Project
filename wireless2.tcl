# Define options
set val(chan) Channel/WirelessChannel ;# channel type
set val(prop) Propagation/TwoRayGround ;# radio-propagation model
set val(netif) Phy/WirelessPhy ;# network interface type
set val(mac) Mac/802_11 ;# MAC type
set val(ifq) Queue/DropTail/PriQueue ;# interface queue type
set val(ll) LL ;# link layer type
set val(ant) Antenna/OmniAntenna ;# antenna model
set val(ifqlen) 50 ;# max packet in ifq
set val(nn) 20 ;# number of mobilenodes
set val(rp) AODV ;# routing protocol
set val(x) 1000 ;# X dimension of topography
set val(y) 1000 ;# Y dimension of topography
set val(stop) 300 ;# time of simulation end
set val(sender) 5;
set val(energy) 150;

set ns [new Simulator]
set tracefd [open thesis.tr w]
set namtrace [open thesis.nam w]

$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

# set up topography object
set topo [new Topography]

$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

# configure the nodes
$ns node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace OFF \
-movementTrace ON

#Random generator
proc random {min max} {
    set randvar [expr {int(rand() * ($max + 1 - $min)) + $min}]
    return $randvar
}


# Energy model for every node
#Energy=Power*time
#Jule is unit of initialEnergy and rest of Energy is unit is watt
$ns node-config  -energyModel EnergyModel \
-initialEnergy 20 \
-txPower 0.744 \
-rxPower 0.0648 \
-idlePower 0.05 \
-sensePower 0.0175

for {set i 0} {$i < $val(nn) } { incr i } {
set n($i) [$ns node]
}




# Provide initial location of mobilenodes
for {set i 0} {$i < $val(nn) } { incr i } {
	set x_rand [random 0 [expr $val(x)-100] ]
	set y_rand [random 0 [expr $val(y)-100] ]
	
	$n($i) set X_ $x_rand
	$n($i) set Y_ $y_rand
	$n($i) set Z_ 5.0
}



#Set receiver label
$ns at 0.0 "$n(0) label Receiver"
#Set Initial Energy
$n(0) set initialEnergy $val(energy)

for {set i 1} {$i <= $val(sender) } { incr i } {
	$n($i) color orange
	$ns at 0.0 "$n($i) color orange"
	#Set Sender Energy
	$n($i) set initialEnergy $val(energy)

	#Set sender label
	$ns at 0.0 "$n($i) label Sender_$i"

	#Set sink
	set sink_($i) [new Agent/TCPSink]
	$ns attach-agent $n(0) $sink_($i)

	#Set TCP agent
	set tcp_($i) [new Agent/TCP/Newreno]
	$tcp_($i) set class_ 2
	$ns attach-agent $n($i) $tcp_($i)
	$ns connect $tcp_($i) $sink_($i)
	set ftp_($i) [new Application/FTP]
	$ftp_($i) attach-agent $tcp_($i)
	$ns at [expr $i * 10] "$ftp_($i) start"
}


# Set a TCP connection between n(13) and n(7)


#defining heads
#new location after move
for {set i 0} {$i < $val(stop) } { set i [expr {$i + 100}]} {
	for {set j 0} {$j < $val(nn) } { incr j } {
		set x_rand [random 10 [expr $val(x)-100] ]
		set y_rand [random 10 [expr $val(y)-100] ]
		$ns at $i "$n($j) setdest $x_rand $y_rand 5.0"
		
	}
} 


# Define node initial position in nam
for {set i 0} {$i < $val(nn)} { incr i } {
# 40 defines the node size for nam
$ns initial_node_pos $n($i) 60
}

# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
$ns at $val(stop) "$n($i) reset";
}

# ending nam and the simulation
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "stop"
$ns at [expr {$val(stop) + 1}] "puts \"end simulation\" ; $ns halt"
proc stop {} {
global ns tracefd namtrace
$ns flush-trace
close $tracefd
close $namtrace
exec nam thesis.nam &
exec awk -f delay.awk thesis.tr > delay.xg &
exec awk -f throughput.awk thesis.tr > throughput.xg &
exec xgraph delay.xg &
exec xgraph throughput.xg &
exit 0
}


$ns run
