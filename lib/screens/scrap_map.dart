import 'package:flutter/material.dart'; 
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

void buildSidebar(BuildContext context, int markerId) {
  markerId -= 1;
  final name = markerData[markerId][0];
  final adr = markerData[markerId][1];
  final openmonth = markerData[markerId][3];
  final openday = markerData[markerId][4];
  final notes = markerData[markerId][5];
  final website = markerData[markerId][6];
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 800,
        width: double.infinity,
        
        child: Column(
          children: <Widget>[
            Text(
              "\n $name",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromRGBO(73,17,129,1)),
            ),
            Text(
              adr,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Color.fromARGB(255, 126, 126, 126)),
            ),
            const Padding(
              padding: EdgeInsets.all(0), //apply padding to all four sides
              child:
              Text(
                "..............................................",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color.fromRGBO(73,17,129,1)),
              ),
            ),
            const Text(
              "OPEN",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color.fromRGBO(73,17,129,1)),
            ),
            Padding(
              padding: const EdgeInsets.all(0), //apply padding to all four sides
              child:
              Text(
                "$openmonth -- $openday",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(0), //apply padding to all four sides
              child:
              Text(
                "..............................................",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color.fromRGBO(73,17,129,1)),
              ),
            ),
            const Text(
              "NOTES",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color.fromRGBO(73,17,129,1)),
            ),
            Padding(
              padding: const EdgeInsets.all(0), //apply padding to all four sides
              child:
              Text(
                notes,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(0), //apply padding to all four sides
              child:
              Text(
                "..............................................",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color.fromRGBO(73,17,129,1)),
              ),
            ),
            const Text(
              "WEBSITE",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color.fromRGBO(73,17,129,1)),
            ),
            Padding(
              padding: const EdgeInsets.all(0), //apply padding to all four sides
              child:
              Text(
                website,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            
          ],
        ),
      );
    },
  );
}


