class Trie {
  _TrieNode head;
  bool isCaseSensitive = false;

  Trie() {
    head = _TrieNode(null);
  }

  addWord(String word) {
    addWordNode(word, head);
  }

  Trie.list(List<String> words) {
    head = _TrieNode(null);
    for (String word in words) {
      addWord(word);
    }
  }

  List<String> getAllWords() {
    return getAllWordsWithPrefix('');
  }

  addWordNode(String word, _TrieNode node) {
    if (word == null || word.length == 0) {
      node.endOfWord = true;
      return;
    }
    for (_TrieNode child in node.children) {
      if ((child.char == word.substring(0, 1)) ||
          (!isCaseSensitive && child.char.substring(0, child.char.length).toLowerCase() == word.substring(0, 1).toLowerCase())) {
        addWordNode(word.substring(1), child);
        return;
      }
    }

    node.addWord(word);
  }

  List<String> collect(StringBuffer prefix, _TrieNode node, List<String> words) {
    if (node != head) {
      prefix.write(node.char);
    }

    if (node.endOfWord) {
      words.add(prefix.toString());
    }

    node.children.forEach((child) {
      collect(StringBuffer(prefix.toString()), child, words);
    });

    return words;
  }

  List<String> getAllWordsWithPrefix(String prefix) {
    StringBuffer fullPrefix = StringBuffer();
    fullPrefix.write(prefix);
    return getAllWordsWithPrefixHelper(prefix, head, fullPrefix);
  }

  List<String> getAllWordsWithPrefixHelper(String prefix, _TrieNode node, StringBuffer fullPrefix) {
    if (prefix.length == 0) {
      String pre = fullPrefix.toString();
      return collect(
          StringBuffer(pre.substring(0, pre.length - 1)), node, []);
    }

      for(_TrieNode child in node.children) {
        if ((child.char == prefix.substring(0, 1)) || (!isCaseSensitive && child.char.substring(0, child.char.length).toLowerCase() == prefix.substring(0, 1).toLowerCase())) {
          return getAllWordsWithPrefixHelper(prefix.substring(1), child, fullPrefix);
        }
      }

      return [];
    }
  }


class _TrieNode {
  String _char;
  List<_TrieNode> _children;
  bool _endOfWord = false;

  _TrieNode(String _char) {
    this._char = _char;
    this._children = [];
  }

  set endOfWord(bool end) {
    _endOfWord = end;
  }

  addWord(String word) {
    _TrieNode curr = this;
    for (int i = 0; i < word.length; i++) {
      _TrieNode child = _TrieNode(word.substring(i, i + 1));
      curr._children.add(child);
      curr = child;
    }
    curr._endOfWord = true;
  }

  bool get endOfWord => _endOfWord;
  String get char => _char;
  List<_TrieNode> get children => _children;
}