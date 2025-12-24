enum AddMode { manual, ai }

class AddItemArgs {
  const AddItemArgs({required this.mode});

  final AddMode mode;
}
