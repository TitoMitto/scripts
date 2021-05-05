/**
 * Promotion Parser helps you parse promotion variations.
 * This formula can parse all valid promotion fomulas that don't contain ambiguous syntax
 * 
 * Created by Tito M. Mitto
 * © MittoLabs 
 */

import 'dart:convert';

parsePromotionFormula(String formula) {
  formula = formula.toLowerCase();
  var trimed = formula.replaceAll(" ", "");
  RegExp matchAfterAnds = new RegExp(r'(\d*)#(\d*)(?=and)');
  RegExp matchBeforeAnds = new RegExp(r'(?<=and)(\d*)#(\d*)');
  RegExp matchOrs = new RegExp(r'(\d*)#(\d*)');
 
  trimed = trimed.replaceAllMapped(matchAfterAnds, (m)=> json.encode([{
    "quantity": m.group(1),
    "product_id": m.group(2)
  }]));
  trimed = trimed.replaceAllMapped(matchBeforeAnds, (m)=> json.encode([{
    "quantity": m.group(1),
    "product_id": m.group(2)
  }]));
  trimed = trimed.replaceAll("and", ",");
  trimed = trimed.replaceAllMapped(matchOrs, (m)=> json.encode({
    "quantity": m.group(1),
    "product_id": m.group(2)
  }));
  trimed = trimed.replaceAll("or", ",");
  trimed = trimed.replaceAll("(", "[");
  trimed = trimed.replaceAll(")", "]");
  return json.decode("[$trimed]");
}



void main() {
  print(parsePromotionFormula("(2#2 or 3#3) and (2#4 and (3#8 or 3#7))"));
 
}
