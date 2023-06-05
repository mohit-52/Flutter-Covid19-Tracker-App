import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coivd19_tracker_app/Model/WorldStatesModel.dart';
import 'package:flutter_coivd19_tracker_app/Services/states_services.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'countries_list.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  // ANIMATION CONTROLLER
  late final AnimationController _controller =
  AnimationController(duration: const Duration(seconds: 3), vsync: this)
    ..repeat();

  // ANIMATION DISPOSE AND INITIALIZATION
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // PIE CHART COLORS
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                          child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,

                      ));
                    }else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap:  {
                              "Total": double.parse(snapshot!.data!.cases.toString()),
                              "Recovered": double.parse(snapshot!.data!.recovered.toString()),
                              "Deaths": double.parse(snapshot!.data!.deaths.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true
                            ),
                            animationDuration: const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            chartRadius: MediaQuery
                                .of(context)
                                .size
                                .width / 3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery
                                .of(context)
                                .size
                                .height * 0.06),
                            child: Card(
                              child: Column(
                                children:  [
                                  ReusableRow(title: "Total", value: snapshot.data!.cases.toString(),),
                                  ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString(),),
                                  ReusableRow(title: "Recovered", value:  snapshot.data!.recovered.toString(),),
                                  ReusableRow(title: "Active", value: snapshot.data!.active.toString(),),
                                  ReusableRow(title: "Critical", value: snapshot.data!.critical.toString(),),
                                  ReusableRow(title: "Today's Deaths", value: snapshot.data!.todayDeaths.toString(),),
                                  ReusableRow(title: "Today's Recovered", value:  snapshot.data!.todayRecovered.toString(),),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Center(child: Text("Track Countries"),),
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
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;

  const ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 10, right: 10,),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              Text(value,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider()
        ],
      ),
    );
  }
}

