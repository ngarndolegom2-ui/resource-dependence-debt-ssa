*==============================================================================
* 06_system_gmm.do : thesis Table 9, dynamic panel, two-step system GMM (Roodman, 2009)
* GMM-style instruments are collapsed to limit instrument proliferation.
* The lag ranges below are those used in the thesis; they differ across
* columns (see "Limitations" in the README).
* Diagnostics reported: AR(1), AR(2) and Hansen tests.
*==============================================================================

use "$data/analysis.dta", clear
xtset id Time
estimates clear

xtabond2 lnDettesExt l.lnDettesExt lnRN, ///
    gmm(lnDettesExt QualInst l.lnRN, collapse lag(16 7)) iv(lnRN l.lnDettesExt L.AEF) twostep small
est store eq1
xtabond2 lnDettesExt l.lnDettesExt lnRN OuvertureC, ///
    gmm(lnDettesExt QualInst l.lnRN, collapse lag(7 6)) iv(lnRN l.lnDettesExt L.AEF) twostep small
est store eq2
xtabond2 lnDettesExt l.lnDettesExt lnRN OuvertureC IDE, ///
    gmm(lnDettesExt QualInst l.lnRN, collapse lag(2 7)) iv(lnRN l.lnDettesExt L.AEF) twostep small
est store eq3
xtabond2 lnDettesExt l.lnDettesExt lnRN OuvertureC IDE lnPIB, ///
    gmm(lnDettesExt QualInst l.lnRN, collapse lag(3 2)) iv(lnRN l.lnDettesExt L.AEF) twostep small
est store eq4
xtabond2 lnDettesExt l.lnDettesExt lnRN OuvertureC IDE lnPIB AEF, ///
    gmm(lnDettesExt QualInst l.lnRN, collapse lag(8 16)) iv(lnRN l.lnDettesExt L.AEF) twostep small
est store eq5

outreg2 [eq*] using "$results/table_system_gmm", dec(3) e(all) replace excel
