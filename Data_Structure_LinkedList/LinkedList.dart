
import 'Node.dart';
class LinkedList<E> {
  Node<E>? head;
  Node<E>? tail;

  bool get isEmpty => head == null;

  void push(E value) {
    head = Node(value, head);
    tail ??= head;
  }

  void append(E value) {
    if (isEmpty) {
      push(value);
      return;
    }
    tail!.next = Node(value);
    tail = tail!.next;
  }

  Node<E>? nodeAt(int index) {
    var currentNode = head;
    var currentIndex = 0;

    while (currentNode != null && currentIndex < index) {
      currentNode = currentNode.next;
      currentIndex++;
    }

    return currentNode;
  }

  @override
  String toString() {
    return head?.toString() ?? 'Empty list';
  }


void printNodesInReverse<E>(LinkedList<E> list) {
  void printNodeRecursive(Node<E>? node) {
    if (node == null) return;
    printNodeRecursive(node.next);
    print(node.value);
  }
  
  printNodeRecursive(list.head);
}



Node<E>? getMiddle<E>(LinkedList<E> list) {
  var slow = list.head;
  var fast = list.head;
  
  while (fast?.next != null) {
    fast = fast?.next?.next;
    slow = slow?.next;
  }
  
  return slow;
}
 

 void reverseLinkedList<E>(LinkedList<E> list) {
  Node<E>? prev = null;
  Node<E>? current = list.head;
  Node<E>? next;
  
  list.tail = list.head;
  
  while (current != null) {
    next = current.next;
    current.next = prev;
    prev = current;
    current = next;
  }
  
  list.head = prev;
}




void removeAllOccurrences<E>(LinkedList<E> list, E value) {
  while (list.head != null && list.head!.value == value) {
    list.head = list.head!.next;
  }
  
  var previous = list.head;
  var current = list.head?.next;
  
  while (current != null) {
    if (current.value == value) {
      previous?.next = current.next;
      current = previous?.next;
      if (current == null) {
        list.tail = previous;
      }
    } else {
      previous = current;
      current = current.next;
    }
  }
  
  list.tail = previous;
}






}
