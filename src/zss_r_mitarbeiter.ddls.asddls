
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mitarbeiter'

define root view entity Zss_R_Mitarbeiter
  as select from zss_mitarbeiter
{

  key id_uuid       as IDUUID,
  mitarbeiternummer as Mitarbeiternummer,
  vorname           as Vorname,
  nachname         as Nachname,
  eintrittsdatum    as Eintrittsdatum,
  
      

      /* Administrative Data */
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt
}
