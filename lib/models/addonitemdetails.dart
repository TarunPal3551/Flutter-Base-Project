class AddonItemDetails {
  int code;
  String msg;
  Details details;
  Post post;

  AddonItemDetails({this.code, this.msg, this.details, this.post});

  AddonItemDetails.fromJson(Map<String, dynamic> json) {
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
  String formId;
  Data data;

  Details({this.nextAction, this.formId, this.data});

  Details.fromJson(Map<String, dynamic> json) {
    nextAction = json['next_action'];
    formId = json['form_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_action'] = this.nextAction;
    data['form_id'] = this.formId;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String subItemId;
  String subItemName;
  String itemDescription;
  String price;
  String thumbnail;
  String photo;
  List<String> category;
  String status;

  Data(
      {this.subItemId,
      this.subItemName,
      this.itemDescription,
      this.price,
      this.thumbnail,
      this.photo,
      this.category,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    subItemId = json['sub_item_id'];
    subItemName = json['sub_item_name'];
    itemDescription = json['item_description'];
    price = json['price'];
    thumbnail = json['thumbnail'];
    photo = json['photo'];
    category = json['category'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_item_id'] = this.subItemId;
    data['sub_item_name'] = this.subItemName;
    data['item_description'] = this.itemDescription;
    data['price'] = this.price;
    data['thumbnail'] = this.thumbnail;
    data['photo'] = this.photo;
    data['category'] = this.category;
    data['status'] = this.status;
    return data;
  }
}

class Post {
  String id;
  String deviceId;
  String devicePlatform;
  String deviceUiid;
  String codeVersion;
  String merchantToken;
  String apiKey;
  String lang;

  Post(
      {this.id,
      this.deviceId,
      this.devicePlatform,
      this.deviceUiid,
      this.codeVersion,
      this.merchantToken,
      this.apiKey,
      this.lang});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = this.id;
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
