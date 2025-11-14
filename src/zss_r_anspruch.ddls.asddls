@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel'
define view entity Zss_R_Anspruch
  as select from zss_urlaubsanspr
  association to parent Zss_R_Mitarbeiter as _Mitarbeiter on $projection.IDUUID = _Mitarbeiter.IDUUID
  
{

  key id_uuid       as IDUUID,
  mitarbeiter_uuid as MitarbeiterUuid,
  jahr             as Jahr,
  urlaubstage      as Urlaubstage,
      

      /* Administrative Data */
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,
      
    _Mitarbeiter
}
