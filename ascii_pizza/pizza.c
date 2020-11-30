#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define N 50 // Size
#define RADIUS N/2
#define CRUST_WIDTH N/20
#define SAUSAGE_SIZE N/16
#define SAUSAGE_COUNT N*N/150
#define MUSHROOM_COUNT N*N/250
#define MUSHROOM_SIZE_X 12
#define MUSHROOM_SIZE_Y 6

const char sausage[] = "Oo";
const char crust[] = "##";
const char no_topping[] = "..";
const char outside[] = "  ";
const char mushroom[][MUSHROOM_SIZE_X] = {
		"...,-=-.....",
		"../.....\\...",
		",'._____.`..",
		"`='\\(_)/`='.",
		"....).(.....",
		"....|||....."
};

double sq(double x) {
	return pow(x, 2);
}

double dist(double x1, double y1, double x2, double y2) {
	return sqrt(sq(x1-x2) + sq(y1-y2));
}

bool in_bounding_box(int x, int y, int size_x, int size_y, int obj_x, int obj_y) {
	return
			x <= obj_x && obj_x < x + size_x &&
			y <= obj_y && obj_y < y + size_y;
}

int main() {
	srand(1); // Magic pizza seed

	// Initializing sausage coordinates
	int sausage_x[SAUSAGE_COUNT], sausage_y[SAUSAGE_COUNT];
	for (int i = 0; i < SAUSAGE_COUNT; i++) {
		sausage_x[i] = rand() % 50;
		sausage_y[i] = rand() % 50;
	}
	// Initializing mushroom coordinates
	int mushroom_x[MUSHROOM_COUNT], mushroom_y[MUSHROOM_COUNT];
	for (int i = 0; i < MUSHROOM_COUNT; i++) {
		mushroom_x[i] = rand() % 50;
		mushroom_y[i] = rand() % 50;
	}

	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			// Outside
			if (dist(RADIUS, RADIUS, i, j) > RADIUS) {
				printf("%s", outside);
			}
			// Crust
			else if(dist(RADIUS, RADIUS, i, j) > RADIUS - CRUST_WIDTH) {
				printf("%s", crust);
			}
			// Inside
			else {
				// Checking for sausages
				bool on_sausage = false;
				for (int k = 0; k < SAUSAGE_COUNT; k++) {
					if (dist(i, j, sausage_x[k], sausage_y[k]) <= SAUSAGE_SIZE) {
						on_sausage = true;
					}
				}
				// Checking for mushrooms
				bool on_mushroom = false;
				int mushroom_id = 0;
				for (int k = 0; k < MUSHROOM_COUNT; k++) {
					if (in_bounding_box(j, i, MUSHROOM_SIZE_X, MUSHROOM_SIZE_Y, mushroom_x[k], mushroom_y[k])) {
						on_mushroom = true;
						mushroom_id = k;
					}
				}
				// Sausage
				if (on_sausage) {
					printf("%s", sausage);
				}
				// Mushroom
				else if (on_mushroom) {
					int x = mushroom_x[mushroom_id] - j - 1;
					int y = MUSHROOM_SIZE_Y - (mushroom_y[mushroom_id] - i) - 1;
					printf("%c%c", mushroom[y][x], mushroom[y][x+1]);
				}
				// No topping
				else {
					printf("%s", no_topping);
				}
			}
		}
		printf("\n");
	}
	return 0;
}
