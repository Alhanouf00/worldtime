import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime
{
  String location; // location name for UI
  String time; //the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDaytime; //true or false if daytime or not

  WorldTime({this.url, this.location, this.flag});

  Future<void> getTime() async{
    try {
      //make a request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties from data

      String datetime  = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //String offsetHours = offset.substring(1, 3); // 05
      //String offsetMinutes = offset.substring(4);
// create DateTime object
      DateTime now = DateTime.parse(datetime );
      now=now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime =  now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }

    catch(e)
    {
      print('Caught error : $e');
      time = 'could not get time data';

    }

  }
}