import 'package:sinda/models/collection.dart';

abstract class ViewData {
  final int index;

  ViewData(this.index);
}

class CollectionView extends ViewData {
  final Collection collection;

  CollectionView(super.index, {required this.collection});
}
