import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(
          const SettingsState.initial(),
        ) {
    on<FlowsPortChangesSettingsEvent>(_onPortChanges);
  }

  Future<void> _onPortChanges(
      FlowsPortChangesSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(flowLink: event.flowsPort));
  }
}
