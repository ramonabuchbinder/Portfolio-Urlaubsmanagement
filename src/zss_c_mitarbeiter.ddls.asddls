@EndUserText.label: 'Projection View Mitarbeiter'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity Zss_C_Mitarbeiter 
provider contract transactional_query
as projection on Zss_R_Mitarbeiter
{
    key IDUUID,
    @Consumption.valueHelpDefinition: [{ entity: { name: 'Zss_I_Genehmigender', element: 'Mitarbeiternummer' } }]
  Mitarbeiternummer,
  @Search.defaultSearchElement: true      
  @Search.fuzzinessThreshold: 0.7
  @Consumption.valueHelpDefinition: [{ entity: { name: 'Zss_I_Genehmigender', element: 'Vorname' } }]
  Vorname,
  @Search.defaultSearchElement: true      
  @Search.fuzzinessThreshold: 0.7
  @Consumption.valueHelpDefinition: [{ entity: { name: 'Zss_I_Genehmigender', element: 'Nachname' } }]
  Nachname,
  @Consumption.valueHelpDefinition: [{ entity: { name: 'Zss_I_Genehmigender', element: 'Eintrittsdatum' } }]
  Eintrittsdatum,
  
      

    /* Administrative Data */
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      
    /* Transient Data */
    GenehmigenderName,
      
    /* Associations */
    _Antrag : redirected to composition child Zss_C_Antrag,
    _Anspruch : redirected to composition child Zss_C_Anspruch
    
}
