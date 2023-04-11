// To parse this JSON data, do
//
//     final dataProduct = dataProductFromJson(jsonString);

import 'dart:convert';

DataProduct dataProductFromJson(String str) => DataProduct.fromJson(json.decode(str));

String dataProductToJson(DataProduct data) => json.encode(data.toJson());

class DataProduct {
    DataProduct({
        required this.isSuccess,
        required this.statusCode,
        required this.products,
    });

    bool isSuccess;
    int statusCode;
    List<Product> products;

    factory DataProduct.fromJson(Map<String, dynamic> json) => DataProduct(
        isSuccess: json["isSuccess"],
        statusCode: json["statusCode"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "statusCode": statusCode,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    Product({
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
        required this.detailEndpoint,
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
    String detailEndpoint;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        detailEndpoint: json["detail-endpoint"],
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
        "detail-endpoint": detailEndpoint,
    };
}
