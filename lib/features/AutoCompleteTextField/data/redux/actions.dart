///This action fetches 'LocationIndex' from firestore;
class GetLocationIndex {}

///Saves 'LocationIndex' to Store;
class SaveLocationIndex {
  List payload;
  SaveLocationIndex({
    required this.payload,
  });
}
