int retryCountMs;

String defaultConfigFile = "config.json";

Pyxl p;
Config configuration;

void setup() {
  strokeWeight(0);
  noStroke();
  frameRate(1);
  fullScreen(P3D);
  
  configuration = new Config(defaultConfigFile);
  p = new Pyxl(configuration);
}

void draw() {
  background(#000000);
  p.drawImage();  
}
