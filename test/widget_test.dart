// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled/covidlist/bloc/covid_bloc.dart';
import 'package:untitled/covidlist/dataModel/covidModel.dart';
import 'package:untitled/covidlist/dataModel/covid_repository.dart';
import 'package:untitled/covidlist/dataModel/covid_response_model.dart';
import 'package:untitled/covidlist/ui/covidlist.dart';

@GenerateMocks([Dio])
void main() async {
 /* late CovidRepository covidRepository;
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);

  dio.httpClientAdapter = dioAdapter;
*/
  setUp(() => {
   // covidRepository = CovidRepository()

  });

  const path = 'https://api.covid19api.com/summary';

  testWidgets("Covid Widget Inital Part", (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BlocProvider(
      create: (context) => CovidBloc(),
      child: const MaterialApp(
        home: CovidList(),
      ),
    ));

    // //rebuilds your widget
    await tester.pump(Duration(seconds: 10));

    // // check output
    expect(find.image(const AssetImage("assets/images/nodata.png")),
        findsOneWidget);
  });

  test("CovidList Api Loading", () async {
      CovidBloc covidBloc = CovidBloc();
      covidBloc.add(CovidStatusLoad(CovidStatus.loaded));

    //  expect(covidBloc, true);
  });

/*
  testWidgets("Widgets Testing Level", (WidgetTester tester) async {

    await tester.pumpWidget(BlocProvider(
      create: (context) => CovidBloc(),
      child: const MaterialApp(
        home: CovidList(),
      ),
    ));

    // //rebuilds your widget
    await tester.pump(Duration(seconds: 10));

    expect(find.byKey(const ValueKey("searchKey")), findsOneWidget);
  });*/
}
