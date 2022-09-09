import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('location').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data!.docs[index]['name'].toString()),
                subtitle: Row(
                  children: [
                    Text(snapshot.data!.docs[index]['latitude'].toString()),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(snapshot.data!.docs[index]['longitude'].toString()),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.directions),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => MyApp()));
                  },
                ),
              );
            });
      },
    ));
  }
}
