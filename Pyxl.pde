class Pyxl {
  private Config cfg;
  private JSONObject imageJson;
  private String[][] imageHexCodes;
  private int gap;
  private int size;
  private int pixelSize;
  private int secondsCounter = 0;

  Pyxl(Config cfg) {
    this.cfg = cfg;
    this.fetchImage();
  }
  
  private void fetchImage() {
    imageJson = loadJSONObject(cfg.baseUrl + "/image");
    gap = imageJson.getInt("gap");
    JSONArray rows = imageJson.getJSONArray("display");
    size = rows.size();
    imageHexCodes = new String[rows.size()][rows.size()];
    
    for (int y = 0; y < rows.size(); y++) {
      JSONArray cols = rows.getJSONArray(y);
      for (int x = 0; x < cols.size(); x++) {
        imageHexCodes[y][x] = cols.getString(x);
      }
    }
  }
  
  private void checkForUpdate() {
    this.secondsCounter += 1;
    if (this.secondsCounter > cfg.retryCountSeconds) {
      this.secondsCounter = 0;
      fetchImage();
    } 
  }
  
  private void calculatePixelSize() {
    float smallestDimension = min(height, width);
    float totalGapSize = parseFloat((size * gap) + gap);
    pixelSize = floor((smallestDimension - totalGapSize) / this.size);
  }
  
  private boolean isLandscape() {
    if (height <= width) {
      return true;
    } else {
      return false;
    }
  }
  
  private int startX() {
    if (isLandscape()) {
      return floor((width - (size * (pixelSize + gap))) / 2);
    } else {
      return gap;
    }
  }
  
  private int startY() {
    if (isLandscape()) {
      return gap;
    } else {
      return floor((height - (size * (pixelSize + gap))) / 2);
    }
  }
  
  void drawImage() {
    this.calculatePixelSize();
    
    int yCoord = startY();
    for (int y = 0; y < this.size; y++) {
      int xCoord = startX();
      
      for (int x = 0; x < size; x++) {
        String hexCode = imageHexCodes[y][x];
        int hc = unhex("FF" + hexCode.substring(1));
        fill(hc);
        rect(xCoord, yCoord, pixelSize, pixelSize);
        xCoord += pixelSize + gap;
      }
      yCoord += pixelSize + gap;
    }
    
    checkForUpdate();
  }
}
