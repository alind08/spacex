import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex/models/space_launch_response_model.dart';

class SpaceXServices {
  Future<List<SpaceXLaunches>> getLaunches(String url) async {
    List<SpaceXLaunches> launchList=[];
    print("Inside future login function");

    SpaceXLaunches _apiResponse = SpaceXLaunches();
    try {
      final response = await http.get(url);
      final jsonResponse = json.decode(response.body);
      print("url is $url");
      print("length is ${jsonResponse.length}");
      if (response.statusCode == 200) {

        for(int i = 0;i<=jsonResponse.length-1;i++){
          _apiResponse = SpaceXLaunches.fromJson(jsonResponse[i]);
          launchList.add(_apiResponse);
        }

          print(jsonEncode(_apiResponse));
          print("login success");
          return launchList;
      }else{
        print("login not success");
        return launchList;
      }
    } on Exception catch (e) {
      print("login throwing exception");
      throw Exception(e);
    }
  }
}