class ScrapMapPage extends StatefulWidget {
  const ScrapMapPage({super.key});
  @override
  State<ScrapMapPage> createState() => _ScrapMapPageState();
}
class _ScrapMapPageState extends State<ScrapMapPage> {
  late String _mapStyle;
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('lib/assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(40.7128, -74.0060);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorSchemeSeed: const Color.fromRGBO(73,17,129,1),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Food Scrap Drop-off Locations'),
          elevation: 15,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          zoomGesturesEnabled: true, //enable Zoom in, out on map
          minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 12.0,
          ),
          markers: <Marker>{
            Marker(
              markerId: const MarkerId("1"),
              position: const LatLng(40.753687, -73.886999),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 1);
              }
            ), 
            Marker(
              markerId: const MarkerId("2"),
              position: const LatLng(40.6840598, -73.9050492),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 2);
              }
            ), 
            Marker(
              markerId: const MarkerId("3"),
              position: const LatLng(40.6727118, -73.984731),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 3);
              }
            ), 
            Marker(
              markerId: const MarkerId("4"),
              position: const LatLng(40.670745, -73.957743),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 4);
              }
            ), 
            Marker(
              markerId: const MarkerId("5"),
              position: const LatLng(40.8172313, -73.9408451),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 5);
              }
            ), 
            Marker(
              markerId: const MarkerId("6"),
              position: const LatLng(40.823692, -73.943764),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 6);
              }
            ), 
            Marker(
              markerId: const MarkerId("7"),
              position: const LatLng(40.746199, -73.919118),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 7);
              }
            ), 
            Marker(
              markerId: const MarkerId("8"),
              position: const LatLng(40.7280614, -73.9792926),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 8);
              }
            ), 
            Marker(
              markerId: const MarkerId("9"),
              position: const LatLng(40.82371538, -73.88005123),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 9);
              }
            ), 
            Marker(
              markerId: const MarkerId("10"),
              position: const LatLng(40.69391737, -73.92580301),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 10);
              }
            ), 
            Marker(
              markerId: const MarkerId("11"),
              position: const LatLng(40.724493, -73.94375),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 11);
              }
            ), 
            Marker(
              markerId: const MarkerId("12"),
              position: const LatLng(40.68419729, -73.93525746),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 12);
              }
            ), 
            Marker(
              markerId: const MarkerId("13"),
              position: const LatLng(40.641438, -73.966333),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 13);
              }
            ), 
            Marker(
              markerId: const MarkerId("14"),
              position: const LatLng(40.70559, -74.00812),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 14);
              }
            ), 
            Marker(
              markerId: const MarkerId("15"),
              position: const LatLng(40.81994461, -73.92850801),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 15);
              }
            ), 
            Marker(
              markerId: const MarkerId("16"),
              position: const LatLng(40.6749729, -73.8066806),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 16);
              }
            ), 
            Marker(
              markerId: const MarkerId("17"),
              position: const LatLng(40.68758323, -73.90656117),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 17);
              }
            ), 
            Marker(
              markerId: const MarkerId("18"),
              position: const LatLng(40.752606, -73.969036),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 18);
              }
            ), 
            Marker(
              markerId: const MarkerId("19"),
              position: const LatLng(40.67428152, -73.94742765),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 19);
              }
            ), 
            Marker(
              markerId: const MarkerId("20"),
              position: const LatLng(40.76668263, -73.92875042),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 20);
              }
            ), 
            Marker(
              markerId: const MarkerId("21"),
              position: const LatLng(40.6979632, -73.91719682),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 21);
              }
            ), 
            Marker(
              markerId: const MarkerId("22"),
              position: const LatLng(40.85489479, -73.90380453),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 22);
              }
            ), 
            Marker(
              markerId: const MarkerId("23"),
              position: const LatLng(40.8215402, -73.9155499),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 23);
              }
            ), 
            Marker(
              markerId: const MarkerId("24"),
              position: const LatLng(40.6200069, -73.9894524),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 24);
              }
            ), 
            Marker(
              markerId: const MarkerId("25"),
              position: const LatLng(40.575904, -74.09677),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 25);
              }
            ), 
            Marker(
              markerId: const MarkerId("26"),
              position: const LatLng(40.82979403, -73.94453757),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 26);
              }
            ), 
            Marker(
              markerId: const MarkerId("27"),
              position: const LatLng(40.71645, -73.85778),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 27);
              }
            ), 
            Marker(
              markerId: const MarkerId("28"),
              position: const LatLng(40.632583, -73.948111),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 28);
              }
            ), 
            Marker(
              markerId: const MarkerId("29"),
              position: const LatLng(40.6721089, -73.92796252),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 29);
              }
            ), 
            Marker(
              markerId: const MarkerId("30"),
              position: const LatLng(40.81308249, -73.93777002),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 30);
              }
            ), 
            Marker(
              markerId: const MarkerId("31"),
              position: const LatLng(40.6726299, -74.0103773),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 31);
              }
            ), 
            Marker(
              markerId: const MarkerId("32"),
              position: const LatLng(40.85345387, -73.88198409),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 32);
              }
            ), 
            Marker(
              markerId: const MarkerId("33"),
              position: const LatLng(40.62262016, -74.14456081),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 33);
              }
            ), 
            Marker(
              markerId: const MarkerId("34"),
              position: const LatLng(40.67617742, -73.96627855),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 34);
              }
            ), 
            Marker(
              markerId: const MarkerId("35"),
              position: const LatLng(40.67112072, -73.93931296),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 35);
              }
            ), 
            Marker(
              markerId: const MarkerId("36"),
              position: const LatLng(40.707626, -73.836079),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 36);
              }
            ), 
            Marker(
              markerId: const MarkerId("37"),
              position: const LatLng(40.877299, -73.900709),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 37);
              }
            ), 
            Marker(
              markerId: const MarkerId("38"),
              position: const LatLng(40.7077, -74.00679),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 38);
              }
            ), 
            Marker(
              markerId: const MarkerId("39"),
              position: const LatLng(40.6903182, -73.93640511),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 39);
              }
            ), 
            Marker(
              markerId: const MarkerId("40"),
              position: const LatLng(40.87527262, -73.87554143),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 40);
              }
            ), 
            Marker(
              markerId: const MarkerId("41"),
              position: const LatLng(40.768389, -73.937),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 41);
              }
            ), 
            Marker(
              markerId: const MarkerId("42"),
              position: const LatLng(40.67081709, -73.9532923),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 42);
              }
            ), 
            Marker(
              markerId: const MarkerId("43"),
              position: const LatLng(40.76267874, -73.92014229),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 43);
              }
            ), 
            Marker(
              markerId: const MarkerId("44"),
              position: const LatLng(40.7003, -73.906675),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 44);
              }
            ), 
            Marker(
              markerId: const MarkerId("45"),
              position: const LatLng(40.76113, -73.99292),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 45);
              }
            ), 
            Marker(
              markerId: const MarkerId("46"),
              position: const LatLng(40.641967, -74.077928),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 46);
              }
            ), 
            Marker(
              markerId: const MarkerId("47"),
              position: const LatLng(40.80014, -73.94232),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 47);
              }
            ), 
            Marker(
              markerId: const MarkerId("48"),
              position: const LatLng(40.8121979, -73.95354006),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 48);
              }
            ), 
            Marker(
              markerId: const MarkerId("49"),
              position: const LatLng(40.69040998, -73.94542437),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 49);
              }
            ), 
            Marker(
              markerId: const MarkerId("50"),
              position: const LatLng(40.80582122, -73.94698139),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 50);
              }
            ), 
            Marker(
              markerId: const MarkerId("51"),
              position: const LatLng(40.75159, -73.82981),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 51);
              }
            ), 
            Marker(
              markerId: const MarkerId("52"),
              position: const LatLng(40.639901, -74.0902865),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 52);
              }
            ), 
            Marker(
              markerId: const MarkerId("53"),
              position: const LatLng(40.85571567, -73.92743781),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 53);
              }
            ), 
            Marker(
              markerId: const MarkerId("54"),
              position: const LatLng(40.67155276, -73.93360522),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 54);
              }
            ), 
            Marker(
              markerId: const MarkerId("55"),
              position: const LatLng(40.5761925, -73.9684342),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 55);
              }
            ), 
            Marker(
              markerId: const MarkerId("56"),
              position: const LatLng(40.61258951, -74.06930957),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 56);
              }
            ), 
            Marker(
              markerId: const MarkerId("57"),
              position: const LatLng(40.76236315, -73.91936067),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 57);
              }
            ), 
            Marker(
              markerId: const MarkerId("58"),
              position: const LatLng(40.70137351, -73.91136554),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 58);
              }
            ), 
            Marker(
              markerId: const MarkerId("59"),
              position: const LatLng(40.84382558, -73.78518753),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 59);
              }
            ), 
            Marker(
              markerId: const MarkerId("60"),
              position: const LatLng(40.68815347, -73.92714042),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 60);
              }
            ), 
            Marker(
              markerId: const MarkerId("61"),
              position: const LatLng(40.6547305, -74.0018481),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 61);
              }
            ), 
            Marker(
              markerId: const MarkerId("62"),
              position: const LatLng(40.762667, -73.915111),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 62);
              }
            ), 
            Marker(
              markerId: const MarkerId("63"),
              position: const LatLng(40.7895156, -73.9716111),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 63);
              }
            ), 
            Marker(
              markerId: const MarkerId("64"),
              position: const LatLng(40.7568246, -73.9443652),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 64);
              }
            ), 
            Marker(
              markerId: const MarkerId("65"),
              position: const LatLng(40.75914, -73.92146),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 65);
              }
            ), 
            Marker(
              markerId: const MarkerId("66"),
              position: const LatLng(40.63034, -74.11616),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 66);
              }
            ), 
            Marker(
              markerId: const MarkerId("67"),
              position: const LatLng(40.7489842, -74.0071142),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 67);
              }
            ), 
            Marker(
              markerId: const MarkerId("68"),
              position: const LatLng(40.6516768, -73.9059912),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 68);
              }
            ), 
            Marker(
              markerId: const MarkerId("69"),
              position: const LatLng(40.79133768, -73.94494258),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 69);
              }
            ), 
            Marker(
              markerId: const MarkerId("70"),
              position: const LatLng(40.745331, -73.998272),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 70);
              }
            ), 
            Marker(
              markerId: const MarkerId("71"),
              position: const LatLng(40.68175218, -73.94362126),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 71);
              }
            ), 
            Marker(
              markerId: const MarkerId("72"),
              position: const LatLng(40.87989884, -73.87587871),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 72);
              }
            ), 
            Marker(
              markerId: const MarkerId("73"),
              position: const LatLng(40.785792, -73.950833),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 73);
              }
            ), 
            Marker(
              markerId: const MarkerId("74"),
              position: const LatLng(40.82739892, -73.91744524),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 74);
              }
            ), 
            Marker(
              markerId: const MarkerId("75"),
              position: const LatLng(40.79758808, -73.93138837),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 75);
              }
            ), 
            Marker(
              markerId: const MarkerId("76"),
              position: const LatLng(40.823225, -73.95617),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 76);
              }
            ), 
            Marker(
              markerId: const MarkerId("77"),
              position: const LatLng(40.636583, -74.000556),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 77);
              }
            ), 
            Marker(
              markerId: const MarkerId("78"),
              position: const LatLng(40.68219458, -73.95365641),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 78);
              }
            ), 
            Marker(
              markerId: const MarkerId("79"),
              position: const LatLng(40.70206804, -73.92383762),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 79);
              }
            ), 
            Marker(
              markerId: const MarkerId("80"),
              position: const LatLng(40.850947, -73.938068),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 80);
              }
            ), 
            Marker(
              markerId: const MarkerId("81"),
              position: const LatLng(40.748406, -73.721002),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 81);
              }
            ), 
            Marker(
              markerId: const MarkerId("82"),
              position: const LatLng(40.8591294, -73.90127487),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 82);
              }
            ), 
            Marker(
              markerId: const MarkerId("83"),
              position: const LatLng(40.712653, -74.007723),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 83);
              }
            ), 
            Marker(
              markerId: const MarkerId("84"),
              position: const LatLng(40.76524333, -73.92510952),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 84);
              }
            ), 
            Marker(
              markerId: const MarkerId("85"),
              position: const LatLng(40.76298114, -73.92041435),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 85);
              }
            ), 
            Marker(
              markerId: const MarkerId("86"),
              position: const LatLng(40.82625676, -73.93855724),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 86);
              }
            ), 
            Marker(
              markerId: const MarkerId("87"),
              position: const LatLng(40.69555546, -73.94638695),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 87);
              }
            ), 
            Marker(
              markerId: const MarkerId("88"),
              position: const LatLng(40.67741, -73.972226),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 88);
              }
            ), 
            Marker(
              markerId: const MarkerId("89"),
              position: const LatLng(40.8460035, -73.8987432),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 89);
              }
            ), 
            Marker(
              markerId: const MarkerId("90"),
              position: const LatLng(40.749728, -73.862513),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 90);
              }
            ), 
            Marker(
              markerId: const MarkerId("91"),
              position: const LatLng(40.69955, -73.93066),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 91);
              }
            ), 
            Marker(
              markerId: const MarkerId("92"),
              position: const LatLng(40.671653, -73.889806),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 92);
              }
            ), 
            Marker(
              markerId: const MarkerId("93"),
              position: const LatLng(40.721268, -73.846877),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 93);
              }
            ), 
            Marker(
              markerId: const MarkerId("94"),
              position: const LatLng(40.7296982, -73.9601997),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 94);
              }
            ), 
            Marker(
              markerId: const MarkerId("95"),
              position: const LatLng(40.69293663, -73.90797403),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 95);
              }
            ), 
            Marker(
              markerId: const MarkerId("96"),
              position: const LatLng(40.745061, -73.973126),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 96);
              }
            ), 
            Marker(
              markerId: const MarkerId("97"),
              position: const LatLng(40.85886086, -73.91091943),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 97);
              }
            ), 
            Marker(
              markerId: const MarkerId("98"),
              position: const LatLng(40.67487312, -73.96038702),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 98);
              }
            ), 
            Marker(
              markerId: const MarkerId("99"),
              position: const LatLng(40.7915258, -73.938805),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 99);
              }
            ), 
            Marker(
              markerId: const MarkerId("100"),
              position: const LatLng(40.7640828, -73.8695398),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 100);
              }
            ), 
            Marker(
              markerId: const MarkerId("101"),
              position: const LatLng(40.738228, -74.0104549),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 101);
              }
            ), 
            Marker(
              markerId: const MarkerId("102"),
              position: const LatLng(40.85034468, -73.9153102),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 102);
              }
            ), 
            Marker(
              markerId: const MarkerId("103"),
              position: const LatLng(40.796764, -73.931341),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 103);
              }
            ), 
            Marker(
              markerId: const MarkerId("104"),
              position: const LatLng(40.83769228, -73.8663211),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 104);
              }
            ), 
            Marker(
              markerId: const MarkerId("105"),
              position: const LatLng(40.67358758, -73.96311119),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 105);
              }
            ), 
            Marker(
              markerId: const MarkerId("106"),
              position: const LatLng(40.688793, -73.904826),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 106);
              }
            ), 
            Marker(
              markerId: const MarkerId("107"),
              position: const LatLng(40.82885132, -73.85682028),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 107);
              }
            ), 
            Marker(
              markerId: const MarkerId("108"),
              position: const LatLng(40.67676683, -73.94710109),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 108);
              }
            ), 
            Marker(
              markerId: const MarkerId("109"),
              position: const LatLng(40.69725935, -73.91542856),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 109);
              }
            ), 
            Marker(
              markerId: const MarkerId("110"),
              position: const LatLng(40.6648161, -73.8975189),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 110);
              }
            ), 
            Marker(
              markerId: const MarkerId("111"),
              position: const LatLng(40.6595266, -73.90591),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 111);
              }
            ), 
            Marker(
              markerId: const MarkerId("112"),
              position: const LatLng(40.6400446, -73.9482956),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 112);
              }
            ), 
            Marker(
              markerId: const MarkerId("113"),
              position: const LatLng(40.83816928, -73.93815592),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 113);
              }
            ), 
            Marker(
              markerId: const MarkerId("114"),
              position: const LatLng(40.68871201, -73.95497169),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 114);
              }
            ), 
            Marker(
              markerId: const MarkerId("115"),
              position: const LatLng(40.7432328, -73.9431336),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 115);
              }
            ), 
            Marker(
              markerId: const MarkerId("116"),
              position: const LatLng(40.70585648, -73.91865954),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 116);
              }
            ), 
            Marker(
              markerId: const MarkerId("117"),
              position: const LatLng(40.8611153, -73.8900366),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 117);
              }
            ), 
            Marker(
              markerId: const MarkerId("118"),
              position: const LatLng(40.60221, -73.9938325),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 118);
              }
            ), 
            Marker(
              markerId: const MarkerId("119"),
              position: const LatLng(40.7948329, -73.93320322),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 119);
              }
            ), 
            Marker(
              markerId: const MarkerId("120"),
              position: const LatLng(40.840005, -73.916636),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 120);
              }
            ), 
            Marker(
              markerId: const MarkerId("121"),
              position: const LatLng(40.824235, -73.94983),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 121);
              }
            ), 
            Marker(
              markerId: const MarkerId("122"),
              position: const LatLng(40.592723, -74.135113),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 122);
              }
            ), 
            Marker(
              markerId: const MarkerId("123"),
              position: const LatLng(40.649778, -73.963194),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 123);
              }
            ), 
            Marker(
              markerId: const MarkerId("124"),
              position: const LatLng(40.75785671, -73.85770325),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 124);
              }
            ), 
            Marker(
              markerId: const MarkerId("125"),
              position: const LatLng(40.67029476, -73.92811507),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 125);
              }
            ), 
            Marker(
              markerId: const MarkerId("126"),
              position: const LatLng(40.69656438, -73.91427923),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 126);
              }
            ), 
            Marker(
              markerId: const MarkerId("127"),
              position: const LatLng(40.81773208, -73.94737802),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 127);
              }
            ), 
            Marker(
              markerId: const MarkerId("128"),
              position: const LatLng(40.68596, -73.99701),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 128);
              }
            ), 
            Marker(
              markerId: const MarkerId("129"),
              position: const LatLng(40.6932882, -73.90436713),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 129);
              }
            ), 
            Marker(
              markerId: const MarkerId("130"),
              position: const LatLng(40.67303171, -73.94181043),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 130);
              }
            ), 
            Marker(
              markerId: const MarkerId("131"),
              position: const LatLng(40.8575626, -73.909437),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 131);
              }
            ), 
            Marker(
              markerId: const MarkerId("132"),
              position: const LatLng(40.725995, -73.983207),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 132);
              }
            ), 
            Marker(
              markerId: const MarkerId("133"),
              position: const LatLng(40.69660505, -73.93099308),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 133);
              }
            ), 
            Marker(
              markerId: const MarkerId("134"),
              position: const LatLng(40.68065837, -73.93454969),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 134);
              }
            ), 
            Marker(
              markerId: const MarkerId("135"),
              position: const LatLng(40.8149687, -73.9560903),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 135);
              }
            ), 
            Marker(
              markerId: const MarkerId("136"),
              position: const LatLng(40.8553832, -73.9380217),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 136);
              }
            ), 
            Marker(
              markerId: const MarkerId("137"),
              position: const LatLng(40.714448, -73.968049),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 137);
              }
            ), 
            Marker(
              markerId: const MarkerId("138"),
              position: const LatLng(40.595012, -73.7765544),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 138);
              }
            ), 
            Marker(
              markerId: const MarkerId("139"),
              position: const LatLng(40.52797, -74.216605),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 139);
              }
            ), 
            Marker(
              markerId: const MarkerId("140"),
              position: const LatLng(40.76833214, -73.92911855),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 140);
              }
            ), 
            Marker(
              markerId: const MarkerId("141"),
              position: const LatLng(40.67623, -73.93295),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 141);
              }
            ), 
            Marker(
              markerId: const MarkerId("142"),
              position: const LatLng(40.80473262, -73.96234996),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 142);
              }
            ), 
            Marker(
              markerId: const MarkerId("143"),
              position: const LatLng(40.74387, -73.9562),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 143);
              }
            ), 
            Marker(
              markerId: const MarkerId("144"),
              position: const LatLng(40.75440298, -73.90911363),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 144);
              }
            ), 
            Marker(
              markerId: const MarkerId("145"),
              position: const LatLng(40.67459378, -73.95274546),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 145);
              }
            ), 
            Marker(
              markerId: const MarkerId("146"),
              position: const LatLng(40.6785, -73.912),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 146);
              }
            ), 
            Marker(
              markerId: const MarkerId("147"),
              position: const LatLng(40.817685, -73.924225),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 147);
              }
            ), 
            Marker(
              markerId: const MarkerId("148"),
              position: const LatLng(40.6413779, -74.08640362),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 148);
              }
            ), 
            Marker(
              markerId: const MarkerId("149"),
              position: const LatLng(40.81859325, -73.86818949),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 149);
              }
            ), 
            Marker(
              markerId: const MarkerId("150"),
              position: const LatLng(40.77405482, -73.93176388),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 150);
              }
            ), 
            Marker(
              markerId: const MarkerId("151"),
              position: const LatLng(40.69056, -73.80395),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 151);
              }
            ), 
            Marker(
              markerId: const MarkerId("152"),
              position: const LatLng(40.6870313, -73.91374111),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 152);
              }
            ), 
            Marker(
              markerId: const MarkerId("153"),
              position: const LatLng(40.7183877, -74.0148782),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 153);
              }
            ), 
            Marker(
              markerId: const MarkerId("154"),
              position: const LatLng(40.82135, -73.92506),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 154);
              }
            ), 
            Marker(
              markerId: const MarkerId("155"),
              position: const LatLng(40.73833, -73.87775),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 155);
              }
            ), 
            Marker(
              markerId: const MarkerId("156"),
              position: const LatLng(40.756149, -73.907915),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 156);
              }
            ), 
            Marker(
              markerId: const MarkerId("157"),
              position: const LatLng(40.712164, -73.980547),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 157);
              }
            ), 
            Marker(
              markerId: const MarkerId("158"),
              position: const LatLng(40.750278, -73.89678),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 158);
              }
            ), 
            Marker(
              markerId: const MarkerId("159"),
              position: const LatLng(40.8050784, -73.95281788),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 159);
              }
            ), 
            Marker(
              markerId: const MarkerId("160"),
              position: const LatLng(40.68415382, -73.90844576),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 160);
              }
            ), 
            Marker(
              markerId: const MarkerId("161"),
              position: const LatLng(40.68085262, -73.91968254),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 161);
              }
            ), 
            Marker(
              markerId: const MarkerId("162"),
              position: const LatLng(40.7256282, -74.003866),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 162);
              }
            ), 
            Marker(
              markerId: const MarkerId("163"),
              position: const LatLng(40.62988, -74.010582),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 163);
              }
            ), 
            Marker(
              markerId: const MarkerId("164"),
              position: const LatLng(40.68277198, -73.94101046),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 164);
              }
            ), 
            Marker(
              markerId: const MarkerId("165"),
              position: const LatLng(40.7889577, -73.9492012),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 165);
              }
            ), 
            Marker(
              markerId: const MarkerId("166"),
              position: const LatLng(40.83726017, -73.9136583),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 166);
              }
            ), 
            Marker(
              markerId: const MarkerId("167"),
              position: const LatLng(40.6799083, -73.95316858),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 167);
              }
            ), 
            Marker(
              markerId: const MarkerId("168"),
              position: const LatLng(40.873838, -73.895344),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 168);
              }
            ), 
            Marker(
              markerId: const MarkerId("169"),
              position: const LatLng(40.67279918, -73.95310335),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 169);
              }
            ), 
            Marker(
              markerId: const MarkerId("170"),
              position: const LatLng(40.63241896, -74.15653929),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 170);
              }
            ), 
            Marker(
              markerId: const MarkerId("171"),
              position: const LatLng(40.864176, -73.900932),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 171);
              }
            ), 
            Marker(
              markerId: const MarkerId("172"),
              position: const LatLng(40.76355516, -73.92199025),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 172);
              }
            ), 
            Marker(
              markerId: const MarkerId("173"),
              position: const LatLng(40.66977726, -73.93377151),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 173);
              }
            ), 
            Marker(
              markerId: const MarkerId("174"),
              position: const LatLng(40.831187, -73.900567),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 174);
              }
            ), 
            Marker(
              markerId: const MarkerId("175"),
              position: const LatLng(40.6657639, -73.9918034),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 175);
              }
            ), 
            Marker(
              markerId: const MarkerId("176"),
              position: const LatLng(40.76808088, -73.93193347),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 176);
              }
            ), 
            Marker(
              markerId: const MarkerId("177"),
              position: const LatLng(40.87283555, -73.90491128),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 177);
              }
            ), 
            Marker(
              markerId: const MarkerId("178"),
              position: const LatLng(40.752222, -74.008278),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 178);
              }
            ), 
            Marker(
              markerId: const MarkerId("179"),
              position: const LatLng(40.6950796, -73.9073417),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 179);
              }
            ), 
            Marker(
              markerId: const MarkerId("180"),
              position: const LatLng(40.68381262, -73.92018981),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 180);
              }
            ), 
            Marker(
              markerId: const MarkerId("181"),
              position: const LatLng(40.70688, -74.00684),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 181);
              }
            ), 
            Marker(
              markerId: const MarkerId("182"),
              position: const LatLng(40.86054009, -73.92733723),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 182);
              }
            ), 
            Marker(
              markerId: const MarkerId("183"),
              position: const LatLng(40.83505989, -73.84551175),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 183);
              }
            ), 
            Marker(
              markerId: const MarkerId("184"),
              position: const LatLng(40.83612098, -73.92934956),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 184);
              }
            ), 
            Marker(
              markerId: const MarkerId("185"),
              position: const LatLng(40.69236338, -73.93096961),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 185);
              }
            ), 
            Marker(
              markerId: const MarkerId("186"),
              position: const LatLng(40.7027688, -73.92527696),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 186);
              }
            ), 
            Marker(
              markerId: const MarkerId("187"),
              position: const LatLng(40.7579291, -73.90980195),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 187);
              }
            ), 
            Marker(
              markerId: const MarkerId("188"),
              position: const LatLng(40.70477, -74.01368),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 188);
              }
            ), 
            Marker(
              markerId: const MarkerId("189"),
              position: const LatLng(40.846468, -73.894107),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 189);
              }
            ), 
            Marker(
              markerId: const MarkerId("190"),
              position: const LatLng(40.6907969, -73.91234536),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 190);
              }
            ), 
            Marker(
              markerId: const MarkerId("191"),
              position: const LatLng(40.67165371, -73.96107707),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 191);
              }
            ), 
            Marker(
              markerId: const MarkerId("192"),
              position: const LatLng(40.773404, -73.981848),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 192);
              }
            ), 
            Marker(
              markerId: const MarkerId("193"),
              position: const LatLng(40.76499499, -73.92496582),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 193);
              }
            ), 
            Marker(
              markerId: const MarkerId("194"),
              position: const LatLng(40.61356176, -74.11656775),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 194);
              }
            ), 
            Marker(
              markerId: const MarkerId("195"),
              position: const LatLng(40.82775765, -73.81831449),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 195);
              }
            ), 
            Marker(
              markerId: const MarkerId("196"),
              position: const LatLng(40.7089479, -73.9019195),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 196);
              }
            ), 
            Marker(
              markerId: const MarkerId("197"),
              position: const LatLng(40.67541, -73.99128),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 197);
              }
            ), 
            Marker(
              markerId: const MarkerId("198"),
              position: const LatLng(40.84212899, -73.85504935),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 198);
              }
            ), 
            Marker(
              markerId: const MarkerId("199"),
              position: const LatLng(40.70496647, -73.91751361),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 199);
              }
            ), 
            Marker(
              markerId: const MarkerId("200"),
              position: const LatLng(40.82705719, -73.83048333),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 200);
              }
            ), 
            Marker(
              markerId: const MarkerId("201"),
              position: const LatLng(40.68856507, -73.93027022),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 201);
              }
            ), 
            Marker(
              markerId: const MarkerId("202"),
              position: const LatLng(40.6676529, -73.8940832),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 202);
              }
            ), 
            Marker(
              markerId: const MarkerId("203"),
              position: const LatLng(40.7019656, -73.9321766),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 203);
              }
            ), 
            Marker(
              markerId: const MarkerId("204"),
              position: const LatLng(40.683883, -73.871694),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 204);
              }
            ), 
            Marker(
              markerId: const MarkerId("205"),
              position: const LatLng(40.64451, -73.92038),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 205);
              }
            ), 
            Marker(
              markerId: const MarkerId("206"),
              position: const LatLng(40.83478846, -73.94085858),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 206);
              }
            ), 
            Marker(
              markerId: const MarkerId("207"),
              position: const LatLng(40.646152, -74.002213),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 207);
              }
            ), 
            Marker(
              markerId: const MarkerId("208"),
              position: const LatLng(40.85865876, -73.88819441),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 208);
              }
            ), 
            Marker(
              markerId: const MarkerId("209"),
              position: const LatLng(40.68823356, -73.95123169),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 209);
              }
            ), 
            Marker(
              markerId: const MarkerId("210"),
              position: const LatLng(40.67876437, -73.96537833),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 210);
              }
            ), 
            Marker(
              markerId: const MarkerId("211"),
              position: const LatLng(40.76198, -73.9693),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 211);
              }
            ), 
            Marker(
              markerId: const MarkerId("212"),
              position: const LatLng(40.81113664, -73.95765916),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 212);
              }
            ), 
            Marker(
              markerId: const MarkerId("213"),
              position: const LatLng(40.67629, -73.94925),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 213);
              }
            ), 
            Marker(
              markerId: const MarkerId("214"),
              position: const LatLng(40.733536, -74.002663),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 214);
              }
            ), 
            Marker(
              markerId: const MarkerId("215"),
              position: const LatLng(40.6636288, -73.9190362),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 215);
              }
            ), 
            Marker(
              markerId: const MarkerId("216"),
              position: const LatLng(40.77285588, -73.93261246),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 216);
              }
            ), 
            Marker(
              markerId: const MarkerId("217"),
              position: const LatLng(40.6944987, -73.7913159),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 217);
              }
            ), 
            Marker(
              markerId: const MarkerId("218"),
              position: const LatLng(40.70216, -73.80445),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 218);
              }
            ), 
            Marker(
              markerId: const MarkerId("219"),
              position: const LatLng(40.86548295, -73.89523789),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 219);
              }
            ), 
            Marker(
              markerId: const MarkerId("220"),
              position: const LatLng(40.84103325, -73.93805467),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 220);
              }
            ), 
            Marker(
              markerId: const MarkerId("221"),
              position: const LatLng(40.645419, -73.902365),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 221);
              }
            ), 
            Marker(
              markerId: const MarkerId("222"),
              position: const LatLng(40.76737357, -73.92958358),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 222);
              }
            ), 
            Marker(
              markerId: const MarkerId("223"),
              position: const LatLng(40.809894, -73.915999),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 223);
              }
            ), 
            Marker(
              markerId: const MarkerId("224"),
              position: const LatLng(40.76223009, -73.91863731),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 224);
              }
            ), 
            Marker(
              markerId: const MarkerId("225"),
              position: const LatLng(40.802223, -73.934723),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 225);
              }
            ), 
            Marker(
              markerId: const MarkerId("226"),
              position: const LatLng(40.6369271, -74.0767091),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 226);
              }
            ), 
            Marker(
              markerId: const MarkerId("227"),
              position: const LatLng(40.68014247, -73.96811318),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 227);
              }
            ), 
            Marker(
              markerId: const MarkerId("228"),
              position: const LatLng(40.76122012, -73.93532887),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 228);
              }
            ), 
            Marker(
              markerId: const MarkerId("229"),
              position: const LatLng(40.737472, -74.005095),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 229);
              }
            ), 
            Marker(
              markerId: const MarkerId("230"),
              position: const LatLng(40.75685381, -73.90800554),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 230);
              }
            ), 
            Marker(
              markerId: const MarkerId("231"),
              position: const LatLng(40.64305723, -74.07695856),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 231);
              }
            ), 
            Marker(
              markerId: const MarkerId("232"),
              position: const LatLng(40.6221465, -73.9084944),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 232);
              }
            ), 
            Marker(
              markerId: const MarkerId("233"),
              position: const LatLng(40.80957427, -73.93987723),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 233);
              }
            ), 
            Marker(
              markerId: const MarkerId("234"),
              position: const LatLng(40.7942659, -73.9344142),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 234);
              }
            ), 
            Marker(
              markerId: const MarkerId("235"),
              position: const LatLng(40.64496, -73.98016),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 235);
              }
            ), 
            Marker(
              markerId: const MarkerId("236"),
              position: const LatLng(40.697523, -73.913913),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 236);
              }
            ), 
            Marker(
              markerId: const MarkerId("237"),
              position: const LatLng(40.78580942, -73.94264292),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 237);
              }
            ), 
            Marker(
              markerId: const MarkerId("238"),
              position: const LatLng(40.85214985, -73.88634603),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 238);
              }
            ), 
            Marker(
              markerId: const MarkerId("239"),
              position: const LatLng(40.85578084, -73.93784981),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 239);
              }
            ), 
            Marker(
              markerId: const MarkerId("240"),
              position: const LatLng(40.59549, -73.77648),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 240);
              }
            ), 
            Marker(
              markerId: const MarkerId("241"),
              position: const LatLng(40.67613038, -73.93318009),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 241);
              }
            ), 
            Marker(
              markerId: const MarkerId("242"),
              position: const LatLng(40.634203, -74.131071),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 242);
              }
            ), 
            Marker(
              markerId: const MarkerId("243"),
              position: const LatLng(40.82041375, -73.94368663),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 243);
              }
            ), 
            Marker(
              markerId: const MarkerId("244"),
              position: const LatLng(40.66973149, -73.94219801),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 244);
              }
            ), 
            Marker(
              markerId: const MarkerId("245"),
              position: const LatLng(40.820667, -73.901845),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 245);
              }
            ), 
            Marker(
              markerId: const MarkerId("246"),
              position: const LatLng(40.68657037, -73.95448588),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 246);
              }
            ), 
            Marker(
              markerId: const MarkerId("247"),
              position: const LatLng(40.879849, -73.906856),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 247);
              }
            ), 
            Marker(
              markerId: const MarkerId("248"),
              position: const LatLng(40.60927, -73.9573422),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 248);
              }
            ), 
            Marker(
              markerId: const MarkerId("249"),
              position: const LatLng(40.7202214, -74.0128434),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 249);
              }
            ), 
            Marker(
              markerId: const MarkerId("250"),
              position: const LatLng(40.6792579, -73.92542146),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 250);
              }
            ), 
            Marker(
              markerId: const MarkerId("251"),
              position: const LatLng(40.6689286, -73.876838),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 251);
              }
            ), 
            Marker(
              markerId: const MarkerId("252"),
              position: const LatLng(40.77538, -73.92302),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 252);
              }
            ), 
            Marker(
              markerId: const MarkerId("253"),
              position: const LatLng(40.705441, -73.93882),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 253);
              }
            ), 
            Marker(
              markerId: const MarkerId("254"),
              position: const LatLng(40.69199579, -73.90651491),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 254);
              }
            ), 
            Marker(
              markerId: const MarkerId("255"),
              position: const LatLng(40.75530561, -73.94141782),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 255);
              }
            ), 
            Marker(
              markerId: const MarkerId("256"),
              position: const LatLng(40.76387665, -73.92266314),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 256);
              }
            ), 
            Marker(
              markerId: const MarkerId("257"),
              position: const LatLng(40.67645433, -73.94148588),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 257);
              }
            ), 
            Marker(
              markerId: const MarkerId("258"),
              position: const LatLng(40.76558558, -73.92632732),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 258);
              }
            ), 
            Marker(
              markerId: const MarkerId("259"),
              position: const LatLng(40.70421989, -73.91591713),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 259);
              }
            ), 
            Marker(
              markerId: const MarkerId("260"),
              position: const LatLng(40.85487248, -73.91663756),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 260);
              }
            ), 
            Marker(
              markerId: const MarkerId("261"),
              position: const LatLng(40.693609, -73.990261),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 261);
              }
            ), 
            Marker(
              markerId: const MarkerId("262"),
              position: const LatLng(40.756032, -74.006046),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 262);
              }
            ), 
            Marker(
              markerId: const MarkerId("263"),
              position: const LatLng(40.69744237, -73.92379101),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 263);
              }
            ), 
            Marker(
              markerId: const MarkerId("264"),
              position: const LatLng(40.67463802, -73.92219376),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 264);
              }
            ), 
            Marker(
              markerId: const MarkerId("265"),
              position: const LatLng(40.8447734, -73.9133703),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 265);
              }
            ), 
            Marker(
              markerId: const MarkerId("266"),
              position: const LatLng(40.715889, -73.986861),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 266);
              }
            ), 
            Marker(
              markerId: const MarkerId("267"),
              position: const LatLng(40.8285158, -73.9481163),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 267);
              }
            ), 
            Marker(
              markerId: const MarkerId("268"),
              position: const LatLng(40.70378294, -73.92708376),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 268);
              }
            ), 
            Marker(
              markerId: const MarkerId("269"),
              position: const LatLng(40.583757, -74.161931),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 269);
              }
            ), 
            Marker(
              markerId: const MarkerId("270"),
              position: const LatLng(40.66085, -73.95283),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 270);
              }
            ), 
            Marker(
              markerId: const MarkerId("271"),
              position: const LatLng(40.68581223, -73.94146979),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 271);
              }
            ), 
            Marker(
              markerId: const MarkerId("272"),
              position: const LatLng(40.530764, -74.222539),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 272);
              }
            ), 
            Marker(
              markerId: const MarkerId("273"),
              position: const LatLng(40.80984148, -73.94765664),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 273);
              }
            ), 
            Marker(
              markerId: const MarkerId("274"),
              position: const LatLng(40.6843647, -73.9107326),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 274);
              }
            ), 
            Marker(
              markerId: const MarkerId("275"),
              position: const LatLng(40.80557429, -73.96601334),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 275);
              }
            ), 
            Marker(
              markerId: const MarkerId("276"),
              position: const LatLng(40.679954, -73.99517),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 276);
              }
            ), 
            Marker(
              markerId: const MarkerId("277"),
              position: const LatLng(40.84622162, -73.88896354),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 277);
              }
            ), 
            Marker(
              markerId: const MarkerId("278"),
              position: const LatLng(40.70807, -74.01437),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 278);
              }
            ), 
            Marker(
              markerId: const MarkerId("279"),
              position: const LatLng(40.67550079, -73.96958336),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 279);
              }
            ), 
            Marker(
              markerId: const MarkerId("280"),
              position: const LatLng(40.68133, -73.93481),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 280);
              }
            ), 
            Marker(
              markerId: const MarkerId("281"),
              position: const LatLng(40.723183, -73.988622),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 281);
              }
            ), 
            Marker(
              markerId: const MarkerId("282"),
              position: const LatLng(40.69513222, -73.92812781),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 282);
              }
            ), 
            Marker(
              markerId: const MarkerId("283"),
              position: const LatLng(40.68254875, -73.94996937),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 283);
              }
            ), 
            Marker(
              markerId: const MarkerId("284"),
              position: const LatLng(40.8328527, -73.8830803),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 284);
              }
            ), 
            Marker(
              markerId: const MarkerId("285"),
              position: const LatLng(40.839897, -73.879181),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 285);
              }
            ), 
            Marker(
              markerId: const MarkerId("286"),
              position: const LatLng(40.68892887, -73.91690746),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 286);
              }
            ), 
            Marker(
              markerId: const MarkerId("287"),
              position: const LatLng(40.7427093, -73.892547),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 287);
              }
            ), 
            Marker(
              markerId: const MarkerId("288"),
              position: const LatLng(40.6742335, -73.8878004),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 288);
              }
            ), 
            Marker(
              markerId: const MarkerId("289"),
              position: const LatLng(40.7475361, -73.8820084),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 289);
              }
            ), 
            Marker(
              markerId: const MarkerId("290"),
              position: const LatLng(40.88207, -73.88825),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 290);
              }
            ), 
            Marker(
              markerId: const MarkerId("291"),
              position: const LatLng(40.7724122, -73.9053388),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 291);
              }
            ), 
            Marker(
              markerId: const MarkerId("292"),
              position: const LatLng(40.697694, -73.925806),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 292);
              }
            ), 
            Marker(
              markerId: const MarkerId("293"),
              position: const LatLng(40.67812845, -73.91918834),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 293);
              }
            ), 
            Marker(
              markerId: const MarkerId("294"),
              position: const LatLng(40.6871579, -74.0201142),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 294);
              }
            ), 
            Marker(
              markerId: const MarkerId("295"),
              position: const LatLng(40.8139813, -73.8190803),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 295);
              }
            ), 
            Marker(
              markerId: const MarkerId("296"),
              position: const LatLng(40.67726495, -73.96265991),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 296);
              }
            ), 
            Marker(
              markerId: const MarkerId("297"),
              position: const LatLng(40.8079687, -73.917581),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 297);
              }
            ), 
            Marker(
              markerId: const MarkerId("298"),
              position: const LatLng(40.635514, -74.022767),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 298);
              }
            ), 
            Marker(
              markerId: const MarkerId("299"),
              position: const LatLng(40.84471862, -73.90847526),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 299);
              }
            ), 
            Marker(
              markerId: const MarkerId("300"),
              position: const LatLng(40.67741189, -73.95897587),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 300);
              }
            ), 
            Marker(
              markerId: const MarkerId("301"),
              position: const LatLng(40.613046, -73.982115),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 301);
              }
            ), 
            Marker(
              markerId: const MarkerId("302"),
              position: const LatLng(40.82162476, -73.86291526),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 302);
              }
            ), 
            Marker(
              markerId: const MarkerId("303"),
              position: const LatLng(40.81762957, -73.95314779),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 303);
              }
            ), 
            Marker(
              markerId: const MarkerId("304"),
              position: const LatLng(40.83545663, -73.92011907),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 304);
              }
            ), 
            Marker(
              markerId: const MarkerId("305"),
              position: const LatLng(40.6472062, -73.9526235),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 305);
              }
            ), 
            Marker(
              markerId: const MarkerId("306"),
              position: const LatLng(40.83161372, -73.94291718),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 306);
              }
            ), 
            Marker(
              markerId: const MarkerId("307"),
              position: const LatLng(40.79805485, -73.94852463),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 307);
              }
            ), 
            Marker(
              markerId: const MarkerId("308"),
              position: const LatLng(40.6674207, -73.9102833),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 308);
              }
            ), 
            Marker(
              markerId: const MarkerId("309"),
              position: const LatLng(40.6688541, -73.8857006),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 309);
              }
            ), 
            Marker(
              markerId: const MarkerId("310"),
              position: const LatLng(40.780087, -73.974657),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 310);
              }
            ), 
            Marker(
              markerId: const MarkerId("311"),
              position: const LatLng(40.69444688, -73.91854059),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 311);
              }
            ), 
            Marker(
              markerId: const MarkerId("312"),
              position: const LatLng(40.77534869, -73.93613856),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 312);
              }
            ), 
            Marker(
              markerId: const MarkerId("313"),
              position: const LatLng(40.7657836, -73.7408196),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 313);
              }
            ), 
            Marker(
              markerId: const MarkerId("314"),
              position: const LatLng(40.70287, -74.01163),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 314);
              }
            ), 
            Marker(
              markerId: const MarkerId("315"),
              position: const LatLng(40.7298117, -74.0110087),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 315);
              }
            ), 
            Marker(
              markerId: const MarkerId("316"),
              position: const LatLng(40.76701706, -73.92599747),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 316);
              }
            ), 
            Marker(
              markerId: const MarkerId("317"),
              position: const LatLng(40.67785104, -73.96890208),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 317);
              }
            ), 
            Marker(
              markerId: const MarkerId("318"),
              position: const LatLng(40.86620151, -73.92508216),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 318);
              }
            ), 
            Marker(
              markerId: const MarkerId("319"),
              position: const LatLng(40.844901, -73.887287),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 319);
              }
            ), 
            Marker(
              markerId: const MarkerId("320"),
              position: const LatLng(40.70324915, -73.91453684),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 320);
              }
            ), 
            Marker(
              markerId: const MarkerId("321"),
              position: const LatLng(40.68574435, -73.93556558),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 321);
              }
            ), 
            Marker(
              markerId: const MarkerId("322"),
              position: const LatLng(40.8385211, -73.84905796),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 322);
              }
            ), 
            Marker(
              markerId: const MarkerId("323"),
              position: const LatLng(40.73661, -73.9893),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 323);
              }
            ), 
            Marker(
              markerId: const MarkerId("324"),
              position: const LatLng(40.76149921, -73.91796863),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 324);
              }
            ), 
            Marker(
              markerId: const MarkerId("325"),
              position: const LatLng(40.9035436, -73.9038447),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 325);
              }
            ), 
            Marker(
              markerId: const MarkerId("326"),
              position: const LatLng(40.5988666, -73.9553874),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 326);
              }
            ), 
            Marker(
              markerId: const MarkerId("327"),
              position: const LatLng(40.754004, -73.885483),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 327);
              }
            ), 
            Marker(
              markerId: const MarkerId("328"),
              position: const LatLng(40.8022352, -73.9366968),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 328);
              }
            ), 
            Marker(
              markerId: const MarkerId("329"),
              position: const LatLng(40.636758, -74.119727),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 329);
              }
            ), 
            Marker(
              markerId: const MarkerId("330"),
              position: const LatLng(40.79314192, -73.94825712),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 330);
              }
            ), 
            Marker(
              markerId: const MarkerId("331"),
              position: const LatLng(40.87628034, -73.88136584),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 331);
              }
            ), 
            Marker(
              markerId: const MarkerId("332"),
              position: const LatLng(40.76346, -74.00025),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 332);
              }
            ), 
            Marker(
              markerId: const MarkerId("333"),
              position: const LatLng(40.68922911, -73.90958436),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 333);
              }
            ), 
            Marker(
              markerId: const MarkerId("334"),
              position: const LatLng(40.6874973, -73.92091434),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 334);
              }
            ), 
            Marker(
              markerId: const MarkerId("335"),
              position: const LatLng(40.67049108, -73.94772705),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 335);
              }
            ), 
            Marker(
              markerId: const MarkerId("336"),
              position: const LatLng(40.84608111, -73.94016188),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 336);
              }
            ), 
            Marker(
              markerId: const MarkerId("337"),
              position: const LatLng(40.761472, -73.925611),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 337);
              }
            ), 
            Marker(
              markerId: const MarkerId("338"),
              position: const LatLng(40.69300171, -73.9556798),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 338);
              }
            ), 
            Marker(
              markerId: const MarkerId("339"),
              position: const LatLng(40.5782545, -73.979703),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 339);
              }
            ), 
            Marker(
              markerId: const MarkerId("340"),
              position: const LatLng(40.75013, -73.91369),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 340);
              }
            ), 
            Marker(
              markerId: const MarkerId("341"),
              position: const LatLng(40.761833, -73.950139),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 341);
              }
            ), 
            Marker(
              markerId: const MarkerId("342"),
              position: const LatLng(40.76154874, -73.93188491),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 342);
              }
            ), 
            Marker(
              markerId: const MarkerId("343"),
              position: const LatLng(40.774194, -73.911611),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 343);
              }
            ), 
            Marker(
              markerId: const MarkerId("344"),
              position: const LatLng(40.69389322, -73.94294936),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 344);
              }
            ), 
            Marker(
              markerId: const MarkerId("345"),
              position: const LatLng(40.81357603, -73.94525472),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 345);
              }
            ), 
            Marker(
              markerId: const MarkerId("346"),
              position: const LatLng(40.62214724, -74.07850452),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 346);
              }
            ), 
            Marker(
              markerId: const MarkerId("347"),
              position: const LatLng(40.672077, -73.996401),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 347);
              }
            ), 
            Marker(
              markerId: const MarkerId("348"),
              position: const LatLng(40.69281, -74.0148306),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 348);
              }
            ), 
            Marker(
              markerId: const MarkerId("349"),
              position: const LatLng(40.84592818, -73.82940911),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 349);
              }
            ), 
            Marker(
              markerId: const MarkerId("350"),
              position: const LatLng(40.68513799, -73.92664053),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 350);
              }
            ), 
            Marker(
              markerId: const MarkerId("351"),
              position: const LatLng(40.70888, -74.00721),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 351);
              }
            ), 
            Marker(
              markerId: const MarkerId("352"),
              position: const LatLng(40.6483066, -73.9772287),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 352);
              }
            ), 
            Marker(
              markerId: const MarkerId("353"),
              position: const LatLng(40.678179, -73.77964),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 353);
              }
            ), 
            Marker(
              markerId: const MarkerId("354"),
              position: const LatLng(40.68135249, -73.92874405),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 354);
              }
            ), 
            Marker(
              markerId: const MarkerId("355"),
              position: const LatLng(40.87896, -73.87585),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 355);
              }
            ), 
            Marker(
              markerId: const MarkerId("356"),
              position: const LatLng(40.6337035, -74.14217077),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 356);
              }
            ), 
            Marker(
              markerId: const MarkerId("357"),
              position: const LatLng(40.74777, -73.95486),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 357);
              }
            ), 
            Marker(
              markerId: const MarkerId("358"),
              position: const LatLng(40.76262573, -73.93766776),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 358);
              }
            ), 
            Marker(
              markerId: const MarkerId("359"),
              position: const LatLng(40.67310418, -73.96755293),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 359);
              }
            ), 
            Marker(
              markerId: const MarkerId("360"),
              position: const LatLng(40.68393669, -73.95034757),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 360);
              }
            ), 
            Marker(
              markerId: const MarkerId("361"),
              position: const LatLng(40.81899415, -73.95624071),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 361);
              }
            ), 
            Marker(
              markerId: const MarkerId("362"),
              position: const LatLng(40.879247, -73.90727),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 362);
              }
            ), 
            Marker(
              markerId: const MarkerId("363"),
              position: const LatLng(40.707547, -73.864884),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 363);
              }
            ), 
            Marker(
              markerId: const MarkerId("364"),
              position: const LatLng(40.820124, -73.895674),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 364);
              }
            ), 
            Marker(
              markerId: const MarkerId("365"),
              position: const LatLng(40.717424, -74.010793),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 365);
              }
            ), 
            Marker(
              markerId: const MarkerId("366"),
              position: const LatLng(40.8432747, -73.9162121),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 366);
              }
            ), 
            Marker(
              markerId: const MarkerId("367"),
              position: const LatLng(40.82647613, -73.9468776),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 367);
              }
            ), 
            Marker(
              markerId: const MarkerId("368"),
              position: const LatLng(40.69828985, -73.93382885),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 368);
              }
            ), 
            Marker(
              markerId: const MarkerId("369"),
              position: const LatLng(40.714243, -73.990163),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 369);
              }
            ), 
            Marker(
              markerId: const MarkerId("370"),
              position: const LatLng(40.69090444, -73.90418004),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 370);
              }
            ), 
            Marker(
              markerId: const MarkerId("371"),
              position: const LatLng(40.8553543, -73.89307771),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 371);
              }
            ), 
            Marker(
              markerId: const MarkerId("372"),
              position: const LatLng(40.84901271, -73.90952233),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 372);
              }
            ), 
            Marker(
              markerId: const MarkerId("373"),
              position: const LatLng(40.7003602, -73.9289955),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 373);
              }
            ), 
            Marker(
              markerId: const MarkerId("374"),
              position: const LatLng(40.654917, -73.962083),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 374);
              }
            ), 
            Marker(
              markerId: const MarkerId("375"),
              position: const LatLng(40.68764908, -73.94487351),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 375);
              }
            ), 
            Marker(
              markerId: const MarkerId("376"),
              position: const LatLng(40.556014, -74.194626),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 376);
              }
            ), 
            Marker(
              markerId: const MarkerId("377"),
              position: const LatLng(40.80545915, -73.96220095),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 377);
              }
            ), 
            Marker(
              markerId: const MarkerId("378"),
              position: const LatLng(40.641619, -74.1012686),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 378);
              }
            ), 
            Marker(
              markerId: const MarkerId("379"),
              position: const LatLng(40.85039541, -73.93447995),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 379);
              }
            ), 
            Marker(
              markerId: const MarkerId("380"),
              position: const LatLng(40.75290526, -73.94352235),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 380);
              }
            ), 
            Marker(
              markerId: const MarkerId("381"),
              position: const LatLng(40.7054315, -73.9269348),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 381);
              }
            ), 
            Marker(
              markerId: const MarkerId("382"),
              position: const LatLng(40.6734846, -73.93339064),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 382);
              }
            ), 
            Marker(
              markerId: const MarkerId("383"),
              position: const LatLng(40.76417452, -73.92345808),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 383);
              }
            ), 
            Marker(
              markerId: const MarkerId("384"),
              position: const LatLng(40.70888, -73.82917),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 384);
              }
            ), 
            Marker(
              markerId: const MarkerId("385"),
              position: const LatLng(40.69608852, -73.92145414),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 385);
              }
            ), 
            Marker(
              markerId: const MarkerId("386"),
              position: const LatLng(40.67165677, -73.95756003),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 386);
              }
            ), 
            Marker(
              markerId: const MarkerId("387"),
              position: const LatLng(40.7649409, -73.92701134),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 387);
              }
            ), 
            Marker(
              markerId: const MarkerId("388"),
              position: const LatLng(40.83343, -73.861655),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 388);
              }
            ), 
            Marker(
              markerId: const MarkerId("389"),
              position: const LatLng(40.7601267, -73.9949035),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 389);
              }
            ), 
            Marker(
              markerId: const MarkerId("390"),
              position: const LatLng(40.64302975, -74.07558024),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 390);
              }
            ), 
            Marker(
              markerId: const MarkerId("391"),
              position: const LatLng(40.605671, -74.140879),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 391);
              }
            ), 
            Marker(
              markerId: const MarkerId("392"),
              position: const LatLng(40.85928459, -73.89476415),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 392);
              }
            ), 
            Marker(
              markerId: const MarkerId("393"),
              position: const LatLng(40.70669251, -73.9204542),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 393);
              }
            ), 
            Marker(
              markerId: const MarkerId("394"),
              position: const LatLng(40.797433, -73.93471364),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 394);
              }
            ), 
            Marker(
              markerId: const MarkerId("395"),
              position: const LatLng(40.728415, -73.84711),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 395);
              }
            ), 
            Marker(
              markerId: const MarkerId("396"),
              position: const LatLng(40.64491, -73.97997),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 396);
              }
            ), 
            Marker(
              markerId: const MarkerId("397"),
              position: const LatLng(40.67495664, -73.92772514),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 397);
              }
            ), 
            Marker(
              markerId: const MarkerId("398"),
              position: const LatLng(40.83316, -73.92728),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 398);
              }
            ), 
            Marker(
              markerId: const MarkerId("399"),
              position: const LatLng(40.666485, -73.950935),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 399);
              }
            ), 
            Marker(
              markerId: const MarkerId("400"),
              position: const LatLng(40.80207202, -73.95370033),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 400);
              }
            ), 
            Marker(
              markerId: const MarkerId("401"),
              position: const LatLng(40.84112457, -73.88433337),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 401);
              }
            ), 
            Marker(
              markerId: const MarkerId("402"),
              position: const LatLng(40.70905, -74.01072),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 402);
              }
            ), 
            Marker(
              markerId: const MarkerId("403"),
              position: const LatLng(40.69288, -73.97391),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 403);
              }
            ), 
            Marker(
              markerId: const MarkerId("404"),
              position: const LatLng(40.6712827, -73.94190498),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 404);
              }
            ), 
            Marker(
              markerId: const MarkerId("405"),
              position: const LatLng(40.71974, -73.953394),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 405);
              }
            ), 
            Marker(
              markerId: const MarkerId("406"),
              position: const LatLng(40.69517863, -73.91169753),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 406);
              }
            ), 
            Marker(
              markerId: const MarkerId("407"),
              position: const LatLng(40.80237734, -73.94273579),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 407);
              }
            ), 
            Marker(
              markerId: const MarkerId("408"),
              position: const LatLng(40.88201, -73.880346),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 408);
              }
            ), 
            Marker(
              markerId: const MarkerId("409"),
              position: const LatLng(40.81491836, -73.95299658),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 409);
              }
            ), 
            Marker(
              markerId: const MarkerId("410"),
              position: const LatLng(40.82096078, -73.95101175),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 410);
              }
            ), 
            Marker(
              markerId: const MarkerId("411"),
              position: const LatLng(40.68434297, -73.95393368),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 411);
              }
            ), 
            Marker(
              markerId: const MarkerId("412"),
              position: const LatLng(40.67465, -73.91823),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 412);
              }
            ), 
            Marker(
              markerId: const MarkerId("413"),
              position: const LatLng(40.67710908, -73.95261202),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 413);
              }
            ), 
            Marker(
              markerId: const MarkerId("414"),
              position: const LatLng(40.7859379, -73.8458402),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 414);
              }
            ), 
            Marker(
              markerId: const MarkerId("415"),
              position: const LatLng(40.767878, -73.923199),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 415);
              }
            ), 
            Marker(
              markerId: const MarkerId("416"),
              position: const LatLng(40.870106, -73.920792),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 416);
              }
            ), 
            Marker(
              markerId: const MarkerId("417"),
              position: const LatLng(40.87214621, -73.88263956),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 417);
              }
            ), 
            Marker(
              markerId: const MarkerId("418"),
              position: const LatLng(40.66392, -73.76626),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 418);
              }
            ), 
            Marker(
              markerId: const MarkerId("419"),
              position: const LatLng(40.5780034, -73.9591672),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 419);
              }
            ), 
            Marker(
              markerId: const MarkerId("420"),
              position: const LatLng(40.67568845, -73.93871281),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 420);
              }
            ), 
            Marker(
              markerId: const MarkerId("421"),
              position: const LatLng(40.76208812, -73.92557334),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 421);
              }
            ), 
            Marker(
              markerId: const MarkerId("422"),
              position: const LatLng(40.63714951, -74.11651209),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 422);
              }
            ), 
            Marker(
              markerId: const MarkerId("423"),
              position: const LatLng(40.742827, -74.0078384),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 423);
              }
            ), 
            Marker(
              markerId: const MarkerId("424"),
              position: const LatLng(40.701501, -73.98263),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 424);
              }
            ), 
            Marker(
              markerId: const MarkerId("425"),
              position: const LatLng(40.67867868, -73.97343334),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 425);
              }
            ), 
            Marker(
              markerId: const MarkerId("426"),
              position: const LatLng(40.807138, -73.96437),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 426);
              }
            ), 
            Marker(
              markerId: const MarkerId("427"),
              position: const LatLng(40.85323679, -73.89310654),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 427);
              }
            ), 
            Marker(
              markerId: const MarkerId("428"),
              position: const LatLng(40.68457611, -73.94418888),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 428);
              }
            ), 
            Marker(
              markerId: const MarkerId("429"),
              position: const LatLng(40.69877411, -73.92600182),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 429);
              }
            ), 
            Marker(
              markerId: const MarkerId("430"),
              position: const LatLng(40.674065, -73.885109),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 430);
              }
            ), 
            Marker(
              markerId: const MarkerId("431"),
              position: const LatLng(40.66547, -73.88668),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 431);
              }
            ), 
            Marker(
              markerId: const MarkerId("432"),
              position: const LatLng(40.595579, -74.062991),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 432);
              }
            ), 
            Marker(
              markerId: const MarkerId("433"),
              position: const LatLng(40.80556262, -73.93639237),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 433);
              }
            ), 
            Marker(
              markerId: const MarkerId("434"),
              position: const LatLng(40.84505235, -73.82693077),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 434);
              }
            ), 
            Marker(
              markerId: const MarkerId("435"),
              position: const LatLng(40.81799952, -73.85720618),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 435);
              }
            ), 
            Marker(
              markerId: const MarkerId("436"),
              position: const LatLng(40.68640156, -73.92984342),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 436);
              }
            ), 
            Marker(
              markerId: const MarkerId("437"),
              position: const LatLng(40.8359312, -73.9391906),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 437);
              }
            ), 
            Marker(
              markerId: const MarkerId("438"),
              position: const LatLng(40.654139, -73.976444),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 438);
              }
            ), 
            Marker(
              markerId: const MarkerId("439"),
              position: const LatLng(40.69271648, -73.9155288),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 439);
              }
            ), 
            Marker(
              markerId: const MarkerId("440"),
              position: const LatLng(40.764056, -73.915722),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 440);
              }
            ), 
            Marker(
              markerId: const MarkerId("441"),
              position: const LatLng(40.80317005, -73.94863548),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 441);
              }
            ), 
            Marker(
              markerId: const MarkerId("442"),
              position: const LatLng(40.7067584, -74.0171557),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 442);
              }
            ), 
            Marker(
              markerId: const MarkerId("443"),
              position: const LatLng(40.67744, -73.953657),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 443);
              }
            ), 
            Marker(
              markerId: const MarkerId("444"),
              position: const LatLng(40.68161005, -73.9039715),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 444);
              }
            ), 
            Marker(
              markerId: const MarkerId("445"),
              position: const LatLng(40.79670761, -73.94496605),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 445);
              }
            ), 
            Marker(
              markerId: const MarkerId("446"),
              position: const LatLng(40.771, -73.995372),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 446);
              }
            ), 
            Marker(
              markerId: const MarkerId("447"),
              position: const LatLng(40.67509191, -73.95637851),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 447);
              }
            ), 
            Marker(
              markerId: const MarkerId("448"),
              position: const LatLng(40.691403, -74.019696),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 448);
              }
            ), 
            Marker(
              markerId: const MarkerId("449"),
              position: const LatLng(40.69466118, -73.93744513),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 449);
              }
            ), 
            Marker(
              markerId: const MarkerId("450"),
              position: const LatLng(40.734225, -74.010722),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 450);
              }
            ), 
            Marker(
              markerId: const MarkerId("451"),
              position: const LatLng(40.794717, -73.969552),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 451);
              }
            ), 
            Marker(
              markerId: const MarkerId("452"),
              position: const LatLng(40.83292727, -73.86668779),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 452);
              }
            ), 
            Marker(
              markerId: const MarkerId("453"),
              position: const LatLng(40.590444, -73.970333),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 453);
              }
            ), 
            Marker(
              markerId: const MarkerId("454"),
              position: const LatLng(40.613444, -74.095028),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 454);
              }
            ), 
            Marker(
              markerId: const MarkerId("455"),
              position: const LatLng(40.76656937, -73.92594543),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 455);
              }
            ), 
            Marker(
              markerId: const MarkerId("456"),
              position: const LatLng(40.779055, -73.944665),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 456);
              }
            ), 
            Marker(
              markerId: const MarkerId("457"),
              position: const LatLng(40.746948, -73.921208),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 457);
              }
            ), 
            Marker(
              markerId: const MarkerId("458"),
              position: const LatLng(40.7616519, -73.8720745),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 458);
              }
            ), 
            Marker(
              markerId: const MarkerId("459"),
              position: const LatLng(40.7536858, -73.9422838),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 459);
              }
            ), 
            Marker(
              markerId: const MarkerId("460"),
              position: const LatLng(40.8097074, -73.9185797),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 460);
              }
            ), 
            Marker(
              markerId: const MarkerId("461"),
              position: const LatLng(40.8138017, -73.9428691),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 461);
              }
            ), 
            Marker(
              markerId: const MarkerId("462"),
              position: const LatLng(40.671899, -73.969673),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 462);
              }
            ), 
            Marker(
              markerId: const MarkerId("463"),
              position: const LatLng(40.69043184, -73.91965739),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 463);
              }
            ), 
            Marker(
              markerId: const MarkerId("464"),
              position: const LatLng(40.70249991, -73.91299399),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 464);
              }
            ), 
            Marker(
              markerId: const MarkerId("465"),
              position: const LatLng(40.86791421, -73.9171445),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 465);
              }
            ), 
            Marker(
              markerId: const MarkerId("466"),
              position: const LatLng(40.83268, -73.918805),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 466);
              }
            ), 
            Marker(
              markerId: const MarkerId("467"),
              position: const LatLng(40.6789777, -73.93855054),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 467);
              }
            ), 
            Marker(
              markerId: const MarkerId("468"),
              position: const LatLng(40.68303106, -73.92619696),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 468);
              }
            ), 
            Marker(
              markerId: const MarkerId("469"),
              position: const LatLng(40.8532261, -73.8434618),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 469);
              }
            ), 
            Marker(
              markerId: const MarkerId("470"),
              position: const LatLng(40.70739, -74.00853),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 470);
              }
            ), 
            Marker(
              markerId: const MarkerId("471"),
              position: const LatLng(40.742278, -73.98725),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 471);
              }
            ), 
            Marker(
              markerId: const MarkerId("472"),
              position: const LatLng(40.69389144, -73.90959073),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 472);
              }
            ), 
            Marker(
              markerId: const MarkerId("473"),
              position: const LatLng(40.609644, -73.999683),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 473);
              }
            ), 
            Marker(
              markerId: const MarkerId("474"),
              position: const LatLng(40.85693035, -73.89822654),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 474);
              }
            ), 
            Marker(
              markerId: const MarkerId("475"),
              position: const LatLng(40.848245, -73.913085),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 475);
              }
            ), 
            Marker(
              markerId: const MarkerId("476"),
              position: const LatLng(40.6174, -74.033703),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 476);
              }
            ), 
            Marker(
              markerId: const MarkerId("477"),
              position: const LatLng(40.7253498, -73.9786278),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 477);
              }
            ), 
            Marker(
              markerId: const MarkerId("478"),
              position: const LatLng(40.84052114, -73.91521599),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 478);
              }
            ), 
            Marker(
              markerId: const MarkerId("479"),
              position: const LatLng(40.69237838, -73.92284252),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
              onTap:(){
                buildSidebar(context, 479);
              }
            )
          },
          cameraTargetBounds: CameraTargetBounds(
                LatLngBounds(
                  northeast: const LatLng(41, -73.6),
                  southwest: const LatLng(40.5128, -74.3),
                )
          )
        ),
        
      ),
    );
  }
}

