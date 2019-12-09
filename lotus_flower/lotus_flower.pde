void setup() {
	size(800, 800, FX2D);
	frameRate(60);
	strokeWeight(3);
}

int layer = 19;
int leaf = 7;
float interval = 15000;

float inOutExp(float x) {
	final float exp = 10;
	return x < 0.5f ?
			0.5f * pow(2f, exp * (2f*x - 1f)) :
			0.5f * (-pow(2f, exp * (-2f*x + 1f)) + 2f);
}

void draw() {
	background(0);

	float x = width / 2;
	float y = height / 2;
	float size = min(x, y);

	for (int j = 0; j < layer; j++) {
		float r = size - j * size / layer;
		r *= 1.5;
		float timer = sin(millis() / interval * PI);
		float rotate = PI / leaf * timer * j;
		float perlin = noise(millis()/1000.0 + j * 0.2);
		float perlin2 = noise(millis()/888.0 + j * 0.07 + 10000);
		if (perlin2 > 0.5) {
			fill(lerpColor(#222222, #11CDDE, (inOutExp(perlin2) - 0.5) * 2));
		}
		else {
			fill(lerpColor(#FF7F50, #222222, inOutExp(perlin2) * 2));
		}
		for (int i = 0; i < leaf; i++) {
			float c = cos(TAU * (float)i/leaf + rotate);
			float d = sin(TAU * (float)i/leaf + rotate);
			ellipse(
					x + c * r / 2,
					y + d * r / 2,
					r * perlin,
					r * perlin
			);
			ellipse(
					x + c * r / 2,
					y + d * r / 2,
					r * perlin - 15,
					r * perlin - 15
			);
		}
	}
}
