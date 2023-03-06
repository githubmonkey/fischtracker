class CatSubmitException {
  String get title => 'Name already used';
  String get description => 'Please choose a different cat name';

  @override
  String toString() {
    return '$title. $description.';
  }
}
