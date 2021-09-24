import 'dart:convert';

import 'package:api_fetch_flutter/album.dart';
import 'package:api_fetch_flutter/api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;
  String _error = '';
  Album? _data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API test')),
      body: Center(
        child: _error != ''
            ? Text(_error, style: const TextStyle(color: Colors.red))
            : _loading
                ? const CircularProgressIndicator()
                : _data == null
                    ? const Text('Nothing here yet...')
                    : Text(_data!.title),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _makeRequest('1'),
            child: const Icon(Icons.check),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => _makeRequest('-1'),
            child: const Icon(Icons.close),
          )
        ],
      ),
    );
  }

  _makeRequest(String id) async {
    setState(() {
      _loading = true;
      _error = '';
    });

    try {
      Album? album = await Api.getAlbum(id);
      setState(() {
        _data = album;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }

    setState(() {
      _loading = false;
    });
  }
}
