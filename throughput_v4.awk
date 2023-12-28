{
  event = $1
  time = $2
  node_id = $3
  pkt_size = $8
  level = $4
# For 0 - > 1
#-----------------
  if (level == "AGT" && event == "s" && $7 == "tcp" && node_id == "_0_") {
    sent++
    if (!startTime || (time < startTime)) {
      startTime = time
    }
  }

  if (level == "AGT" && event == "r" && $7 == "tcp" && node_id =="_1_") {
    receive++
    if (time > stopTime) {
      stopTime = time
    }
    recvdSize += pkt_size
  }
# For 2->3
#---------------------
  if (level == "AGT" && event == "s" && $7 == "tcp"&& node_id =="_2_") {
    sent2++
    if (!startTime2 || (time < startTime2)) {
      startTime2 = time
    }
  }

  if (level == "AGT" && event == "r" && $7 == "tcp"&& node_id =="_3_") {
    receive2++
    if (time > stopTime2) {
      stopTime2 = time
    }
    recvdSize2 += pkt_size
  }
# For 4->5
#---------------------------------
  if (level == "AGT" && event == "s" && $7 == "tcp"&& node_id =="_4_") {
    sent4++
    if (!startTime4 || (time < startTime4)) {
      startTime4 = time
    }
  }

  if (level == "AGT" && event == "r" && $7 == "tcp"&& node_id =="_5_") {
    receive4++
    if (time > stopTime4) {
      stopTime4 = time
    }
    recvdSize4 += pkt_size
  }

}

END {
  printf("---------0->1------------\n") >"proj2Results.tr"
  printf("sent_packets\t %d\n",sent) > "proj2Results.tr"
  printf("received_packets %d\n",receive) > "proj2Results.tr"
  printf("Packet Loss %d\n",(sent-receive)) > "proj2Results.tr";
  printf("Average Throughput[kbps] = %.2f\tStartTime=%.2f\tStopTime = %.2f\n", (recvdSize/(stopTime-startTime))*(8/1000),startTime,stopTime) >"proj2Results.tr";
  printf("---------2->3------------\n") >"proj2Results.tr"
  printf("sent_packets\t %d\n",sent2) > "proj2Results.tr"
  printf("received_packets %d\n",receive2) > "proj2Results.tr"
  printf("Packet Loss %d\n",(sent2-receive2)) > "proj2Results.tr";
  printf("Average Throughput[kbps] = %.2f\tStartTime=%.2f\tStopTime = %.2f\n", (recvdSize2/(stopTime2-startTime2))*(8/1000),startTime2,stopTime2) >"proj2Results.tr";
  printf("---------4->5------------\n") >"proj2Results.tr"
  printf("sent_packets\t %d\n",sent4) > "proj2Results.tr"
  printf("received_packets %d\n",receive4) > "proj2Results.tr"
  printf("Packet Loss %d\n",(sent4-receive4)) > "proj2Results.tr";
  printf("Average Throughput[kbps] = %.2f\tStartTime=%.2f\tStopTime = %.2f\n", (recvdSize4/(stopTime4-startTime4))*(8/1000),startTime4,stopTime4) >"proj2Results.tr";


}
