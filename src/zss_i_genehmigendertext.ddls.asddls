@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Textelement für Genehmigender'

define view entity ZSS_I_GENEHMIGENDERText 
as select from zss_mitarbeiter
{
    key id_uuid as IDUUID,
     mitarbeiternummer as Mitarbeiternummer,
     vorname as Vorname,
     nachname as Nachname,
     
     concat_with_space(vorname, nachname, 1) as Name
}
