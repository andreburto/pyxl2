class Config {
  
  public String host;
  public String port;
  public String baseUrl;
  public int retryCountSeconds;
  
  Config(String fileName) {
    JSONObject json = loadJSONObject(fileName);
    
    this.host = json.getString("host", "127.0.0.1");
    this.port = json.getString("port", "80");
    this.retryCountSeconds = json.getInt("retryCountSeconds", 10);
    this.baseUrl = "http://" + this.host + ":" + this.port + "/";
  }
}
