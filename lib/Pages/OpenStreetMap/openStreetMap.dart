import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:hotellocation/Pages/OpenStreetMap/fakeData.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMap extends StatefulWidget {
  const OpenStreetMap({Key? key}) : super(key: key);

  @override
  State<OpenStreetMap> createState() => _OpenStreetMapState();
}

class _OpenStreetMapState extends State<OpenStreetMap> {
  List<Marker> setMarker() {
    return List<Marker>.from(FakeData.getLocation.map((e) =>new Marker(
        width: 60,
        height: 60,
        point:new LatLng(e.latitude, e.longitude),
        builder: (context) => new Icon(Icons.pin_drop))));
  }
  final MapController _mapController= MapController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Open Street Map'),
        ),
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Positioned(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                        center: LatLng(FakeData.getLocation[0].longitude,
                            FakeData.getLocation[0].latitude),
                        zoom: 13.0,
                        plugins: [
                          LocationMarkerPlugin(),
                          MarkerClusterPlugin(),
                        ]),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                        maxZoom: 19,
                      ),
                      MarkerLayerOptions(
                        markers: setMarker(),
                      ),
                    ],
                  ),
                ),
              Positioned(
                bottom: 20,
                right: 0,
                left: 0,
                child:Container(
                  height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: FakeData.getLocation.length,
                    itemBuilder: (BuildContext
                context,
                    int index )=>
                       GestureDetector(
                         onTap: (){
                           var response =_mapController.move(LatLng(FakeData
                               .getLocation[index].latitude, FakeData
                               .getLocation[index].longitude), 13);
                         },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
               width: MediaQuery.of(context).size.width / 1.7,
            decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)
            ),
              child:Padding(padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(FakeData.getLocation[index].name, style: TextStyle
                      (fontSize: 20),),
                    Text(FakeData.getLocation[index].Description, style: TextStyle
                      (fontSize: 18),),
                  ],
                ),
              )
    )
                       ),
                ),
               )

              ),
                // Positioned(
                //   bottom: 20,
                //   right: 0,
                //   left: 0,
                //   child: Container(
                //     width: MediaQuery.of(context).size.width / 1.7,
                //     decoration: BoxDecoration(color: Colors.white),
                //     child: Row(
                //       children: [Text('Test')],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
    );
  }
}
