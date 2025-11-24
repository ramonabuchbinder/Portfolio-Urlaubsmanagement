@EndUserText.label: 'Projection View Mitarbeiter'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity Zss_C_Anspruch as projection on Zss_R_Anspruch
{
    key IDUUID,
     MitarbeiterUuid,
      Jahr,
      Urlaubstage,
      VerbrauchteUrlaubstage,
      VerfuegbareUrlaubstage,
      GeplanteUrlaubstage,
  
    _Mitarbeiter : redirected to parent Zss_C_Mitarbeiter
}
