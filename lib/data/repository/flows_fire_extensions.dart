import 'package:event/domain/repository/flows.dart';

extension FlowsFireExtensions on AiFlows {
  String get severLink => switch (this) {
        AiFlows.getParamsFromString =>
          'https://menusuggestionflow-rd2a2u3mdq-uc.a.run.app',
        AiFlows.getEventTutor => throw UnimplementedError(),
      };

  String getLocalLink(String port) =>
      'http://127.0.0.1:$port/ai-event-app/us-central1/$name';
}
