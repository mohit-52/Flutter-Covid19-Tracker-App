import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              PieChart(
                dataMap: const {
                  "Total": 200,
                  "Recovered": 120,
                  "Deaths": 80,
                },
                animationDuration: const Duration(milliseconds: 1200),
                chartType: ChartType.ring,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                legendOptions: const LegendOptions(
                  legendPosition: LegendPosition.left
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                child: Card(
                  child: Column(
                    children: const [
                      ReusableRow(title: "Total",value: "200",),
                      ReusableRow(title: "Total",value: "200",),
                      ReusableRow(title: "Total",value: "200",),
                      ReusableRow(title: "Total",value: "200",),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                decoration:  BoxDecoration(
                  color: const Color(0xff1aa260),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(child: Text("Track Countries"),),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12,left: 10, right: 10, ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider()
        ],
      ),
    );
  }
}

