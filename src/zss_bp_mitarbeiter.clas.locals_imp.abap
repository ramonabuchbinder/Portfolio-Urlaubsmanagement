CLASS lhc_Zss_R_Mitarbeiter DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Zss_R_Mitarbeiter RESULT result.

    METHODS get_global_authorizations_a FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zss_r_antrag RESULT result.

    METHODS keineUrlaubstage FOR MODIFY
      IMPORTING keys FOR ACTION ZSS_R_Antrag~keineUrlaubstage.

    METHODS datumsvalidierung FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZSS_R_Antrag~datumsvalidierung.

    METHODS DetermineStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZSS_R_Antrag~determineStatus.

    METHODS berechneUTage FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZSS_R_Antrag~berechneUTage.

  METHODS UAntragBestaetigen FOR MODIFY
    IMPORTING keys FOR ACTION Zss_R_Antrag~UAntragBestaetigen
RESULT result.

    METHODS UAntragAblehnen FOR MODIFY
    IMPORTING keys FOR ACTION Zss_R_Antrag~UAntragAblehnen
    RESULT result.




ENDCLASS.

CLASS lhc_Zss_R_Mitarbeiter IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations_a.
  ENDMETHOD.

  METHOD datumsvalidierung.
    DATA message TYPE REF TO ZSS_cm_Mitarbeiter.
    DATA(lo_context_info) = NEW cl_abap_context_info( ).

    " Anträge lesen
    READ ENTITY IN LOCAL MODE ZSS_R_Antrag
         FIELDS ( Startdatum Enddatum )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_Antrag).

    LOOP AT lt_antrag INTO DATA(ls_antrag).
      IF ls_antrag-Enddatum < ls_antrag-Startdatum.
        message = NEW Zss_cm_mitarbeiter( textid = Zss_cm_mitarbeiter=>datumsvalidierung
        severity = if_abap_behv_message=>severity-error ).

        APPEND VALUE #( %tky = ls_antrag-%tky
                        %msg = message ) TO reported-zss_r_antrag.
        APPEND VALUE #( %tky = ls_antrag-%tky ) TO failed-zss_r_antrag.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD determineStatus.

    READ ENTITY IN LOCAL MODE ZSS_R_Antrag
         FIELDS ( Status Beschreibung )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_antrag).

    LOOP AT lt_antrag INTO DATA(ls_antrag).

      " Neue Werte
      DATA(new_status)       = 'B'.
      DATA(new_beschreibung) = 'Beantragt'.

      " Nur updaten, wenn sich etwas ändert → verhindert Endlosschleife!
      IF ls_antrag-Status <> new_status
      OR ls_antrag-Beschreibung <> new_beschreibung.

        MODIFY ENTITY IN LOCAL MODE ZSS_R_Antrag
          UPDATE FIELDS ( Status Beschreibung )
          WITH VALUE #(
            ( %tky        = ls_antrag-%tky
              Status      = new_status
              Beschreibung = new_beschreibung )
          ).

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD berechneUTage.

    " Anträge lesen inkl. Urlaubstage (wichtig!)
    READ ENTITY IN LOCAL MODE ZSS_R_Antrag
         FIELDS ( Startdatum Enddatum Urlaubstage )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_antrag).

    LOOP AT lt_antrag INTO DATA(ls_antrag).

      DATA(startdatum) = ls_antrag-Startdatum.
      startdatum = startdatum - 1.
      TRY.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          DATA(working_days) = calendar->calc_workingdays_between_dates( iv_start = startdatum iv_end = ls_antrag-Enddatum ).
        CATCH cx_fhc_runtime.
      ENDTRY.



      " ❗ WICHTIG: Nur ändern, wenn der Wert WIRKLICH anders ist
      IF working_days <> ls_antrag-Urlaubstage.

        MODIFY ENTITY IN LOCAL MODE ZSS_R_Antrag
          UPDATE FIELDS ( Urlaubstage )
          WITH VALUE #(
            ( %tky        = ls_antrag-%tky
              Urlaubstage = working_days )
          ).

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD keineurlaubstage.

  ENDMETHOD.

  METHOD UAntragBestaetigen.
    DATA nachricht TYPE REF TO zss_cm_mitarbeiter.

    " Read Inquiry
    READ ENTITY IN LOCAL MODE Zss_R_Antrag
         FIELDS ( Status kommentar )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_antrag).

    " Process Inquiry
    LOOP AT lt_antrag REFERENCE INTO DATA(ls_antrag).


      " Validate State and Create Error Message
      IF ls_antrag->Status = 'A'.
        nachricht = NEW zss_cm_mitarbeiter( textid   = zss_cm_mitarbeiter=>bereitsbearbeitet
                                          severity = if_abap_behv_message=>severity-error
                                          comment = ls_antrag->kommentar ).
        APPEND VALUE #( %tky = ls_antrag->%tky
                        %msg = nachricht ) TO reported-zss_r_antrag.
        APPEND VALUE #( %tky = ls_antrag->%tky ) TO failed-zss_r_antrag.
        "DELETE lt_antrag INDEX sy-tabix.
        CONTINUE.
      ENDIF.



 IF ls_antrag->Status = 'G'.
        nachricht = NEW zss_cm_mitarbeiter( textid   = zss_cm_mitarbeiter=>bereitsbearbeitet
                                          severity = if_abap_behv_message=>severity-error
                                          comment  = ls_antrag->kommentar ).
        APPEND VALUE #( %tky = ls_antrag->%tky
                        %msg = nachricht ) TO reported-zss_r_antrag.
        APPEND VALUE #( %tky = ls_antrag->%tky ) TO failed-zss_r_antrag.
        "DELETE lt_antrag INDEX sy-tabix.
        CONTINUE.
      ENDIF.

