///This action fetches 'LocationIndex' from firestore;
///This action is first listned by the Middleware;
class GetLocationIndex {}

class SaveLocationIndex {
  List payload;
  SaveLocationIndex({
    required this.payload,
  });
}
