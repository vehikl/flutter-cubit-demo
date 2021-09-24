import 'package:api_fetch_flutter/album.dart';
import 'package:api_fetch_flutter/album_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: BlocProvider<AlbumCubit>(
        create: (context) => AlbumCubit(),
        child: const MyHomePage(),
      ),
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
  void initState() {
    // change the param to -1 to see the error state
    BlocProvider.of<AlbumCubit>(context).getAlbum('1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API test')),
      body: Center(
        child: BlocBuilder<AlbumCubit, AlbumState>(
          builder: (context, albumState) {
            if (albumState.hasError) {
              return Text(
                albumState.error.toString(),
                style: const TextStyle(color: Colors.red),
              );
            }

            if (albumState.loading || albumState.data == null) {
              return const CircularProgressIndicator();
            }

            Album album = albumState.data!;

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
