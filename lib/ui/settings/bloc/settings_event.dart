part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class FlowsPortChangesSettingsEvent extends SettingsEvent {
  const FlowsPortChangesSettingsEvent(this.flowsPort);
  final String flowsPort;
}
