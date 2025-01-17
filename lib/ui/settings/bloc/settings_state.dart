part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.canChangeFlowLink,
    required this.flowLink,
  });

  const SettingsState.initial()
      : canChangeFlowLink = true,
        flowLink = '';

  final bool canChangeFlowLink;
  final String flowLink;

  SettingsState copyWith({
    String? flowLink,
  }) =>
      SettingsState(
        canChangeFlowLink: canChangeFlowLink,
        flowLink: flowLink ?? this.flowLink,
      );

  @override
  List<Object> get props => [
        canChangeFlowLink,
        flowLink,
      ];
}
