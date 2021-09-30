class OrderModel {
  int code;
  List<Msg> msg;
  Details details;

  OrderModel({this.code, this.msg, this.details});

  OrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['msg'] != null) {
      msg = new List<Msg>();
      json['msg'].forEach((v) {
        msg.add(new Msg.fromJson(v));
      });
    }
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.msg != null) {
      data['msg'] = this.msg.map((v) => v.toJson()).toList();
    }
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    return data;
  }
}

class Msg {
  String label;
  String value;

  Msg({this.label, this.value});

  Msg.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class Details {
  List<Item> item;
  Total total;
  Settings settings;
  OrderInfo orderInfo;

  Details({this.item, this.total, this.settings, this.orderInfo});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = new List<Item>();
      json['item'].forEach((v) {
        item.add(new Item.fromJson(v));
      });
    }
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    orderInfo = json['order_info'] != null
        ? new OrderInfo.fromJson(json['order_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item.map((v) => v.toJson()).toList();
    }
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings.toJson();
    }
    if (this.orderInfo != null) {
      data['order_info'] = this.orderInfo.toJson();
    }
    return data;
  }
}

class Item {
  String itemId;
  String itemName;
  String sizeWords;
  int sizeId;
  int qty;
  String normalPrice;
  String discountedPrice;
  String discount;
  String orderNotes;
  String cookingRef;
  String ingredients;
  String nonTaxable;
  String categoryId;
  String categoryName;
  String categoryNameTrans;
  ItemNameTrans itemNameTrans;
  String sizeNameTrans;
  String cookingNameTrans;

  Item(
      {this.itemId,
      this.itemName,
      this.sizeWords,
      this.sizeId,
      this.qty,
      this.normalPrice,
      this.discountedPrice,
      this.discount,
      this.orderNotes,
      this.cookingRef,
      this.ingredients,
      this.nonTaxable,
      this.categoryId,
      this.categoryName,
      this.categoryNameTrans,
      this.itemNameTrans,
      this.sizeNameTrans,
      this.cookingNameTrans});

  Item.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemName = json['item_name'];
    sizeWords = json['size_words'];
    sizeId = json['size_id'];
    qty = json['qty'];
    normalPrice = json['normal_price'];
    discountedPrice = json['discounted_price'];
    discount = json['discount'];
    orderNotes = json['order_notes'];
    cookingRef = json['cooking_ref'];
    ingredients = json['ingredients'];
    nonTaxable = json['non_taxable'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    // categoryNameTrans = json['category_name_trans'];
    // itemNameTrans = json['item_name_trans'] != null
    //     ? new ItemNameTrans.fromJson(json['item_name_trans'])
    //     : null;
    // sizeNameTrans = json['size_name_trans'];
    // cookingNameTrans = json['cooking_name_trans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['size_words'] = this.sizeWords;
    data['size_id'] = this.sizeId;
    data['qty'] = this.qty;
    data['normal_price'] = this.normalPrice;
    data['discounted_price'] = this.discountedPrice;
    data['discount'] = this.discount;
    data['order_notes'] = this.orderNotes;
    data['cooking_ref'] = this.cookingRef;
    data['ingredients'] = this.ingredients;
    data['non_taxable'] = this.nonTaxable;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    // data['category_name_trans'] = this.categoryNameTrans;
    if (this.itemNameTrans != null) {
      data['item_name_trans'] = this.itemNameTrans.toJson();
    }
    data['size_name_trans'] = this.sizeNameTrans;
    data['cooking_name_trans'] = this.cookingNameTrans;
    return data;
  }
}

class ItemNameTrans {
  String itemNameTrans;

  ItemNameTrans({this.itemNameTrans});

  ItemNameTrans.fromJson(Map<String, dynamic> json) {
    // itemNameTrans = json['item_name_trans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name_trans'] = this.itemNameTrans;
    return data;
  }
}

