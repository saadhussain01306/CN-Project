<!DOCTYPE html>
<html>

<body>

  <h1>NS2 Simulation Project</h1>

  <h2>Overview</h2>

  <p>This repository contains scripts and files for an NS2 simulation project focused on determining packet transmit
    time with varying node destinations. The project includes both wired and wireless network simulations, each providing
    insights into different aspects of network behavior.</p>

  <h2>Project Structure</h2>

  <ul>
    <li><strong><code>wired.tcl</code>:</strong> Script for the wired network simulation using NS2.</li>
    <li><strong><code>wireless.tcl</code>:</strong> Script for the wireless network simulation using NS2.</li>
    <li><strong><code>thesis.tr</code>:</strong> Trace file for wireless network simulation.</li>
    <li><strong><code>thesis.nam</code>:</strong> NAM (Network Animator) file for visualizing the wireless network
      simulation.</li>
    <li><strong><code>delay.awk</code>:</strong> AWK script for analyzing delay in the wireless network simulation.</li>
    <li><strong><code>throughput.awk</code>:</strong> AWK script for analyzing throughput in the wireless network
      simulation.</li>
  </ul>

  <h2>Simulation Setup</h2>

  <h3>Wired Simulation</h3>

  <ul>
    <li>Seven nodes connected by duplex links.</li>
    <li>Dynamic routing (DV) used.</li>
    <li>CBR traffic source at node n(0) with a corresponding traffic sink at node n(1).</li>
    <li>Simulation events include the initiation and termination of CBR traffic.</li>
    <li>Concludes after 2.0 seconds.</li>
  </ul>

  <h3>Wireless Simulation</h3>

  <ul>
    <li>Ad-hoc network with 20 mobile nodes.</li>
    <li>Two-ray ground radio-propagation model, 802.11 MAC, and PriQueue for interface queue.</li>
    <li>Energy model for each node, with random node movement every 100 seconds.</li>
    <li>Multiple TCP connections established between sender nodes and a common receiver node.</li>
    <li>Simulation concludes after a specified time.</li>
  </ul>

  <h2>Execution</h2>

  <p>To run the simulations:</p>

  <pre><code>ns wired.tcl
ns wireless.tcl
</code></pre>

  <h2>Results and Analysis</h2>

  <p>Results and analysis of the simulations are presented in the project report. Refer to the <a href="link-to-report">project
      report</a> for detailed insights.</p>

  <h2>Conclusion</h2>

  <p>This NS2 simulation project provides valuable insights into packet transmit times in both wired and wireless network
    scenarios. The wired simulation explores the impact of dynamic routing, while the wireless simulation investigates the
    effects of node mobility on energy consumption and network performance.</p>


</body>

</html>
