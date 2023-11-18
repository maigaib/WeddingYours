import 'package:app_wedding_yours/modeles/mariage.dart';
import 'package:app_wedding_yours/services/mariagesServices.dart';
import 'package:flutter/material.dart';


class MariagesController extends ChangeNotifier {
  final MariagesService _service = MariagesService();

  List<Mariage> _mariages = [];
  List<Mariage> get mariages => _mariages;

  Mariage _currentMariage = Mariage(
    mariageId: 0,
    monsieur: '',
    madame: '',
    lieu: '',
    date: DateTime.now(),
    photo: '',
    utilisateursId: 0,
  );
  Mariage get currentMariage => _currentMariage;

  void setCurrentMariage(Mariage mariage) {
    _currentMariage = mariage;
    notifyListeners();
  }

  Future<void> addMariage(Mariage mariage) async {
    await _service.addMariage(mariage);
    await getMariages();
  }

  Future<void> updateMariage(Mariage mariage) async {
    await _service.updateMariage(mariage);
    await getMariages();
  }

  Future<void> deleteMariage(int mariageId) async {
    await _service.deleteMariage(mariageId);
    await getMariages();
  }

  Future<void> getMariages() async {
    _mariages = await _service.getMariages();
    notifyListeners();
  }

  Future<void> getMariageById(int mariageId) async {
    _currentMariage = await _service.getMariageById(mariageId);
    notifyListeners();
  }
}
