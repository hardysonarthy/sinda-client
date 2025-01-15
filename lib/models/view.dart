import 'package:sinda/models/collection.dart';

enum ViewTypes { request, collection, environment, workflow, monitoring }

abstract class ViewData {
  final int index;
  late ViewTypes viewType;

  ViewData(this.index, {required this.viewType});
}

class CollectionViewData extends ViewData {
  final Collection collection;

  CollectionViewData(super.index, {required this.collection})
      : super(viewType: ViewTypes.collection);
}

class RequestViewData extends ViewData {
  final HttpRequest request;

  RequestViewData(super.index, {required this.request})
      : super(viewType: ViewTypes.request);
}
