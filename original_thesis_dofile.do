
**** Declarer le panel ***
tsset id Time
*******
egen id =group ( CountryName )

****
gen RN= Totalnaturalresourcesrents
gen DettesExt= ExternaldebtstocksofGNI
gen PIB= GDPpercapitaconstant2015US
gen Electricite= Accesstoelectricityofpopu
gen OuvertureC= TradeofGDPNETRDGNFSZS 
gen Internet= IndividualsusingtheInternet
gen APF= Proportionofseatsheldbywome
gen Corruption= ControlofCorruptionEstimate
gen EG= GovernmentEffectivenessEstima
gen QualInst= RegulatoryQualityEstimateRQ
gen IDE= Foreigndirectinvestmentneti
gen AEF= Laborforcefemaleoftotal
gen InclusionF= Mobilecellularsubscriptionsp

gen lnPIB =log( PIB )
gen lnRN =log( RN )
gen lnDettesExt =log( DettesExt )

****** MCO ******

set more off
reg  lnDettesExt lnRN  , r
est store eq1
reg  lnDettesExt lnRN OuvertureC  , r
est store eq2
reg  lnDettesExt lnRN OuvertureC IDE , r
est store eq3
reg  lnDettesExt lnRN OuvertureC IDE lnPIB  , r
est store eq4
reg  lnDettesExt lnRN OuvertureC IDE lnPIB AEF , r
est store eq5

outreg2 [eq*] using myfile, dec(3) e(all) replace see excel
drop _est_eq2 _est_eq3 _est_eq4 _est_eq5 _est_eq1


****** Endogeneite ******

*** Les Moments generalisés avec variables instrumentales: IV GMM

