class AddonItem {
  int code;
  String msg;
  Details details;
  Post post;

  AddonItem({this.code, this.msg, this.details, this.post});

  AddonItem.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;

    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }

    if (this.post != null) {
      data['post'] = this.post.toJson();
    }
    return data;
  }
}

class Details {
  String nextAction;
  int refresh;
  List<Data> data;

  Details({this.nextAction, this.refresh, this.data});

  Details.fromJson(Map<String, dynamic> json) {
    nextAction = json['next_action'];
    refresh = json['refresh'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_action'] = this.nextAction;
    data['refresh'] = this.refresh;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String name;
  String description;
  String thumbnail;
  String status;
  String dateCreated;

  Data(
      {this.id,
      this.name,
      this.description,
      this.thumbnail,
      this.status,
      this.dateCreated});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['status'] = this.status;
    data['date_created'] = this.dateCreated;
    return data;
  }
}

class Post {
  String deviceId;
  String devicePlatform;
  String deviceUiid;
  String codeVersion;
  String merchantToken;
  String apiKey;
  String lang;

  Post(
      {this.deviceId,
      this.devicePlatform,
      this.deviceUiid,
      this.codeVersion,
      this.merchantToken,
      this.apiKey,
      this.lang});

  Post.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    devicePlatform = json['device_platform'];
    deviceUiid = json['device_uiid'];
    codeVersion = json['code_version'];
    merchantToken = json['merchant_token'];
    apiKey = json['api_key'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_id'] = this.deviceId;
    data['device_platform'] = this.devicePlatform;
    data['device_uiid'] = this.deviceUiid;
    data['code_version'] = this.codeVersion;
    data['merchant_token'] = this.merchantToken;
    data['api_key'] = this.apiKey;
    data['lang'] = this.lang;
    return data;
  }
}
