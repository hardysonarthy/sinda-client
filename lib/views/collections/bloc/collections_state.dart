part of 'collections_bloc.dart';

@immutable
sealed class CollectionsState {
  final List<PartialIndex> collections;

  const CollectionsState(this.collections);
}

final class CollectionsInitial extends CollectionsState {
  const CollectionsInitial(super.collections);
}

final class CollectionsReady extends CollectionsState {
  const CollectionsReady(super.collections);
}
