@AbapCatalog.sqlViewName: 'ZSS_I_GEPLANT'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View geplante urlaubstage'
define view ZSS_I_geplanteUTage as select from zss_urlaubsantr
{
    antragsteller_uuid as antragsteller,
    sum(
        case when startdatum > $session.system_date
        then urlaubstage
        else 0
        end)
        as geplanteUTage
}
where status <> 'A'
group by antragsteller_uuid;
