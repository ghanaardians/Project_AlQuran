import 'package:flutter/material.dart';
import 'Quran_model.dart';
import 'package:proyekufx/Quran_data_source.dart';

import 'details.dart';

// class home extends StatelessWidget {
//   const home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.red,
//       appBar: AppBar(
//           backgroundColor: Colors.green,
//           centerTitle: true,
//           title: const Text("IQRA'")),
//       body: _homeState(),
//     );
//   }
// }

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // static const List<Widget> _widgetOptions = <Widget>[
  //   menu()
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: const Text("IQRA'")),
      body: MainPage(),
      // body: Center(
      //   child: _widgetOptions.elementAt(_selectedIndex),
      // ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: QuranDataSource.instance.loadQuran(),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            QuranModel quranModel = QuranModel.fromJson(snapshot.data);
            return _buildSuccessSection(quranModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(QuranModel quran) {
    return ListView.builder(
      itemCount: quran.data?.length,
      itemBuilder: (BuildContext context, int index) {
        final Quran? details = quran.data?[index];
        return Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            color: Colors.blue.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  //leading: Icon(Icons.arrow_drop_down_circle),
                  title: Text(
                    "${quran.data?[index].nama}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${quran.data?[index].asma}\nSurah ke ${quran.data?[index].nomor}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 35,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlueAccent,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(13.0)),
                            ),
                            child: const Text(
                              'Selengkapnya',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return DetailsPage(details: details);
                                }),
                              );
                            })
                        // onPressed: () {
                        //   // Navigator.push(
                        //   //   context,
                        //   //   MaterialPageRoute(builder: (context) {
                        //   //     return DetailsPage(details: details);
                        //   //   }),
                        // //   );
                        // }
                        ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
