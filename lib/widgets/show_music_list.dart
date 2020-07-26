import 'package:flutter/material.dart';
import 'package:music_info/ui/song_page.dart';
import 'package:music_info/bloc/track_info_bloc.dart';

class ShowMusicList extends StatefulWidget {
  @override
  _ShowMusicListState createState() => _ShowMusicListState();
}

class _ShowMusicListState extends State<ShowMusicList> {
  TrackInfoBloc infoBloc = TrackInfoBloc();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: infoBloc.getList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something Went Wrong',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          var data = snapshot.data;
          return ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            separatorBuilder: (context, index) => Divider(),
            padding: EdgeInsets.only(left: 10, right: 10),
            itemBuilder: (context, index) {
              final item = data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Center(
                    child: ListTile(
                      dense: true,
                      leading: Icon(Icons.library_music),
                      title: Text(
                    ' ${item.track_name}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: 65.0,
                          child: Text(
                        '${item.artist_name}',
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ),
                  ),
                      subtitle: Text('${item.album_name}'),
                      onTap: () async {
                      await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrackInfo(track_id: item.track_id);
                    }));
                  },
                )),
              );
            },
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
    );
  }
}
