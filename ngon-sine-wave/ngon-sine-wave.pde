float freq=6.0;

ArrayList<Line> Line=new ArrayList<Line>();
int linecnt, getline;
PVector pos, newpos, newsize, tmpvec, tmpvec2;
float angle, cangle;
VecInter interpoint;
PVector[] graphPoint=new PVector[400];

void setup() {
  surface.setTitle("Ngon Sine Wave"); 
  size(1100, 500, FX2D);
  //fullScreen(FX2D);
  textSize(18);
  strokeWeight(2);
  
  pos=new PVector(height/2, height/2);
  for (int i=0; i<graphPoint.length; i++) graphPoint[i]=new PVector(height+((width-height)*i/(graphPoint.length-1)), height/2.0);
}

void draw() {
  //calculations
  if (frameCount==1) linecnt=0;
  else linecnt=round(pow(5.0*mouseX/width, 2))+3;
  angle=(TWO_PI/linecnt);
  cangle=TWO_PI-(TWO_PI*millis()/1000/freq)%TWO_PI;
  getline=ceil((cangle+angle/2-(angle/2.0*mouseY/height))/angle);
  for (int i=Line.size()-1; i>0; i--) Line.remove(i);
  for (int i=0; i<=linecnt; i++) {  
    newpos=PVector.fromAngle((i-.5)*angle+(angle/2.0*mouseY/height)).setMag(height/3).add(pos);
    newsize=PVector.fromAngle((i+.5)*angle+(angle/2.0*mouseY/height)).setMag(height/3).add(pos);
    Line.add(new Line(newpos, newsize.sub(newpos)));
  }
  interpoint=intersect(pos, PVector.fromAngle(cangle).add(pos), Line.get(getline).pos, new PVector(Line.get(getline).size.x, Line.get(getline).size.y).add(Line.get(getline).pos));
  graphPoint[0]=new PVector(height, interpoint.pos.y);
  for (int i=graphPoint.length-1; i>0; i--) graphPoint[i].y=graphPoint[i-1].y;

  //background
  background(255);

  //ngon
  stroke(255, 0, 0);
  for (int i=0; i<Line.size(); i++) Line.get(i).draw();

  //ngon center
  stroke(0);
  ellipse(pos.x, pos.y, 5, 5);

  //garph line
  stroke(127);
  line(height-2, 0, height-2, height);

  //current edge
  stroke(0, 191, 0);
  Line.get(getline).draw();

  //current point
  stroke(0);
  ellipse(interpoint.pos.x, interpoint.pos.y, 5, 5);

  //center to point
  stroke(0, 0, 191);
  line(pos.x, pos.y, interpoint.pos.x, interpoint.pos.y);

  //graph
  stroke(0);
  line(interpoint.pos.x, interpoint.pos.y, height+1, interpoint.pos.y);
  for (int i=0; i<graphPoint.length-1; i++) line(graphPoint[i].x, graphPoint[i].y, graphPoint[i+1].x, graphPoint[i+1].y);

  //text
  fill(0);
  text("Current angle: "+round(degrees(TWO_PI-cangle))+"\nShape angle: "+round(degrees(angle/2.0*mouseY/height))+"\nEdges: "+linecnt, 5, 20);
}


class Line {
  PVector pos, size;
  Line(PVector pos, PVector size) {
    this.pos=pos;
    this.size=size;
  }
  void draw() {
    line(pos.x, pos.y, pos.x+size.x, pos.y+size.y);
  }
}
class VecInter {
  PVector pos;
  boolean state;
  VecInter(float posx, float posy, boolean state) {
    pos=new PVector(posx, posy);
    this.state=state;
  }
}
VecInter intersect(PVector A, PVector B, PVector C, PVector D) {
  float k=((D.y-C.y)*(B.x-A.x)-(B.y-A.y)*(D.x-C.x));
  if (k!=0) {
    k=((D.y-C.y)*(C.x-A.x)-(C.y-A.y)*(D.x-C.x))/k;
    return new VecInter(A.x+(B.x-A.x)*k, A.y+(B.y-A.y)*k, true);
  } else return new VecInter(0, 0, false);
}