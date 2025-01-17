import 'package:cloud_functions/cloud_functions.dart';
import 'package:event/data/repository/flows_fire_extensions.dart';
import 'package:event/domain/repository/flows.dart';
import 'package:event/ui/auth/bloc/auth/auth_bloc.dart';
import 'package:event/ui/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();
  String _answer = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthBloc>().add(
                  const SignOutAuthEvent(),
                ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                if (state.canChangeFlowLink) {
                  return TextField(
                    onChanged: (port) => context.read<SettingsBloc>().add(
                          FlowsPortChangesSettingsEvent(
                            port,
                          ),
                        ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Expanded(
              child: Text(_answer),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onChanged: (value) => setState(() {}),
                  ),
                ),
                BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: _textController.text.isNotEmpty
                          ? () async {
                              try {
                                final str =
                                    AiFlows.getParamsFromString.getLocalLink(
                                  state.flowLink,
                                );
                                HttpsCallable callable = FirebaseFunctions
                                    .instance
                                    .httpsCallableFromUrl(
                                  state.canChangeFlowLink &&
                                          state.flowLink.isNotEmpty
                                      ? str
                                      : AiFlows.getParamsFromString.severLink,
                                );

                                final result =
                                    await callable.call<Map<String, dynamic>?>(
                                        _textController.text);

                                setState(() {
                                  _answer = result.data?['result'] ?? '';
                                });
                              } catch (e) {
                                print(e.toString());
                              }
                            }
                          : null,
                      icon: const Icon(Icons.search),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
