import 'package:api_integration/COVID_App/AppModels/WorldStatesModel.dart';
import 'package:api_integration/COVID_App/Services/States_Services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'CountriesListScreen.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {

  late final AnimationController _controller= AnimationController(
      duration: Duration(seconds: 5),
      vsync: this)..repeat();

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorlist= <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices= StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .01,),
                FutureBuilder(
                    future: statesServices.fetchWorldStatesRecords(),
                    builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){


                      if(!snapshot.hasData){
                    return Expanded(
                      flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,

                        )
                    );
                  }else{

                        return Column(
                          children: [

                            PieChart(

                              dataMap: {
                                "Total" : double.parse(snapshot.data!.cases.toString()),
                                "Recovered" : double.parse(snapshot.data!.recovered.toString()),
                                "Deaths" : double.parse(snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions:const ChartValuesOptions(
                                showChartValuesInPercentage: true
                              ),
                              animationDuration: const Duration(milliseconds: 1200),
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                              chartType: ChartType.ring,
                              colorList: colorlist,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .04),
                              child: Card(
                                child: Column(
                                  children: [

                                    ReuseableRow(title: "Total", value:  snapshot.data!.cases.toString()),
                                    ReuseableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                    ReuseableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                    ReuseableRow(title: "Active", value:  snapshot.data!.active.toString()),
                                    ReuseableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                    ReuseableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                                    ReuseableRow(title: "Today Recovered", value:  snapshot.data!.todayRecovered.toString()),

                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesListScreen()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text("Track Country")),
                              ),
                            )
                          ],
                        );

                  }

                }),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
   ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            ],

          ),
          Divider(color: Colors.white,)


        ],
      ),
    );
  }
}

