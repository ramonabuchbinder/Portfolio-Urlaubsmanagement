@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel'
define view entity Zss_R_Antrag
  as select from zss_urlaubsantr
  association to parent Zss_R_Mitarbeiter as _Antragsteller on $projection.AntragstellerUuid = _Antragsteller.IDUUID
    association [1..1] to Zss_R_Mitarbeiter as _Genehmigender on $projection.GenehmigenderUuid = _Genehmigender.IDUUID
      association [1..1] to ZSS_I_MitarbeiterText as _Genehmigendername on $projection.GenehmigenderUuid = _Genehmigendername.IDUUID
    association [1..1] to ZSS_I_MitarbeiterText as _Antragstellername on $projection.AntragstellerUuid = _Antragstellername.IDUUID
  
  
{

  key id_uuid       as IDUUID,
  antragsteller_uuid as AntragstellerUuid,
  genehmigender_uuid as GenehmigenderUuid,
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
      
      _Antragstellername.Name as Antragstellername,
      _Genehmigendername.Name as Genehmigendername,
      
    _Antragsteller,
    _Genehmigender
}
