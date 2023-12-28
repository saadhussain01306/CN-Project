#include <iostream>
#include <fstream>
#include <string>

// Simple parser created to obtain delay for wired case
int main(int argc, char** argv){
	char a;
	float number;
	int source, dest;
	float time1, time2;
	std::string test;
	std::ifstream myfile ("out6.tr");
	bool empty_plus = true;
	bool packet_var = true;

	if(myfile.is_open()){
		for (int i = 1; i <= 100; i++){
			myfile>>a >>number >>source >>dest;
			if(empty_plus && a == '+'){
				empty_plus = false;				
				time1 = number;
			}
			if(a == 'r' and dest ==6){
				if(packet_var){
					time2 = number;
					packet_var =false;
				}
			}
			getline(myfile,test);

		}

	}
	std::cout<<time2-time1 <<" is the transfer time\n";


	return 0;
}
