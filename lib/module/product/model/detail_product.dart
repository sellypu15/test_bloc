// To parse this JSON data, do
//
//     final detailProduct = detailProductFromJson(jsonString);

import 'dart:convert';

DetailProduct detailProductFromJson(String str) => DetailProduct.fromJson(json.decode(str));

String detailProductToJson(DetailProduct data) => json.encode(data.toJson());

class DetailProduct {
    DetailProduct({
        required this.isSuccess,
        required this.statusCode,
        required this.data,
    });

    bool isSuccess;
    int statusCode;
    Data data;

    factory DetailProduct.fromJson(Map<String, dynamic> json) => DetailProduct(
        isSuccess: json["isSuccess"],
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "statusCode": statusCode,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.id,
        required this.name,
        required this.defaultImageUrl,
        required this.pricePerGram,
        required this.productPlu,
        required this.productCode,
        required this.unit,
        required this.price,
        required this.sku,
        required this.productSellingPrice,
        required this.productDiscountPrice,
        required this.description,
    });

    int id;
    String name;
    String defaultImageUrl;
    String pricePerGram;
    String productPlu;
    String productCode;
    String unit;
    String price;
    String sku;
    String productSellingPrice;
    String productDiscountPrice;
    String description;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        defaultImageUrl: json["default_image_url"],
        pricePerGram: json["price_per_gram"],
        productPlu: json["product_plu"],
        productCode: json["product_code"],
        unit: json["unit"],
        price: json["price"],
        sku: json["sku"],
        productSellingPrice: json["product_selling_price"],
        productDiscountPrice: json["product_discount_price"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "default_image_url": defaultImageUrl,
        "price_per_gram": pricePerGram,
        "product_plu": productPlu,
        "product_code": productCode,
        "unit": unit,
        "price": price,
        "sku": sku,
        "product_selling_price": productSellingPrice,
        "product_discount_price": productDiscountPrice,
        "description": description,
    };
}
