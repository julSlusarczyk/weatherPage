import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Pogoda'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherFactory wf = new WeatherFactory("12b6e28582eb9298577c734a31ba9f4f", language: Language.POLISH);
  @override
  void initState() {
    super.initState();
    load();
  }
  //TODO Checking if there is internet connection
  String cityNameAndCountry ="";
  Widget weatherCard = CircularProgressIndicator();

  load() async{
    Weather w = await wf.currentWeatherByCityName('Trzebinia'); //TODO Store City Name in SharedPreferences
    setState(() {
      cityNameAndCountry = "${w.areaName}, ${w.country}";
      weatherCard = cart(w.weatherIcon, w.temperature.celsius.round().toString(), w.weatherDescription);
    });
  }

  Widget cart(var icon, var temp, var desc) {
    var ico = Image.network('http://openweathermap.org/img/wn/$icon@2x.png');
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0, vertical:20.0),
        child: Column(
          children: <Widget>[
            ico,
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(temp + "°C"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(desc),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.amber[100],
        shadowColor: Colors.amber[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){},
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){
                setState(() {
                  weatherCard = CircularProgressIndicator();
                  load();
                });
              }),
          IconButton(
              icon: Icon(Icons.menu), //TODO Menu with changing city name and change kelvin/celsius/fahrenheit
              onPressed: (){})
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(cityNameAndCountry),
              alignment: Alignment.centerLeft,
            ),
            weatherCard,
            Spacer(),
            Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: FlatButton(
                        onPressed: (){},
                        child: Text(
                          "Dziś",
                          style: GoogleFonts.yanoneKaffeesatz(
                              textStyle: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 2
                              )
                          ),
                        ),
                      ),
                    )
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: FlatButton(
                        onPressed: (){},
                        child: Text(
                          "Tydzień",
                          style: GoogleFonts.yanoneKaffeesatz(
                              textStyle: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 2
                              )
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
