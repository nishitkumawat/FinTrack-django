class HashMap:

    def __init__(self):
        self.map = {}  

    def put(self, key, value):
        self.map[key] = value

    def get(self, key):
        return self.map.get(key, None)

    def remove(self, key):
        if key in self.map:
            del self.map[key]

    def get_all(self):
        return self.map


class TreeNode:
    """Node for the Binary Search Tree (BST)"""
    def __init__(self, key, value):
        self.key = key  # Item name (key)
        self.value = value  # Quantity (value)
        self.left = None
        self.right = None

class BST:
    """Binary Search Tree for sorting by quantity"""
    def __init__(self):
        self.root = None

    def insert(self, key, value):
        """Inserts a key-value pair into the BST"""
        self.root = self._insert_recursive(self.root, key, value)

    def _insert_recursive(self, node, key, value):
        """Recursive insertion helper function"""
        if not node:
            return TreeNode(key, value)
        if value < node.value:
            node.left = self._insert_recursive(node.left, key, value)
        else:
            node.right = self._insert_recursive(node.right, key, value)
        return node

    def get_top_n(self, n):
        """Returns the top `n` items with the highest quantities"""
        result = []
        self._reverse_inorder(self.root, result, n)
        return dict(result)

    def _reverse_inorder(self, node, result, n):
        """Helper function to get top `n` elements in descending order"""
        if node and len(result) < n:
            self._reverse_inorder(node.right, result, n)  # Visit right (higher values)
            if len(result) < n:
                result.append((node.key, node.value))  # Add current node
            self._reverse_inorder(node.left, result, n)  # Visit left (lower values)
