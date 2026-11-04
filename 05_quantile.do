*==============================================================================
* 05_quantile.do : thesis Table 8, quantile regressions (25th, 50th and 75th percentiles)
* Tests whether the rents-debt relationship differs across the debt distribution.
*==============================================================================

use "$data/analysis.dta", clear
estimates clear

qreg lnDettesExt lnRN OuvertureC IDE lnPIB AEF, quantile(0.25)
est store eq1
qreg lnDettesExt lnRN OuvertureC IDE lnPIB AEF, quantile(0.50)
est store eq2
qreg lnDettesExt lnRN OuvertureC IDE lnPIB AEF, quantile(0.75)
est store eq3

outreg2 [eq*] using "$results/table_quantile", dec(3) e(all) replace excel
