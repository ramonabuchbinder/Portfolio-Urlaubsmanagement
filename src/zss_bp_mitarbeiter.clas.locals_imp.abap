CLASS lhc_Zss_R_Mitarbeiter DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Zss_R_Mitarbeiter RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Zss_R_Mitarbeiter RESULT result.

    METHODS datumsvalidierung FOR MODIFY
      IMPORTING keys FOR ACTION ZSS_R_Antrag~datumsvalidierung.

    METHODS keineUrlaubstage FOR MODIFY
      IMPORTING keys FOR ACTION ZSS_R_Antrag~keineUrlaubstage.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZSS_R_Antrag~ValidateDates.

    METHODS DetermineStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZSS_R_Antrag~determineStatus.

    METHODS berechneUTage FOR DETERMINE ON MODIFY
    IMPORTING keys FOR ZSS_R_Antrag~berechneUTage.



ENDCLASS.

CLASS lhc_Zss_R_Mitarbeiter IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD datumsvalidierung.
    DATA message TYPE REF TO ZSS_cm_Mitarbeiter.

    message = NEW ZSS_cm_mitarbeiter( severity  = if_abap_behv_message=>severity-success
                              textid    = Zss_cm_Mitarbeiter=>datumsvalidierung ).

    APPEND message TO reported-%other.
  ENDMETHOD.

  METHOD keineUrlaubstage.
    DATA message TYPE REF TO ZSS_cm_Mitarbeiter.

    message = NEW ZSS_cm_mitarbeiter( severity  = if_abap_behv_message=>severity-success
                              textid    = Zss_cm_Mitarbeiter=>keineUrlaubstage ).

    APPEND message TO reported-%other.
  ENDMETHOD.

  METHOD validatedates.
    DATA message TYPE REF TO ZSS_cm_Mitarbeiter.

    " Read Travels
    READ ENTITY IN LOCAL MODE ZSS_R_Antrag
         FIELDS ( Startdatum Enddatum )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_Antrag).

    " Process Travels
    LOOP AT lt_antrag INTO DATA(ls_antrag).
      " Validate Dates and Create Error Message
      IF ls_antrag-Enddatum < ls_antrag-Startdatum.
        message = NEW Zss_cm_mitarbeiter( textid = Zss_cm_mitarbeiter=>datumsvalidierung ).
        APPEND VALUE #( %tky = ls_antrag-%tky
                        %msg = message ) TO reported-zss_r_antrag.
        APPEND VALUE #( %tky = ls_antrag-%tky ) TO failed-zss_r_antrag.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD determineStatus.
    READ ENTITY IN LOCAL MODE ZSS_R_Antrag
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_antrag).

    LOOP AT lt_antrag REFERENCE INTO DATA(ls_antrag).
      IF ls_antrag->Status = 'A'.
        MODIFY ENTITY IN LOCAL MODE ZSS_R_Antrag
            UPDATE FIELDS ( Beschreibung )
        WITH VALUE #( FOR key IN keys
        ( %tky       = key-%tky
                       Beschreibung = 'Abgelehnt' ) ).
    ELSEIF ls_antrag->Status = 'B'.
        MODIFY ENTITY IN LOCAL MODE ZSS_R_Antrag
            UPDATE FIELDS ( Beschreibung )
        WITH VALUE #( FOR key IN keys
        ( %tky       = key-%tky
                       Beschreibung = 'Beantragt' ) ).
    ELSEIF ls_antrag->Status = 'G'.
        MODIFY ENTITY IN LOCAL MODE ZSS_R_Antrag
            UPDATE FIELDS ( Beschreibung )
        WITH VALUE #( FOR key IN keys
        ( %tky       = key-%tky
                       Beschreibung = 'Genehmigt' ) ).
    ENDIF.
      IF ls_antrag->Status <> 'B'.
        MODIFY ENTITY IN LOCAL MODE ZSS_R_Antrag
           UPDATE FIELDS ( Status Beschreibung )
       WITH VALUE #( FOR key IN keys
                     ( %tky       = key-%tky
                       Status     = 'B'
                       Beschreibung = 'Beantragt' ) ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD berechneUTage.

  " Betroffene Anträge einlesen
  READ ENTITY IN LOCAL MODE ZSS_R_Antrag
       FIELDS ( Startdatum Enddatum Urlaubstage )
       WITH CORRESPONDING #( keys )
       RESULT DATA(lt_antrag).

  LOOP AT lt_antrag INTO DATA(ls_antrag).

    " BW-Kalender erstellen
    TRY.
        DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
      CATCH cx_fhc_runtime.
        CONTINUE.
    ENDTRY.

    " Werktage zählen
    TRY.
        DATA(working_days) = ( calendar->calc_workingdays_between_dates(
                                 iv_start = ls_antrag-startdatum
                                 iv_end   = ls_antrag-enddatum ) ) + 1.
      CATCH cx_fhc_runtime.
        CONTINUE.
    ENDTRY.

    " Nur schreiben, wenn Wert sich wirklich ändert
    IF ls_antrag-Urlaubstage <> working_days.
      " Vermeidung von Endlosschleifen: nur Update, wenn Wert unterschiedlich
      MODIFY ENTITY IN LOCAL MODE ZSS_R_Antrag
        UPDATE FIELDS ( Urlaubstage )
        WITH VALUE #(
          ( %tky        = ls_antrag-%tky
            Urlaubstage = working_days )
        ).
    ENDIF.

  ENDLOOP.

ENDMETHOD.


ENDCLASS.
