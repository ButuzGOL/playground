// Copyright 2020 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:my_app/models/album.dart';

/// The [Favorites] class holds a list of favorite items saved by the user.
class Favorites extends ChangeNotifier {
  final List<Album> _favoriteItems = [];

  List<Album> get items => _favoriteItems;

  void add(Album item) {
    _favoriteItems.add(item);
    notifyListeners();
  }

  void remove(int itemNo) {
    _favoriteItems.removeWhere((element) => element.id == itemNo);
    notifyListeners();
  }
}
