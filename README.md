# Natural resource dependence and external debt in Sub-Saharan Africa

Replication code and data for my Master's thesis in Economics (Monetary and Banking Economics), Dschang School of Economics and Management, University of Dschang, Cameroon, academic year 2023–2024 (graded 15/20):

> *Effet de la dépendance aux ressources naturelles sur la dette publique en Afrique subsaharienne* (Effect of natural resource dependence on public debt in Sub-Saharan Africa). Supervisor: Prof. Honoré Tekam Oumbe.

**Author:** NGARNDOLEGOM GOD-FOIS TOG-ASRA · [ORCID 0009-0002-8884-6109](https://orcid.org/0009-0002-8884-6109)

## Research question

Do Sub-Saharan African countries that depend more on natural resource rents accumulate more external debt? The thesis estimates the elasticity of external debt with respect to total natural resource rents in a panel of 48 countries over 1990–2021.

## Data

`ssa_panel_1990_2021_raw.dta` contains the raw panel (48 countries × 32 years) from the World Bank's World Development Indicators (WDI) and Worldwide Governance Indicators (WGI), both published under a CC BY 4.0 licence.

| Variable | Definition | WDI / WGI series |
|---|---|---|
| `lnDettesExt` | Log of external debt stocks (% of GNI) | DT.DOD.DECT.GN.ZS |
| `lnRN` | Log of total natural resource rents (% of GDP) | NY.GDP.TOTL.RT.ZS |
| `OuvertureC` | Trade (% of GDP) | NE.TRD.GNFS.ZS |
| `IDE` | Foreign direct investment, net inflows (% of GDP) | WDI |
| `lnPIB` | Log of GDP per capita (constant 2015 US$) | WDI |
| `AEF` | Female labour force (% of total labour force) | WDI |
| `Internet` | Individuals using the Internet (% of population) | WDI |
| `InclusionF` | Mobile cellular subscriptions (per 100 people) | WDI |
| `Electricite` | Access to electricity (% of population) | WDI |
| `QualInst` | Regulatory quality (GMM instrument) | WGI |

Variable names are in French, as in the thesis.

## Methods and correspondence with the thesis

| Do-file | Method | Thesis table |
|---|---|---|
| `07_descriptives.do` | Descriptive statistics and correlation matrix | Tables 3–4 |
| `02_baseline_ols.do` | Pooled OLS, robust standard errors | Table 5 |
| `03_iv_gmm_lewbel.do` | Two-step IV-GMM with lagged rents and heteroskedasticity-based instruments (Lewbel, 2012) | Table 6 |
| `04_robustness_controls.do` | IV-GMM with additional controls | Table 7 |
| `05_quantile.do` | Quantile regressions (25th, 50th, 75th percentiles) | Table 8 |
| `06_system_gmm.do` | Two-step system GMM with collapsed instruments (Roodman, 2009) | Table 9 |
| `08_oster_test.do` | Coefficient stability test (Oster, 2019) | Table 10 (corrected, see below) |

## Main results

- **OLS (Table 5).** The coefficient of resource rents is positive and significant in all five specifications, between 0.042 and 0.083. With all controls, a 10% increase in resource rents is associated with a 0.6% increase in the external debt-to-GNI ratio (n = 1,110).
- **IV-GMM (Table 6).** The elasticity remains positive and significant, between 0.034 and 0.070.
- **Quantile regressions (Table 8).** The effect is significant at the median (0.071) and the 75th percentile (0.065), but not at the 25th percentile (0.021): resource rents matter more in countries that are already more indebted.
- **System GMM (Table 9).** The short-run coefficient is positive in all five columns and significant in four, with AR(2) and Hansen tests that do not reject the model (p > 0.17).

## Correction to the thesis (Table 10)

In the original do-file (`original_thesis_dofile.do`), the command `keep if Time==2014`, used to draw a figure, was executed before the Oster test. Table 10 of the thesis was therefore computed on the 2014 cross-section only (38 observations), which explains its negative and imprecise coefficient (−0.048, standard error 0.112). The table also mentions country and year fixed effects, which the regression does not include. `08_oster_test.do` runs the test on the full panel, the same sample as Table 5.

On the full panel (n = 1,110), adding the controls barely moves the coefficient of resource rents (from 0.062 to 0.059), while the R-squared rises from 0.014 to 0.056. Using Oster's approximation:

| R<sub>max</sub> | δ needed for β = 0 | β* (δ = 1) |
|---|---|---|
| 1.3 × R̃ = 0.073 (Oster's recommended bound) | 48.6 | 0.058 |
| 1 (most conservative bound) | 0.87 | −0.009 |

Under Oster's recommended bound, the result is robust to selection on unobservables. Under the most conservative assumption (unobservables could explain all remaining variance), it is not. These values come from the approximate formula of Oster (2019, eq. 3), computed in Python; `psacalc` uses the exact formula and may give slightly different numbers.

## Limitations and next steps

- **Debt measure.** The thesis discusses public debt, but the series used (external debt stocks, % of GNI) covers both public and private external debt.
- **Unobserved heterogeneity.** The OLS and IV estimations are pooled and do not include country fixed effects; only the system GMM accounts for country-specific effects.
- **Instruments.** Lagged rents are valid instruments only if shocks to debt are not serially correlated. The Hansen test rejects the overidentifying restrictions in columns 3 to 5 of Table 6 and in all columns of Table 7, so these estimates should be read with caution.
- **System GMM.** Lag ranges were chosen separately for each column; results should be checked against a common lag structure, with the number of instruments reported.
- **Common drivers.** Commodity prices affect both resource rents and borrowing. My doctoral project addresses this with country-specific commodity price shocks and local projections, and distinguishes resource-backed loans from other debt.

## Repository structure

All files are in the root folder of the repository:

- `00_master.do` runs everything (set the path first); `01_prepare_data.do` to `08_oster_test.do` reproduce the thesis tables.
- `original_thesis_dofile.do` is the do-file used for the thesis, unchanged.
- `ssa_panel_1990_2021_raw.dta` is the raw panel (World Bank WDI and WGI).
- `thesis_results_tables.xlsx` contains the Stata output for Tables 6, 7 and 9.

## How to reproduce

1. Download this repository (green **Code** button, then **Download ZIP**) and unzip it.
2. Open `00_master.do` in Stata and set `global root` to the unzipped folder.
3. Run `00_master.do`. It installs the required SSC packages (`ivreg2`, `ranktest`, `ivreg2h`, `xtabond2`, `outreg2`, `asdoc`, `psacalc`) and writes all tables to the same folder.

## Citation

Tog-Asra, N. G.-F. (2024). *Effet de la dépendance aux ressources naturelles sur la dette publique en Afrique subsaharienne* [Master's thesis, University of Dschang]. Replication code and data: this repository.

## Licence

Code: MIT licence (see `LICENSE`). Data: World Bank, CC BY 4.0.
