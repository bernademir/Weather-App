import 'package:weatherapp/modal/weather_data.dart';

class ForecastData {
  final List list;

  ForecastData({this.list});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    final List list = [];

    for (dynamic e in json['list']) {
      WeatherData w = new WeatherData(
        date: new DateTime.fromMillisecondsSinceEpoch(
          json['dt'] * 100,
          isUtc: false,
        ),
        name: e['name'],
        temp: e['main']['temp'].toDouble(),
        main: e['weather'][0]['main'],
        icon: e['weather'][0]['icon'],
      );
      list.add(w);
    }
    return ForecastData(list: list);
  }
}
