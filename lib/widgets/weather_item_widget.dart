import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/modal/weather_data.dart';

class WeatherItemWidget extends StatelessWidget {
  final WeatherData weather;

  const WeatherItemWidget({Key key, @required this.weather}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(weather.name, style: TextStyle(fontSize: 30)),
            Text(weather.main, style: TextStyle(fontSize: 32)),
            Text('${weather.temp.toString()}°F',
                style: TextStyle(fontSize: 15)),
            SizedBox(
              child: Image.network(
                "https://openweathermap.org/img/wn/${weather.icon}.png",
                width: 100.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            Text(DateFormat.yMMMd().format(weather.date)),
            Text(DateFormat.Hm().format(weather.date)),
          ],
        ),
      ),
    );
  }
}
