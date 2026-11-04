*==============================================================================
* 02_baseline_ols.do : thesis Table 5, pooled OLS with heteroskedasticity-robust standard errors
*==============================================================================

use "$data/analysis.dta", clear
xtset id Time
estimates clear

reg lnDettesExt lnRN, r
est store eq1
reg lnDettesExt lnRN OuvertureC, r
est store eq2
reg lnDettesExt lnRN OuvertureC IDE, r
est store eq3
reg lnDettesExt lnRN OuvertureC IDE lnPIB, r
est store eq4
reg lnDettesExt lnRN OuvertureC IDE lnPIB AEF, r
est store eq5

outreg2 [eq*] using "$results/table_ols", dec(3) e(all) replace excel
