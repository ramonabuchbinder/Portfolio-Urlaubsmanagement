@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel'
define view entity Zss_R_Anspruch
  as select from zss_urlaubsanspr
  association to parent Zss_R_Mitarbeiter as _Mitarbeiter on $projection.MitarbeiterUuid = _Mitarbeiter.IDUUID
  
{

  key id_uuid       as IDUUID,
  mitarbeiter_uuid as MitarbeiterUuid,
  jahr             as Jahr,
  urlaubstage      as Urlaubstage,
      

      /* Administrative Data */
      @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt,
      
    _Mitarbeiter
}
