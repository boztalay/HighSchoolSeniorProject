#include <cstdlib>
#include <iostream>
#include <string>
#include <math.h>

using namespace std;

int main()
{
    int choice = 0;
	string binaryNum;
	float decimalNum = 0.0F;
	float decimalNum2 = 0.0F;
	unsigned int bigNum = 0;
	float twos = 0.0F;
	int powers = 0;
	bool again = true;
    
    cout << "This program converts back and forth between decimal numbers\n";
    cout << "and signed 32-bit fixed-point binary numbers with the representation:\n";
    cout << "0000.00000000000000000000000000\n\n";
    
	while(again == true) {
		choice = 0;
		decimalNum = 0.0F;
		decimalNum2 = 0.0F;
		bigNum = 0;
		twos = 0.0F;
		powers = 0;
		again = true;

	    cout << "To decimal (1) or to binary (2)? ";
	    cin >> choice;
    
	    if(choice == 1) {
			cout << "\n\nEnter your binary number, without a decimal point: \n";
			cin >> binaryNum;
	
			twos = 4.0F;
	
			for(int i = 0; ((i < 32) && (binaryNum[i] != '\0')); i++) {
				if(binaryNum[i] == '1') {
					if(i == 0) {
						decimalNum -= 8.0F;
					} else {
						decimalNum += twos;
						twos /= 2.0F;
					}
				} else {
					if(i != 0)
						twos /= 2.0F;
				}
			}
	
			cout << "\n\nHere's your number, foo: " << decimalNum << "\n\n";
	    } else if(choice == 2) {
	        cout << "\n\nEnter your decimal number: \n";
			cin >> decimalNum;
			decimalNum2 = decimalNum;
			
			binaryNum = "00000000000000000000000000000000";
	
			if(decimalNum < 0.0F) {
				decimalNum += 8.0F;
				binaryNum[0] = '1';
			}
	
			powers = 2;
	
			for(int i = 1; i < 32; i++) {
				if(pow(2, powers) <= decimalNum) {
					decimalNum -= pow(2, powers);
					binaryNum[i] = '1';
				}
				powers--;
			}
	
			cout << "\n\nHere's your raw binary: " << binaryNum << "\n";
			cout << "Here's it with a decimal point: " << binaryNum.substr(0, 4) << "." << binaryNum.substr(4, 28) << "\n";	
	
			twos = 4.0F;
			decimalNum2 = 0.0F;
	
			for(int j = 0; j < 32; j++) {
				if(binaryNum[j] == '1') {
					if(j == 0) {
						decimalNum2 -= 8.0F;
					} else {
						decimalNum2 += twos;
						twos /= 2.0F;
					}
				} else {
					if(j != 0)
						twos /= 2.0F;
				}
			}
	
			cout << "Here's it spit back: " << decimalNum2 << "\n"; 
	
			bigNum = 0;
	
			for(int k = 0; k < 32; k++) {
				if(binaryNum[k] == '1') {
					bigNum += int(pow(2, (31 - k)));
				}
			}
		
			cout << "And here's it as an unsigned integer: " << bigNum << "\n\n";
	
	    } else {
	    	cout << "You're dumb.";
	    } 

		cout << "Again (1/0)? ";
		cin >> again;  
		cout << "\n";
	}
	    
	cout << "\n";
    system("PAUSE");
    return EXIT_SUCCESS;
}
