class Notes {
  String? title;
  String? content;
  String? date;

  Notes({required this.title,required this.content,required this.date});

  Notes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['date'] = date;
    return data;
  }
}
