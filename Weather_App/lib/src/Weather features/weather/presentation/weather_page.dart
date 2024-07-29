import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/Weather constants/app_colors.dart';
import 'package:open_weather_example_flutter/src/Weather features/weather/presentation/city_search_box.dart';
import 'package:open_weather_example_flutter/src/Weather features/weather/presentation/current_weather.dart';
import 'package:open_weather_example_flutter/src/Weather features/weather/presentation/hourly_weather.dart';
import 'package:open_weather_example_flutter/src/News Feature//News Page.dart'; // Import the news page

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key, required this.city});
  final String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.rainGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              CitySearchBox(),
              Spacer(),
              CurrentWeather(),
              Spacer(),
              HourlyWeather(),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsPage(), // Navigate to NewsPage
                    ),
                  );
                },
                child: Text('News'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
