
import http.requests.*;
 
JSONObject json;

void setup() {

  GetRequest get = new GetRequest("https://www.n2yo.com/rest/v1/satellite/tle/25544&apiKey=87A87V-5RGY6Q-VFFMP6-4KGX");
  get.send();
  JSONObject json = parseJSONObject(get.getContent());
    if (json == null) {
      println("JSONObject could not be parsed");
    } else {
      println(json);
      JSONObject main = json.getJSONObject("info");
      int id = main.getInt("satid");
      print(id);
    }
  }
