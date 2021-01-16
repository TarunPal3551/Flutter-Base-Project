class UploadResponse {
  String code;
  String nextAction;
  String msg;
  String filename;
  String fileUrl;

  UploadResponse(
      {this.code, this.nextAction, this.msg, this.filename, this.fileUrl});

  UploadResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    nextAction = json['next_action'];
    msg = json['msg'];
    filename = json['filename'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['next_action'] = this.nextAction;
    data['msg'] = this.msg;
    data['filename'] = this.filename;
    data['file_url'] = this.fileUrl;
    return data;
  }
}
