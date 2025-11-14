@EndUserText.label: 'Projection View Mitarbeiter'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity Zss_C_Antrag as projection on Zss_R_Antrag
{
    key IDUUID,
 AntragstellerUuid,
 GenehmigenderUuid,
  Startdatum,
  Enddatum,
  Urlaubstage,
  Kommentar,
  Status,
  
  /* Assosiations*/
  _Mitarbeiter : redirected to parent Zss_C_Mitarbeiter
}   
