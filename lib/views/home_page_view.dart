import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/modal/forecast_data.dart';
import 'package:weatherapp/modal/weather_data.dart';
import 'package:weatherapp/widgets/weather_item_widget.dart';
import 'package:weatherapp/widgets/weather_widget.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;
  static const apiKey = 'f8830cb87f0dd1f8ffb01c4ce9b8123f';
  Color color = Color.fromRGBO(204, 171, 216, 1);

  loadWeather() async {
    setState(() {
      isLoading = true;
    });
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
    } catch (e) {
      print(e);
    }

    if (position != null) {
      final lat = position.latitude;
      final lon = position.longitude;

      final weatherResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?lat=${lat.toString()}&lon=${lon.toString()}&appid=$apiKey');
      final forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast/?lat=${lat.toString()}&lon=${lon.toString()}&appid=$apiKey');

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData = WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData =
              ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: weatherData != null
                        ? WeatherWidget(weather: weatherData)
                        : Container(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: loadWeather,
                            color: Colors.white,
                            tooltip: 'Refresh',
                          ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  height: 200.0,
                  child: forecastData != null
                      ? ListView.builder(
                          itemCount: forecastData.list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => WeatherItemWidget(
                              weather: forecastData.list.elementAt(index)))
                      : Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
