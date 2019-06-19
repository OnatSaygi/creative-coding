void setup() {
	size(400, 400, FX2D);
	ellipseMode(CENTER);
	noStroke();
	colorMode(RGB, 1);
}

void draw() {
	//background(255);

	int step = 8;
	int offset = 100000;
	float posdiv = 300f;
	float ms = millis() / 3000f;
	float pw = 0.33;

	// every 5 seconds cycle mp from target1 to target2 with sin curve
	posdiv *= map(sin(TAU * millis() / 5000f), -1, 1, 0.8, 1.2);

	for(int i = 0; i < height; i += step) {
		for(int j = 0; j < width; j += step) {
			float r = noise(i/posdiv + ms, j/posdiv + offset*0, ms + offset*0);
			float g = noise(i/posdiv + ms, j/posdiv + offset*1, ms + offset*1);
			float b = noise(i/posdiv + ms, j/posdiv + offset*2, ms + offset*2);

			//fill(r, g, b);
			fill(pow(r, pw), pow(g, pw), pow(b, pw));
			circle(j + step/2, i + step/2, step * 1.5);
		}
	}

	println(frameRate, millis());

}
