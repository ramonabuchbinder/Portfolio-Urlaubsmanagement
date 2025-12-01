@AbapCatalog.sqlViewName: 'ZSS_I_VERBRAUCHT'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View verbrauchte urlaubstage'
define view ZSS_I_verbrauchteUTage as select from zss_urlaubsantr
{
    antragsteller_uuid as antragsteller,
    sum(
        case when enddatum > $session.user_date and startdatum < $session.user_date
            then dats_days_between(startdatum, enddatum)
            when enddatum < $session.user_date and startdatum < $session.user_date
            then urlaubstage
            else 0
            end) as verbrauchteUTage
}
where status = 'G'
group by antragsteller_uuid;
