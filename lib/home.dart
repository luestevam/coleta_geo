import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? latitude;
  double? longitude;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localização de Madeira"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          latitude != null
              ? Text(
                  'Latitude: $latitude',
                  textAlign: TextAlign.center,
                )
              : Text('Latitude: ', textAlign: TextAlign.center),
          longitude != null
              ? Text(
                  'Longitude: $longitude',
                  textAlign: TextAlign.center,
                )
              : Text('Logitude: ', textAlign: TextAlign.center),
          address != null
              ? Text(
                  'Endereço: $address',
                  textAlign: TextAlign.center,
                )
              : Text('Endereço: ', textAlign: TextAlign.center),
          Center(
            child: TextButton(
              child: Text('Onde estou'),
              onPressed: () {
                pegarPosicao();
              },
            ),
          ),
        ],
      ),
    );
  }

  pegarPosicao() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
    List<Placemark> locais =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (locais != null) {
      setState(() {
        address = locais[0].toString();
      });
    }
  }
}
