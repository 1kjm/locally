import 'package:locally/model/destination_model.dart';

class MakeListTileInContactScreen {
  final int id;
  MakeListTileInContactScreen({required this.id});
}

class NavigateToNext {
  NavigateToNext({required this.destination});
  final Destination destination;
}

class NavigateBack {}