set more off
ivreg2h  lnDettesExt (lnRN= l.lnRN l2.lnRN)     , r ffirst  gmm2s
est store eq1
ivreg2h  lnDettesExt (lnRN= l.lnRN l2.lnRN) OuvertureC     , r ffirst  gmm2s
est store eq2
ivreg2h  lnDettesExt (lnRN= l.lnRN l2.lnRN) OuvertureC IDE     , r ffirst  gmm2s
est store eq3
ivreg2h  lnDettesExt (lnRN= l.lnRN l2.lnRN) OuvertureC IDE lnPIB   , r ffirst  gmm2s
est store eq4
ivreg2h  lnDettesExt (lnRN= l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF    , r ffirst  gmm2s
est store eq5
outreg2 [eq*] using myfile, dec(3) e(all) replace see excel

drop _est_eq2 _est_eq3 _est_eq4 _est_eq5 _est_eq1

****** Robustesse ******

***** Ajout des variables de controle additionnelles ***

set more off
ivreg2h  lnDettesExt (lnRN= l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF   , r ffirst  gmm2s
est store eq1
ivreg2h  lnDettesExt (lnRN= l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF Internet     , r ffirst  gmm2s
est store eq2
ivreg2h  lnDettesExt (lnRN= l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF  InclusionF     , r ffirst  gmm2s
est store eq3
ivreg2h  lnDettesExt (lnRN= l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF  Electricite    , r ffirst  gmm2s
est store eq4
ivreg2h  lnDettesExt (lnRN= l.lnRN l3.lnRN) OuvertureC IDE lnPIB AEF Internet InclusionF Electricite    , r ffirst  gmm2s
est store eq5

outreg2 [eq*] using myfile, dec(3) e(all) replace see excel
drop _est_eq2 _est_eq3 _est_eq4 _est_eq5 _est_eq1

***** Methodes alternatives *****

****GMM***

set more off
xtabond2 lnDettesExt l.lnDettesExt lnRN , gmm ( lnDettesExt QualInst l.lnRN, collapse lag(16 7)) iv( lnRN l.lnDettesExt L.AEF )  twostep small
est store eq1
xtabond2 lnDettesExt l.lnDettesExt lnRN OuvertureC, gmm ( lnDettesExt QualInst l.lnRN, collapse lag(7 6)) iv( lnRN l.lnDettesExt L.AEF )  twostep small
est store eq2
xtabond2 lnDettesExt l.lnDettesExt lnRN OuvertureC IDE, gmm ( lnDettesExt QualInst l.lnRN, collapse lag(2 7)) iv( lnRN l.lnDettesExt L.AEF )  twostep small
est store eq3
xtabond2 lnDettesExt l.lnDettesExt lnRN OuvertureC IDE lnPIB , gmm ( lnDettesExt QualInst l.lnRN, collapse lag(3 2)) iv( lnRN l.lnDettesExt L.AEF )  twostep small
est store eq4
xtabond2 lnDettesExt l.lnDettesExt lnRN OuvertureC IDE lnPIB AEF , gmm ( lnDettesExt QualInst l.lnRN, collapse lag(8 16)) iv( lnRN l.lnDettesExt L.AEF )  twostep small
est store eq5
outreg2 [eq*] using myfile, dec(3) e(all) replace see excel
drop _est_eq2 _est_eq3 _est_eq4 _est_eq5 _est_eq1


*** quantiles**

set more off
qreg lnDettesExt lnRN OuvertureC IDE lnPIB AEF  , quantile (0.25)
est store eq1
qreg lnDettesExt lnRN OuvertureC IDE lnPIB AEF  , quantile (0.50)
est store eq2
qreg lnDettesExt lnRN OuvertureC IDE lnPIB AEF  , quantile (0.75)
est store eq3
outreg2 [eq*] using myfile, dec(3) e(all) replace see excel
drop _est_eq1 _est_eq2 _est_eq3

****  Methode des IV GMM *****

set more off
ivreg2  lnDettesExt OuvertureC  ( lnRN =  l.lnRN  l.lnRN ), gmm2s first robust
est store eq1
ivreg2  lnDettesExt OuvertureC IDE   ( lnRN =  l.lnRN  l.lnRN ), gmm2s first robust
est store eq2
ivreg2  lnDettesExt OuvertureC IDE  lnPIB  ( lnRN =  l.lnRN  l.lnRN ), gmm2s first robust
est store eq3
ivreg2  lnDettesExt OuvertureC IDE  lnPIB AEF ( lnRN =  l.lnRN  l.lnRN ), gmm2s first robust
est store eq4
outreg2 [eq*] using myfile, dec(3) e(all) replace see excel
drop _est_eq2 _est_eq3 _est_eq4 _est_eq1

**** Methode des variables instrumentales ******

set more off
ivreg2  lnDettesExt   ( lnRN = l.lnRN l2.lnRN)   , r ffirst
est store eq1
ivreg2  lnDettesExt OuvertureC IDE    ( lnRN = l.lnRN l2.lnRN)   , r ffirst
est store eq2
ivreg2  lnDettesExt OuvertureC IDE  lnPIB AEF  ( lnRN = l.lnRN l2.lnRN)   , r ffirst
est store eq3

outreg2 [eq*] using myfile, dec(3) e(all) replace see excel


** Stat descriptive****

asdoc sum lnDettesExt lnRN OuvertureC IDE lnPIB AEF Internet InclusionF Electricite

 *** Matrice de correlation ***

asdoc corr lnDettesExt lnRN OuvertureC IDE lnPIB AEF

***generons la moyenne des variables***

egen mlnDettesExt= mean ( lnDettesExt), by ( CountryName)
egen mlnRN= mean ( lnDettesExt), by ( CountryName)


keep if Time==2014 

twoway (lfit mlnDettesExt lnRN ) (scatter mlnDettesExt lnRN , mlabel( CountryCode ))

********************Coefficient stability test of Oster*************************

reg lnDettesExt lnRN OuvertureC IDE lnPIB AEF , r
psacalc delta lnRN
psacalc beta lnRN


