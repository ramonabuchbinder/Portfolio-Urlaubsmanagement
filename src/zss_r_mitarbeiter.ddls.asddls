@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mitarbeiter'

define root view entity Zss_R_Mitarbeiter
  as select from zss_mitarbeiter
  composition [0..*] of Zss_R_Anspruch as _Anspruch
  composition [0..*] of Zss_R_Antrag as _Antrag
  association [1..1] to ZSS_I_GENEHMIGENDERText as _GENEHMIGENDERText on $projection.IDUUID = _GENEHMIGENDERText.IDUUID
  association[1..1] to ZSS_I_geplanteUTage as _geplant on $projection.IDUUID = _geplant.antragsteller
  association[1..1] to ZSS_I_verbrauchteUTage as _verbraucht on $projection.IDUUID = _verbraucht.antragsteller
  association[1..1] to ZSS_I_verfuegbareUTage as _verfuegbar on $projection.IDUUID = _verfuegbar.antragsteller
{
  @ObjectModel.text.element: ['GenehmigenderName']
  key id_uuid       as IDUUID,
  mitarbeiternummer as Mitarbeiternummer,
  vorname           as Vorname,
  nachname         as Nachname,
  eintrittsdatum    as Eintrittsdatum,
  
  
      

      /* Administrative Data */
       @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt,
      
       _GENEHMIGENDERText.Nachname as GenehmigenderName,
       _verbraucht.verbrauchteUTage as verbrauchteUrlaubstage,
       _verfuegbar.verfuegbareUTage as verfuegbareUrlaubstage,
       _geplant.geplanteUTage as geplanteUrlaubstage,
      
      /* Associations*/
      _Antrag,
      _Anspruch
}
