*==============================================================================
* 04_robustness_controls.do : thesis Table 7, robustness to additional control variables
* (internet use, mobile subscriptions, access to electricity)
*==============================================================================

use "$data/analysis.dta", clear
xtset id Time
estimates clear

ivreg2h lnDettesExt (lnRN = l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF, r ffirst gmm2s
est store eq1
ivreg2h lnDettesExt (lnRN = l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF Internet, r ffirst gmm2s
est store eq2
ivreg2h lnDettesExt (lnRN = l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF InclusionF, r ffirst gmm2s
est store eq3
ivreg2h lnDettesExt (lnRN = l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF Electricite, r ffirst gmm2s
est store eq4
ivreg2h lnDettesExt (lnRN = l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF Internet InclusionF Electricite, r ffirst gmm2s
est store eq5

outreg2 [eq*] using "$results/table_robustness", dec(3) e(all) replace excel
