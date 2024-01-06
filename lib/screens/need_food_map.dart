import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:async';

final places = GoogleMapsPlaces(apiKey: '');

Future<List<PlacesSearchResult>> fetchNearbyPlaces(double lat, double lng, int radius, String type) async {
  final response = await places.searchNearbyWithRadius(
    Location(lat: lat, lng: lng),
    radius,
    keyword: type,
    //type: "food" 
  );

  if (response.isOkay) {
    return response.results;
  } else {
    return [];
  }
}
Future<PlaceDetails> getPlaceDetails(PlacesSearchResult place) async {

  final response = await places.getDetailsByPlaceId(place.placeId.toString());

  if (response.isOkay) {
    final placeDetails = response.result;
    return placeDetails;
  } else {
    throw response.errorMessage!;
  }

}
String getAddress(PlaceDetails placeDetails) {
  final addressComponents = placeDetails.addressComponents;
  String address = '';

  // Extracting individual address components
  for (var component in addressComponents) {
    if (component.types.contains('street_number')) {
      address += '${component.longName} ';
    }
    if (component.types.contains('route')) {
      address += '${component.longName}, ';
    }
    if (component.types.contains('locality')) {
      address += '${component.longName}, ';
    }
    if (component.types.contains('administrative_area_level_1')) {
      address += '${component.longName}, ';
    }
    if (component.types.contains('country')) {
      address += component.longName;
    }
  }

  final formattedPhoneNumber = placeDetails.formattedPhoneNumber;

  if (address.isNotEmpty && formattedPhoneNumber != null) {
    return '$address\n$formattedPhoneNumber';
  } else if (address.isNotEmpty) {
    return address;
  } else if (formattedPhoneNumber != null) {
    return formattedPhoneNumber;
  } else {
    return '';
  }
}

class NeedFoodPage extends StatefulWidget {
  const NeedFoodPage({Key? key}) : super(key: key);
  @override
  State<NeedFoodPage> createState() => _NeedFoodPageState();
}
class _NeedFoodPageState extends State<NeedFoodPage> {

  Set<Circle> circles = {}; 


  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = true;
  bool _pantries = false;
  bool _fridges = false;
  bool _kitchens = false;
  double _radius = 1000;
  late LatLng currLoc;
  late String _mapStyle;
  final myController = TextEditingController();
  Set<Marker> _markers = {};

  String googleAPiKey = "";

    @override
    void dispose() {
    myController.dispose();
    super.dispose();
  }
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

