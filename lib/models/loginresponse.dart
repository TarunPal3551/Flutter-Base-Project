class LoginResponse {
  int code;
  String msg;
  Details details;

  Post post;

  LoginResponse({this.code, this.msg, this.details, this.post});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  MerchantInfo merchantInfo;
  String nextAction;
  DeviceInfo deviceInfo;

  Details({this.merchantInfo, this.nextAction, this.deviceInfo});

  Details.fromJson(Map<String, dynamic> json) {
    merchantInfo = json['merchant_info'] != null
        ? new MerchantInfo.fromJson(json['merchant_info'])
        : null;
    nextAction = json['next_action'];
    deviceInfo = json['device_info'] != null
        ? new DeviceInfo.fromJson(json['device_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.merchantInfo != null) {
      data['merchant_info'] = this.merchantInfo.toJson();
    }
    data['next_action'] = this.nextAction;
    if (this.deviceInfo != null) {
      data['device_info'] = this.deviceInfo.toJson();
    }
    return data;
  }
}

class MerchantInfo {
  String id;
  String merchantId;
  String merchantToken;
  String restaurantName;
  String userType;
  String userAccess;
  String username;
  String emailAddress;
  String contactNumber;
  String pin;
  String merchantPhoto;

  MerchantInfo(
      {this.id,
      this.merchantId,
      this.merchantToken,
      this.restaurantName,
      this.userType,
      this.userAccess,
      this.username,
      this.emailAddress,
      this.contactNumber,
      this.pin,
      this.merchantPhoto});

  MerchantInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    merchantToken = json['merchant_token'];
    restaurantName = json['restaurant_name'];
    userType = json['user_type'];
    userAccess = json['user_access'];
    username = json['username'];
    emailAddress = json['email_address'];
    contactNumber = json['contact_number'];
    pin = json['pin'];
    merchantPhoto = json['merchant_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['merchant_id'] = this.merchantId;
    data['merchant_token'] = this.merchantToken;
    data['restaurant_name'] = this.restaurantName;
    data['user_type'] = this.userType;
    data['user_access'] = this.userAccess;
    data['username'] = this.username;
    data['email_address'] = this.emailAddress;
    data['contact_number'] = this.contactNumber;
    data['pin'] = this.pin;
    data['merchant_photo'] = this.merchantPhoto;
    return data;
  }
}

class DeviceInfo {
  String pushEnabled;
  String subscribeTopic;
  String topicNewOrder;
  String topicAlert;

  DeviceInfo(
      {this.pushEnabled,
      this.subscribeTopic,
      this.topicNewOrder,
      this.topicAlert});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    pushEnabled = json['push_enabled'];
    subscribeTopic = json['subscribe_topic'];
    topicNewOrder = json['topic_new_order'];
    topicAlert = json['topic_alert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['push_enabled'] = this.pushEnabled;
    data['subscribe_topic'] = this.subscribeTopic;
    data['topic_new_order'] = this.topicNewOrder;
    data['topic_alert'] = this.topicAlert;
    return data;
  }
}

class Post {
  String username;
  String password;
  String deviceId;
  String devicePlatform;
  String deviceUiid;
  String codeVersion;
  String merchantToken;
  String apiKey;
  String lang;

  Post(
      {this.username,
      this.password,
      this.deviceId,
      this.devicePlatform,
      this.deviceUiid,
      this.codeVersion,
      this.merchantToken,
      this.apiKey,
      this.lang});

  Post.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
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
    data['username'] = this.username;
    data['password'] = this.password;
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
