import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthomeui/util/smart_device_box.dart';
import 'package:http/http.dart' as http;

class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  // padding constants
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  // list of smart devices
  List mySmartDevices = [
    // [ smartDeviceName, iconPath , powerStatus ]
    ["Kitchen Lamp", "lib/icons/light-bulb.png", true],
    ["Kitchen AC", "lib/icons/air-conditioner.png", false],
  ];

  // power button switched
  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
      Fluttertoast.showToast(
          msg: mySmartDevices[index][0] +
              " is " +
              mySmartDevices[index][2].toString(),
          toastLength: Toast.LENGTH_SHORT, // Toast mesajının gösterim süresi
          gravity:
              ToastGravity.BOTTOM, // Toast mesajının konumu (alt, üst, merkez)
          backgroundColor: Colors.black, // Toast mesajının arkaplan rengi
          textColor: Colors.white, // Toast mesajının yazı rengi
          fontSize: 16.0 // Toast mesajının yazı boyutu
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // app bar
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // menu icon
                    Image.asset(
                      'lib/icons/menu.png',
                      height: 45,
                      color: Colors.grey[800],
                    ),
                    // account icon
                    Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.grey[800],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // welcome home
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Home,",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade800),
                    ),
                    Text(
                      'Ahmet Topak',
                      style: GoogleFonts.bebasNeue(fontSize: 40),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // smart devices grid
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  "Sensors",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),

              // grid
              Expanded(
                child: GridView.builder(
                  itemCount: mySmartDevices.length,
                  physics: const ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemBuilder: (context, index) {
                    return SmartDeviceBox(
                      smartDeviceName: mySmartDevices[index][0],
                      iconPath: mySmartDevices[index][1],
                      powerOn: mySmartDevices[index][2],
                      onChanged: (value) => powerSwitchChanged(value, index),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
