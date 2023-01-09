part of 'covid_bloc.dart';



@immutable
abstract class CovidState {
  const CovidState();
  get covidModel => CovidModel.empty;
}

class CovidInitial extends CovidState {}

class CovidErro extends CovidState {}


class CovidLoadState extends CovidState {

  final CovidStatus status;
  final CovidModel covidModel;

  const CovidLoadState._({
    this.status = CovidStatus.unknown,
    this.covidModel = CovidModel.empty
  });

  const CovidLoadState.unknown() : this._();

  const CovidLoadState.loaded(CovidModel covidModel)
      : this._(status: CovidStatus.loaded,covidModel: covidModel);
}
