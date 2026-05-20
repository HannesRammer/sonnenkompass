String enumToString(Object value) => value.toString().split('.').last;

T enumFromString<T extends Enum>(Iterable<T> values, String raw) {
  return values.firstWhere((value) => enumToString(value) == raw);
}
