import 'package:music_info/network/music_network_access.dart';
import 'package:music_info/utility/music_tile_template.dart';
import 'package:music_info/utility/track_info_template.dart';

const apiKey = '';
const musicListURL = 'https://api.musixmatch.com/ws/1.1';

class TrackInfoBloc{

  Future<dynamic> getList() async{
    MusicModel model = MusicModel();
    var listData = await model.getMusicList();
    List<MusicTileTemplate> musicList = [];
    for (final item in listData['message']['body']['track_list']) {
      musicList.add(MusicTileTemplate(
          track_id: item['track']['track_id'].toString(),
          track_name: item['track']['track_name'],
          artist_name: item['track']['artist_name'],
          album_name: item['track']['album_name']));
    }
    return musicList;
  }

  Future<dynamic> getDetails(String track_id) async{
    MusicModel model = MusicModel();
    var data = await model.getMusicInfo(track_id);
    List<TrackInfoTemplate> details = [];
    details.add(
      TrackInfoTemplate(
        track_id : data['message']['body']['track']['track_id'].toString(),
        artist_name: data['message']['body']['track']['artist_name'],
        track_name : data['message']['body']['track']['track_name'],
        album_name: data['message']['body']['track']['album_name'],
        explicit: data['message']['body']['track']['explicit'].toString(),
        Rating: data['message']['body']['track']['track_rating'].toString()
      )
    );
    return details;
  }

  Future<dynamic> properLyrics(String track_id) async{
    MusicModel model = MusicModel();
    var lyrics_data = await model.getLyrics(track_id);
    var extracted_lyrics = lyrics_data['message']['body']['lyrics']['lyrics_body'];
    return extracted_lyrics;
  }

}
