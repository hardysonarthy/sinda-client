import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:sinda/models/collection.dart';
import 'package:sinda/models/view.dart';

part 'view_event.dart';
part 'view_state.dart';

List<ViewData> activeViews = [];

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  ViewBloc() : super(CollectionView(activeViews)) {
    on<OpenView>((event, emit) {
      ViewData? existingView = activeViews.firstWhereOrNull((view) {
        return event.viewType == view.viewType;
      });
      if (existingView == null) {
        activeViews.add(CollectionViewData(activeViews.length + 1,
            collection: Collection(1, 'test', [])));
        emit(RequestView(activeViews));
      }
      if (existingView != null) {
        switch (existingView.viewType) {
          case ViewTypes.request:
            {
              emit(RequestView(activeViews));
            }
          case ViewTypes.collection:
            {
              emit(CollectionView(activeViews));
            }
          default:
            {}
        }
      }
    });
  }
}
