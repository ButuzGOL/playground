import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorites.dart';
import '../models/album.dart';

class FavoritesPage extends StatelessWidget {
  static String routeName = '/favorites';
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Consumer<Favorites>(
        builder: (context, value, child) => value.items.isNotEmpty
            ? ListView.builder(
                itemCount: value.items.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) =>
                    FavoriteItemTile(value.items[index]),
              )
            : const Center(
                child: Text('No favorites added.'),
              ),
      ),
    );
  }
}

class FavoriteItemTile extends StatelessWidget {
  final Album item;

  const FavoriteItemTile(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[item.id % Colors.primaries.length],
        ),
        title: Text(
          'Item ${item.title}',
          key: Key('favorites_text_${item.id}'),
        ),
        trailing: IconButton(
          key: Key('remove_icon_${item.id}'),
          icon: const Icon(Icons.close),
          onPressed: () {
            context.read<Favorites>().remove(item.id);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Removed from favorites.'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
