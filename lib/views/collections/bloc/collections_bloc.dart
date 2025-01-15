import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sinda/models/collection.dart';
import 'package:sinda/models/partial_index.dart';

part 'collections_event.dart';
part 'collections_state.dart';

List<PartialIndex> collections = [];
int? activeCollectionIndex;

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  late Directory appDocumentsDir;
  CollectionsBloc() : super(CollectionsInitial([])) {
    on<OnInit>((event, emit) async {
      appDocumentsDir = await getApplicationDocumentsDirectory();
      emit(CollectionsReady(collections));
    });
    on<OnNewCollection>((event, emit) {
      emit(CollectionsInitial(collections));
      collections.add(Collection(collections.length + 1, 'New Collection', []));
      activeCollectionIndex =
          collections.lastIndexWhere((col) => col is Collection);
      emit(CollectionsReady(collections));
    });
    on<OnNewRequest>((event, emit) {
      emit(CollectionsInitial(collections));
      if (activeCollectionIndex != null) {
        (collections.elementAt(activeCollectionIndex!) as Collection)
            .requests
            .add(event.request);
      } else {
        collections.add(event.request);
      }
      emit(CollectionsReady(collections));
    });
    on<OnNewFolder>((event, emit) {});
  }
}