  void _updateMarkers() async{
    List<PlacesSearchResult> pantries = [];
    List<PlacesSearchResult> fridges = [];
    List<PlacesSearchResult> kitchens = [];
   
    if (_pantries) {
      pantries += await fetchNearbyPlaces(currLoc.latitude, currLoc.longitude, _radius.toInt(), "food pantry");
      for (final place in pantries){
        setState(() {
          place.types.add('food_pantry');
        });
      }
    }
    if (_fridges) {
      fridges += await fetchNearbyPlaces(currLoc.latitude, currLoc.longitude, _radius.toInt(), "community fridge");
      for (final place in fridges){
        setState(() {
          place.types.add('community_fridge');
        });
      }
    }

    if (_kitchens) {
      kitchens += await fetchNearbyPlaces(currLoc.latitude, currLoc.longitude, _radius.toInt(), "soup kitchen");
      for (final place in kitchens){
        setState(() {
          place.types.add('soup_kitchen');
        });
      }
    }
     setState(() { _markers = {}; });
    _addMarkersFromPlaces(pantries + fridges + kitchens);
    // if (_foodBank) {
    //   final pantries = await fetchNearbyPlaces(currLoc.latitude, currLoc.longitude, _radius.toInt(), "food bank");
    //   for (final place in pantries){
    //     setState(() {
    //       place.types.add('food_bank');
    //     });
    //   }
    //   _addMarkersFromPlaces(pantries);
    // }
  }
  void _addMarkersFromPlaces(List<PlacesSearchResult> placesList) {
  for (final place in placesList) {
    BitmapDescriptor markerIcon;
    late String type;
    if(place.name.toLowerCase().contains('pantry')){
      markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      type = "pantry";
    }
    else if(place.name.toLowerCase().contains('fridge')){
      markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      type = "fridge";
    }
    else if(place.name.toLowerCase().contains('soup')){
      markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      type = "soup";
    }
    else if (place.types.contains('food_pantry')) {
      markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      type = "pantry";
    } else if (place.types.contains('community_fridge')) {
      markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      type = "fridge";
    } else if (place.types.contains('soup_kitchen')) {
      markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      type = "soup";
    } else if (place.types.contains('food_bank')) {
      markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
      type = "bank";
    } else{
      markerIcon = BitmapDescriptor.defaultMarker;
      type = "unknown";
    }

    final marker = Marker(
      markerId: MarkerId(place.placeId),
      position: LatLng(
        place.geometry!.location.lat,
        place.geometry!.location.lng,
      ),
      icon: markerIcon,
      infoWindow: InfoWindow(
        title: place.name,
        snippet: "Click for more info",
        onTap: () async {
          final placeDetails = await getPlaceDetails(place);
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        place.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        getAddress(placeDetails),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );

    setState(() {
      bool addit = true;

      if(type == "pantry" && !_pantries){
        addit = false;
      }
      if(type == "fridge" && !_fridges){
        addit = false;
      }
      if(type == "soup" && !_kitchens){
        addit = false;
      }
      if(addit){
        _markers.add(marker);
      }
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            const SizedBox(width: 20, height: 20),
            map(),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  searchBar(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        showResourceLocationsButton("pantry"),
                        const SizedBox(width: 16.0),
                        showResourceLocationsButton("fridge"),
                        const SizedBox(width: 16.0),
                        showResourceLocationsButton("kitchen"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget map(){
    return Focus(
      focusNode: _focusNode,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        zoomGesturesEnabled: true, 
        minMaxZoomPreference: const MinMaxZoomPreference(1, 20),
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        markers: _markers,
        circles: circles,
      ),
    );
  }
  Widget searchBar(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child:
              Material(
                elevation: 15,
                child:
                SearchGooglePlacesWidget(
                  placeType: PlaceType.region,
                  placeholder: 'Find locations near this address',
                  apiKey: '',
                  onSearch: (Place place) {},
                  onSelected: (Place place) async {
                    final geolocation = await place.geolocation;
                    
                    setState(() {
                      currLoc = LatLng(geolocation!.coordinates.latitude, geolocation.coordinates.longitude);
                      circles = Set.from([Circle(
                        circleId: CircleId("location"),
                        center: currLoc,
                        radius: _radius + 1000,
                        fillColor: Color.fromARGB(62, 247, 231, 0),
                        strokeColor: Color.fromARGB(255, 255, 209, 2),
                        strokeWidth: 1,
                    )]);
                    });

                    _updateMarkers();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget showResourceLocationsButton(String type){
    Color color;
    Color backgroundColor;
    String name;
    double elevation;
    if(type == "pantry"){
      color = const Color.fromARGB(255, 0, 210, 25);
      name = "Pantries";
      if(_pantries){
        elevation = 0;
        backgroundColor = Color.fromARGB(225, 219, 219, 219);
      } else{
        elevation = 10;
        backgroundColor = Colors.white;
      }
    } else if(type == "fridge"){
      color = const Color.fromARGB(255, 31, 52, 213);
      name = "Fridges";
      if(_fridges){
        elevation = 0;
        backgroundColor = Color.fromARGB(225, 219, 219, 219);
      } else{
        elevation = 10;
        backgroundColor = Colors.white;
      }
    } else{
      color = const Color.fromARGB(255, 195, 24, 24);
      name = "Kitchens";
      if(_kitchens){
        elevation = 0;
        backgroundColor = Color.fromARGB(225, 219, 219, 219);
      } else{
        elevation = 10;
        backgroundColor = Colors.white;
      }
    }
    return Expanded(
      child:
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: elevation,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), 
            ),
            side:
              BorderSide(
                color: color, 
                width: 1.0,
              ),
          ),
          onPressed: () {
            setState(() {
              if(type == "pantry"){
                _pantries = !_pantries;
              } else if(type == "fridge"){
                _fridges = !_fridges;
              } else{
                _kitchens = !_kitchens;
              }
            });
            _updateMarkers();
          },
          child: Text(
            name,
            style: TextStyle(
              color: color, 
            ),
          ),
        ),
    );
  }
}