List<List<String>> markerData = [
  ["Jackson Heights Greenmarket", "79th St and Northern Blvd", "GrowNYC", "Year Round", "Sundays (Start Time: 8:30 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["Aberdeen Community Garden", "91 Aberdeen St, Brooklyn, 11207", "BK Rot", "Year Round", "Sundays (Start Time: 1:00 PM - End Time:  4PM (Dec-Feb), 5PM (Mar.-Nov.))", "Not accepted: meat, bones, or dairy", "www.bkrot.org"],
  ["Old Stone House Brooklyn", "336 3rd St, Brooklyn, NY 11215", "Old Stone House Brooklyn", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "-", "-"],
  ["Crown Heights Franklin Ave Food Scrap Drop-off", "Franklin Avenue & Eastern Parkway", "GrowNYC", "Year Round", "Thursdays (Start Time: 8:30 AM - End Time:  11:30 AM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["Abyssinian Tot Lot", "130 W 139th St, New York, NY 10030", "GrowNYC and the Malcolm X Boulevard Beautification Group", "Year Round", "Saturday (Start Time: 8:00 AM - End Time:  12:30 PM)", "-", "grownyc.org/compost"],
  ["145th St Food Scrap Drop-off", "145th St & Edgecombe Ave", "GrowNYC", "Year Round", "Thursdays (Start Time: 7:30 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["45th Street Composters", "41-12 45th Street (45th St & Skillman Ave, Queens, NY 11104)", "Volunteers at 45th Street Compost", "Year Round", "Sundays (Start Time: 10:30 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "https://linktr.ee/45thstreetcomposters"],
  ["Down to Earth Garden (formerly Children's Garden)", "546 East 12th St, New York, NY 10009", "Down to Earth Garden", "Year Round", "Tuesdays and Sundays (Start Time: Tuesday: 1:30PM, Sunday 12:00pm - End Time:  Tuesday 4pm, Sunday 4pm)", "Keep food scraps and plant material separated. This site accepts meat, fish, and dairy", "https://downtoearthgarden.org/"],
  ["NW Bruckner Boulevard & Evergreen Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Bushwick Avenue & Himrod Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["North Brooklyn Compost", "Russell Street &, Nassau Ave, Brooklyn, NY 11222", "North Brooklyn Compost", "Year Round", "Sundays (Start Time: 10:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/nbkcompost/?hl=en"],
  ["SE Lewis Avenue & Hancock Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Cortelyou Greenmarket", "Argyle Rd and Cortelyou Rd", "GrowNYC", "Year Round", "Sundays (Start Time: 9:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["SmartComposting: Wall & Pearl Streets", "Wall and Pearl Streets (Southwest corner)", "Alliance for Downtown New York", "Year Round", "24/7", "Scan QR code on the bin to drop-off! Accepts all types of food scraps, including meat & dairy.", "https://downtownny.com/compost/"],
  ["NW Gerard Avenue & East 150th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Office of Assemblymember Anderson", "131-15 Rockaway Boulevard", "Assemblymember Anderson", "Year Round", "Tuesdays and Wednesdays (Start Time: 12:00 PM - End Time:  4:00 PM)", "Not accepted: meat, bones, or dairy", "https://nyassembly.gov/mem/Khaleel-M-Anderson"],
  ["NW Central Avenue & Moffat Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Dag Hammarskjold Plaza Greenmarket", "E 47th St & 2nd Ave", "GrowNYC", "Year Round", "Wednesdays (Start Time: 8:00 AM - End Time:  12:30 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NW New York Avenue & Prospect Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW 31st Avenue & 23rd Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE Knickerbocker Avenue & Menahan Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE East 181st Street & Morris Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Rainbow Garden of Health", "757 Melrose Ave Bronx, NY 10451", "-", "Year Round", "Wednesdays, Thursdays, Saturdays (Start Time: 10:00 AM - End Time:  W&Th 1:00 PM, Sat 2:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["18th Avenue at 64th Street", "west of 18th Avenue between 64th Street and 63rd Street", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Tuesdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["*CLOSED FOR THE SEASON*\nMidland Beach", "Bedford Ave and Mason Ave", "Snug Harbor Youth", "Seasonal", "Wednesdays (Start Time: 3:30 PM - End Time:  5:00 PM)", "Not accepted: meat, bones, or dairy", "https://snug-harbor.org/"],
  ["NW Amsterdam Avenue & W 152 Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["The Compost Collective", "The corner of Yellowstone Blvd, and Kessel Street Forest Hills, NY 11375", "The Compost Collective", "Year Round (Except February)", "Saturdays (Start Time: 12:00 PM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.facebook.com/pg/thecompostcollective/about/?ref=page_internal"],
  ["Flatbush Junction Food Scrap Drop-off", "Hillel Pl & Flatbush Ave", "GrowNYC", "Year Round", "Fridays (Start Time: 8:30 AM - End Time:  2:30 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["SE Rochester Avenue & Park Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW West 135 Street & 5th Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Red Hook Community Farm", "103 Otsego St", "NYC Compost Project Hosted by Big Reuse", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "-"],
  ["SW East 187th Street & Southern Boulevard", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Houston Street & Willowbrook Road", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Underhill Avenue & Park Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Albany Avenue & St. Johns Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Kew Gardens Food Scrap Drop-off", "Metropolitan Ave & Audley St", "GrowNYC", "Year Round", "Thursdays (Start Time: 9:30 AM - End Time:  12:30 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["Kingsbridge Heights Community Center", "3101 Kingsbridge Terrace, Bronx NY 10463", "Staff at Kingsbridge Heights Community Center", "Year Round", "Wednesdays (Start Time: 12:00 PM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "www.khcc-nyc.org"],
  ["SmartComposting: Platt & Gold Streets", "Platt and Gold Streets (Southeast corner)", "Alliance for Downtown New York", "Year Round", "24/7", "Scan QR code on the bin to drop-off! Accepts all types of food scraps, including meat & dairy.", "https://downtownny.com/compost/"],
  ["NE Lewis Avenue & Green Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Hull Avenue & East 207th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Socrates Sculpture Park", "Broadway & Vernon Blvd, Queens, NY 11106", "Socrates Sculpture Park", "Year Round", "Every day (Start Time: 9:00 AM - End Time:  Dusk)", "Not accepted: meat, bones, or dairy", "socratessculpturepark.org"],
  ["SW Rogers Avenue & Lincoln Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE 31st Avenue & 35th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Ridgewood", "Cypress Ave btw Myrtle Ave. and Putnam Ave.", "GrowNYC", "Year Round", "Saturdays (Start Time: 9:30 AM - End Time:  1:30 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["Mathews-Palmer Park", "437 W 45 St, New York, NY 10036", "Mathews-Palmer Park", "Year Round", "Every day (Start Time: Dawn - End Time:  Dusk)", "Please register to participate at the website. Setup is inside the park gate, under the mosaic panels, to the right of the park house door. Lids must remain closed and all food scraps must be placed INSIDE the bins", "https://bit.ly/HKcompost"],
  ["St. George Greenmarket", "St. Marks Pl and Hyatt St", "NYC Compost Project Hosted by Snug Harbor Cultural Center & Botanical Garden", "Year Round", "Saturdays (Start Time: 8:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "snug-harbor.org"],
  ["Lydia's Magic Garden", "1665 Park Avenue, Manhattan 10035 between 117th and 118th Streets", "Lydia's Magic Garden", "Seasonal", "Tuesday-Sunday (Start Time: Tuesday 5:30 PM-7:30; Wednesday 7:00AM - 9:00AM; Saturday 10:00 AM - 12 PM; Sunday 11:00 AM - 1PM - End Time:  See above ranges)", "Bring food scraps inside the garden to place in the compost tumbler. Not accepted: meat, bones, or dairy", "https://www.facebook.com/lydiasmagicgarden/"],
  ["NW West 126th St & Morningside Ave", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Tompkins Avenue & Lafayette Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW West 122 Street & Malcolm X Blvd", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Queens Botanical Garden Public Food Scrap Drop-Off", "Parking Garden at QBG 42-80 Crommelin Avenue, Flushing, NY 11355", "NYC Compost Project Hosted by Queens Botanical Garden", "Year Round", "Every day (Start Time: 8:00 AM - End Time:  5:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["H.E.A.L.T.H for Youths Skyline Community Garden", "1 Clyde Place", "H.E.A.L.T.H for Youths Skyline Community Garden", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "www.health4youths.org"],
  ["NW Audubon Avenue & West 192nd Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE Schenectady Avenue & Sterling Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Brighton Beach Avenue and Ocean Parkway", "Southeast corner of Brighton Beach Avenue and Ocean Parkway (Same corner as Big Bazaar Supermarket)", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Wednesdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["NE Vermont Avenue & Hylan Blvd", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE 31st Avenue & 36th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW St. Nicholas Avenue & Linden Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE City Island Avenue & Winter Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Patchen Avenue & Monroe Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Los Colibries Community Garden", "219 34th Street, Brooklyn 11232", "Los Colibries Community Garden", "Year Round", "Sundays (Start Time: 11:00 AM - End Time:  4:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.facebook.com/jardin34/"],
  ["Astoria Pug: Newtown", "30-36 41st Street, Astoria, NY", "Astoria Pug", "Year Round", "Fridays (Start Time: 11:00 AM - End Time:  4:30 PM)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/astoriapug/?hl=en"],
  ["West Side Community Garden", "West of 110 West 90th street, New York, NY 10024 (between Columbus Ave and Amsterdam Ave)", "West Side Community Garden", "Year Round", "Sundays 11 am - 12 pm", "Receptacles are placed outside the West Side Community Garden gate. No rice, bread, pasta, and grains. The drop-off will be closed during inclement weather including rain and snow.", "www.instagram.com/westsidecommunitygarden"],
  ["SE 40th Avenue & 10th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Astoria Pug: Most Precious Blood", "32-23 36th St, Queens, NY 11106 (inside parking lot)", "Astoria Pug", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/astoriapug/?hl=en"],
  ["Olivet Heavenly Harvest", "97 Myrtle Avenue, Staten Island, NY", "Olivet Heavenly Harvest", "Closed During Winter", "Saturdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "olivetheavenlyharvest.com"],
  ["Hudson River Park's Chelsea Waterside Park at W. 23rd St.", "Chelsea Waterside Park near the playground", "Staff at Hudson River Park", "Year Round", "Every day (Start Time: 7:00 AM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://hudsonriverpark.org/the-park/sustainability/community-compost-program/"],
  ["Rockaway Avenue Community Compost Site", "1149 Rockaway Avenue, Brooklyn NY, 11236", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["SE East 106th Street & 3rd Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["8th Ave & 24th St", "W 24th St. and 8th Ave., New York, NY, 1001 (Collection bins are on the northwest corner of W 24th St and 8th Ave., near subway exit)", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Wednesdays (Start Time: 9:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["SW Tompkins Avenue & Macon Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE Kings College Place & Gun Hill Road", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["East 96th Street Food Scrap Drop-off", "96th St & Lexington Ave", "GrowNYC", "Year Round", "Fridays (Start Time: 7:30 AM - End Time:  11:30 AM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NW Morris Avenue & East 163rd Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE Pleasant Avenue & East 120 Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Jenny's Garden", "699 West 138th Street", "Jenny's Garden", "Year Round", "Sundays (Start Time: 12:00 PM - End Time:  1:00 PM)", "Year Round: check social media for open hour updates + November - March only open on Saturday 11-12pm.", "Not accepted: meat, bones, or dairy Please DO NOT leave bags of food scraps by gate", "https://www.facebook.com/JennysGardenRiverside"],
  ["Rappaport Playground", "NW corner of Fort Hamilton Pkwy and 53rd Street", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Tuesdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["NE Bedford Avenue & Hancock Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Knickerbocker Avenue & Suydam Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["181st Street Food Scrap Drop-off", "W 181st St & Fort Washington Ave, New York, NY 10033", "GrowNYC", "Year Round", "Thursdays (Start Time: 8:00 AM - End Time:  12:30 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["Queens County Farm Museum", "73-50 Little Neck Parkway, Queens, NY 11004", "Staff at Queens County Farm Museum", "Year Round", "Every day (Check Calendar of Events at queensfarm.org for dates when admission is charged* (and compost site is not accessible without a ticket). (Start Time: 10:00 AM - End Time:  4:00 PM)", "*Farm-wide admission is charged for weekend events on 10-12 days each calendar year. Also, stop by the Farm Store to find a map for the location of tumblers for drop-off. Not accepted: meat, bones, or dairy", "http://queensfarm.org/"],
  ["SE Field Place & Morris Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SmartComposting: Broadway & Park Place", "Broadway and Park Place (Northwest corner)", "Alliance for Downtown New York", "Year Round", "24/7", "Scan QR code on the bin to drop-off! Accepts all types of food scraps, including meat & dairy.", "https://downtownny.com/compost/"],
  ["NW 29th Street & 31st Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW 31st Avenue & 35th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE West 151 Street & Macombs Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Tompkins Avenue & Myrtle Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Prospect Heights Food Scrap Drop-off", "Park Place & Carlton Ave", "GrowNYC", "Year Round", "Thursdays (Start Time: 8:00 AM - End Time:  11:00 AM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NE East 176th Street & Washington Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Corona", "Roosevelt Ave at 103 Street, Queens", "GrowNYC", "Year Round", "Fridays (Start Time: 8:00 AM - End Time:  1:30 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["EL Garden", "120 Jefferson St, Brooklyn, NY 11206", "EL Garden", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "https://www.facebook.com/elgardenbushwickpage/"],
  ["East New York Farms: Poppa & Momma Jones Historical Garden", "337 Van Siclen Ave, Brooklyn, NY 11207", "East New York Farms", "March - November", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "ucceny.org/enyf-old/compost/"],
  ["Forest Hills Greenmarket", "MacDonald Park: Queens Blvd and 70th Ave", "GrowNYC and the Forest Hills Green Team", "Year Round", "Sundays (Start Time: 9:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["Transmitter Park Drop-Off", "2 Greenpoint Ave and West Street", "North Brooklyn Compost Project", "Year Round", "Sundays (Start Time: 11:30 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "nbkcompost.org"],
  ["NE Knickerbocker Avenue & Halsey Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["St. Vartan Park", "Near the 1st Ave. & E 36th St. entrance", "Alliance for Kips Bay with PS281 Green Team and PS116 PTA", "Year Round", "Saturdays (Start Time: 10:00 AM - End Time:  4:00 PM)", "Not accepted: meat, bones, or dairy", "bit.ly/StVartanCompost"],
  ["NW Loring Place North & Hall of Fame Terrace", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Classon Avenue & Park Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW East 109th Street & 2nd Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["McIntosh Neighborhood Association", "25-16 McIntosh St, East Elmhurst, NY, 11369", "-", "April - November", "Every 3rd Saturday of the month (Start Time: 10:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "https://bqlt.org/garden/mcintosh-neighborhood-garden"],
  ["Hudson River Park's Pier 51 at Horatio St.", "Pier 51 at Horatio St. near playground", "Staff at Hudson River Park", "Year Round", "Every day (Start Time: 7:00 AM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://hudsonriverpark.org/the-park/sustainability/community-compost-program/"],
  ["SE West Tremont Avenue & University Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Pleasant Village Community Garden", "o	Along gates on the southside of 119th Street between Pleasant Avenue and FDR Drive", "Pleasant Village Community Garden", "Year Round", "Every day (Start Time: Dawn - End Time:  Dusk)", "Not accepted: meat, bones, or dairy", "http://facebook.com/pleasantvillagecommunitygarden"],
  ["NE Taylor Avenue & Archer Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Washington Avenue & St. Johns Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Wilson Ave Food Scrap Drop-off", "Wilson Ave & Moffat St (near L train)", "GrowNYC", "Year Round", "Thursdays (Start Time: 9:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["SW Pugsley Avenue & Watson Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW New York Avenue & Dean Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Knickerbocker Avenue & Linden Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["East New York Farms: Success Community Garden", "461 Williams Avenue", "East New York Farms", "Year Round", "Mondays, Wednesday, and Sundays (Start Time: Monday 10-12:30pm Tuesday 10-3pm - End Time:  )", "Not accepted: meat, bones, or dairy", "-"],
  ["Abib Newborn Learning Garden", "495 Osborn St, Brooklyn, NY 11212", "Volunteers at Abib Newborn Learning Garden", "Year Round", "Monday, Wednesday, Fridays (Start Time: 10:00 AM - End Time:  6:00 PM)", "Not accepted: meat, bones, or dairy", "https://cityparksfoundation.org/learning-gardens/"],
  ["Little Haiti Food Scrap Drop-off Site", "Newkirk Ave & Nostrand Ave", "GrowNYC", "Year Round", "Wednesdays (Start Time: 9:30 AM - End Time:  1:30 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NW Amsterdam Avenue & West 165th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Bedford Avenue & Clifton Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Smiling Hogshead Ranch", "Pearson Pl & Skillman Ave, Queens, NY 11101", "Volunteers at Smiling Hogshead Ranch", "Year Round", "Every day (Start Time: Dawn - End Time:  Dusk)", "-", "smilinghogsheadranch.org"],
  ["NE St. Nicholas Avenue & Hart Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Fordham Plaza Food Scrap Drop-off", "E Fordham Rd between Webster Ave & Third Ave", "GrowNYC", "Year Round", "Fridays (Start Time: 8:00 AM - End Time:  11:30 AM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["Bay Parkway at 86th Street", "Near NE corner of Bay Parkway and 86th Street (Off Bay Parkway D Subways station between 85th and 86th Streets)", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Tuesdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["SE Pleasant Avenue & East 116th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["New Settlement- 170 Farm Stand", "New Settlement Community Center 1501 Jerome Ave.", "New Settlement- 170 Farm Stand", "July 14th-November 24th", "Wednesdays (Start Time: 2:30 PM - End Time:  5:00 PM)", "Not accepted: meat, bones, or dairy", "http://www.newsettlementcommunitycenter.org/"],
  ["Frank White Memorial Garden", "506 West 143rd Street, New York, NY 10031", "Brotherhood/Sister Sol", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Garden staff will be available for questions or concerns from 10am-6pm. \nNot accepted: meat, bones, or dairy", "www.brotherhood-sistersol.org"],
  ["Grace Foundation", "460w Brielle Avenue", "Grace Foundation", "Year Round", "Mondays (Start Time: 9:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "graceofny.org"],
  ["Q Gardens", "58 E 18th St, Brooklyn, NY 11226", "Q Gardens", "Year Round", "Tuesdays, Fridays, Saturdays, and Sundays (Start Time: Tuesday 6pm; Friday - Sunday dawn - End Time:  Tuesday 8pm; Fridays + Saturdays all night; Sundays until 4:00PM)", "Not accepted: meat, bones, or dairy", "https://qgardenscf.com/places-to-drop-off-your-compost/"],
  ["*CLOSED FOR THE SEASON*\nMalcolm X FSDO", "111-26 Northern Blvd, Flushing, NY 11368", "NYC Compost Project Hosted by Big Reuse", "Spring - Fall", "Tuesdays (Start Time: 12:00 PM - End Time:  2:00 PM)", "-", "-"],
  ["SE Rochester Avenue & St. Johns Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Knickerbocker Avenue & Palmetto Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE West 136th Street & Edgecombe Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Christ Church Community Compost", "326 Clinton Street", "Volunteers at Christ Church", "Year Round", "Sundays & Wednesdays (Start Time: Sundays at 9 am; Wednesdays at 7 pm - End Time:  Sundays at 10 am; Wednesdays at 8 pm)", "Not accepted: meat, bones, or dairy", "www.christchurchcobblehill.net"],
  ["SW Irving Avenue & Schaefer Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Kingston Avenue & Park Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Francis Martin Library", "2150 University Avenue Bronx, NY 10453", "-", "Year Round", "Wednesday (Start Time: 12:00 PM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.nypl.org/locations/francis-martin"],
  ["Tompkins Square Greenmarket", "E 7th St & Avenue A, New York, NY 10009", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Sundays (Start Time: 8:00 AM - End Time:  5:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["NE Bushwick Avenue & Suydam Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Lewis Avenue & Bainbridge Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["St. Mary's Harlem", "521 W 126th St, New York, NY 10027", "GrowNYC", "Year Round", "Fridays (Start Time: 8:30 AM - End Time:  12:30 PM)", "Not accepted: meat, bones, or dairy", "stmarysharlem.org"],
  ["S/E Corner of Cabrini Blvd and 187th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "http://www.nyc.gov/smartcomposting"],
  ["Domino Park", "15 River Street Brooklyn, NY 11249", "Staff at Domino Park", "Year Round", "Mondays and Thursdays (Start Time: Mondays, 10:00 AM; Thursdays, 6:00 PM - End Time:  Mondays, 12:00 PM, Thursdays, 8:00 PM)", "Not accepted: meat, bones, or dairy", "http://www.dominopark.com/"],
  ["Edgemere Farm", "385 Beach 45th St, Far Rockaway, NY 11691", "Volunteers at Edgemere Farm", "Year Round", "Wednesdays, Thursdays, Fridays, and Saturdays (Start Time: 10:00 AM - End Time:  Wednesday-Friday at 5:00PM; Saturdays at 3:00PM)", "Not accepted: meat, bones, or dairy", "http://www.edgemerefarm.org/"],
  ["Pleasant Plains", "Bloomingdale Rd and Drumgoole Road East", "Snug Harbor Youth", "Year Round", "Mondays (Start Time: 12:00 PM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://snug-harbor.org/"],
  ["SW 21st Street & 30th Drive", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Imani Community Garden", "87-91 Schenectady Ave, Brooklyn, NY 11213", "Imani Community Garden", "Year Round", "Wednesdays and Saturdays (Start Time: Saturdays 11:00AM; Wednesdays 8:00AM - End Time:  Saturdays 1:00PM; Wednesdays 10:00AM)", "Not accepted: meat, bones, or dairy", "https://www.facebook.com/Imani-Garden-168006109999475/"],
  ["SE Amsterdam Avenue & W 113 Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["The Connected Chef", "49-09 5th Street and 49th Avenue", "The Connected Chef", "Year Round", "Fridays and Saturdays (Start Time: Fridays-8:30AM/Saturdays-9AM - End Time:  Fridays-3:30PM/Saturdays-2PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["NW Broadway & 51st Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Rogers Avenue & Prospect Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Phoenix Community Garden", "36 Somers Street, Brooklyn, NY 11233", "Phoenix Community Garden", "March - November", "Saturdays (Start Time: 11:00 AM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.phoenixcommunitygarden.org/"],
  ["*CLOSED FOR THE SEASON*\nLincoln Hospital Greenmarket", "149th St between Park Ave and Morris Ave", "GrowNYC", "Spring - November 19", "Fridays (Start Time: 8:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NE Layton Avenue & Jersey Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Seward Avenue & Croes Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW 8th Street & 27th Ave", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Paradise Garden", "107-31 Inwood St, Queens, NY 11435", "Paradise Garden", "July-December", "Fridays (Start Time: 12:00 PM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["NE Bushwick Avenue & Halsey Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Battery Park City Authority Rockefeller Park", "Lower level downstairs at corner of Chambers St and River Terrace", "Battery Park City Authority", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "https://bpca.ny.gov/nature-and-sustainability/sustainability/"],
  ["New Roots Community Farm", "670 Grand Concourse, The Bronx, NY 10451", "GrowNYC", "Year Round", "Fridays (Start Time: 8:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["St. James Compost", "86-02 Broadway, Elmhurst, NY 11373", "Volunteers at St. James Compost", "Year Round", "Every day (Start Time: 9:00 AM - End Time:  6:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/stjamescompost/"],
  ["Moore-Jackson Cemetery/Garden", "51st Street between 31st and 32nd Avenue, Woodside, NY 11377", "Members at Moore-Jackson Garden", "Year Round", "Saturdays (Start Time: 9:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.facebook.com/MooreJacksonNYC/"],
  ["Corlears Hook Park", "397 FDR Dr, New York, NY 10002 (Southeast corner of Cherry Street and Jackson Street)", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Thursdays (Start Time: 9:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["*CLOSED FOR THE SEASON*\nJH Scraps", "35-20 69th Street, Jackson Heights, NY 11372", "Volunteers at JH Scraps", "Seasonal", "Saturdays (Start Time: 11:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.jhbg.org/2020/07/28/jh-scraps-reopens"],
  ["SW St. Nicholas Avenue & West 118 Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE Bushwick Avenue & Chauncey Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Howard Avenue & Marion Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["6th Ave & Spring St", "6th Avenue & Spring Street -NE Corner", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Wednesdays (Start Time: 9:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["Leif Ericson Park Food Scrap Drop-off Site", "Fort Hamilton Pkwy b/t 66 & 67 Streets", "GrowNYC", "Year Round", "Wednesdays 8:30 AM - 12:30 PM", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["SW Throop Avenue & Halsey Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Maggie's Magic Garden", "1574 Lexington Ave, New York, NY 10029", "Maggie's Magic Garden", "Year Round", "Every day (Start Time: Dawn - End Time:  Dusk)", "Not accepted: meat, bones, or dairy", "-"],
  ["NW Sheridan Avenue & Marcy Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Bedford Avenue & Herkimer Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Lehman College", "Gate 8: Bedford Park Blvd West & Paul Ave Bronx, NY 10468", "Volunteers at Lehman College", "Year Round", "Mondays (Start Time: 9:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "http://www.lehman.cuny.edu/"],
  ["NW Rogers Avenue & Sterling Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Maple Parkway & Walloon Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["New Beginnings Community Garden", "2502 Davidson Ave", "New Beginnings Community Garden", "Year Round", "Fridays, Saturdays, and Sundays (Start Time: Sat+Sun:2PM, Friday:5pm - End Time:  Sat.+Sun.:5pm, Friday:6pm)", "Not accepted: meat, bones, or dairy", "@new.beginnings.garden"],
  ["SE 33rd Street & 31st Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Schenectady Avenue & Lincoln Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Morrisania", "McKinley Square at 169th St & Boston Rd", "GrowNYC", "Year Round", "Wednesdays (Start Time: 10:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["Brooklyn Hope Church", "120 16th Street, Brooklyn, New York 11215", "Brooklyn Hope Church", "Year Round", "Sundays (Start Time: 12 pm - End Time:  2 pm)", "Accepts meat, bones, and dairy", "Brooklynhope.org"],
  ["SE 31st Avenue & 14th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Heath Avenue & West Kingsbridge Road", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Hudson River Park Pier 66 at W 26 St", "Pier 66 at W 26 St", "Staff at Hudson River Park", "Year Round", "Every day (Start Time: 7:00 AM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://hudsonriverpark.org/the-park/sustainability/community-compost-program/"],
  ["NW Irving Avenue & Weirfield Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Howard Avenue & Macdonough Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SmartComposting: Maiden Lane & Pearl Street", "Maiden Lane and Pearl Streets (Northwest corner)", "Alliance for Downtown New York", "Year Round", "24/7", "Scan QR code on the bin to drop-off! Accepts all types of food scraps, including meat & dairy.", "https://downtownny.com/compost/"],
  ["SE Sickles Street & Nagle Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Zerega Avenue & Waterbury Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE West 166th St & Dr. Martin Luther King Jr Boulevard", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Malcolm X Boulevard & Lafayette Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Knickerbocker Avenue & Starr Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE 31st Avenue & 49th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SmartComposting: Bowling Green (South)", "Bowling Green (inside south entrance)", "Alliance for Downtown New York", "Year Round", "6 am ? 7:30, or when park gates are open", "Scan QR code on the bin to drop-off! Accepts all types of food scraps, including meat & dairy.", "https://downtownny.com/compost/"],
  ["La Familia Verde Farmer's Market", "Tremont Ave between LaFontaine and Arthur Ave (Tremont Park)", "Volunteers at La Familia Verde Farmers Market", "July- November 16 2021", "Tuesdays (Start Time: 8:00 AM - End Time:  2:00 PM)", "Visit the Center Farm stand to drop off your food scraps. \nNot accepted: meat, bones, or dairy", "http://www.lafamiliaverde.org/"],
  ["NW Central Avenue & Hancock Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE Classon Avenue & Eastern Parkway", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Tucker Square Thursday Greenmarket", "66th St and Columbus Ave.", "GrowNYC", "Year Round", "Thursdays (Start Time: 8:00 AM - End Time:  11:00 AM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["SE 31st Avenue & 29th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Victory Blvd & Slosson Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW 	Throgs Neck Expressway & Randall Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["New Roots Community Garden, Queens", "Adjacent to 41-38 69th Street and Woodside Avenue", "New Roots Community Garden, Queens", "Year Round", "Tuesday + Thursdays from 6 - 7 pm; Sundays from 12 - 1pm (Start Time: See above - End Time:  See above)", "Not accepted: meat, bones, or dairy", "-"],
  ["Gowanus Salt Lot", "2 2nd Ave, Brooklyn, NY 11215", "NYC Compost Project Hosted by Big Reuse", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "https://www.bigreuse.org/service/compost/"],
  ["SE Purdy Street & East Tremont Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW St. Nicholas Avenue & Stockholm Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Lafayette Avenue & Cross Bronx Expressway", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Malcolm X Boulevard & Gates Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["East New York Farms: St. John Community Garden", "474 New Jersey Ave, Brooklyn, NY 11207", "East New York Farms", "March - November", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "ucceny.org/enyf-old/compost/"],
  ["SW Central Avenue & Noll Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Cypress Hills", "Fulton Street, between Crescent & Hemlock Streets", "GrowNYC", "Year Round", "Fridays (Start Time: 10:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["Wyckoff Farmhouse Museum", "5816 Clarendon Rd, Brooklyn, NY 11203", "Staff at Wychoff Farmhouse Museum", "Year Round (except February)", "Every day (Start Time: Dawn - End Time:  Dusk)", "Not accepted: meat, bones, or dairy", "wyckoffmuseum.org"],
  ["SW Amsterdam Avenue & West 160th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Sunset Park FSDO", "7th Ave & 44th St", "GrowNYC", "Year Round", "Saturdays (Start Time: 8:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NE Bathgate Avenue & East 189th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Nostrand Avenue & Greene Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Underhill Avenue & Bergen Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["58th Street Library Food Scrap Drop-off", "127 E 58th St, New York, NY 10022", "GrowNYC", "Year Round", "Wednesdays (Start Time: 7:30 AM - End Time:  1:30 PM)", "Not accepted: meat, bones, or dairy", "grownyc.gov/compost"],
  ["SE West 123 Street & Amsterdam Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["1100 Bergen Street Community Garden", "1107 Bergen Street, Brooklyn, NY 11216", "Volunteers at 1100 Bergen Street Community Garden", "Year Round", "Sundays (Start Time: 10:00 AM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "https://bqlt.org/garden/1100-block-bergen-st-community-garden"],
  ["Christopher Park", "West 4th Street b/w Christopher St and Grove St., west side of Christopher Park", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Wednesdays (Start Time: 9:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["Howard Garden", "750 Howard Avenue", "Howard Garden", "April - October", "Fridays (Start Time: 9:00 AM - End Time:  10:00 AM)", "Not accepted: meat, bones, or dairy", "-"],
  ["NW 8th Street & Astoria Blvd", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Discovery Community Garden", "108-56 Union Hall St, Jamaica, NY 11433", "NYC Compost Project Hosted by Big Reuse", "Year Round", "Wednesdays (Start Time: 1:00 PM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["King Manor Museum", "150-03 Jamaica Ave, Jamaica, NY 11432", "King Manor Museum", "Year Round", "Fridays and Saturdays (Start Time: Friday 10 AM; Saturday 9:30 - End Time:  Friday 4:00; Saturdays 2:30pm)", "Not accepted: meat, bones, or dairy", "https://www.kingmanor.org/"],
  ["SW East 193rd Street & Grand Concourse", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Audubon Avenue & West 169th St", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Rockaway Parkway", "1425 Rockaway Pkwy", "GrowNYC", "Year Round", "Wednesday (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, dairy", "grownyc.org/compost"],
  ["NE 21st Street & 31st Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Mott Haven Food Scrap Drop-off", "545 East 142nd Street", "GrowNYC", "Year Round", "Wednesdays (Start Time: 9:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NE 31st Avenue & 37th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Carver Community Garden", "242 East 124th", "Carver Community Garden", "Year Round", "Wednesdays (Start Time: 10:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["Staten Island Urban Center", "208 Bay Street", "Staten Island Urban Center", "Year Round", "Saturdays (Start Time: 11:00 AM - End Time:  1:30 PM)", "Not accepted: meat, bones, or dairy", "www.siurbancenter.org"],
  ["SW Vanderbilt Avenue & Dean Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE 35th Avenue & 21st Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Abingdon Square Greenmarket", "W 12th St and 8th Ave", "GrowNYC", "Year Round", "Saturdays (Start Time: 8:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["SW 31st Avenue & 51st Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE Stuyvesant Place & Schuyler Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Genovesi Environmental Study Center", "7151 Avenue T, Brooklyn, NY 11234", "Genovesi Environmental Study Center", "Year Round", "Monday-Friday (Start Time: 9:00 AM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.schools.nyc.gov/learning/student-journey/experiential-learning/genovesi-environmental-study-center"],
  ["NE East 130th Street & 5th Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Rodale Pleasant Park Community Garden", "437 E 114th St, New York, NY 10029", "Rodale Pleasant Park Community Garden", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "To volunteer, email Flosparks0306@gmail.com.\nNot accepted: meat, bones, or dairy", "-"],
  ["Kensington Food Scrap Drop-off", "McDonald Ave & Albemarle Rd", "GrowNYC", "Year Round", "Saturdays (Start Time: 8:30 AM - End Time:  11:30 AM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["*CLOSED FOR THE SEASON*\nBushwick Grows! Community Garden", "1474 Gates Ave, Brooklyn, NY 11237", "Volunteers at Bushwick Grows!", "Seasonal, May-November 28", "Saturdays (Start Time: 10:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "riseboro.org"],
  ["SE East 100th Street & 1st Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE East 183 Street & Cambreleng Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Cabrini Blvd & West 187st Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["*CLOSED FOR THE SEASON*\nFar Rock Urban Agro-Education Center", "45-55 Beach Channel Dr, Far Rockaway, NY, 11691", "-", "July - November", "Tuesdays & Thursdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["NE Schenectady Avenue & Dean Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Venture House", "1442 Castleton Avenue, 10302", "Snug Harbor Youth", "Year Round", "Fridays (Start Time: 10:30 AM - End Time:  2:30 PM)", "Not accepted: meat, bones, or dairy", "snug-harbor.org"],
  ["NW West 141st Street & Fredrick Douglas Blvd", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Kingston Avenue & Eastern Parkway", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Montefiore", "871 Prospect Ave", "GrowNYC", "Year Round", "Fridays (Start Time: 11:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NE Bedford Avenue & Quincy Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["*CLOSED FOR THE SEASON*\nMediator's Composting Initiative", "260 West 231 Street Bronx, NY 10463", "The Earth Ministry of The Church of The Mediator", "Year Round", "Saturdays (Start Time: 10:00 AM - End Time:  12:00 PM)", "Donation: 25 cents per pound. Drop off location is by Bx7, Bx10, BX1 bus stop. Not accepted: meat, bones, or dairy", "https://www.instagram.com/mediator_garden_and_composting/"],
  ["Kings Highway and East 16th Street", "Kings Highway and East 16th Street, northeast corner", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Wednesdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["Hudson River Park's Pier 25 at N. Moore St.", "Pier 25 at N. Moore St. near kid's playground", "Staff at Hudson River Park", "Year Round", "Every day (Start Time: 7:00 AM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://hudsonriverpark.org/the-park/sustainability/community-compost-program/"],
  ["NW Patchen Avenue & Fulton Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["East New York Farms: 400 Montauk Ave Block Association Garden", "956 New Lots Avenue, Brooklyn, NY 11208", "East New York Farms", "Year Round", "Sunday from 11am - 3pm and Mondays from 5:30pm - 6:30pm  (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "ucceny.org/enyf-old/compost/"],
  ["Astoria Pug: Hoyt", "Northwest corner of Hoyt Avenue North and 21st Street, in a courtyard that?s officially called SITTING AREA", "Astoria Pug", "Year Round", "Saturdays (Start Time: 9:00 AM - End Time:  4:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/astoriapug/?hl=en"],
  ["Sure We Can", "219 McKibben Street, Brooklyn, NY 11206", "Sure We Can", "Year Round", "Monday-Saturday (Start Time: 7:00 AM - End Time:  Monday-Friday at 5:00PM; Saturday at 1:00PM)", "Not accepted: meat, bones, or dairy", "http://www.surewecan.org/composting"],
  ["NE Knickerbocker Avenue & Covert Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW 40th Avenue & 21st Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE 32nd Street & 31st Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Kingston Avenue & Dean Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE 31st Avenue & Crescent Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW St. Nicholas Avenue & Himrod Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE West Burnside Avenue & Sedgewick", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Brooklyn Borough Hall Saturday Greenmarket", "Court St. and Montague St.", "GrowNYC", "Year Round", "Saturdays (Start Time: 8:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["Hudson River Park's Pier 76 at W. 34th St.", "Pier 76 at 34th Street and 12th Ave outside of compost yard South of 34th St", "Staff at Hudson River Park", "Year Round", "Every day (Start Time: 7:00 AM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://hudsonriverpark.org/the-park/sustainability/community-compost-program/"],
  ["NW Central Avenue & Stanhope Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Ralph Avenue - Bergen Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE Townsend Avenue & East 174th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Grand Street & Clinton Street", "Grand Street & Clinton Street", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Mondays (Start Time: 9:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["Maggie's Garden", "564 W 149th St", "Maggie's Garden", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "-"],
  ["SW Knickerbocker Avenue & Jefferson Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["*CLOSED FOR THE SEASON*\nStaten Island Mall Greenmarket", "Staten Island Mall, Marsh Ave & Ring Rd, Staten Island, NY 10314", "NYC Compost Project Hosted by Snug Harbor Cultural Center & Botanical Garden", "June 11 - November 19", "Saturdays (Start Time: 8:30 AM - End Time:  12:30 PM)", "Not accepted: meat, bones, or dairy", "snug-harbor.org"],
  ["Maple Street Community Garden", "237 Maple St, Brooklyn, NY 11225", "Maple Street Community Garden", "Year Round", "Wednesdays and Saturdays (Start Time: 10:30 AM - End Time:  12:30 PM)", "Not accepted: meat, bones, or dairy", "www.maplestreetcommunitygarden.com"],
  ["NE Throop Avenue & Madison Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Rossville", "Gladwin St and Pitney Ave", "Snug Harbor Youth", "Year Round", "Mondays (Start Time: 12:00 PM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://snug-harbor.org/"],
  ["NW West 126th Street & Adam Clayton Powell Jr Blvd", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Moffat Street Community Garden", "9 Moffat St, Brooklyn, NY 11207", "Moffat St Community Garden", "Year Round", "Saturdays (Start Time: 10:30 AM - End Time:  12:30 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["SW West 112 Street & Broadway", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Carroll Gardens Greenmarket", "Smith St and 1st Pl", "GrowNYC", "Year Round", "Sundays (Start Time: 8:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["SW East 179th Street & Clinton Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SmartComposting: Rector & Washington Streets", "Rector and Washington Streets (Southeast corner)", "Alliance for Downtown New York", "Year Round", "24/7", "Scan QR code on the bin to drop-off! Accepts all types of food scraps, including meat & dairy.", "https://downtownny.com/compost/"],
  ["NW Vanderbilt Avenue & Plaza Street East", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Bed Stuy Fresh Food Box", "Decatur St and Lewis Ave", "GrowNYC", "Year Round", "Saturdays (Start Time: 11:00 AM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["1st Ave and 1st St", "First Avenue between Houston and First Street (West Side)", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Mondays (Start Time: 9:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["NE Bushwick Avenue & Dekalb Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE Nostrand Avenue & Hancock Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Bronx River House / Starlight Park", "1490 Sheridan Blvd", "Bronx River Alliance", "Year Round", "Fridays (Start Time: 9:00 AM - End Time:  11:00 AM)", "Not accepted: meat, bones, or dairy", "www.bronxriver.org"],
  ["Drew Gardens", "1070 East Tremont Avenue. between Bronx Street and, Boston Rd, The Bronx, NY 10460", "Volunteers at Drew Gardens", "Year Round", "Mondays, Wednesdays, and Fridays (Start Time: 4:00 PM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.facebook.com/drewgardens.educationalrecreational"],
  ["NW Bushwick Avenue & Cornelia Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Rusty Wheelbarrow Farm", "72-2 Woodside Ave, Woodside, NY 11377", "Rusty Volunteers", "Year Round", "Saturdays (Start Time: 10:30 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.bigreuse.org/"],
  ["East New York Farms: Concerned Residents of Barbey Street Community Garden", "351 Barbey St, Brooklyn, NY 11207", "East New York Farms", "March - November", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "ucceny.org/enyf-old/compost/"],
  ["Terraza 7", "40-19 Gleane Street, Elmhurst, NY, 11373", "-", "Year Round", "Sundays (Start Time: 9:30 AM - End Time:  1:30 PM)", "Not accepted: meat, bones, or dairy", "https://terraza7.com/"],
  ["*CLOSED FOR THE SEASON*\nJames Baldwin Outdoor Learning Center", "100 W Mosholu Pkwy S, The Bronx, NY 10468", "Volunteers at James Baldwin Outdoor Learning Center", "Spring - Fall", "Saturdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Site entrance is on the Goulden Ave side of campus.\nNot accepted: meat, bones, or dairy", "https://www.jamesbaldwinoutdoorlearningcenter.org/"],
  ["Astoria Pug: 41st Street", "Ditmars Boulevard and 41st Street", "Astoria Pug", "Year Round", "Mondays (Start Time: 8:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/astoriapug/?hl=en"],
  ["BK Rot", "1309 Dekalb Ave, Brooklyn, NY 11221 (Know Waste Lands Community Garden)", "BK Rot", "Year Round", "Sundays (Start Time: 12:00 PM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "BKrot.org"],
  ["NW Howard Avenue & Herkimer Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Governors Island Compost Learning Center", "758 Enright Rd", "NYC Compost Project Hosted by Earth Matter NY", "May 1- November 1", "Saturdays and Sundays (Start Time: 12:00 PM - End Time:  4:00 PM)", "-", "-"],
  ["The Garden at Preston", "2780 Schurz Ave, The Bronx, NY 10465 (Intersection of Schurz Avenue and Huntington Avenue)", "Northeast Bronx Farmers Market Project", "March- November", "Tuesdays (Start Time: 4:00 PM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.facebook.com/northeastbronxcommunityfarmersmarket/"],
  ["NW Grand Avenue & St. Marks Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Padre Plaza Community Garden", "541 E 139th St, Bronx, NY 10454", "Padre Plaza Community Garden", "Year Round", "Mondays and Wednesdays (Start Time: 12:00 PM - End Time:  5:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["4th Avenue Presbyterian Church", "6753 4th Avenue, Brooklyn, NY 11220", "4th Avenue Presbyterian Church", "Year Round", "Every day (Start Time: Dawn - End Time:  Dusk)", "Not accepted: meat, bones, or dairy", "-"],
  ["SE Eastburn Avenue & East 174th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE Classon Avenue & Bergen Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Bay Parkway at 66th Street", "east of Bay Parkway between 66th Street & West 8th Street", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Tuesdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["NE Taylor Avenue & Lafayette Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Corner Amsterdam Avenue & W 133 Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Gerard Avenue & East 167th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Rogers / Tilden / Veronica Place Garden", "2601 - 2603 Tilden Avenue, Brooklyn 11226", "Rogers / Tilden / Veronica Place Garden", "Year Round", "Saturdays (Start Time: 10:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["NE Amsterdam Avenue & West 155th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW West 112 Street	& 5th Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["*CLOSED FOR THE SEASON*\nIso Student Farm", "514 Rockaway Avenue, Brooklyn, NY 11212", "Volunteers at Isabahlia LOE Foundation", "Seasonal, April-October", "Fridays and Saturdays (Start Time: 9:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.isabahlialoefinc.org/"],
  ["East New York Farms: Nehemiah Ten Community Garden", "565 Barbey St, Brooklyn, NY 11207", "East New York Farms", "Year Round", "Sunday from 9am - 3pm; Monday from 6:30pm - 8pm; Tuesday from 6:30pm - 8pm; Friday from 6:30pm - 8pm; Saturday from 8am - 2pm (Start Time: See above - End Time:  See above)", "Not accepted: meat, bones, or dairy", "ucceny.org/enyf-old/compost/"],
  ["79th St. Greenmarket", "77th Street between Columbus Ave and Central Park West", "GrowNYC", "Year Round", "Sundays (Start Time: 9:00 AM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NW Central Avenue & Linden Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE 27 Avenue & 1 Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["St. Anastasia Roman Catholic Church", "246-02 Northern Blvd; Enter the path to the right of the school yard to the student garden", "St. Anastasia Roman Catholic Church", "Year Round", "Fridays and Saturdays (Start Time: Fridays 8 AM; Saturdays 12 PM - End Time:  Fridays 12 PM; Saturdays 12:30 PM)", "Not accepted: meat, bones, or dairy", "https://www.sta.nyc/"],
  ["SmartComposting: One New York Plaza", "One New York Plaza (Corner of Broad and Water Streets)", "Alliance for Downtown New York", "Year Round", "24/7", "Scan QR code on the bin to drop-off! Accepts all types of food scraps, including meat & dairy.", "https://downtownny.com/compost/"],
  ["Hudson River Park's Pier 40 at W. Houston St.", "Pier 40 at Houston St. near dog park", "Staff at Hudson River Park", "Year Round", "Every day (Start Time: 7:00 AM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://hudsonriverpark.org/the-park/sustainability/community-compost-program/"],
  ["NW Crescent Street & 30th Drive", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Vanderbilt Avenue & Prospect Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE Broadway & Academy Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Mary Mitchell Center", "2007 Mapes Ave, Bronx, NY 10460", "Mary Mitchell Family & Youth Center", "Year Round", "Monday-Friday (Start Time: 9:00 AM - End Time:  5:00 PM)", "Not accepted: meat, bones, or dairy", "http://themarymitchellfyc.org/"],
  ["SW St. Nicholas Avenue & Greene Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Lewis Avenue & Putnam Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Glebe Avenue & Zerega Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Union Square Greenmarket", "E 17th St & Union Square E, New York, NY", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Mondays, Wednesdays, Fridays, and Saturdays (Start Time: 8:00 AM - End Time:  5:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["SE 38th Street & 31st Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Riverdale Neighborhood House", "5521 Mosholu Ave Bronx, NY 10471", "Riverdale Neighborhood House", "Year Round", "Thursdays (Start Time: 1:00 PM - End Time:  6:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.riverdaleonline.org/"],
  ["Avenue U and East 16th Street", "Avenue U and East 16th Street, southeast corner", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Wednesdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["*CLOSED FOR THE SEASON*\nFarm Spot CSA", "33-50 82nd street", "Volunteers at Farm Spot", "June 23-Oct 27", "Thursdays (Start Time: 6:00 PM - End Time:  7:30 PM)", "Not accepted: meat, bones, or dairy", "Farmspot.org"],
  ["SW East 123rd Street & 2nd Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["*CLOSED FOR THE SEASON*\nWest Brighton", "Chappell Street and Henderson Avenue", "Snug Harbor Youth", "Year Round", "Fridays (Start Time: 4:00 PM - End Time:  5:30 PM)", "Not accepted: meat, bones, or dairy", "snug-harbor.org"],
  ["NW East 106th Street & Park Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE East Mosholu Parkway North & Van Cortlandt Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Hudson River Park's Pier 84 at W. 44th St.", "Pier 84 at W. 44th St. near dog park", "Staff at Hudson River Park", "Year Round", "Every day (Start Time: 7:00 AM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://hudsonriverpark.org/the-park/sustainability/community-compost-program/"],
  ["NW Central Avenue & Covert Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Howard Avenue & Putnam Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW New York Avenue & Lincoln Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE West 174th Street & Fort Washington Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Astoria Pug: Broadway", "32-11 31st St, Queens, NY 11106", "Astoria Pug", "Year Round", "Saturdays (Start Time: 9:00 AM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/astoriapug/?hl=en"],
  ["SE Bedford Avenue & Willoughby Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["PS 90 Coney Island", "2840 W 12th Street, Brooklyn, NY 11224", "PS 90 Coney Island", "Year Round", "Wednesdays (Start Time: 7:30 AM - End Time:  10:30 AM)", "Not accepted: meat, bones, or dairy", "-"],
  ["Woodside Sunnyside Composting", "38-63-38-1 50th St, Woodside, NY 11377", "Volunteers at Woodside Sunnyside Composting", "Year Round", "Sundays (Start Time: 2:00 PM - End Time:  5:00 PM (Spring, Summer))", "Not accepted: meat, bones, or dairy", "https://www.woodsidesunnysidecomposting.org/"],
  ["Roosevelt Island Farmers Market", "543 Main St, New York, NY 10044", "Haki Compost Collective", "Year Round", "Saturdays (Start Time: 9:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/hakicompost/"],
  ["SW 24th Street & 34th Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Astoria Pug: Ditmars", "Ditmars #1 Municipal Parking Field 22-18 33rd Street", "Astoria Pug", "Year Round", "Saturdays (Start Time: 9:00 AM - End Time:  3:45 PM)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/astoriapug/?hl=en"],
  ["SE Throop Avenue & Hart Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW West 132 Street & Adam Clayton Powell Jr Blvd", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Hill Street & Tompkins Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Big Reuse Warehouse", "1 12th St, Brooklyn NY 11215", "NYC Compost Project Hosted by Big Reuse", "Year Round", "Every Day (Start Time: 10:00 AM - End Time:  6:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.bigreuse.org/service/compost/"],
  ["Governors Island Soissons Ferry Landing", "Adjacent to Soissons Landing and Taco Vista", "NYC Compost Project Hosted by Earth Matter NY", "Year Round", "Whenever the Island is open to the public  (check ferry schedule) (Start Time: Check ferry schedule - End Time:  Check ferry schedule)", "-", "www.earthmatter.org"],
  ["SW Jarvis Avenue & Roberts Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Patchen Avenue & Hancock Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SmartComposting: John & Williams Streets", "John and William Streets (Northwest corner)", "Alliance for Downtown New York", "Year Round", "24/7", "Scan QR code on the bin to drop-off! Accepts all types of food scraps, including meat & dairy.", "https://downtownny.com/compost/"],
  ["East 4th Street Community Garden", "173 E 4th St, Brooklyn, NY 11218", "Members at East 4th Street Community Garden", "April - October", "Wednesdays and Saturdays (Start Time: Wednesdays 4:30 PM, Saturdays 9 AM & Sundays 10 AM - End Time:  Wednesdays 6:30 PM, Saturdays 1 PM, Sundays 2 PM)", "Not accepted: meat, bones, or dairy", "https://eastfourthstreetgarden.tumblr.com/"],
  ["Brewer Food Scrap Drop-off Site", "Guy R Brewer Blvd and Baisley Blvd. (Corner Near Walgreens)", "NYC Compost Project Hosted by Big Reuse", "Year Round", "Wednesdays (Start Time: 10:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["NW Malcolm X Boulevard & Bainbridge Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Keepers House Edible Garden", "3400 Reservoir Oval East", "Friends of Mosholu Parkland", "Year Round", "Every day (Start Time: 9:00 AM - End Time:  8:00 PM)", "Not accepted: meat, bones, or dairy", "www.mpcbronx.org"],
  ["NW Innis Street & St Josephs Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Astoria Pug: Hunter's Point", "46th Avenue and 5th Street", "Astoria Pug", "Year Round", "Tuesdays (Start Time: 9:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/astoriapug/?hl=en"],
  ["NE 35th Avenue & 12th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Underhill Avenue & Eastern Parkway", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Nostrand Avenue & Putnam Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW West 133 Street	& Broadway", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Spuyten Duyvil PreSchool", "3041 Kingsbridge Avenue", "Spuyten Duyvil PreSchool", "September - June", "Fridays (Start Time: 8:00 AM - End Time:  12:00 PM)", "Remove all plastic, stickers and zip ties before dropping off food scraps.\nNot accepted: meat, bones, or dairy", "www.spuytenduyvilpreschool.org"],
  ["Glendale Community Garden", "74-10 88th St, Glendale, NY 11385", "Volunteers at Glendale Community Garden", "Year Round", "Fridays and Saturdays (Start Time: 11:00 AM - End Time:  4:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["Kelly Street Garden", "924 Kelly St, The Bronx, NY 10459", "Volunteers at Kelly Street Garden", "Year Round", "Saturdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.facebook.com/kellyst.garden/"],
  ["Tribeca Greenmarket", "Greenwich St. & Duane St", "GrowNYC", "Year Round", "Saturdays (Start Time: 8:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["New Settlement Community Center", "1501 Jerome Ave, Bronx, NY 10452", "New Settlement's Community Food Action", "Year Round", "Thursday, Friday, Saturday (Start Time: Thursday/Friday 1:00 PM, Saturday 10:30 AM - End Time:  Thursday/Friday 5:00 PM, Saturday 12:30 PM)", "Not accepted: meat, bones, or dairy", "NewSettlement.org/food"],
  ["SW West 147th Street & Amsterdam Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Bushwick Avenue & Jefferson Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["East Broadway & Rutgers Street", "East side of Rutgers St b/w East Broadway & Canal St, on the west side of Straus Sq", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Thursdays (Start Time: 9:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["NE Knickerbocker Avenue & Cooper Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW East 183rd Street & Washington Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Mount Hope Place & Walton Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Central Avenue & Troutman Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Nurture BK", "Prospect Park, West of the entrance on Parkside Av (& Ocean Av)", "Nurture BK", "Year Round", "Sundays (Start Time: 9:00 AM - End Time:  11:00 AM)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/nurturebk_compost/"],
  ["SW Tompkins Avenue & Quincy Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Arden Heights", "Arden Avenue and Forest Green", "Snug Harbor Youth", "Year Round", "Saturdays (Start Time: 1:00 PM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://snug-harbor.org/"],
  ["SW West 114th Street & Amsterdam Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Compost Demonstration Site at Snug Harbor Cultural Center & Botanical Garden", "Compost Demonstration Site at Snug Harbor Cultural Center & Botanical Garden 1000 Richmond Terrace", "NYC Compost Project Hosted by Snug Harbor Cultural Center & Botanical Garden", "Year Round", "Every Day (Start Time: Dawn - End Time:  Dusk)", "Not accepted: meat, bones, or dairy", "www.snug-harbor.org"],
  ["NE Wadsworth Avenue & West 182nd Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Queens Plaza North & 21st Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Farm To People", "1100 Flushing Ave, Brooklyn, NY 11237", "Farm to People", "Year Round", "Sundays and Mondays (Start Time: Sunday: 9AM, Monday: 1PM - End Time:  Sunday: 1PM, Monday:7PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["NE Schenectady Avenue & Prospect Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE 31st Street & 31st Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Kew Gardens Cinemas Park", "8105 Lefferts Blvd, Kew Gardens, NY 11415", "Kew Gardens CSA, sponsored by Kew Gardens Cinemas", "Year Round", "Sundays (Start Time: 8:30 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "kewgardenscsa.org"],
  ["NW Central Avenue & Green Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Franklin Avenue & Lincoln Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Crescent Street & 31st Road", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Parkchester", "Westchester Ave and White Plains Rd.", "GrowNYC", "Year Round", "Fridays (Start Time: 8:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["10th Avenue and 43rd Street", "Southeast corner of 10th Avenue and 43rd Street, New York, 10036", "LES Ecology Center", "Year Round", "Tuesdays (Start Time: 9 AM - End Time:  12 PM)", "Not accepted: meat, bones, or dairy", "www.lesecologycenter.org"],
  ["NE Richmond Terrace & Ferry Terminal Viaduct", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["*CLOSED FOR THE SEASON*\nManor Heights", "Woodward Ave and Woolley Ave, 10314", "Snug Harbor Youth", "Year Round", "Thursdays (Start Time: 4:00 PM - End Time:  5:30 PM)", "Not accepted: meat, bones, or dairy", "snug-harbor.org"],
  ["SE Marion Avenue & East 187th Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW St. Nicholas Avenue & Willoughby Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW East 118th Street & 1 Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Commonpoint Queens in partnership with The Forest Hills Green Team", "NE corner of 67 Rd & 108th Street 67-09 108th St, Forest Hills, NY 11375", "Forest Hills Green Team", "Year Round", "Sundays (Start Time: 10:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "commonpointqueens.org"],
  ["Albemarle Road and McDonald Avenue", "southwest corner of McDonald Avenue and Albemarle Road, near Church Avenue F subway entrance", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Tuesdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["NE Rochester Avenue & Bergen Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Target Bronx Community Garden", "1024 Woodycrest Avenue", "Target Bronx Community Garden", "Year Round", "Mondays (Start Time: 10:00 AM - End Time:  5:00 PM)", "Bins at gate during winter months.\nNot accepted: meat, bones, or dairy", "www.targetbronxcommunitygarden.org"],
  ["Crown Heights", "Nostrand Ave & Crown St", "GrowNYC", "Year Round", "Fridays (Start Time: 9:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NW West 114 Street & Adam Clayton Powell Jr Blvd", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Daly Avenue & Elsmere Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SmartComposting: Zuccotti Park", "Zuccotti Park (East side)", "Alliance for Downtown New York", "Year Round", "24/7", "Scan QR code on the bin to drop-off! Accepts all types of food scraps, including meat & dairy.", "https://downtownny.com/compost/"],
  ["Fort Greene Greenmarket", "Washington Park and Myrtle Ave", "GrowNYC", "Year Round", "Saturdays (Start Time: 9:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NE Kingston Avenue & St. Johns Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["McCarren Park Greenmarket", "N 12th St and Driggs Ave", "GrowNYC", "Year Round", "Saturdays (Start Time: 8:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NE Knickerbocker Avenue & Putnam Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE East 120 Street & Madison Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Norwood", "E Gun Hill Road and Dekalb Ave. (SE corner)", "GrowNYC", "Year Round", "Thursdays (Start Time: 9:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NE Convent Avenue & W 130 Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW West 138th Street & Amsterdam Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE Bedford Avenue & Madison Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Farmers Garden", "1899 Bergen Street", "Volunteers at Farmers Garden", "Seasonal", "Thursdays, Saturdays, and Sundays (Start Time: TH 1PM, SAT&SUN 11AM - End Time:  TH 4PM, SAT & SUN 3PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["NE Rogers Avenue & Dean Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["College Point FSDO", "College Point Blvd & 14th Ave", "Coastal Preservation Network", "Year Round", "Fridays (Start Time: 8:30 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "www.coastalpreservation.org"],
  ["PS 17 Wellness Council & Q300 Green Team", "28-37 29th Street, Queens, NY, 11102", "Volunteers at PS17", "September - June", "Fridays (Start Time: 2:00 PM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.ps17queens.com/"],
  ["Inwood Greenmarket", "Seaman Ave and Isham St (N corner)", "GrowNYC", "Year Round", "Saturdays (Start Time: 8:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NW Bainbridge Avenue & East Mosholu Parkway S", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Garden of Resilience", "179-18 145th Dr, Jamaica, NY 11434", "Volunteers at Garden of Resilience", "Year Round", "Saturdays (Start Time: 9:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "http://www.laurelton.nyc/resilience"],
  ["Brighton Beach Avenue at Coney Island Avenue", "South of Brighton Beach Avenue, between Coney Island Avenue and Brighton 11th Street", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Wednesdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["NW Albany Avenue & Bergen Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW 31st Street & Broadway", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Campbell Avenue & Henderson Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Hudson River Park's 14th Street Park at 10th Ave.", "14th Street Park at southwest corner of 15th St. and 10th Ave", "Staff at Hudson River Park", "Year Round", "Every day (Start Time: 7:00 AM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://hudsonriverpark.org/the-park/sustainability/community-compost-program/"],
  ["Vinegar Hill Community Garden", "199 York St, Brooklyn, NY 11201", "Members of Vinegar Hill Community Garden", "Year Round", "Sundays (Start Time: 12:30 PM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://groundcycle.org/"],
  ["NE Flatbush Avenue & Prospect Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Columbia Sunday Greenmarket", "Broadway between 114th St. and 115th St.", "GrowNYC", "Year Round", "Sundays (Start Time: 8:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["SW Bathgate Avenue & East 182 Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Tompkins Avenue & Putnam Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Central Avenue & Hart Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["East New York Farms: Ashford Learning Garden", "341 Ashford St, Brooklyn, NY 11207", "East New York Farms", "March - November", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "ucceny.org/enyf-old/compost/"],
  ["East New York Farms: UCC Youth Farm", "613 New Lots Avenue", "East New York Farms", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "https://ucceny.org/enyf/"],
  ["South Beach", "21 Robin Road, Staten Island NY", "Snug Harbor Youth", "Year Round", "Friday (Start Time: 1:30 PM - End Time:  4:30 PM)", "-", "snug-harbor.org"],
  ["NE East 127th Street & Lexington Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Parkview Avenue & Middletown Road", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NE White Plains Road & Randall Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Malcolm X Boulevard & Putnam Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Morris-Jumel Community Garden", "457 West 162nd Street", "Morris-Jumel Community Garden compost volunteers", "Year Round", "Saturdays and Sundays (Start Time: 12 PM - End Time:  5 PM)", "Please bring your food scraps to the compost bin at the back of the garden whenever the garden gate is open. We will have brown bins out on the sidewalk on other days and times when we have cap.\nNot accepted: meat, bones, or dairy.", "-"],
  ["Prospect Farm", "1194 Prospect Ave, Brooklyn, NY 11218", "Prospect Farm", "Year Round", "Wednesdays and Saturdays (Start Time: Wednesdays at 5 PM; Saturdays at 11:00:00 AM - End Time:  Wednesdays at 6 PM; Saturdays at 12:00:00 PM)", "Not accepted: meat, bones, or dairy", "https://prospectfarm.org/composting/"],
  ["NW Central Avenue & Madison Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Astoria Pug: Steinway", "38-12 30th Ave, Queens, NY 11103", "Astoria Pug", "Year Round", "Saturdays (Start Time: 9:00 AM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.instagram.com/astoriapug/?hl=en"],
  ["SE West 118 Street & Lenox Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Battery Park City Authority Headquarters", "75 Battery Place", "Battery Park City Authority", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "https://bpca.ny.gov/nature-and-sustainability/sustainability/"],
  ["Walt L Shamel Community Garden", "1097 Dean St, Brooklyn, NY 11216", "Volunteers at Walt L Shamel Community Garden", "End of March - January 30", "Saturdays and Sundays (Start Time: 12:00 PM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.facebook.com/WaltLShamelCommunityGarden/"],
  ["NE Bushwick Avenue & Vanderveer Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SE East 112th Street & Park Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Hudson River Park Pier 96 Boathouse at W 55 St", "Park Pier 96 Boathouse at W 55 St", "Staff at Hudson River Park", "Year Round", "Every day (Start Time: 7:00 AM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://hudsonriverpark.org/the-park/sustainability/community-compost-program/"],
  ["NE Franklin Avenue & Prospect Place", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Governors Island Zero Waste Stations", "Several locations throughout Governors Island", "NYC Compost Project Hosted by Earth Matter NY", "Year Round", "Whenever the Island is open to the public  (check ferry schedule) (Start Time: Check ferry schedule - End Time:  Check ferry schedule)", "-", "-"],
  ["NW Lewis Avenue & Hart Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Hudson River Park Pier 46 at Charles St", "Pier 46 at Charles St", "Staff at Hudson River Park", "Year Round", "Every day (Start Time: 7:00 AM - End Time:  7:00 PM)", "Not accepted: meat, bones, or dairy", "https://hudsonriverpark.org/the-park/sustainability/community-compost-program/"],
  ["97th Street Greenmarket", "W 97th St and Amsterdam Ave", "GrowNYC", "Year Round", "Fridays (Start Time: 8:00 AM - End Time:  12:30 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["SW Beach Avenue & East 172nd Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Avenue X at West Street", "SW corner of Avenue X and West Street, in front of Rite Aide, across from P.S.216", "NYC Compost Project Hosted by LES Ecology Center", "Year Round", "Wednesdays (Start Time: 10:00 AM - End Time:  2:00 PM)", "Not accepted: meat, bones, or dairy", "https://www.lesecologycenter.org/programs/compost/compost-drop-off-locations/"],
  ["Grymes Hill Wagner College", "1 Campus Rd, Staten Island, NY 10301", "Wagner College", "September-June", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "wagner.edu"],
  ["SE Crescent Street & 30th Drive", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Asphalt Green Food Scrap Drop-off", "East 91st St & York Ave", "GrowNYC", "Year Round", "Sundays (Start Time: 7:30 AM - End Time:  12:30 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["Sunnyside Greenmarket", "Skillman Ave between 42nd St. and 43rd St.", "GrowNYC", "Year Round", "Saturdays (Start Time: 8:00 AM - End Time:  12:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["East Elmhurst Community School", "26-25 97th St, Queens, NY 11369", "East Elmhurst Community School", "Year Round", "Wednesdays (Start Time: 1:00 PM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["Commuter Composting at 21 St-Queensbridge F", "NW Corner of 21st street at 41st Ave", "NYC Compost Project Hosted by Big Reuse", "Year Round", "Tuesdays (Start Time: 8:00 AM - End Time:  10:00 AM)", "Not accepted: meat, bones, or dairy", "-"],
  ["Friends of Brook Park Community Garden", "494 E 141st St, The Bronx, NY 10454", "Volunteers at Friends of Brook Park Community Garden", "Year Round", "Saturdays and Sundays (Start Time: 10:00 AM - End Time:  4:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["134th Street Farm", "118 W 134th St", "Harlem Grown", "Year Round", "24/7 (Start Time: 24/7 - End Time:  24/7)", "Not accepted: meat, bones, or dairy", "www.harlemgrown.org/volunteer"],
  ["Grand Army Plaza Greenmarket", "Flatbush Ave & Prospect Park W (Prospect Park entrance)", "GrowNYC", "Year Round", "Saturdays (Start Time: 8:00 AM - End Time:  3:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NE Bushwick Avenue & Palmetto Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW St. Nicholas Avenue & Menahan Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW West 212th Street & 10th Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["BronxWorks Carolyn McLaughlin Community Center", "1130 Grand Concourse", "GrowNYC", "Year Round", "Thursdays (Start Time: 10:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["SW Albany Avenue & Herkimer Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["SW Patchen Avenue & Macdonough Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Albert Einstein College of Medicine (AECOM) Garden Club", "Near 1975 Eastchester Road", "Volunteers at Einstein Community Garden", "Year Round", "Wednesdays (Start Time: 4:00 PM - End Time:  5:00 PM)", "Not accepted: meat, bones, or dairy", "-"],
  ["SmartComposting: Cedar & William Streets", "Cedar and William Streets (Northeast corner)", "Alliance for Downtown New York", "Year Round", "24/7", "Scan QR code on the bin to drop-off! Accepts all types of food scraps, including meat & dairy.", "https://downtownny.com/compost/"],
  ["Madison Square Park Food Scrap Drop-off", "Madison Ave & East 25th Street", "GrowNYC", "Year Round", "Wednesdays (Start Time: 8:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NW Knickerbocker Avenue & Hancock Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Bensonhurst", "18th Ave btwn 81st & 82nd Streets", "GrowNYC", "Year Round", "Sundays (Start Time: 9:00 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["NW Valentine Avenue & East 183rd Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["Community Access - Davidson Ave", "1750 Davidson Ave", "GrowNYC", "Year Round", "Thursdays (Start Time: 8:30 AM - End Time:  1:00 PM)", "Not accepted: meat, bones, or dairy", "www.communityaccess.org/"],
  ["Bay Ridge", "3rd Ave & 95th Street", "GrowNYC", "Year Round", "Saturdays (Start Time: 8:00 AM - End Time:  12:30 PM)", "Not accepted: meat, bones, or dairy", "grownyc.org/compost"],
  ["La Plaza Cultural Community Garden", "674 East 9th Street", "La Plaza Cultural Community Garden", "April-November", "Saturdays and Sundays (Start Time: 2:00 PM - End Time:  4:00 PM)", "Please carefully read instructions on the website.\nNot accepted: meat, bones, or dairy", "https://bit.ly/laplazadropoff"],
  ["SE East 171st Street & Walton Avenue", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"],
  ["NW Bushwick Avenue & Menahan Street", "-", "Department of Sanitation", "Year Round", "24/7", "Download the app to access bins. Accepts all food scraps, including meat and dairy. Do not leave food scraps outside of bin!", "www.nyc.gov/smartcomposting"]
];