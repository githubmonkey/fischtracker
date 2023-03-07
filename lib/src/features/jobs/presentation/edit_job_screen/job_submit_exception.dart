class JobSubmitException {
  JobSubmitException({required this.title, required this.description});

  String title;
  String description;

  @override
  String toString() {
    return '$title. $description.';
  }
}
