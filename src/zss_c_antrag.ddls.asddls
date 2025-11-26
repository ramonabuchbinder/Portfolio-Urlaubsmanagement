@EndUserText.label: 'Projection View Mitarbeiter'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity Zss_C_Antrag as projection on Zss_R_Antrag
{
    key IDUUID,
 AntragstellerUuid,
@Consumption.valueHelpDefinition: [{ entity: { name: 'Zss_I_Genehmigender', element: 'IDUUID' } }]
 GenehmigenderUuid,
  Startdatum,
  Enddatum,
  Urlaubstage,
  Kommentar,
  Status,
  Beschreibung,
  
  /* Assosiations*/
  _Mitarbeiter : redirected to parent Zss_C_Mitarbeiter,
  _Manager : redirected to composition child ZSS_C_AntragManager
}   
