void settings() {
	size(1000, 1000, FX2D);
}

void setup() {
	noStroke();
	colorMode(HSB, 100);
}

ArrayList<Float> circleX = new ArrayList<Float>();
ArrayList<Float> circleY = new ArrayList<Float>();
ArrayList<Float> circleSize = new ArrayList<Float>();
ArrayList<Integer> circleDepth = new ArrayList<Integer>();

final int DEPTH_LIMIT = 5;

void fractal(final int step, final int depth, final float x, final float y) {
	if (depth > DEPTH_LIMIT) return;

	final float dist = width / step;
	final float offset = pow(2, -depth);
	final float size = dist / pow(2, depth + 1);

	circleX.add((x + offset) * dist);
	circleY.add((y - offset) * dist);
	circleSize.add(size);
	circleDepth.add(depth);

	fractal(step, depth + 1, x + offset, y + offset);
	fractal(step, depth + 1, x + offset, y);
	fractal(step, depth + 1, x, y + offset);
	fractal(step, depth + 1, x, y);


	return;
}

void draw() {
	background(0);
	int step = 5;

	final int interval = 7000;
	final int stepDelay = 500;

	for (int i = -1; i <= step + 1; i++) {
		for (int j = -1; j <= step + 1; j++) {
			fractal(step, 0, i, j);
		}
	}

	for(int j = DEPTH_LIMIT - 1; j >= 0; j--) {

		final float val = 1.0 / DEPTH_LIMIT * (j + 1);
		final int td = millis() + j * -stepDelay;
		final float t = (td % interval) / (float)interval;
		final color color0 = color(t * 100, 100, 100);
		final color color1 = color(t * 100, 100, 40);
		fill(lerpColor(color0, color1, val));

		for(int i = 0; i < circleSize.size(); i++) {

			if(circleDepth.get(i) != j) continue;

			ellipse(
				circleX.get(i),
				circleY.get(i),
				circleSize.get(i),
				circleSize.get(i)
				);
			}
	}

	circleX.clear();
	circleY.clear();
	circleSize.clear();
	circleDepth.clear();
}