class Total {
  dynamic subtotal;
  int taxableTotal;
  String deliveryCharges;
  dynamic total;
  String tax;
  String taxAmt;
  String curr;
  String mid;
  dynamic discountedAmount;
  dynamic merchantDiscountAmount;
  String merchantPackagingCharge;
  dynamic lessVoucher;
  String voucherType;
  String tips;
  String tipsPercent;
  String cartTipPercentage;
  dynamic ptsRedeemAmt;
  dynamic voucherValue;
  String voucherTypes;
  String calculationMethod;
  dynamic ptsRedeemAmtOrig;
  dynamic lessVoucherOrig;

  Total(
      {this.subtotal,
      this.taxableTotal,
      this.deliveryCharges,
      this.total,
      this.tax,
      this.taxAmt,
      this.curr,
      this.mid,
      this.discountedAmount,
      this.merchantDiscountAmount,
      this.merchantPackagingCharge,
      this.lessVoucher,
      this.voucherType,
      this.tips,
      this.tipsPercent,
      this.cartTipPercentage,
      this.ptsRedeemAmt,
      this.voucherValue,
      this.voucherTypes,
      this.calculationMethod,
      this.ptsRedeemAmtOrig,
      this.lessVoucherOrig});

  Total.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    taxableTotal = json['taxable_total'];
    deliveryCharges = json['delivery_charges'];
    total = json['total'];
    tax = json['tax'];
    taxAmt = json['tax_amt'];
    curr = json['curr'];
    mid = json['mid'];
    discountedAmount = json['discounted_amount'];
    merchantDiscountAmount = json['merchant_discount_amount'];
    merchantPackagingCharge = json['merchant_packaging_charge'];
    lessVoucher = json['less_voucher'];
    voucherType = json['voucher_type'];
    tips = json['tips'];
    tipsPercent = json['tips_percent'];
    cartTipPercentage = json['cart_tip_percentage'];
    ptsRedeemAmt = json['pts_redeem_amt'];
    voucherValue = json['voucher_value'];
    voucherTypes = json['voucher_types'];
    calculationMethod = json['calculation_method'];
    ptsRedeemAmtOrig = json['pts_redeem_amt_orig'];
    lessVoucherOrig = json['less_voucher_orig'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['taxable_total'] = this.taxableTotal;
    data['delivery_charges'] = this.deliveryCharges;
    data['total'] = this.total;
    data['tax'] = this.tax;
    data['tax_amt'] = this.taxAmt;
    data['curr'] = this.curr;
    data['mid'] = this.mid;
    data['discounted_amount'] = this.discountedAmount;
    data['merchant_discount_amount'] = this.merchantDiscountAmount;
    data['merchant_packaging_charge'] = this.merchantPackagingCharge;
    data['less_voucher'] = this.lessVoucher;
    data['voucher_type'] = this.voucherType;
    data['tips'] = this.tips;
    data['tips_percent'] = this.tipsPercent;
    data['cart_tip_percentage'] = this.cartTipPercentage;
    data['pts_redeem_amt'] = this.ptsRedeemAmt;
    data['voucher_value'] = this.voucherValue;
    data['voucher_types'] = this.voucherTypes;
    data['calculation_method'] = this.calculationMethod;
    data['pts_redeem_amt_orig'] = this.ptsRedeemAmtOrig;
    data['less_voucher_orig'] = this.lessVoucherOrig;
    return data;
  }
}

class Settings {
  String decimalPlace;
  String currencyPosition;
  String currencySet;
  String thousandSeparator;
  String decimalSeparator;

  Settings(
      {this.decimalPlace,
      this.currencyPosition,
      this.currencySet,
      this.thousandSeparator,
      this.decimalSeparator});

  Settings.fromJson(Map<String, dynamic> json) {
    decimalPlace = json['decimal_place'];
    currencyPosition = json['currency_position'];
    currencySet = json['currency_set'];
    thousandSeparator = json['thousand_separator'];
    decimalSeparator = json['decimal_separator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['decimal_place'] = this.decimalPlace;
    data['currency_position'] = this.currencyPosition;
    data['currency_set'] = this.currencySet;
    data['thousand_separator'] = this.thousandSeparator;
    data['decimal_separator'] = this.decimalSeparator;
    return data;
  }
}

class OrderInfo {
  String orderId;
  String orderChange;

  OrderInfo({this.orderId, this.orderChange});

  OrderInfo.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderChange = json['order_change'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_change'] = this.orderChange;
    return data;
  }
}
