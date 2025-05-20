import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githubactions/core/theme/app_theme.dart';
import 'package:githubactions/di/get_it_setup.dart';
import 'package:githubactions/home/model/user_model.dart';
import 'package:githubactions/home/store/home_state.dart';
import 'package:githubactions/home/store/home_store.dart';
import 'package:githubactions/home/test_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeStore _homeStore;
  late final AppThemeMode themeMode;
  //MODEL
  UserModel? userModel;

  @override
  void initState() {
    super.initState();

    _homeStore = getIt<HomeStore>();
    themeMode = AppThemeMode();
    _homeStore.loadData();

    _homeStore.addListener(storeListener);
  }

  @override
  void dispose() {
    _homeStore.removeListener(storeListener);

    super.dispose();
  }

  void storeListener() {
    switch (_homeStore.value) {
      case HomeSuccessState(userModel: var userModel):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(userModel.name),
            backgroundColor: Colors.green,
          ),
        );
        updateModel(userModel);
        break;
      case HomeErrorState(error: var error):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.purple,
          ),
        );

      default:
        break;
    }
  }

  void updateModel(UserModel model) {
    setState(() {
      userModel = model;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ListenableBuilder(
          listenable: themeMode,
          builder: (context, _) {
            return FloatingActionButton(
              onPressed: () async {
                themeMode.toggleTheme();
                _homeStore.dispose();
                // ----

                await Future.delayed(const Duration(seconds: 1));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TestScreen(),
                  ),
                );
              },
              child: Icon(
                themeMode.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
            );
          }),
      body: Center(
        child: userModel != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userModel!.avatarUrl),
                      radius: 40,
                    ),
                    title: Text(userModel!.name),
                    subtitle: Text(
                      userModel!.login,
                    ),
                    trailing: CupertinoButton(
                      child: const Text(
                        'LinkedIn',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => _launchUrl(
                        userModel!.blogUrl,
                      ),
                    ),
                  ),
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}
