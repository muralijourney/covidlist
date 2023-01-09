part of 'covid_bloc.dart';

@immutable
abstract class CovidEvent {
  const CovidEvent();
}

class CovidStatusLoad extends CovidEvent {
  const CovidStatusLoad(this.status);

  final CovidStatus status;
}