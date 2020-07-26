import 'package:music_info/network/network_helper.dart';

const apiKey = '9bf554613f9147cdb57390429a8c809b';
const musicListURL = 'https://api.musixmatch.com/ws/1.1';

class MusicModel{

  Future<dynamic> getMusicList() async{
    NetworkHelper networkHelper = NetworkHelper(
      url: '$musicListURL/chart.tracks.get?apikey=$apiKey'
    );
    var musicList = await networkHelper.getData();
    return musicList;
  }

  Future<dynamic> getMusicInfo(String track_id) async{
    NetworkHelper networkHelper = NetworkHelper(
      url: '$musicListURL/track.get?track_id=$track_id&apikey=$apiKey'
    );
    var musicInfo = await networkHelper.getData();
    return musicInfo;
  }

  Future<dynamic> getLyrics(String track_id) async{
    NetworkHelper networkHelper = NetworkHelper(
      url: '$musicListURL/track.lyrics.get?track_id=$track_id&apikey=$apiKey'
    );
    var track_lyrics = await networkHelper.getData();
    return track_lyrics;
  }



}