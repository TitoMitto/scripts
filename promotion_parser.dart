/**
 * Promotion Parser helps you parse promotion variations.
 * This formula can parse all valid promotion fomulas that don't contain ambiguous syntax
 * 
 * Created by Tito M. Mitto
 * © MittoLabs 
 */

import 'dart:convert';

List parsePromotionFormula(String formula) {
  formula = formula.toLowerCase();
  var trimed = formula.replaceAll(" ", "");
  RegExp matchAfterAnds = new RegExp(r'(\d*)#(\d*)(?=and)');
  RegExp matchBeforeAnds = new RegExp(r'(?<=and)(\d*)#(\d*)');
  RegExp matchOrs = new RegExp(r'(\d*)#(\d*)');

  trimed = trimed.replaceAllMapped(
      matchAfterAnds,
      (m) => json.encode([
            {"quantity": m.group(1), "product_id": m.group(2)}
          ]));

  trimed = trimed.replaceAllMapped(
      matchBeforeAnds,
      (m) => json.encode([
            {"quantity": m.group(1), "product_id": m.group(2)}
          ]));

  trimed = trimed.replaceAllMapped(matchOrs,
      (m) => json.encode({"quantity": m.group(1), "product_id": m.group(2)}));

  trimed = trimed.replaceAll("and", ",");
  trimed = trimed.replaceAll("or", ",");
  trimed = trimed.replaceAll("(", "[");
  trimed = trimed.replaceAll(")", "]");

  return json.decode("[$trimed]");
}

bool passesPromotion(List<Map<String, int>> products, String formula) {
  var promotions = parsePromotionFormula(formula);
  List<bool> passes = [];

  for (var group in promotions) {
    if (group is List && group.length == 1 && group.first is Map) {
      var isPassing = products.any((product) =>
          product["product_id"] == int.parse("${group.first["product_id"]}") &&
          product["quantity"] >= int.parse("${group.first["quantity"]}"));

      passes.add(isPassing);
    } else if (group is List &&
        group.length > 1 &&
        group.every((i) => i is Map)) {
      bool isPassing = group.any((item) => products.any((p) =>
          p["product_id"] == int.parse("${item.first["product_id"]}") &&
          p["quantity"] >= int.parse("${item.first["quantity"]}")));

      passes.add(isPassing);
    } else if (group is List &&
        group.length > 1 &&
        group.every((i) => i is List)) {
      for (var i in group) {
        var isPassing = products.any((product) =>
            product["product_id"] == int.parse("${i.first["product_id"]}") &&
            product["quantity"] >= int.parse("${i.first["quantity"]}"));
        passes.add(isPassing);
      }
    } else if (group is Map) {
      bool isPassing = products.any((item) =>
          int.parse("${group["product_id"]}") == item["product_id"] &&
          int.parse("${group["quantity"]}") == item["quantity"]);

      passes.add(isPassing);
    }
  }

  return !passes.contains(false);
}

void main() {
  print("PROMO ${parsePromotionFormula('(2#4 and 4#6)')}");
  print("PASSES ${passesPromotion([
    {"product_id": 4, "quantity": 2},
    {"product_id": 6, "quantity": 4}
  ], "(2#4 and 4#6)")}");
}
