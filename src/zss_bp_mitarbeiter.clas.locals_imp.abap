CLASS lhc_Zss_R_Mitarbeiter DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Zss_R_Mitarbeiter RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Zss_R_Mitarbeiter RESULT result.

    METHODS datumsvalidierung FOR MODIFY
        IMPORTING keys FOR ACTION ZSS_R_Mitarbeiter~datumsvalidierung.

    METHODS keineUrlaubstage FOR MODIFY
        IMPORTING keys FOR ACTION ZSS_R_Mitarbeiter~keineUrlaubstage.

    METHODS validateDates FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZSS_R_Mitarbeiter~ValidateDates.

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
                        %msg = message ) TO reported-ZSS_R_ANTRAG.
        APPEND VALUE #( %tky = ls_antrag-%tky ) TO failed-ZSS_R_ANTRAG.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
