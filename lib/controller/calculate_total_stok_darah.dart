class CalculateTotalStokDarah {
  int totalAPos(snapshot) {
    return snapshot.data.WB.a_pos +
        snapshot.data.PRC.a_pos +
        snapshot.data.TC.a_pos +
        snapshot.data.FFP.a_pos +
        snapshot.data.AHF.a_pos +
        snapshot.data.LP.a_pos +
        snapshot.data.WE.a_pos +
        snapshot.data.FP.a_pos +
        snapshot.data.TC_Aferesis.a_pos +
        snapshot.data.BC.a_pos;
  }
  int totalANeg(snapshot) {
    return snapshot.data.WB.a_neg +
        snapshot.data.PRC.a_neg +
        snapshot.data.TC.a_neg +
        snapshot.data.FFP.a_neg +
        snapshot.data.AHF.a_neg +
        snapshot.data.LP.a_neg +
        snapshot.data.WE.a_neg +
        snapshot.data.FP.a_neg +
        snapshot.data.TC_Aferesis.a_neg +
        snapshot.data.BC.a_neg;
  }
}