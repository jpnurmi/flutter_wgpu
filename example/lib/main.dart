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

  @override
  void initState() {
    super.initState();
    initWgpu();
  }

  void initWgpu() async {
    final adapter = await Adapter.request();
    setState(() => _adapter = adapter);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter WebGPU'),
        ),
        body: Center(
          child: Text('${_adapter?.toString()} (${_adapter?.id})'),
        ),
      ),
    );
  }
}
