import 'dart:convert';

import 'package:flutter_coivd19_tracker_app/Model/WorldStatesModel.dart';
import 'package:flutter_coivd19_tracker_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices{
  Future<WorldStatesModel> fetchWorldStatesRecords() async{

    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async{

    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error');
    }
  }
}