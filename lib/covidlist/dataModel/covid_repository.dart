import 'dart:async';

import 'package:dio/dio.dart';

import 'covidModel.dart';
import 'covid_response_model.dart';

enum CovidStatus { unknown, loaded }

class CovidRepository {
  static String _url = 'https://api.covid19api.com/summarys';

  Future loadingList() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(_url);
      if (response.statusCode == 200) {
        covidResponseModel responseModel = covidResponseModel.fromJson(response.data);
        List<Global> globalArray = [];
        globalArray.add(responseModel.global!);
        return CovidModel(id: responseModel.iD!, globalJson: globalArray, countryList: responseModel.countries!);
      }else {
        return CovidModel.empty;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

}
