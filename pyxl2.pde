int retryCountMs;

String defaultConfigFile = "config.json";

Config configuration;

void setup() {
  configuration = new Config(defaultConfigFile);
  retryCountMs = configuration.retryCountSeconds * 1000;
}

void draw() {
  print(configuration.baseUrl);
    
  delay(retryCountMs);
}
