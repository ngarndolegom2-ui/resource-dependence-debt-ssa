*==============================================================================
* Effet de la dependance aux ressources naturelles sur la dette publique
* en Afrique subsaharienne
* Master's thesis, University of Dschang, 2023-2024
* Author: NGARNDOLEGOM GOD-FOIS TOG-ASRA (supervisor: Prof. Honore Tekam Oumbe)
*
* 00_master.do : runs the full analysis, from raw data to result tables
*==============================================================================

clear all
set more off

* --- 1. Set the path to the folder where you downloaded this repository -------
*        (all files are in this single folder)
global root "C:/Users/YOURNAME/Documents/resource-dependence-debt-ssa"

global do      "$root"
global data    "$root"
global results "$root"

* --- 2. Install the user-written packages (run once) --------------------------
foreach pkg in ivreg2 ranktest ivreg2h xtabond2 outreg2 asdoc psacalc {
    capture which `pkg'
    if _rc ssc install `pkg', replace
}

* --- 3. Run the analysis -------------------------------------------------------
do "$do/01_prepare_data.do"        // variables, logs, panel declaration
do "$do/02_baseline_ols.do"        // thesis Table 5: pooled OLS
do "$do/03_iv_gmm_lewbel.do"       // thesis Table 6: IV-GMM (Lewbel, 2012)
do "$do/04_robustness_controls.do" // thesis Table 7: additional controls
do "$do/05_quantile.do"            // thesis Table 8: quantile regressions
do "$do/06_system_gmm.do"          // thesis Table 9: system GMM
do "$do/07_descriptives.do"        // thesis Tables 3-4 and figure
do "$do/08_oster_test.do"          // thesis Table 10: Oster (2019), corrected sample
