import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as poly;
import 'package:ffa_app/screens/needExistList.dart';

final places = GoogleMapsPlaces(apiKey: 'apiKey');

Future<List<PlacesSearchResult>> fetchNearbyPlaces(double lat, double lng, int radius, String type) async {
  final response = await places.searchNearbyWithRadius(
    Location(lat: lat, lng: lng),
    radius, // radius in meters
    keyword: type,
    type: "food" // adjust the type according to your needs
  );

  if (response.isOkay) {
    return response.results;
  } else {
    throw response.errorMessage!;
  }
}
Future<PlaceDetails> getPlaceDetails(PlacesSearchResult place) async {

  final response = await places.getDetailsByPlaceId(place.placeId.toString());

  if (response.isOkay) {
    final placeDetails = response.result;
    return placeDetails;
  } else {
    // Handle the error case
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

  final String? selectedValue;


  const NeedFoodPage({Key? key, this.selectedValue}) : super(key: key);
  @override
  State<NeedFoodPage> createState() => _NeedFoodPageState();

}
class _NeedFoodPageState extends State<NeedFoodPage> {
  poly.PolylinePoints polylinePoints = poly.PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = true;
  bool _pantries = false;
  bool _fridges = false;
  bool _soup = false;
  final bool _foodBank = false;
  double _radius = 500;
  late LatLng currLoc;
  late String _mapStyle;
  final myController = TextEditingController();
  Set<Marker> _markers = {};

  String googleAPiKey = "AIzaSyAMJ4LB2kRLFaToL5t1ej8GGjRIRYl5Xpg";

    @override
    void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  @override
  void initState() {

    super.initState();

    rootBundle.loadString('lib/assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    if (widget.selectedValue == 'See food pantry locations') {
      _pantries = true;
    } else if (widget.selectedValue == 'See community fridge locations') {
      _fridges = true;
    } else if (widget.selectedValue == 'See soup kitchen locations') {
      _soup = true;
    }
  }
  getDirections(LatLng startLocation, LatLng endLocation) async {
      List<LatLng> polylineCoordinates = [];

      poly.PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleAPiKey,
          poly.PointLatLng(startLocation.latitude, startLocation.longitude),
          poly.PointLatLng(endLocation.latitude, endLocation.longitude),
          travelMode: poly.TravelMode.walking,
      );

      if (result.points.isNotEmpty) {
            for (var point in result.points) {
                polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            }
      }
      addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: const Color.fromARGB(255, 255, 0, 0),
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
    setState(() {});
  }
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(40.7128, -74.0060);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
  }

  void _updateMarkers() async{
    // Clear existing markers
    setState(() {
      _markers = {Marker(
        markerId: const MarkerId("currentLocation"),
        position: currLoc,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: const InfoWindow(title: "Your Location")
      ),};
    });

    // Add new markers based on the selected checkboxes
    if (_pantries) {
      // Add markers for food pantries
      // Replace the below code with your own logic to add appropriate markers
      final pantries = await fetchNearbyPlaces(currLoc.latitude, currLoc.longitude, _radius.toInt(), "food pantry");
      for (final place in pantries){
        setState(() {
          place.types.add('food_pantry');
        });
      }
      _addMarkersFromPlaces(pantries);
      // Add more markers as needed
    }

    if (_fridges) {
      // Add markers for community fridges
      // Replace the below code with your own logic to add appropriate markers
      final pantries = await fetchNearbyPlaces(currLoc.latitude, currLoc.longitude, _radius.toInt(), "community fridge");
      for (final place in pantries){
        setState(() {
          place.types.add('community_fridge');
        });
      }
      _addMarkersFromPlaces(pantries);
      // Add more markers as needed
    }

    if (_soup) {
      // Add markers for soup kitchens
      // Replace the below code with your own logic to add appropriate markers
      final pantries = await fetchNearbyPlaces(currLoc.latitude, currLoc.longitude, _radius.toInt(), "soup kitchen");
      for (final place in pantries){
        setState(() {
          place.types.add('soup_kitchen');
        });
      }
      _addMarkersFromPlaces(pantries);
      // Add more markers as needed
    }
    if (_foodBank) {
      // Add markers for soup kitchens
      // Replace the below code with your own logic to add appropriate markers
      final pantries = await fetchNearbyPlaces(currLoc.latitude, currLoc.longitude, _radius.toInt(), "food bank");
      for (final place in pantries){
        setState(() {
          place.types.add('food_bank');
        });
      }
      _addMarkersFromPlaces(pantries);
      // Add more markers as needed
    }
  }
  void _addMarkersFromPlaces(List<PlacesSearchResult> placesList) {
  for (final place in placesList) {
    BitmapDescriptor markerIcon;
    late String type;
    // Set different marker icons based on the keyword used
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(

                        child: ElevatedButton(
                          onPressed: (){
                            _isExpanded = false;
                            getDirections(currLoc,
                                          LatLng(
                                            place.geometry!.location.lat,
                                            place.geometry!.location.lng,
                                          ),
                             );
                          },
                          child: const Text('Show Route')
                          )
                        )
                    ),

                    // Add more place details if needed
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
      if(type == "soup" && !_soup){
        addit = false;
      }
      if(type == "bank" && !_foodBank){
        addit = false;
      }
      if(addit){
        _markers.add(marker);
      }
    });
  }
}
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Maps'),
    Text('Show Listings'),
    Icon(Icons.add),
    Text('Account'),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        colorSchemeSeed: const Color.fromARGB(255, 225, 102, 102),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            const SizedBox(width: 20, height: 20),
            Focus(
              focusNode: _focusNode,
              child: GoogleMap(
                polylines: Set<Polyline>.of(polylines.values),
                onMapCreated: _onMapCreated,
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                minMaxZoomPreference: const MinMaxZoomPreference(1, 20),
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 12.0,
                ),
                markers: _markers,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Container(
                    height: 60,

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
                            apiKey: 'AIzaSyAMJ4LB2kRLFaToL5t1ej8GGjRIRYl5Xpg',
                            onSearch: (Place place) {},
                            onSelected: (Place place) async {
                              final geolocation = await place.geolocation;
                              setState(() {
                                currLoc = LatLng(geolocation!.coordinates.latitude, geolocation.coordinates.longitude);
                              });
                            },
                          ),
                        ),


                        )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child:

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(

                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                              ),
                              side:
                                BorderSide(
                                  color: const Color.fromARGB(255, 0, 210, 25), // Set the color of the outline
                                  width: 1.0, // Set the width of the outline
                                ),

                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const NeedFoodPage(selectedValue: "See food pantry locations"),
                                ),
                              );
                            },
                            child: const Text(
                              'Pantries',
                              style: TextStyle(
                                color: Colors.green, // Set the color of the text
                              ),
                            ),
                          ),

                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(

                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                              ),
                              side:
                              BorderSide(
                                color: const Color.fromARGB(255, 31, 52, 213), // Set the color of the outline
                                width: 1.0, // Set the width of the outline
                              ),

                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const NeedFoodPage(
                                      selectedValue: "See community fridge locations"),
                                ),
                              );
                            },
                            child: const Text(
                              'Fridges',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 31, 52, 213), // Set the color of the text
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(

                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                              ),
                              side:
                              BorderSide(
                                color: const Color.fromARGB(255, 195, 24, 24), // Set the color of the outline
                                width: 1.0, // Set the width of the outline
                              ),

                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const NeedFoodPage(
                                      selectedValue: "See soup kitchen locations"),
                                ),
                              );
                            },
                            child: const Text(
                              'Kitchens',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 195, 24, 24), // Set the color of the text
                              ),
                            ),
                          ),
                        ),
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
}