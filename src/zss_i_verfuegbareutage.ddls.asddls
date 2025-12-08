@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View verfügbare urlaubstage'
define view entity ZSS_I_verfuegbareUTage as select from zss_urlaubsanspr
    association[1..1] to ZSS_I_geplanteUTage as _geplant on $projection.antragsteller = _geplant.antragsteller
    association[1..1] to ZSS_I_verbrauchteUTage as _verbraucht on $projection.antragsteller = _verbraucht.antragsteller
{
    key mitarbeiter_uuid as antragsteller,
    sum(urlaubstage) - coalesce(_verbraucht.verbrauchteUTage, 0) - coalesce(_geplant.geplanteUTage, 0) as verfuegbareUTage
}
group by mitarbeiter_uuid, urlaubstage, _verbraucht.verbrauchteUTage, _geplant.geplanteUTage;
