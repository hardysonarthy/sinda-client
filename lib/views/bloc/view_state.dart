part of 'view_bloc.dart';

@immutable
sealed class ViewState {
  final List<ViewData> activeViews;
  const ViewState(this.activeViews);
}

final class OnLoading extends ViewState {
  const OnLoading(super.activeViews);
}

abstract class LoadView extends ViewState {
  const LoadView(super.activeViews);
}

final class WorkspaceView extends LoadView {
  const WorkspaceView(super.activeViews);
}

final class CollectionView extends LoadView {
  const CollectionView(super.activeViews);
}

final class RequestView extends LoadView {
  const RequestView(super.activeViews);
}

final class WorkflowView extends LoadView {
  const WorkflowView(super.activeViews);
}

final class MonitoringView extends LoadView {
  const MonitoringView(super.activeViews);
}
