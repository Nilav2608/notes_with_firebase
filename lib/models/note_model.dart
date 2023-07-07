class Notes {
  String? id;
  String? title;
  String? content;
  String? date;

  Notes({
    required this.id,
    required this.title,
  required this.content,required this.date});

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['date'] = date;
    return data;
  }
}
