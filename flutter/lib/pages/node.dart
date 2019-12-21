class Node<T> {
  bool expand; //是否展开
  int depth; //深度

  int nodeId; //id
  int fatherId; //父类id
  T object; //
  bool isHasChildren; //是否有孩子节点

  Node(this.expand, this.depth, this.nodeId, this.fatherId, this.object,
      this.isHasChildren);
}
