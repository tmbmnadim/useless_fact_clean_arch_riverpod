import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_log_tests/features/useless_facts/presentation/widgets/useless_fact_card.dart';

import '../../../../injector.dart';

class UselessFactPresentor extends StatelessWidget {
  const UselessFactPresentor({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("Useless Fact")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer(
            builder: (context, ref2, child) {
              final uselessFactState = ref2.watch(uselessFactProvider);
              if (uselessFactState.isInitial) {
                return SizedBox(
                  width: screen.width,
                  child: Center(
                    child: Text("Press the button to know a fact!"),
                  ),
                );
              } else if (uselessFactState.isLoading) {
                return SizedBox(
                  width: screen.width,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (uselessFactState.isFailure) {
                return SizedBox(
                  width: screen.width,
                  child: Center(
                    child: Text("ERROR!:${uselessFactState.message}"),
                  ),
                );
              } else {
                return UselessFactCard(
                  text: uselessFactState.uselessFact!.text!,
                );
              }
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final uselessFactController = ref.read(
                uselessFactProvider.notifier,
              );
              return ElevatedButton(
                onPressed: () => uselessFactController.getAFact(),
                child: Text("Get a Useless Fact"),
              );
            },
          ),
        ],
      ),
    );
  }
}
