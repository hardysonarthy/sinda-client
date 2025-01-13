part of 'collections_bloc.dart';

@immutable
sealed class CollectionsEvent {}

final class OnInit extends CollectionsEvent {}

final class OnNewCollection extends CollectionsEvent {
  final HttpRequest collection;
  final String? parentDir;

  OnNewCollection(this.collection, {this.parentDir});
}

final class OnNewFolder extends CollectionsEvent {
  final String dirName;
  final String dirPath;
  final String parentDir;

  OnNewFolder(
      {required this.dirName, required this.dirPath, required this.parentDir});
}

final class OnRun extends CollectionsEvent {
  final Collection collection;

  OnRun(this.collection);
}
