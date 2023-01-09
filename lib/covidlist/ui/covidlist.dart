import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import 'package:untitled/common/MarqueeWidget.dart';
import 'package:untitled/common/NormalText.dart';
import 'package:untitled/covidlist/bloc/covid_bloc.dart';
import 'package:untitled/covidlist/dataModel/covid_repository.dart';
import 'package:untitled/covidlist/dataModel/covid_response_model.dart';
import 'package:untitled/covidlist/ui/covidBarChart.dart';

class CovidList extends StatefulWidget {
  const CovidList({super.key});

  @override
  State<CovidList> createState() => _CovidListPageState();
}

class _CovidListPageState extends State<CovidList> {
  final CovidBloc _covidBloc = CovidBloc();

  @override
  void initState() {
    _covidBloc.add(const CovidStatusLoad(CovidStatus.loaded));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("COVID-19 List"),
      ),
      body: BlocProvider(
          create: (_) => _covidBloc,
          child: BlocBuilder<CovidBloc, CovidState>(
            builder: (context, state) {
              if (state is CovidInitial) {
                return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              } else if (state is CovidErro) {
                return const Center(
                  child:  Image(
                    image: AssetImage("assets/images/nodata.png"),
                  ));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Global Covid List
                    MarqueeWidget(
                      direction: Axis.horizontal,
                      child: covidCaseShow(state.covidModel.globalJson[0]),
                    ),

                    //Search Country List
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        key: const Key("searchKey"),
                        onChanged: (value) {
                          BlocProvider.of<CovidBloc>(context).onSearch(value);
                        },
                        decoration: const InputDecoration(
                            labelText: "Search",
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),

                    // Country List Load
                    Flexible(
                      child: SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height,
                          child: countryList(state.covidModel.countryList!)),
                    ),
                  ],
                );
              }
            },
          )),
    );
  }

  Widget covidCaseShow(Global globalJson) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            covidCardCount(
                "NewConfirmed: ${globalJson.newConfirmed.toString()}"),
            covidCardCount(
                "TotalConfirmed: ${globalJson.totalConfirmed.toString()}"),
            covidCardCount("NewDeaths:  ${globalJson.newDeaths.toString()}"),
            covidCardCount(
                "TotalDeaths:  ${globalJson.totalDeaths.toString()}"),
            covidCardCount(
                "NewRecovered:  ${globalJson.newRecovered.toString()}"),
            covidCardCount(
                "TotalRecovered:  ${globalJson.totalRecovered.toString()}"),
          ],
        ),
      ),
    );
  }

  Widget covidCardCount(String value) {
    return Card(
      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10))),
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NormalText(
              text: value,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontcolor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget countryList(List<Countries>? countryCovidList) {
    return ListView.builder(
        shrinkWrap: false,
        padding: const EdgeInsets.all(8),
        itemCount: countryCovidList!.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: countryCard(countryCovidList[index]),
          );
        });
  }

  Widget countryCard(Countries model) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CovidBarChart(countriesModel: model)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              // Country Name
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(8),
                child: NormalText(
                  text: model.country.toString(),
                  fontcolor: Colors.amberAccent,
                  fontSize: 25,
                  textAlign: TextAlign.start,
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NormalText(text: "NewConfirmed"),
                        NormalText(text: model.newConfirmed.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NormalText(text: "TotalConfirmed"),
                        NormalText(text: model.totalConfirmed.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NormalText(text: "NewDeaths"),
                        NormalText(text: model.newDeaths.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NormalText(text: "TotalDeaths"),
                        NormalText(text: model.totalDeaths.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NormalText(text: "NewRecovered"),
                        NormalText(text: model.newRecovered.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NormalText(text: "TotalRecovered"),
                        NormalText(text: model.totalRecovered.toString())
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
