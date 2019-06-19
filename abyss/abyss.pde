int squiggleCount = 7;
color palette[] = {#3c076f, #2E071B};
color backgroundColor = #000000;
Squiggle s[] = new Squiggle[squiggleCount];


void setup() {
	size(480, 720, FX2D);
	background(backgroundColor);

	for(int i=0; i<squiggleCount; i++) {
		s[i] = new Squiggle(palette[i%palette.length], i*100.0);
	}
}

class Squiggle{
	color c;
	float strokeInit = 0.02; // width
	float strokeLast = 0.25; // width
	float headTailDiff = 1500.0; // milliseconds
	float noiseMultipler = 1 / 2500.0;
	float timeOffset; // milliseconds
	int lineCount = 150; // resolution;

	Squiggle(color c, float timeOffset) {
		this.c = c;
		this.timeOffset = timeOffset;
	}

	float position(float i) {
		float time = (millis() + sqrt(i) * headTailDiff) * noiseMultipler;
		float noise = noise(time + timeOffset);
		float absnoise = abs(noise - 0.5) * 2;

		return absnoise;
	}

	void drawLines() {
		float offset = 1.0/lineCount;
		//stroke(c);


		/*
		float positionArr[] = new float[lineCount+1];

		for(int i=0; i<lineCount+1; i++) {
			positionArr[i] = position(offset * i / lineCount);
		}

		for(int i=0; i<lineCount; i++) {
			stroke(lerpColor(c, backgroundColor, 1-pow(position(i), 0.35)));
			strokeWeight(lerp(width * strokeInit, width * strokeLast, (float)i / lineCount));

			float hl = (float)height / lineCount;

			line(width * positionArr[i], hl * i, width * positionArr[i+1], hl * (i+1));
			line(width - (width * positionArr[i]), hl * i, width - (width * positionArr[i+1]), hl * (i+1));
		}*/

		for(float i=offset, j=0; i<1; j=i, i+=offset) {
			stroke(lerpColor(c, backgroundColor, 1-pow(position(i), 0.35)));
			strokeWeight(lerp(width * strokeInit, width * strokeLast, i));

			line(width * position(i), height * i, width * position(j), height * j);
			line(width - (width * position(i)), height * i, width - (width * position(j)), height * j);
		}
		
	}

}

void draw() {
	noStroke();
	fill(backgroundColor, 6);
	rect(0, 0, width, height);

	for(Squiggle s: s) {
		s.drawLines();
	}
}
