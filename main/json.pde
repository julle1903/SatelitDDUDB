import http.requests.*;

String kei = "87A87V-5RGY6Q-VFFMP6-4KGX";
String url = "https://www.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/300/&apiKey=";

void request() {
  GetRequest get = new GetRequest(url+kei);
  // get.send();
  // ;
  //   if (json == null) {
  //     println("JSONObject could not be parsed");
  //   } else {
  //     println(json);
  // JSONObject main = json.getJSONObject("info");
  // int id = main.getInt("satid");
  // 
  // JSONObject object = list.getJSONObject(0);
  // float l = object.getFloat("dec");  
  // println(id);
  // println(l);
  
  JSONObject json = parseJSONObject(get.getContent());
  JSONArray list = json.getJSONArray("positions");

  for (int i = 0; i < 301; i++) {

    JSONObject object = list.getJSONObject(i);
    float l = object.getFloat("dec");  
    println(l);
    if (i == 290) {
      println("Point");
    } else if (i==300) {
      println("new");
      get.send();
      JSONObject ll = parseJSONObject(get.getContent());
      JSONArray lst = json.getJSONArray("positions");
      i=0;
    }
  }
}
