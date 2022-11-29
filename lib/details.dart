import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:proyekufx/Quran_model.dart';
import 'package:proyekufx/Quran_data_source.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:typed_data';

class DetailsPage extends StatefulWidget {
  final Quran? details;

  const DetailsPage({Key? key, required this.details}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;
  // int maxduration = 100;
  // int currentpos = 0;
  // String currentpostlabel = "00:00";
  // String audioasset = "assets/audio/red-indian-music.mp3";
  bool isplaying = false;
  bool audioplayed = false;
  late Uint8List audiobytes;

  AudioPlayer player = AudioPlayer();

  // void initState() {
  //   Future.delayed(Duration.zero, () async {
  //     // ByteData bytes =
  //     //     await rootBundle.load(audioasset); //load audio from assets
  //     // audiobytes =
  //     //     bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  //     //convert ByteData to Uint8List
  //
  //     // player.onDurationChanged.listen((Duration d) {
  //     //   //get the duration of audio
  //     //   maxduration = d.inMilliseconds;
  //     //   setState(() {});
  //     // });
  //     //
  //     // player.onAudioPositionChanged.listen((Duration p) {
  //     //   currentpos =
  //     //       p.inMilliseconds; //get the current position of playing audio
  //     //
  //     //   //generating the duration label
  //     //   int shours = Duration(milliseconds: currentpos).inHours;
  //     //   int sminutes = Duration(milliseconds: currentpos).inMinutes;
  //     //   int sseconds = Duration(milliseconds: currentpos).inSeconds;
  //     //
  //     //   int rhours = shours;
  //     //   int rminutes = sminutes - (shours * 60);
  //     //   int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);
  //     //
  //     //   currentpostlabel = "$rhours:$rminutes:$rseconds";
  //     //
  //     //   setState(() {
  //     //     //refresh the UI
  //     //   });
  //     // });
  //   });
  //   super.initState();
  // }

  // double rating = 4.1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (isFavorite) ? Colors.green.shade100 : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text("${widget.details!.nama}"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              FutureBuilder(
                future: QuranDataSource.instance.loadQuran(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    // debugPrint(snapshot.data);
                    return _buildErrorSection();
                  }
                  if (snapshot.hasData) {
                    QuranModel quranModel = QuranModel.fromJson(snapshot.data);
                    return _buildSuccessSection(quranModel);
                  }
                  return _buildLoadingSection();
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildSuccessSection(QuranModel quran) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  child: Column(
                    children: [
                      Text(
                        "${widget.details!.arti}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "\nArab : ${widget.details!.asma}\n\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Surat ke\n${widget.details!.nomor}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Kategori\n${widget.details!.type}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Jumlah Ayat\n${widget.details!.ayat}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\n${widget.details!.keterangan}\n",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Audio Surah ${widget.details!.nama}\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  child: Wrap(
                    spacing: 10,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (!isplaying && !audioplayed) {
                            int result =
                                await player.play("${widget.details!.audio}");
                            if (result == 1) {
                              //play success
                              setState(() {
                                isplaying = true;
                                audioplayed = true;
                              });
                            } else {
                              print("Error while playing audio.");
                            }
                          } else if (audioplayed && !isplaying) {
                            int result = await player.resume();
                            if (result == 1) {
                              //resume success
                              setState(() {
                                isplaying = true;
                                audioplayed = true;
                              });
                            } else {
                              print("Error on resume audio.");
                            }
                          } else {
                            int result = await player.pause();
                            if (result == 1) {
                              //pause success
                              setState(() {
                                isplaying = false;
                              });
                            } else {
                              print("Error on pause audio.");
                            }
                          }
                        },
                        icon: Icon(isplaying ? Icons.pause : Icons.play_arrow),
                        label: Text(isplaying ? "Pause" : "Play"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.lightBlueAccent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90.0),
                            // side: BorderSide(color: Colors.red)
                          )),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(20)),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          int result = await player.stop();
                          if (result == 1) {
                            //stop success
                            setState(() {
                              isplaying = false;
                              audioplayed = false;
                              // currentpos = 0;
                            });
                          } else {
                            print("Error on stop audio.");
                          }
                        },
                        icon: Icon(Icons.stop),
                        label: Text("Stop"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90.0),
                            // side: BorderSide(color: Colors.red)
                          )),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

// void _launchURL(_url) async {
//   if (!await launch(_url)) throw 'Could not launch $_url';
// }
}