" Set State to G und Create Success Message
      ls_antrag->Status = 'G'.
      nachricht = NEW zss_cm_mitarbeiter(
           textid = zss_cm_mitarbeiter=>erfolgreichangenommen
          severity = if_abap_behv_message=>severity-success

    ).
      APPEND VALUE #( %tky = ls_antrag->%tky %msg = nachricht ) TO reported-zss_r_antrag.


    ENDLOOP.



    " Modify Inquiry
    MODIFY ENTITY IN LOCAL MODE zss_r_antrag
           UPDATE FIELDS ( Status )
           WITH VALUE #( FOR lr IN lt_antrag
                         ( %tky = lr-%tky Status = lr-Status ) ).

    " Set Result
    result = VALUE #( FOR lr IN lt_antrag
                      ( %tky = lr-%tky %param = lr ) ).
  ENDMETHOD.



  METHOD UAntragAblehnen.
    DATA nachricht TYPE REF TO zss_cm_mitarbeiter.

    " Read Inquiry
    READ ENTITY IN LOCAL MODE zss_r_antrag
        FIELDS ( Status kommentar )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_antrag).

    " Process Inquiry
    LOOP AT lt_antrag REFERENCE INTO DATA(ls_antrag).

      " Validate State and Create Error Message
      IF ls_antrag->Status = 'A'.
        nachricht = NEW zss_cm_mitarbeiter(
            textid = zss_cm_mitarbeiter=>bereitsbearbeitet
             severity = if_abap_behv_message=>severity-error
            comment = ls_antrag->Kommentar
         ).
        APPEND VALUE #( %tky = ls_antrag->%tky %msg = nachricht ) TO reported-zss_r_antrag.
        APPEND VALUE #( %tky = ls_antrag->%tky ) TO failed-zss_r_antrag.
        "DELETE lt_antrag INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF ls_antrag->Status = 'G'.
        nachricht = NEW zss_cm_mitarbeiter(
            textid = zss_cm_mitarbeiter=>bereitsbearbeitet
            severity = if_abap_behv_message=>severity-error
            comment = ls_antrag->Kommentar
        ).
        APPEND VALUE #( %tky = ls_antrag->%tky %msg = nachricht ) TO reported-zss_r_antrag.
        APPEND VALUE #( %tky = ls_antrag->%tky ) TO failed-zss_r_antrag.
       " DELETE lt_antrag INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set State to A und Create Success Message
      ls_antrag->Status = 'A'.
      nachricht = NEW zss_cm_mitarbeiter(
         textid = zss_cm_mitarbeiter=>erfolgreichabgelehnt
         severity = if_abap_behv_message=>severity-success

      ).
      APPEND VALUE #( %tky = ls_antrag->%tky %msg = nachricht ) TO reported-zss_r_antrag.
    ENDLOOP.

    " Modify Inquiry
    MODIFY ENTITY IN LOCAL MODE zss_r_antrag
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR lr IN lt_antrag ( %tky = lr-%tky Status = lr-Status ) ).

    " Set Result
    result = VALUE #( FOR lr IN lt_antrag ( %tky = lr-%tky %param = lr ) ).
  ENDMETHOD.


ENDCLASS.
