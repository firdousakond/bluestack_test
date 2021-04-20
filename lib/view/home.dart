import 'dart:convert';

import 'package:bluesstack_app/data/GameData.dart';
import 'package:bluesstack_app/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../API.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tournaments> tournamentList = [];
  final int _defaultItemPerPageCount = 10;
  final int _nextPageThreshold = 5;
  bool _hasMore;
  String _cursor;
  bool _error;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _hasMore = true;
    _cursor = 'CmMKGQoMcmVnX2VuZF9kYXRlEgkIgLTH_rqS7AISQmoOc35nYW1lLXR2LXByb2RyMAsSClRvdXJuYW1lbnQiIDIxMDQ5NzU3N2UwOTRmMTU4MWExMDUzODEwMDE3NWYyDBgAIAE=';
    _error = false;
    _loading = true;
     fetchGameList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          "FlyingWolf",
          style: kNormalBlackTextStyle,
        ),
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/thanos.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Thanos',
                              style: kLargeBlackTextStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border:
                                      Border.all(color: Colors.blue, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '2250',
                                      style: kLargeBlueTextStyle,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Elo rating',
                                      style: kNormalGreyTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  //performance details
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.yellow[800],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            child: Column(
                              children: [
                                Text(
                                  '34',
                                  style: kBoldWhiteTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Tournaments Played',
                                  style: kNormalWhiteTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.purple,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '09',
                                  style: kBoldWhiteTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Tournaments Won',
                                  style: kNormalWhiteTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.orange[800],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Column(
                              children: [
                                Text(
                                  '26%',
                                  style: kBoldWhiteTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Winning Percentage',
                                  style: kNormalWhiteTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recommended for you',
                      style: kExtraLargeBoldTextStyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  //
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: gameListBody(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget gameListBody() {
    if (tournamentList.isEmpty) {
      if (_loading) {
        return Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
      } else if (_error) {
        return Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  _loading = true;
                  _error = false;
                  fetchGameList();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("Error while loading, tap to try again"),
              ),
            ));
      }
    } else {
      return ListView.builder(
          itemCount: tournamentList.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == tournamentList.length - _nextPageThreshold) {
              fetchGameList();
            }
            if (index == tournamentList.length) {
              if (_error) {
                return Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _loading = true;
                          _error = false;
                          fetchGameList();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("Error while loading, tap to try agin"),
                      ),
                    ));
              } else {
                return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ));
              }
            }
            final Tournaments tournaments = tournamentList[index];
                return Card(
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Image.network(
                                tournaments.coverUrl,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.fitWidth,),

                            ListTile(
                              title: Text(
                                tournaments.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                  tournaments.gameName),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      )),
                );
          });
    }
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchGameList() {
    API
        .getGameList(context,
        _cursor)
        .then((value) async {
      try {
        setState(() {
          _hasMore = value.tournaments.length == _defaultItemPerPageCount;
          _loading = false;
          tournamentList.addAll(value.tournaments);
          _cursor = value.cursor;
        });
      }
      catch(Ex){
        _error = true;
        _loading = false;
      }
    });
  }
}
