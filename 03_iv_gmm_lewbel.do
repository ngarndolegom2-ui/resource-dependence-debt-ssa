*==============================================================================
* 03_iv_gmm_lewbel.do : thesis Table 6, treatment of endogeneity
* Two-step efficient GMM. Resource rents are instrumented by their own lags,
* complemented by heteroskedasticity-based instruments (Lewbel, 2012) through
* ivreg2h. First-stage diagnostics are reported with the ffirst option.
*==============================================================================

use "$data/analysis.dta", clear
xtset id Time
estimates clear

ivreg2h lnDettesExt (lnRN = l.lnRN l2.lnRN), r ffirst gmm2s
est store eq1
ivreg2h lnDettesExt (lnRN = l.lnRN l2.lnRN) OuvertureC, r ffirst gmm2s
est store eq2
ivreg2h lnDettesExt (lnRN = l.lnRN l2.lnRN) OuvertureC IDE, r ffirst gmm2s
est store eq3
ivreg2h lnDettesExt (lnRN = l.lnRN l2.lnRN) OuvertureC IDE lnPIB, r ffirst gmm2s
est store eq4
* Column 5 uses lags 1 and 3, as in the thesis
ivreg2h lnDettesExt (lnRN = l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF, r ffirst gmm2s
est store eq5

outreg2 [eq*] using "$results/table_iv_gmm", dec(3) e(all) replace excel
