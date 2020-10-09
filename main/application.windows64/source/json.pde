import http.requests.*;

String kei = "87A87V-5RGY6Q-VFFMP6-4KGX";
String url = "https://www.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/300/&apiKey=";

int i = 0;

int id;
String name;

GetRequest get = new GetRequest(url+kei);

PVector[] locationList;
int[] timestampList;

PVector getPosition(int number) {
  return locationList[number];
}

int getTime(int number) {
  return timestampList[number];
}

void request() {
  get.send();
  JSONObject json = parseJSONObject(get.getContent());
  if (json == null) {
    println("JSONObject could not be parsed");
  } else {
    JSONObject info = json.getJSONObject("info");
    id = info.getInt("satid");
    name = info.getString("satname");
    JSONArray list = json.getJSONArray("positions");
    locationList = new PVector[list.size()];
    timestampList = new int[list.size()];
    for (int i = 0; i < list.size(); i++) {
      JSONObject object = list.getJSONObject(i);
      locationList[i] = new PVector(object.getFloat("satlatitude"), object.getFloat("satlongitude"), object.getFloat("sataltitude"));
      timestampList[i] = object.getInt("timestamp");
    } 
    JSONObject object = list.getJSONObject(0);
    float l = object.getFloat("dec");
  }
}
