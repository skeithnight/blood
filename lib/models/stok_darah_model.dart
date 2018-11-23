import 'detail_stok_darah_model.dart';
class StokDarah{
  String golonganDarah;
  DetailStokDarah WB;
  DetailStokDarah PRC;
  DetailStokDarah TC;
  DetailStokDarah FFP;
  DetailStokDarah AHF;
  DetailStokDarah LP;
  DetailStokDarah WE;
  DetailStokDarah FP;
  DetailStokDarah TC_Aferesis;
  DetailStokDarah BC;

  StokDarah();

  StokDarah.fromSnapshot( Map<dynamic,dynamic> snapshot)
      : WB = DetailStokDarah.fromSnapshot(snapshot['WB']),
        PRC = DetailStokDarah.fromSnapshot(snapshot['PRC']),
        TC = DetailStokDarah.fromSnapshot(snapshot['TC']),
        FFP = DetailStokDarah.fromSnapshot(snapshot['FFP']),
        AHF = DetailStokDarah.fromSnapshot(snapshot['AHF']),
        LP = DetailStokDarah.fromSnapshot(snapshot['LP']),
        WE = DetailStokDarah.fromSnapshot(snapshot['WE']),
        FP = DetailStokDarah.fromSnapshot(snapshot['FP']),
        TC_Aferesis = DetailStokDarah.fromSnapshot(snapshot['TC Aferesis']),
        BC = DetailStokDarah.fromSnapshot(snapshot['BC']);
  toJson() {
    return {
      "WB": WB,
      "PRC": PRC,
      "TC": TC,
      "FFP": FFP,
      "AHF": AHF,
      "LP": LP,
      "WE": WE,
      "FP": FP,
      "TC Aferesis": TC_Aferesis,
      "BC": BC,
    };
  }
}