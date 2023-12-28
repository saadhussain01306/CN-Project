
#Goal: To determine package transmit time with varying node 
# destinations

#Create a simulator object
set ns [new Simulator]

#Tell the simulator to use dynamic routing
set rtproto DV

#Open the nam trace file
set nf [open out1.nam w]
$ns namtrace-all $nf

#Open the Trace file
#Change out file based on destination node
set tf [open out1.tr w]
$ns trace-all $tf

#Define a 'finish' procedure
proc finish {} {
	global ns nf tf
	$ns flush-trace
	close $nf
	close $tf
	exec nam -a out1.nam &
	exit 0
}

#Create seven nodes
for {set i 0} {$i < 7} {incr i} {
	set n($i) [$ns node]
}

#create links between the nodes
for {set i 0} {$i<7} {incr i} {
	$ns duplex-link $n($i) $n([expr ($i+1)%7]) 1Mb 10ms DropTail
}

#Create a UDP agent and attach it to node n(0)
set udp0 [new Agent/UDP]
$ns attach-agent $n(0) $udp0

#create a cbr traffic source and attach it to udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

#Create a Null agent (a traffic sink) and attach it to node
#We will vary the destination node and determine transmit time
set null0 [new Agent/Null]
$ns attach-agent $n(1) $null0

#Connect the traffic source with the traffic sink
$ns connect $udp0 $null0
#schedule events for the cbr agent and the network dynamics
$ns at 0.2 "$cbr0 start"
$ns at 0.5 "$cbr0 stop"
$ns at 2.0 "finish"
$ns run