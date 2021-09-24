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
  bool _loading = true;
  String _error = '';
  Album? _data;

  @override
  void initState() {
    _makeRequest('1');
    super.initState();
  }

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
                    : ListTile(title: Text('Title: ' + _data!.title), tileColor: Colors.amber,),
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
