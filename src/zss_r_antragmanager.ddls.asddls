@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel'
define view entity ZSS_R_ANTRAGMANAGER
  as select from zss_urlaubsantr
association to parent Zss_R_Antrag as _Antrag on $projection.IDUUID = _Antrag.IDUUID
  
{

  key id_uuid       as IDUUID,
  antragsteller_uuid as AntragstellerUuid,
  startdatum         as Startdatum,
  enddatum           as Enddatum,
  urlaubstage        as Urlaubstage,
  kommentar          as Kommentar,
  status  as Status,
  sbeschreibung as Beschreibung,
      

      /* Administrative Data */
      @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt,
      
      _Antrag
}
