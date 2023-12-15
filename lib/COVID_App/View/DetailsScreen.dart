import 'package:flutter/material.dart';

import 'WorldStateScreen.dart';


class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  int cases, deaths, recovered, active, critical, todayDeaths, todayRecovered;
  DetailsScreen({super.key,
    required String this.name,
    required String this.image,
    required int this.cases,
    required int this.deaths,
    required int this.recovered,
    required int this.active,
    required int this.critical,
    required int this.todayDeaths,
    required int this.todayRecovered,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.name)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),

                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                      ReuseableRow(title: "Cases", value: widget.cases.toString()),
                      ReuseableRow(title: "Deaths", value: widget.deaths.toString()),
                      ReuseableRow(title: "Recovered", value: widget.recovered.toString()),
                      ReuseableRow(title: "Active", value: widget.active.toString()),
                      ReuseableRow(title: "Critical", value: widget.critical.toString()),
                      ReuseableRow(title: "Today Deaths", value: widget.todayDeaths.toString()),
                      ReuseableRow(title: "Today Recovered", value: widget.todayRecovered.toString()),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                  backgroundImage:NetworkImage(widget.image)),
            ],
          ),
        ],
      ),
    );
  }
}
