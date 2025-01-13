import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sinda/models/collection.dart';
import 'package:sinda/models/partial_index.dart';

part 'collections_event.dart';
part 'collections_state.dart';

List<PartialIndex> collections = [];

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  late Directory appDocumentsDir;
  CollectionsBloc() : super(CollectionsInitial([])) {
    on<OnInit>((event, emit) async {
      appDocumentsDir = await getApplicationDocumentsDirectory();
      emit(CollectionsReady(collections));
    });
    on<OnNewCollection>((event, emit) {
      emit(CollectionsInitial(collections));
      HttpRequest newCollection = event.collection;
      collections.add(newCollection);
      emit(CollectionsReady(collections));
    });
    on<OnNewFolder>((event, emit) {});
  }
}
