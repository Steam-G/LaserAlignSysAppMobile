import 'dart:async';

import 'package:arduino_ble_sensor/model/sensor_data.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SensorView extends StatefulWidget {
  final SensorData sensorData;
  SensorView(this.sensorData, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SensorViewState();
  }
}

class _SensorViewState extends State<SensorView> {
  String _lastTime = "now";
  Timer _timeUpdater;

  @override
  void initState() {
    _timeUpdater =
        new Timer.periodic(const Duration(seconds: 1), _updateLastTime);
    super.initState();
  }

  @override
  void dispose() {
    _timeUpdater.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset('assets/images/sens.png'),
            title: Text('Sensor avaliable : '),
            subtitle: Text(
                '${widget.sensorData.name} rssi : ${widget.sensorData.rssi}'),
            trailing: Icon(MdiIcons.bluetoothConnect),
          ),
          ListTile(
            //leading: Image.asset('assets/images/temp.png'),
            leading: Icon(
              MdiIcons.thermometer,
              //color: Colors.black38,
              size: 40.0,
            ),
            title: Text(
                'Температура : ${widget.sensorData.temperature.toStringAsFixed(2)} °C'),
          ),
          ListTile(
            //leading: Image.asset('assets/images/humm.png'),
            leading: Icon(
              MdiIcons.waterPercent,
              //color: Colors.blue,
              size: 40.0,
            ),
            title: Text(
                'Влажность : ${widget.sensorData.humidity.toStringAsFixed(2)} %'),
          ),
          ListTile(
            //leading: Image.asset('assets/images/pres.png'),
            leading: Icon(
                  Icons.wb_sunny,
                  //color: Colors.yellow,
                  size: 40.0,
                ),
            title: Text(
                'Освещенность : ${widget.sensorData.pressure.toStringAsFixed(2)} lux'),
          ),
          ListTile(
            leading: Icon(MdiIcons.timelapse, size: 40),
            title: Text('Последнее обновление: $_lastTime seconds ago'),
          ),
        ],
      ),
    );
  }

  void _updateLastTime(Timer timer) {
    setState(() {
      _lastTime = DateTime.now()
          .difference(widget.sensorData.lastTime)
          .inSeconds
          .toString();
    });
  }
}
