

int maxIterations;
float ca, cb;      // ca : real constant, cb : imaginary constant
float threshold;
float angle;

void setup() {
  
  size(1000, 800);
  
  // changing the color mode to hsb, for better color options
  colorMode(HSB, 1.0);
  
  background(255);
  maxIterations = 100;
  threshold = 16;
  angle = 0;
  
}

void draw() {
  
  background(255);
  loadPixels();
  
   //ca = map(mouseX, 0, width, -1, 1);
   //cb = map(mouseY, 0, height, -1, 1);
  //ca = -0.70176;
  //cb = -0.384;
  
  ca = 0.78 * sin(angle);
  cb = 0.78 * cos(angle);
  angle += 0.01;


  float w = 5;        // zoom factor
  float h = (w * height) / width;

  float xmin = -w/2;
  float ymin = -h/2;
  
  float xmax = xmin + w;
  float ymax = ymin + h;

  float dx = (xmax - xmin) / (width);
  float dy = (ymax - ymin) / (height);

  float y = ymin, x;
  
  for (int j = 0; j < height; j++, y+= dx) {
    x = xmin;
    
    for (int i = 0; i < width; i++, x+= dy) {  
      apply_transformation(x , y, i,j);
      
    }
   
  }
  
  updatePixels();
  
  println(ca + " " + cb);
}

// function to apply the transformation on the complex number
// z -> z^2 + c

void apply_transformation(float a, float b, int i, int j){
  int n = 0;
  
  while (n < maxIterations) {
    float a_square = a * a;
    float b_square = b * b;
    
    // check if distance exceeding threshold
    if (a_square + b_square > threshold) {
      break;  
    }
    
    float two_ab = 2 * a * b;
    a = a_square - b_square + ca;
    b = two_ab + cb;
    n++;
  }
  
  // update the pixel value
  pixels[i + j * width] = n == maxIterations? color(0) : color(sqrt(float(n)/maxIterations));

  
}
