import 'package:flutter/material.dart';
import 'package:music_info/network/my_connectivity.dart';
import 'package:connectivity/connectivity.dart';
import 'package:music_info/widgets/show_music_list.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('The Music List'),
      ),
      body: _connected
          ? Center(
        child: ShowMusicList(),
            ) : Center(child: Text('Not Connected')),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Color(0xFFD4AF37),
//        foregroundColor: Colors.white,
//        child: Icon(Icons.bookmark),//ffd700
//      ),
    );
  }
}
