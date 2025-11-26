@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Projection View Manager vom Antrag'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZSS_C_AntragManager as projection on ZSS_R_ANTRAGMANAGER
{
    key IDUUID,
    AntragstellerUuid,
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
      
      _Antrag : redirected to parent Zss_C_Antrag
      
}
