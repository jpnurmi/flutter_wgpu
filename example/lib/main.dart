import 'package:flutter/material.dart';
import 'package:wgpu/wgpu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Adapter? _adapter;
  Device? _device;

  @override
  void initState() {
    super.initState();
    initWgpu();
  }

  void initWgpu() async {
    final adapter = await WGPU.requestAdapter();
    //final device = adapter.requestDevice();
    setState(() {
      _adapter = adapter;
      //_device = device;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter WebGPU'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Adapter: ${_adapter?.toString()} (${_adapter?.id})'),
              Text('Device: ${_device?.toString()} (${_device?.id})'),
            ],
          ),
        ),
      ),
    );
  }
}
