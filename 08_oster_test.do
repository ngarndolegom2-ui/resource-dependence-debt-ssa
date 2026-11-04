*==============================================================================
* 08_oster_test.do : thesis Table 10, coefficient stability test (Oster, 2019)
* Estimates how strong selection on unobservables would have to be, relative
* to selection on observables, to drive the effect of resource rents to zero.
*
* CORRECTION: in the original do-file, the command "keep if Time==2014" (used
* for a figure) was executed before this test, so Table 10 of the thesis was
* computed on the 2014 cross-section only (38 observations; beta = -0.048,
* not significant). This file runs the test on the full panel, the sample used
* for every other table. See the README.
*==============================================================================

use "$data/analysis.dta", clear

reg lnDettesExt lnRN OuvertureC IDE lnPIB AEF, r
psacalc delta lnRN
psacalc beta lnRN
