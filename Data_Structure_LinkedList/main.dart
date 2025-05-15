import 'LinkedList.dart';

void main() {
  var list = LinkedList<int>();
  list.push(3);
  list.push(2);
  list.push(1);
  list.append(1);
  list.append(2);
  list.append(3);
  list.append(4);
  list.append(5);
  list.reverseLinkedList(list);
  print(list.getMiddle(list)?.value);
  list.removeAllOccurrences(list, 2);
}
