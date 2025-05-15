class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);
  E pop() => _list.removeLast();
  E get peek => _list.last;
  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;
  int get length => _list.length;

  @override
  String toString() => _list.toString();

  void printInReverse<T>(List<T> list) {
  var stack = Stack<T>();
  
  for (T item in list) {
    stack.push(item);
  }
  
  while (stack.isNotEmpty) {
    print(stack.pop());
  }
}
bool checkParentheses(String text) {
  var stack = Stack<int>();
  
  for (int i = 0; i < text.length; i++) {
    final char = text[i];
    if (char == '(') {
      stack.push(i);
    } else if (char == ')') {
      if (stack.isEmpty) {
        return false;
      }
      stack.pop();
    }
  }
  
  return stack.isEmpty;
}

}


