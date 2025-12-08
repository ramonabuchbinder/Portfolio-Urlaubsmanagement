@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Projection View Manager vom Antrag'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZSS_C_AntragManager 
as projection on Zss_R_Antrag
{
    key IDUUID,
    AntragstellerUuid,
    @Consumption.valueHelpDefinition: [{ entity: {name: 'ZSS_I_MitarbeiterText', element: 'Name'} }]
    Antragstellername,
    GenehmigenderUuid,
    Genehmigendername,
      Startdatum,
      Enddatum,
      Urlaubstage,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Kommentar,
      Status,
      Beschreibung,
      
       /* Administrative Data */
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      
      
      
      /*Assosiations*/
     _Antragsteller: redirected to parent ZSS_C_Mitarbeiter_M,
  _Genehmigender: redirected to ZSS_C_Mitarbeiter_M
      
}
