import 'package:flutter/material.dart';
import 'package:flutter_coivd19_tracker_app/Services/states_services.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Search with country name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: statesServices.countriesListApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                              children: [
                              ListTile(
                              leading: Container(height: 50, width:50, color: Colors.white,),
                              title: Container(height: 10, width:89, color: Colors.white,),
                              subtitle: Container(height: 10, width:89, color: Colors.white,),
                              )
                              ],
                              )
                              );

                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];

                              if(searchController.text.isEmpty){
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot!.data![index]
                                        ['countryInfo']['flag']),
                                      ),
                                      title: Text(snapshot!.data![index]
                                      ['country']
                                          .toString()),
                                      subtitle: Text(snapshot!.data![index]
                                      ['cases']
                                          .toString()),
                                    )
                                  ],
                                );
                              }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot!.data![index]
                                        ['countryInfo']['flag']),
                                      ),
                                      title: Text(snapshot!.data![index]
                                      ['country']
                                          .toString()),
                                      subtitle: Text(snapshot!.data![index]
                                      ['cases']
                                          .toString()),
                                    )
                                  ],
                                );
                              }else{
                                return Container();
                              }

                            });
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
