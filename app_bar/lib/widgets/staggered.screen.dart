import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class StaggeredView extends StatefulWidget {
  const StaggeredView({super.key});

  @override
  State<StaggeredView> createState() => _StaggeredViewState();
}

class _StaggeredViewState extends State<StaggeredView> {
  List<String> _imagePaths = [];

  @override
  void initState() {
    super.initState();
    _loadImagePaths();
  }

  Future<void> _loadImagePaths() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) =>
            key.startsWith('assets/staggeredViewImages/') &&
            (key.endsWith('.png') ||
                key.endsWith('.jpg') ||
                key.endsWith('.jpeg')))
        .toList();

    setState(() {
      _imagePaths = imagePaths;
    });
  }

  int _calculateCrossAxisCount(double width) {
    if (width < 600) {
      return 2; // Mobile view
    } else if (width >= 600 && width < 1200) {
      return 4; // Tablet view
    } else {
      return 6; // Desktop view
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = _calculateCrossAxisCount(width);

    return _imagePaths.isEmpty
        ? Center(child: CircularProgressIndicator())
        : MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
            ),
            itemCount: _imagePaths.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    _imagePaths[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
  }
}
