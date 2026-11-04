*==============================================================================
* 01_prepare_data.do : builds the analysis dataset
* Input : data/ssa_panel_1990_2021_raw.dta (48 countries, 1990-2021, World Bank)
* Output: data/analysis.dta
*==============================================================================

use "$data/ssa_panel_1990_2021_raw.dta", clear

* --- Panel identifier and declaration -----------------------------------------
capture drop id
egen id = group(CountryName)
xtset id Time

* --- Variables used in the thesis (World Bank WDI and WGI series) -------------
gen RN          = Totalnaturalresourcesrents    // total natural resource rents (% of GDP)
gen DettesExt   = ExternaldebtstocksofGNI       // external debt stocks (% of GNI)
gen PIB         = GDPpercapitaconstant2015US    // GDP per capita (constant 2015 US$)
gen OuvertureC  = TradeofGDPNETRDGNFSZS         // trade openness (% of GDP)
gen IDE         = Foreigndirectinvestmentneti   // FDI, net inflows (% of GDP)
gen AEF         = Laborforcefemaleoftotal       // female labour force (% of total)
gen Electricite = Accesstoelectricityofpopu     // access to electricity (% of population)
gen Internet    = IndividualsusingtheInternet   // internet users (% of population)
gen InclusionF  = Mobilecellularsubscriptionsp  // mobile subscriptions (per 100 people)
gen APF         = Proportionofseatsheldbywome   // seats held by women in parliament (%)
gen Corruption  = ControlofCorruptionEstimate   // WGI control of corruption
gen EG          = GovernmentEffectivenessEstima // WGI government effectiveness
gen QualInst    = RegulatoryQualityEstimateRQ   // WGI regulatory quality

* --- Logarithms -----------------------------------------------------------------
gen lnPIB       = log(PIB)
gen lnRN        = log(RN)
gen lnDettesExt = log(DettesExt)

label var lnDettesExt "Log external debt stocks (% of GNI)"
label var lnRN        "Log total natural resource rents (% of GDP)"
label var lnPIB       "Log GDP per capita"

save "$data/analysis.dta", replace
