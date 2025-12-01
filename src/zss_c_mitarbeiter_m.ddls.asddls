@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Mitabeiter Manager'
define root view entity ZSS_C_Mitarbeiter_M 
provider contract transactional_query
as projection on Zss_R_Mitarbeiter
{
    key IDUUID,
  Mitarbeiternummer,
  Vorname,
  Nachname,
  Eintrittsdatum,
  
    /* Administrative Data */
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      
      /*Assosiations*/
      _Antrag : redirected to composition child ZSS_C_AntragManager
}
