#include <cstdlib>
#include <iostream>

using namespace std;

double X = 0.0;
double Y = 0.0;
double cX = 0.0;
double cY = 0.0;
double zX = 0.0;
double zY = 0.0;
double tempX = 0.0;
double tempY = 0.0;
double iterations = 0;
double zAbs = 0.0;

int main()
{
	for(X = -2.0; X < 2.0; X+=0.05) {
		for(Y = 2.0; Y > -2.0; Y-=0.05) {
			cX = X;
		    cY = Y;
		    zX = 0.0;
		    zY = 0.0;
		    iterations = 0;
		    zAbs = 0.0;
		    while ((iterations < 256) && (zAbs < 4.0))
		    {
		          tempY = (2.0 * zX * zY) + cY;
		          tempX = ((zX * zX) - (zY * zY)) + cX;
		          zX = tempX;
		          zY = tempY;
		          zAbs = ((zX * zX) + (zY * zY));
		          iterations++;
		    }
			if(iterations > 8 && iterations < 16) {
				cout << "Found one!\n";
				cout << "Iterations: " << iterations << "\n";
				cout << "X: " << X << "\n";
				cout << "Y: " << Y << "\n\n";
			}
		}
	}

    system("PAUSE");
    return EXIT_SUCCESS;
}
