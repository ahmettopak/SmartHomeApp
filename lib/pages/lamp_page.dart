import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthomeui/api/fetch_lamp.dart';
import 'package:smarthomeui/util/app_bar.dart';
import 'package:smarthomeui/util/smart_device_box.dart';
import 'package:http/http.dart' as http;
import 'package:smarthomeui/util/title.dart';

import '../constants/constants.dart';
import '../model/lamp_model.dart';

class LampPage extends StatefulWidget {
  const LampPage({super.key});

  @override
  State<LampPage> createState() => _LampPageState();
}

class _LampPageState extends State<LampPage> {
  // list of smart devices
  // List mySmartDevices = [
  //   // [ smartDeviceName, iconPath , powerStatus ]
  //   ["Smart Livingroom", "lib/icons/air-conditioner.png", false],
  //   ["Balkon", "lib/icons/smart-tv.png", false],
  //   ["Oturma odası", "lib/icons/fan.png", false],
  // ];

  List<Lamp> lamp = [];
  @override
  void initState() {
    super.initState();

    _fetchLamp();
  }

  // power button switched
  void powerSwitchChanged(bool value, int index) {
    setState(() {
      //mySmartDevices[index][2] = value;
      final body = {
        'name': lamp[index].name,
        "status": value.toString(),
      };
      _sendData(value, body);
    });
  }

  Future<void> _sendData(bool value, Object body) async {
    final response = await http.post(Uri.parse(lampUpdateUrl), body: body);

    // Fluttertoast.showToast(
    //     msg: response.statusCode.toString(),
    //     toastLength: Toast.LENGTH_SHORT, // Toast mesajının gösterim süresi
    //     gravity:
    //         ToastGravity.BOTTOM, // Toast mesajının konumu (alt, üst, merkez)
    //     backgroundColor: Colors.black, // Toast mesajının arkaplan rengi
    //     textColor: Colors.white, // Toast mesajının yazı rengi
    //     fontSize: 16.0 // Toast mesajının yazı boyutu
    //     );

    _fetchLamp();
  }

  Future<void> _fetchLamp() async {
    final fetchedLamp = await fetchLamp();
    setState(() {
      lamp = fetchedLamp;
      // Fluttertoast.showToast(
      //   msg: lamp.length.toString(),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyAppBar(),
            const SizedBox(height: 25),

            // smart devices grid
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: MyTitle(text: "Lamp"),
            ),

            Expanded(
              child: GridView.builder(
                itemCount: lamp.length,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return SmartDeviceBox(
                    smartDeviceName: lamp[index].name,
                    iconPath: "lib/icons/light-bulb.png",
                    powerOn: lamp[index].status,
                    onChanged: (value) => powerSwitchChanged(value, index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
