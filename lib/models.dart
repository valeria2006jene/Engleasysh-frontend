class AppMessage {
  final String? header;
  final String? emoji;
  final String? text;
  final String? time;

  const AppMessage({
    this.header,
    this.emoji,
    this.text,
    this.time,
  });

  bool get isHeader => header != null;
}