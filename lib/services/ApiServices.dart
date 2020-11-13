import 'dart:convert';
import '../Utils/Constant.dart' as constant;
import 'package:http/http.dart' as http;


///this class contains most
///of the APIs that are used
///in this application
///@author Ndeme Yvan
///@date 20/05/2020
///Contributors : Ndeme yvan,



class ApiService {
  getVideos(context , String by,{ String id }) async {
    try {
      var jsonResponse;
      var response = await http.get("${constant.ApiBaseUrl}/videos?by=${by}&id=${id}");
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
//        print(" 200 response /user : ${response.body}");
        if (jsonResponse != null) {
          //print(" 200 response /Videos : ${json.decode(response.body)}");
          return json.decode(response.body);
        }
      }
    } catch (e) {
      print(" 200 error /user : ${e}");
    } finally {}
  }


}
