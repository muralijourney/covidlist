import 'package:equatable/equatable.dart';
import 'covid_response_model.dart';

class CovidModel extends Equatable {
  const CovidModel({required this.id, required this.globalJson, required this.countryList});

  final String id;
  final List<Global> globalJson;
  final List<Countries> countryList;

  static const empty = CovidModel(id: '',globalJson: [],countryList: []);

  @override
  List<Object> get props => [id, globalJson, countryList];
}
