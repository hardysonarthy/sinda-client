part of 'view_bloc.dart';

@immutable
sealed class ViewState {}

final class OnLoading extends ViewState {}

final class WorkspaceView extends ViewState {}

final class CollectionView extends ViewState {}

final class WorkflowView extends ViewState {}

final class MonitoringView extends ViewState {}
