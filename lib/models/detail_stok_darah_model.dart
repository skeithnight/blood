class DetailStokDarah{
  int a_pos;
  int b_pos;
  int ab_pos;
  int o_pos;
  int a_neg;
  int b_neg;
  int ab_neg;
  int o_neg;

  DetailStokDarah();

  DetailStokDarah.fromSnapshot( Map<dynamic,dynamic> snapshot)
      : a_pos = int.parse(snapshot["a_pos"]),
        b_pos = int.parse(snapshot["b_pos"]),
        ab_pos = int.parse(snapshot["ab_pos"]),
        o_pos = int.parse(snapshot["o_pos"]),
        a_neg = int.parse(snapshot["a_neg"]),
        b_neg = int.parse(snapshot["b_neg"]),
        ab_neg = int.parse(snapshot["ab_neg"]),
        o_neg = int.parse(snapshot["o_neg"]);

  toJson() {
    return {
      "a_pos": a_pos,
      "b_pos": b_pos,
      "ab_pos": ab_pos,
      "o_pos": o_pos,
      "a_neg": a_neg,
      "b_neg": b_neg,
      "ab_neg": ab_neg,
      "o_neg": o_neg,
    };
  }
}