import 'package:car_share/config/menu/menu_items.dart';
import 'package:car_share/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
// import '../../../../config/requests/google_maps_requests.dart';
// import 'package:geocoding/geocoding.dart';
import '../states/app_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:uuid/uuid.dart';
// import '../../../../constants.dart';

class HomeMapScreen extends StatefulWidget {
  static const String name = 'home_screen';
  // const HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Map());
  }
}

class Map extends StatefulWidget {
  // const Map({super.key});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return SafeArea(
        child: appState.initialPosition == null
            ? Container(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitRotatingCircle(
                        color: Colors.black,
                        size: 50.0,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: appState.locationServiceActive == false,
                    child: Text(
                      "Please enable location services!",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  )
                ],
              ))
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Mapa de Navegación',
                    style: TextStyle(color: colorFontsTitle),
                  ),
                  backgroundColor: colorBackground,
                ),
                drawer: Drawer(
                  backgroundColor: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          _MyHeaderDrawer(),
                          _MyDrawerList(),
                        ],
                      ),
                    ),
                  ),
                ),
                body: Stack(
                  children: <Widget>[
                    GoogleMap(
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                          target: appState.initialPosition, zoom: 10.0),
                      onMapCreated: appState.onCreated,
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      compassEnabled: true,
                      markers: appState.markers,
                      onCameraMove: appState.onCameraMove,
                      polylines: appState.polyLines,
                    ),
                    Positioned(
                        top: 10.0,
                        right: 15.0,
                        left: 15.0,
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(1.0, 5.0),
                                  blurRadius: 10,
                                  spreadRadius: 3)
                            ],
                          ),
                          child: TextField(
                            cursorColor: Colors.black,
                            controller: appState.locationController,
                            decoration: InputDecoration(
                              icon: Container(
                                margin: EdgeInsets.only(left: 20, top: 5),
                                width: 10,
                                height: 10,
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "pick up",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 15.0, top: 16.0),
                            ),
                          ),
                        )),
                    Positioned(
                      top: 73.0,
                      right: 15.0,
                      left: 15.0,
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 5.0),
                                blurRadius: 10,
                                spreadRadius: 3)
                          ],
                        ),
                        child: TextField(
                          cursorColor: colorIcons,
                          controller: appState.destinationController,
                          textInputAction: TextInputAction.go,
                          onSubmitted: (value) {
                            appState.sendRequest(value);
                          },
                          decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(left: 20, top: 5),
                              width: 10,
                              height: 10,
                              child: Icon(
                                Icons.local_taxi,
                                color: colorIcons,
                              ),
                            ),
                            hintText: "",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 16.0),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30.0,
                      right: 15.0,
                      left: 15.0,
                      child: FilledButton(
                        onPressed: () {},
                        child: Text(
                          'Solicitar Viaje',
                          style: TextStyle(color: colorFontsTitle),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                colorBackgroundButton)),
                      ),
                    ),
                    Positioned(
                      bottom: 86.0, // Ajusta la posición vertical del botón
                      right: 16.0, // Ajusta la posición horizontal del botón
                      child: FloatingActionButton(
                        backgroundColor: colorBackground,
                        onPressed: () {
                          // Acción del botón de "Mi ubicación"
                          appState
                              .getUserLocation(); // Llama a la función para obtener la ubicación del usuario
                          // Otro código relacionado con la acción del botón
                        },
                        child: Icon(Icons.my_location, color: colorIcons),
                      ),
                    )
                  ],
                ),
              ));
  }

  Widget menuItem(String title, IconData icon, String link) {
    return Builder(builder: (context) {
      return Material(
        child: InkWell(
            onTap: () {
              context.push(link);
            },
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(children: [
                Expanded(
                  child: Icon(
                    icon,
                    size: 20,
                    color: colorIcons,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: colorIcons,
                        fontSize: 16,
                      ),
                    ))
              ]),
            )),
      );
    });
  }

  Widget _MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        //Lista del menu
        children: [
          menuItem(appMenuConfig[0].title, appMenuConfig[0].icon,
              appMenuConfig[0].link),
          menuItem(appMenuConfig[1].title, appMenuConfig[1].icon,
              appMenuConfig[1].link)
        ],
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        context.push(menuItem.link);
      },
    );
  }
}

class _MyHeaderDrawer extends StatefulWidget {
  const _MyHeaderDrawer({super.key});

  @override
  State<_MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<_MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBackground,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/profile.png')),
            ),
          ),
          FilledButton(
            onPressed: () {},
            child: const Text(
              'Yeferson Adrian Huarachi Aleman',
              style: TextStyle(color: colorFontsTitle),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(colorBackgroundButton)),
          ),
          FilledButton(
            onPressed: () {},
            child: const Text(
              '220001499',
              style: TextStyle(color: colorFontsTitle),
            ),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(colorBackgroundButton)),
          ),
        ],
      ),
    );
  }
}
