// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// Required for ImageFilter , import 'dart:ui';
import 'dart:ui';

import 'package:app_bar/widgets/custom.container.dart';
import 'package:app_bar/widgets/custom.drawer.dart';
import 'package:app_bar/widgets/floating.appbar.dart';
import 'package:flutter/material.dart';
import 'package:app_bar/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

import 'widgets/staggered.screen.dart';

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
      extendBodyBehindAppBar: true,
      drawer: size.width < 600 ? CustomDrawer() : null,
      appBar: size.width < 600
          ? AppBar(
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10)),
              ),
              elevation: 0,
              backgroundColor: Colors.white.withAlpha(200),
              // Display AppBar only in mobile view
              title: Text(
                "AppBar",
                style: TextStyle(color: Colors.black87),
              ),
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
            child: 
            
            
            // To have the colored container background, uncomment the below code, and remove the code below it
            // SingleChildScrollView(
            //   padding: size.width > 600
            //       ? EdgeInsets.only(top: 80)
            //       : EdgeInsets.all(8),
            //   child: Column(
            //     children: [
            //       CustomContainer(
            //         color: Colors.pink,
            //       ),
            //       CustomContainer(
            //         color: Colors.amber,
            //       ),
            //       CustomContainer(
            //         color: Colors.blue,
            //       ),
            //       CustomContainer(
            //         color: Colors.orange,
            //       ),
            //       CustomContainer(
            //         color: Colors.lime,
            //       ),
            //     ],
            //   ),
            // ),



            // to use the colored container code, comment out the below code/ padding widget, and un-comment the above widget(SingleChildScrollView)
            Padding(
              padding: size.width > 600
                  ? EdgeInsets.only(top: 50.0)
                  : EdgeInsets.all(2),
              child: StaggeredView(),
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
