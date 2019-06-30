class HMap<K, V> {
  final Map map;

  HMap(map) : this.map = map ?? {};

  V operator [] (Object key) {
    return map[key] ?? null;
  }

}