import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  String cityNameAndCountry ="";

  Widget wet = CircularProgressIndicator();
  Widget weatherIcon = CircularProgressIndicator();

  load() async{
    Weather w = await wf.currentWeatherByCityName('Trzebinia');
    setState(() {
      wet=Text(w.weatherDescription);
      cityNameAndCountry=w.areaName+", "+w.country;
      var ico = w.weatherIcon;
      weatherIcon = Image.network('http://openweathermap.org/img/wn/$ico@2x.png');
    });
  }

  Widget todayWeatherCard(var temperature, var areaName, var country, var weatherIcon, ){

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
                  wet = CircularProgressIndicator();
                  load();
                });
              }),
          IconButton(
              icon: Icon(Icons.menu),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0, vertical:20.0),
                        child: Column(
                          children: <Widget>[
                            weatherIcon,
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text(
                                "temp",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: wet,
                            )
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
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
