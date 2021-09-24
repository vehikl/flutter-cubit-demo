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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API test')),
      body: Center(
        child: FutureBuilder<Album?>(
          future: Api.getAlbum('-1'),
          builder: (context, snap) {
            if (snap.hasError) {
              return Text(
                snap.error.toString(),
                style: const TextStyle(color: Colors.red),
              );
            }

            if (snap.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            Album album = snap.data!;

            return ListTile(
              title: Text('Title: ' + album.title),
              tileColor: Colors.amber,
            );
          },
        ),
      ),
    );
  }
}
