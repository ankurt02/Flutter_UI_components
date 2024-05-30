// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// Required for ImageFilter , import 'dart:ui';
import 'package:app_bar/widgets/custom.container.dart';
import 'package:app_bar/widgets/custom.drawer.dart';
import 'package:app_bar/widgets/floating.appbar.dart';
import 'package:flutter/material.dart';
import 'package:app_bar/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

// void main() => runApp(MyApp());

void main() => runApp(
      DevicePreview(
        // enabled: !kReleaseMode,
        builder: (context) => ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
          child: MyApp(),
        ),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.currentTheme,
          home: Home(),
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: size.width < 600 ? CustomDrawer() : null,
      appBar: size.width < 600
          ? AppBar(
              // Display AppBar only in mobile view
              title: Text("AppBar"),
              actions: [
                IconButton(
                  icon: Icon(Icons.wb_sunny_rounded),
                  onPressed: () {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .toggleTheme();
                  },
                ),
              ],
            )
          : null,
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              padding: size.width > 600 ? EdgeInsets.only(top: 80) : EdgeInsets.all(8),
              child: Column(
                children: [
                  CustomContainer(
                    color: Colors.pink,
                  ),
                  CustomContainer(
                    color: Colors.amber,
                  ),
                  CustomContainer(
                    color: Colors.blue,
                  ),
                  CustomContainer(
                    color: Colors.orange,
                  ),
                  CustomContainer(
                    color: Colors.lime,
                  ),
                ],
              ),
            ),
          ),
          if (size.width >= 600)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: FloatingAppBar(),
            )
        ],
      ),
    );
  }
}
