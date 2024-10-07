import 'package:coloring/model/data.dart';
import 'package:coloring/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

class DataProvider extends ChangeNotifier {
  Data data = Data();
  int score = 0;
  List<String> missiondone = [];

  void setData(Data data) {
    this.data = data;
    notifyListeners();
  }

  Data getData() {
    return data;
  }

  Future savemissiondone(DrawingController controller, String mission) async {
    missiondone.add(mission);
    await LocalStorage.savemissiondone(missiondone);
    await LocalStorage.saveDrawingToLocal(controller, mission);
    notifyListeners();
  }

  Future removemission(String mission) async {
    missiondone.remove(mission);
    await LocalStorage.removeDrawingFromLocal(mission);
    await LocalStorage.savemissiondone(missiondone);
    notifyListeners();
  }

  //load mission done
  Future loadmissiondone() async {
    missiondone = await LocalStorage.getmissiondone() ?? [];
    notifyListeners();
  }
}
