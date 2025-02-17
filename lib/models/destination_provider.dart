import 'package:flutter/foundation.dart';

class DestinationProvider extends ChangeNotifier {
  String? _selectedDestination;
  String? get selectedDestination => _selectedDestination;

  void updateSelectedDestination(String destination) {
    _selectedDestination = destination;
    notifyListeners();
  }
}
