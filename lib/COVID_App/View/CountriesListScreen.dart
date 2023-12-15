import 'package:api_integration/COVID_App/Services/States_Services.dart';
import 'package:api_integration/COVID_App/View/DetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {

  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search Country",
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                  ),
                ),
              ),
              SizedBox(height: 5,),

              Expanded(
                  child: FutureBuilder(
                    future: statesServices.fetchCountriesList(),
                    builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                      if(!snapshot.hasData){
                        return ListView.builder(
                            itemCount:  7,

                            itemBuilder: (context, index){
                              return Shimmer.fromColors(

                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade200,
                                child: Column(
                                  children: [
                                    ListTile(

                                      leading: Container(height: 70, width: 70, color: Colors.white),
                                      title:  Container(height: 10, width: 90, color: Colors.white),
                                      subtitle: Container(height: 10, width: 90, color: Colors.white),
                                    )
                                  ],
                                ),

                              );

                            });
                      }else{
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){

                              var countryName= snapshot.data![index]["country"].toString();
                              if(searchController.text.isEmpty){
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(
                                          name: snapshot.data![index]["country"].toString(),
                                          image: snapshot.data![index]["countryInfo"]["flag"].toString(),
                                          cases: snapshot.data![index]["cases"] ,
                                          active: snapshot.data![index]["active"] ,
                                          critical: snapshot.data![index]["critical"] ,
                                          deaths: snapshot.data![index]["deaths"] ,
                                          todayDeaths: snapshot.data![index]["todayDeaths"] ,
                                          recovered: snapshot.data![index]["recovered"] ,
                                          todayRecovered: snapshot.data![index]["todayRecovered"] ,
                                        )));
                                      },
                                      child: ListTile(

                                        leading: Image(
                                          height:70,
                                          width: 70,
                                          image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"].toString()),
                                        ),
                                        title: Text(snapshot.data![index]["country"].toString()),
                                        subtitle: Text(snapshot.data![index]["cases"].toString()),
                                      ),
                                    )
                                  ],
                                );
                              }else if(countryName.toLowerCase().contains(searchController.text.toLowerCase())){
                                return Column(
                                  children: [
                                    InkWell(
                                        onTap: ()
                                {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          DetailsScreen(
                                            name: snapshot
                                                .data![index]["country"]
                                                .toString(),
                                            image: snapshot
                                                .data![index]["countryInfo"]["flag"]
                                                .toString(),
                                            cases: snapshot
                                                .data![index]["cases"],
                                            active: snapshot
                                                .data![index]["active"],
                                            critical: snapshot
                                                .data![index]["critical"],
                                            deaths: snapshot
                                                .data![index]["deaths"],
                                            todayDeaths: snapshot
                                                .data![index]["todayDeaths"],
                                            recovered: snapshot
                                                .data![index]["recovered"],
                                            todayRecovered: snapshot
                                                .data![index]["todayRecovered"],
                                          )));
                                },
                                      child: ListTile(

                                        leading: Image(
                                          height:70,
                                          width: 70,
                                          image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"].toString()),
                                        ),
                                        title: Text(snapshot.data![index]["country"].toString()),
                                        subtitle: Text(snapshot.data![index]["cases"].toString()),
                                      ),
                                    )
                                  ],
                                );
                              }else{
                                return Container();

                              }

                              return Column(
                                children: [
                                  ListTile(

                                    leading: Image(
                                      height:70,
                                      width: 70,
                                      image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"].toString()),
                                    ),
                                    title: Text(snapshot.data![index]["country"].toString()),
                                    subtitle: Text(snapshot.data![index]["cases"].toString()),
                                  )
                                ],
                              );
                            });
                      }
                    },
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
