class DriverWalletModel {
  int code;
  String msg;
  List<Details> details;

  DriverWalletModel({this.code, this.msg, this.details});

  DriverWalletModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String recordId;
  String merchantId;
  String orderId;
  String driverId;
  String subTotal;
  String deliveryFee;
  String merchantEarnings;
  String teamId;
  String taskId;
  String paymentType;
  String accepted;
  String dealType;
  Null deliveryBy;
  String teamLeader;
  String partner;
  Null receiveFromCustomer;
  Null payToMerchant;
  Null driverDeal;
  Null driverCommission;
  Null driverInitialCommission;
  Null driverRevenueAdjustment;
  Null driverRevenue;
  Null adminRevenue;
  String adminRevenueStatus;
  String driverBalance;
  List<MerchantInfo> merchantInfo;

  Details(
      {this.recordId,
      this.merchantId,
      this.orderId,
      this.driverId,
      this.subTotal,
      this.deliveryFee,
      this.merchantEarnings,
      this.teamId,
      this.taskId,
      this.paymentType,
      this.accepted,
      this.dealType,
      this.deliveryBy,
      this.teamLeader,
      this.partner,
      this.receiveFromCustomer,
      this.payToMerchant,
      this.driverDeal,
      this.driverCommission,
      this.driverInitialCommission,
      this.driverRevenueAdjustment,
      this.driverRevenue,
      this.adminRevenue,
      this.adminRevenueStatus,
      this.driverBalance,
      this.merchantInfo});

