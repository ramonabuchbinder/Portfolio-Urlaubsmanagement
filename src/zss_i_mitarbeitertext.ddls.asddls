
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View MitarbeiterName'

define view entity ZSS_I_MitarbeiterText as select from zss_mitarbeiter
{
    key id_uuid as IDUUID,
    vorname as vorname,
    nachname as nachname,
    
    concat_with_space(vorname, nachname, 1) as Name
}
