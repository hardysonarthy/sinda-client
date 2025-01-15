part of 'view_bloc.dart';

@immutable
sealed class ViewEvent {
  final ViewTypes viewType;
  final Map<String, dynamic> data;

  const ViewEvent(this.viewType, this.data);
}

class OnInitView extends ViewEvent {
  const OnInitView(super.viewType, super.data);
}

class OpenView extends ViewEvent {
  const OpenView(super.viewType, super.data);
}

class CloseView extends ViewEvent {
  const CloseView(super.viewType, super.data);
}
