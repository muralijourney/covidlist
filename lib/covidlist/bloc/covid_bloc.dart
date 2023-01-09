import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled/covidlist/dataModel/covidModel.dart';
import 'package:untitled/covidlist/dataModel/covid_response_model.dart';
import '../dataModel/covid_repository.dart';

part 'covid_event.dart';
part 'covid_state.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc():super(CovidInitial()) {
   on<CovidStatusLoad>(_onCovidStatusLoad);
  }

  final CovidRepository _covidRepository = CovidRepository();
  late final CovidModel covidModel;


  Future<void> _onCovidStatusLoad(
      CovidStatusLoad event,
      Emitter<CovidState> emit
      ) async {

    switch (event.status) {
      case CovidStatus.loaded:
       final model = await _covidRepository.loadingList();
       covidModel = model ?? CovidModel.empty; ///
        return emit(
          model != null
              ? CovidLoadState.loaded(model)
              : CovidErro(),
        );
      case CovidStatus.unknown:
        return emit(CovidErro());
    }
  }

  void onSearch(String value) {
    try{
      if(covidModel.countryList.isNotEmpty) {
        List<Countries> countryList = [];
        countryList.addAll(covidModel.countryList);
        List<Countries> filterCountryList = countryList.where((i) =>
        i.country.toString().toUpperCase().contains(value.toUpperCase()))
            .toList();

        if (value == "") {
          emit(
              CovidLoadState.loaded(
                  CovidModel(id: covidModel.id,
                  globalJson: covidModel.globalJson,
                  countryList: countryList))
          );
        }else if(filterCountryList.isEmpty){
          emit(
              CovidLoadState.loaded(
                  CovidModel(id: covidModel.id,
                      globalJson: covidModel.globalJson,
                      countryList: countryList))
          );
        } else {
          emit(
              CovidLoadState.loaded(CovidModel(id: covidModel.id,
                  globalJson: covidModel.globalJson,
                  countryList: filterCountryList))
          );
        }
      }

    }catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }



}
