@EndUserText.label: 'Projection View Mitarbeiter'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity Zss_C_Mitarbeiter 
provider contract transactional_query
as projection on Zss_R_Mitarbeiter
{
    key IDUUID,
  Mitarbeiternummer,
  @Search.defaultSearchElement: true      
  @Search.fuzzinessThreshold: 0.7
  Vorname,
  @Search.defaultSearchElement: true      
  @Search.fuzzinessThreshold: 0.7
  Nachname,
  Eintrittsdatum,
  
      

    /* Administrative Data */
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      
    /* Associations */
    _Antrag : redirected to composition child Zss_C_Antrag,
    _Anspruch : redirected to composition child Zss_C_Anspruch
    
}
