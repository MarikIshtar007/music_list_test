
import 'package:music_info/network/network_helper.dart';


void main() {
  void getting(){
    var data = NetworkHelper(url: 'https://musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7');
    print(data);
  }
  getting();
}
