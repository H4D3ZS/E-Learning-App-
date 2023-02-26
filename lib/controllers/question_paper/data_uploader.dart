import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearningapp/models/question_paper_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  void uploadData() async {
    final firestore = FirebaseFirestore.instance;

    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    // jsonEncode(manifestContent);
    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    // load json file and print path
    final paperInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/paper") && path.contains(".json"))
        .toList();
    print(paperInAssets);

    List<QuestionPaperModel> questionPapers = [];

    // read the content

    for (var paper in paperInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      print(stringPaperContent);

      questionPapers
          .add(QuestionPaperModel.fromJson(jsonDecode(stringPaperContent)));
    }
    // print('Items number ${questionPapers[0].description}');

    var batch = firestore.batch();
  }
}
