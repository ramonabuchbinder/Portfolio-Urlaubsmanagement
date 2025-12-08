@EndUserText.label: 'Projection View Mitarbeiter'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity Zss_C_Antrag as projection on Zss_R_Antrag
{
    key IDUUID,
 AntragstellerUuid,
 @Search.defaultSearchElement: true
 Antragstellername,
@Consumption.valueHelpDefinition: [{ entity: { name: 'Zss_I_Genehmigender', element: 'IDUUID' } }]
 GenehmigenderUuid,
 Genehmigendername,
  Startdatum,
  Enddatum,
  Urlaubstage,
  Kommentar,
  Status,
  Beschreibung,
  
  /* Assosiations*/
  _Antragsteller: redirected to parent Zss_C_Mitarbeiter,
 _Genehmigender: redirected to Zss_C_Mitarbeiter
 
}   
