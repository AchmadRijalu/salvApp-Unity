import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:salv/UI/pages/recommendation_page.dart';

import '../widgets/buttons.dart';

class CameraPreviewPage extends StatelessWidget {
  final String picture;
  final dynamic label;
  CameraPreviewPage({super.key, required this.picture, required this.label});
  static const routeName = '/camerapreviewpage';

  @override
  Widget build(BuildContext context) {
    String combinedLabel = "";
    label.forEach((fruit) {
      combinedLabel += "${" " + fruit},";
    });

    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.network(picture, fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Kami menemukan$combinedLabel berikut adalah rekomendasi iklan terkait.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 54,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomFilledButton(
              title: "Lihat Rekomendasi",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return IklanRecommendationPage(
                      label: label,
                    );
                  },
                ));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
