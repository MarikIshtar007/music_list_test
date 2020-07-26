import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_info/bloc/track_info_bloc.dart';
import 'package:music_info/network/my_connectivity.dart';
import 'package:connectivity/connectivity.dart';

class TrackInfo extends StatefulWidget {
  final track_id;

  TrackInfo({this.track_id});

  @override
  _TrackInfoState createState() => _TrackInfoState();
}

class _TrackInfoState extends State<TrackInfo> {
  String track_id;
  TrackInfoBloc infoBloc = TrackInfoBloc();
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;


  void getId() async {
    track_id = widget.track_id;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((event) {
      setState(() {
        _source = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _connected;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        _connected = false;
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        _connected = true;
    }
    getId();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Track Details'),
          centerTitle: true,
        ),
        body: !_connected? Center(child: Text('Not Connected'))
            :SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 100,top: 10.0),
                child: FutureBuilder(
                  future: infoBloc.getDetails(track_id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if(snapshot.hasError){
                        return Center(
                          child: Text(
                            'Something Went Wrong',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      var data = snapshot.data;
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        width: 300,
                        child: Column(
                          children: <Widget>[
                            MyTile(
                              title: 'Name',
                              subtitle: data[0].track_name,
                            ),
                            MyTile(
                              title: 'Artist',
                              subtitle: data[0].artist_name,
                            ),
                            MyTile(
                              title: 'Album Name',
                              subtitle: data[0].album_name,
                            ),
                            MyTile(
                              title: 'Explicit',
                              subtitle:
                                  data[0].explicit == '0' ? 'False' : 'True',
                            ),
                            MyTile(
                              title: 'Rating',
                              subtitle: data[0].Rating,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                            margin: EdgeInsets.all(20.0),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),

              FutureBuilder(
                future: infoBloc.properLyrics(track_id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var final_lyrics = snapshot.data;
                    return Container(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Lyrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                            Text(
                              final_lyrics,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                          margin: EdgeInsets.all(20.0),
                        ),
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyTile extends StatelessWidget {
  final title;
  final subtitle;

  const MyTile({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
    );
  }
}
