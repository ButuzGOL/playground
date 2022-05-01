import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorites.dart';
import './favorites.dart';
import '../models/album.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './newItem.dart';

GlobalKey<_AlbumListState> globalKey = GlobalKey();

class AlbumList extends StatefulWidget {
  static final GlobalKey<_AlbumListState> globalKey = GlobalKey();
  const AlbumList({Key? key}) : super(key: key);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  late Future<Album> futureAlbum;

  void methodA() {
    getData();
  }

  List<Album> listModel = [];
  var loading = false;

  Future<Null> getData() async {
    setState(() {
      loading = true;
    });

    final responseData =
        await http.get(Uri.parse("http://localhost:57151/data.json"));

    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      List jsonResponse = json.decode(responseData.body);
      print(data);
      setState(() {
        listModel =
            jsonResponse.map((data) => new Album.fromJson(data)).toList();
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: listModel.length,
                itemBuilder: (context, index) =>
                    ItemTile(index, listModel[index]),
              ));
  }
}

class HomePage extends StatelessWidget {
  static String routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  _callback() {
    print('callback');
    globalKey.currentState!.methodA();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album list'),
        actions: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, FavoritesPage.routeName);
            },
            icon: const Icon(Icons.favorite_border),
            label: const Text('Favorites'),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () {
              Navigator.of(context)
                  .push(
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => NewItemPage(),
                    ),
                  )
                  .then((val) => val ? _callback() : null);
            },
            icon: const Icon(Icons.abc),
            label: const Text('New item'),
          ),
        ],
      ),
      body: AlbumList(key: globalKey),
    );
  }
}

class ItemTile extends StatelessWidget {
  final int itemNo;
  final Album model;

  const ItemTile(this.itemNo, this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<Favorites>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          'Item $itemNo ' + model.title,
          key: Key('text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('icon_$itemNo'),
          icon: favoritesList.items.contains(model)
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          onPressed: () {
            !favoritesList.items.contains(model)
                ? favoritesList.add(model)
                : favoritesList.remove(model.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(favoritesList.items.contains(model)
                    ? 'Added to favorites.'
                    : 'Removed from favorites.'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
