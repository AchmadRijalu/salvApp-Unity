// To parse this JSON data, do
//
//     final kota = kotaFromJson(jsonString);

import 'dart:convert';

Kota kotaFromJson(String str) => Kota.fromJson(json.decode(str));

String kotaToJson(Kota data) => json.encode(data.toJson());

class Kota {
    Kota({
        required this.code,
        required this.messages,
        required this.value,
    });

    String code;
    String messages;
    List<KotaValue> value;

    factory Kota.fromJson(Map<String, dynamic> json) => Kota(
        code: json["code"],
        messages: json["messages"],
        value: List<KotaValue>.from(json["value"].map((x) => KotaValue.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "messages": messages,
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
    };
}

class KotaValue {
    KotaValue({
        required this.id,
        required this.idProvinsi,
        required this.name,
    });

    String id;
    String idProvinsi;
    String name;

    factory KotaValue.fromJson(Map<String, dynamic> json) => KotaValue(
        id: json["id"],
        idProvinsi: json["id_provinsi"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_provinsi": idProvinsi,
        "name": name,
    };
}
