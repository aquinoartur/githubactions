import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githubactions/di/get_it_setup.dart';
import 'package:githubactions/home/store/home_state.dart';
import 'package:githubactions/home/store/home_store.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late final HomeStore _homeStore;
  @override
  void initState() {
    super.initState();
    _homeStore = getIt<HomeStore>();

    if (_homeStore.value is HomeSuccessState) {
      final data = _homeStore.value as HomeSuccessState;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showMessage(data.userModel.name);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: Text('Test Screen')),
          CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
