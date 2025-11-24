@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Genehmigender'
define view entity Zss_I_Genehmigender
  as select from zss_mitarbeiter
{
     
     key id_uuid as IDUUID,
     mitarbeiternummer as Mitarbeiternummer,
     vorname as Vorname,
     nachname as Nachname,
     eintrittsdatum as Eintrittsdatum
     }