  Details.fromJson(Map<String, dynamic> json) {
    recordId = json['record_id'];
    merchantId = json['merchant_id'];
    orderId = json['order_id'];
    driverId = json['driver_id'];
    subTotal = json['sub_total'];
    deliveryFee = json['delivery_fee'];
    merchantEarnings = json['merchant_earnings'];
    teamId = json['team_id'];
    taskId = json['task_id'];
    paymentType = json['payment_type'];
    accepted = json['accepted'];
    dealType = json['deal_type'];
    deliveryBy = json['delivery_by'];
    teamLeader = json['team_leader'];
    partner = json['partner'];
    receiveFromCustomer = json['receive_from_customer'];
    payToMerchant = json['pay_to_merchant'];
    driverDeal = json['driver_deal'];
    driverCommission = json['driver_commission'];
    driverInitialCommission = json['driver_initial_commission'];
    driverRevenueAdjustment = json['driver_revenue_adjustment'];
    driverRevenue = json['driver_revenue'];
    adminRevenue = json['admin_revenue'];
    adminRevenueStatus = json['admin_revenue_status'];
    driverBalance = json['driver_balance'];
    if (json['merchant_info'] != null) {
      merchantInfo = new List<MerchantInfo>();
      json['merchant_info'].forEach((v) {
        merchantInfo.add(new MerchantInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['record_id'] = this.recordId;
    data['merchant_id'] = this.merchantId;
    data['order_id'] = this.orderId;
    data['driver_id'] = this.driverId;
    data['sub_total'] = this.subTotal;
    data['delivery_fee'] = this.deliveryFee;
    data['merchant_earnings'] = this.merchantEarnings;
    data['team_id'] = this.teamId;
    data['task_id'] = this.taskId;
    data['payment_type'] = this.paymentType;
    data['accepted'] = this.accepted;
    data['deal_type'] = this.dealType;
    data['delivery_by'] = this.deliveryBy;
    data['team_leader'] = this.teamLeader;
    data['partner'] = this.partner;
    data['receive_from_customer'] = this.receiveFromCustomer;
    data['pay_to_merchant'] = this.payToMerchant;
    data['driver_deal'] = this.driverDeal;
    data['driver_commission'] = this.driverCommission;
    data['driver_initial_commission'] = this.driverInitialCommission;
    data['driver_revenue_adjustment'] = this.driverRevenueAdjustment;
    data['driver_revenue'] = this.driverRevenue;
    data['admin_revenue'] = this.adminRevenue;
    data['admin_revenue_status'] = this.adminRevenueStatus;
    data['driver_balance'] = this.driverBalance;
    if (this.merchantInfo != null) {
      data['merchant_info'] = this.merchantInfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MerchantInfo {
  String merchantId;
  String restaurantSlug;
  String restaurantName;
  String restaurantPhone;
  String contactName;
  String contactPhone;
  String contactEmail;
  String countryCode;
  String street;
  String city;
  String state;
  String postCode;
  String cuisine;
  String service;
  String freeDelivery;
  String deliveryEstimation;
  String username;
  String password;
  String activationKey;
  String activationToken;
  String status;
  String dateCreated;
  String dateModified;
  String dateActivated;
  String lastLogin;
  String ipAddress;
  String packageId;
  String packagePrice;
  String membershipExpired;
  String paymentSteps;
  String isFeatured;
  String isReady;
  String isSponsored;
  Null sponsoredExpiration;
  String lostPasswordCode;
  String userLang;
  String membershipPurchaseDate;
  String sortFeatured;
  String isCommission;
  String percentCommision;
  String abn;
  String sessionToken;
  String commisionType;
  String mobileSessionToken;
  String merchantKey;
  String latitude;
  String lontitude;
  String deliveryCharges;
  String minimumOrder;
  String deliveryMinimumOrder;
  String deliveryMaximumOrder;
  String pickupMinimumOrder;
  String pickupMaximumOrder;
  String countryName;
  String countryId;
  String stateId;
  String cityId;
  String areaId;
  String logo;
  String merchantType;
  String invoiceTerms;
  String paymentGatewayRef;
  String userAccess;
  String distanceUnit;
  String deliveryDistanceCovered;
  String closeStore;
  String pin;
  Null dealType;
  Null deliveryBy;
  String teamLeader;
  String partner;
  Null restaurantNameTrans;
  Null adminId;

  MerchantInfo(
      {this.merchantId,
      this.restaurantSlug,
      this.restaurantName,
      this.restaurantPhone,
      this.contactName,
      this.contactPhone,
      this.contactEmail,
      this.countryCode,
      this.street,
      this.city,
      this.state,
      this.postCode,
      this.cuisine,
      this.service,
      this.freeDelivery,
      this.deliveryEstimation,
      this.username,
      this.password,
      this.activationKey,
      this.activationToken,
      this.status,
      this.dateCreated,
      this.dateModified,
      this.dateActivated,
      this.lastLogin,
      this.ipAddress,
      this.packageId,
      this.packagePrice,
      this.membershipExpired,
      this.paymentSteps,
      this.isFeatured,
      this.isReady,
      this.isSponsored,
      this.sponsoredExpiration,
      this.lostPasswordCode,
      this.userLang,
      this.membershipPurchaseDate,
      this.sortFeatured,
      this.isCommission,
      this.percentCommision,
      this.abn,
      this.sessionToken,
      this.commisionType,
      this.mobileSessionToken,
      this.merchantKey,
      this.latitude,
      this.lontitude,
      this.deliveryCharges,
      this.minimumOrder,
      this.deliveryMinimumOrder,
      this.deliveryMaximumOrder,
      this.pickupMinimumOrder,
      this.pickupMaximumOrder,
      this.countryName,
      this.countryId,
      this.stateId,
      this.cityId,
      this.areaId,
      this.logo,
      this.merchantType,
      this.invoiceTerms,
      this.paymentGatewayRef,
      this.userAccess,
      this.distanceUnit,
      this.deliveryDistanceCovered,
      this.closeStore,
      this.pin,
      this.dealType,
      this.deliveryBy,
      this.teamLeader,
      this.partner,
      this.restaurantNameTrans,
      this.adminId});

  MerchantInfo.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchant_id'];
    restaurantSlug = json['restaurant_slug'];
    restaurantName = json['restaurant_name'];
    restaurantPhone = json['restaurant_phone'];
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    contactEmail = json['contact_email'];
    countryCode = json['country_code'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    postCode = json['post_code'];
    cuisine = json['cuisine'];
    service = json['service'];
    freeDelivery = json['free_delivery'];
    deliveryEstimation = json['delivery_estimation'];
    username = json['username'];
    password = json['password'];
    activationKey = json['activation_key'];
    activationToken = json['activation_token'];
    status = json['status'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
    dateActivated = json['date_activated'];
    lastLogin = json['last_login'];
    ipAddress = json['ip_address'];
    packageId = json['package_id'];
    packagePrice = json['package_price'];
    membershipExpired = json['membership_expired'];
    paymentSteps = json['payment_steps'];
    isFeatured = json['is_featured'];
    isReady = json['is_ready'];
    isSponsored = json['is_sponsored'];
    sponsoredExpiration = json['sponsored_expiration'];
    lostPasswordCode = json['lost_password_code'];
    userLang = json['user_lang'];
    membershipPurchaseDate = json['membership_purchase_date'];
    sortFeatured = json['sort_featured'];
    isCommission = json['is_commission'];
    percentCommision = json['percent_commision'];
    abn = json['abn'];
    sessionToken = json['session_token'];
    commisionType = json['commision_type'];
    mobileSessionToken = json['mobile_session_token'];
    merchantKey = json['merchant_key'];
    latitude = json['latitude'];
    lontitude = json['lontitude'];
    deliveryCharges = json['delivery_charges'];
    minimumOrder = json['minimum_order'];
    deliveryMinimumOrder = json['delivery_minimum_order'];
    deliveryMaximumOrder = json['delivery_maximum_order'];
    pickupMinimumOrder = json['pickup_minimum_order'];
    pickupMaximumOrder = json['pickup_maximum_order'];
    countryName = json['country_name'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    logo = json['logo'];
    merchantType = json['merchant_type'];
    invoiceTerms = json['invoice_terms'];
    paymentGatewayRef = json['payment_gateway_ref'];
    userAccess = json['user_access'];
    distanceUnit = json['distance_unit'];
    deliveryDistanceCovered = json['delivery_distance_covered'];
    closeStore = json['close_store'];
    pin = json['pin'];
    dealType = json['deal_type'];
    deliveryBy = json['delivery_by'];
    teamLeader = json['team_leader'];
    partner = json['partner'];
    restaurantNameTrans = json['restaurant_name_trans'];
    adminId = json['admin_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchant_id'] = this.merchantId;
    data['restaurant_slug'] = this.restaurantSlug;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_phone'] = this.restaurantPhone;
    data['contact_name'] = this.contactName;
    data['contact_phone'] = this.contactPhone;
    data['contact_email'] = this.contactEmail;
    data['country_code'] = this.countryCode;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['post_code'] = this.postCode;
    data['cuisine'] = this.cuisine;
    data['service'] = this.service;
    data['free_delivery'] = this.freeDelivery;
    data['delivery_estimation'] = this.deliveryEstimation;
    data['username'] = this.username;
    data['password'] = this.password;
    data['activation_key'] = this.activationKey;
    data['activation_token'] = this.activationToken;
    data['status'] = this.status;
    data['date_created'] = this.dateCreated;
    data['date_modified'] = this.dateModified;
    data['date_activated'] = this.dateActivated;
    data['last_login'] = this.lastLogin;
    data['ip_address'] = this.ipAddress;
    data['package_id'] = this.packageId;
    data['package_price'] = this.packagePrice;
    data['membership_expired'] = this.membershipExpired;
    data['payment_steps'] = this.paymentSteps;
    data['is_featured'] = this.isFeatured;
    data['is_ready'] = this.isReady;
    data['is_sponsored'] = this.isSponsored;
    data['sponsored_expiration'] = this.sponsoredExpiration;
    data['lost_password_code'] = this.lostPasswordCode;
    data['user_lang'] = this.userLang;
    data['membership_purchase_date'] = this.membershipPurchaseDate;
    data['sort_featured'] = this.sortFeatured;
    data['is_commission'] = this.isCommission;
    data['percent_commision'] = this.percentCommision;
    data['abn'] = this.abn;
    data['session_token'] = this.sessionToken;
    data['commision_type'] = this.commisionType;
    data['mobile_session_token'] = this.mobileSessionToken;
    data['merchant_key'] = this.merchantKey;
    data['latitude'] = this.latitude;
    data['lontitude'] = this.lontitude;
    data['delivery_charges'] = this.deliveryCharges;
    data['minimum_order'] = this.minimumOrder;
    data['delivery_minimum_order'] = this.deliveryMinimumOrder;
    data['delivery_maximum_order'] = this.deliveryMaximumOrder;
    data['pickup_minimum_order'] = this.pickupMinimumOrder;
    data['pickup_maximum_order'] = this.pickupMaximumOrder;
    data['country_name'] = this.countryName;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['logo'] = this.logo;
    data['merchant_type'] = this.merchantType;
    data['invoice_terms'] = this.invoiceTerms;
    data['payment_gateway_ref'] = this.paymentGatewayRef;
    data['user_access'] = this.userAccess;
    data['distance_unit'] = this.distanceUnit;
    data['delivery_distance_covered'] = this.deliveryDistanceCovered;
    data['close_store'] = this.closeStore;
    data['pin'] = this.pin;
    data['deal_type'] = this.dealType;
    data['delivery_by'] = this.deliveryBy;
    data['team_leader'] = this.teamLeader;
    data['partner'] = this.partner;
    data['restaurant_name_trans'] = this.restaurantNameTrans;
    data['admin_id'] = this.adminId;
    return data;
  }
}
