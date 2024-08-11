class ChatId {
  static combine(String id1, String id2) {
    return (id1.compareTo(id2) <= 0) ? '$id1\_$id2' : '$id2\_$id1';
  }
}
