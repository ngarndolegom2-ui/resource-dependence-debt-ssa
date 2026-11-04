*==============================================================================
* 07_descriptives.do : thesis Tables 3-4, descriptive statistics, correlation matrix and figure
*==============================================================================

use "$data/analysis.dta", clear

* --- Descriptive statistics and correlations (Word tables via asdoc) ------------
asdoc sum lnDettesExt lnRN OuvertureC IDE lnPIB AEF Internet InclusionF Electricite, ///
    save("$results/descriptives.doc") replace
asdoc corr lnDettesExt lnRN OuvertureC IDE lnPIB AEF, ///
    save("$results/correlations.doc") replace

* --- Figure: country averages of external debt and resource rents ---------------
preserve
collapse (mean) lnDettesExt lnRN, by(CountryName CountryCode)
twoway (lfit lnDettesExt lnRN) (scatter lnDettesExt lnRN, mlabel(CountryCode)), ///
    xtitle("Log natural resource rents (% of GDP), country average 1990-2021") ///
    ytitle("Log external debt (% of GNI), country average") legend(off)
graph export "$results/figure_rents_debt.png", replace width(2000)
restore
