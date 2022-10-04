enum PointStates {
  passing(true),
  impassable(false);

  final bool value;

  const PointStates(this.value);
}
