CLASS zss_cl_mitarbeiter_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZSS_CL_MITARBEITER_GENERATOR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA ls_mitarbeiter TYPE zss_mitarbeiter.
    DATA lt_mitarbeiter TYPE TABLE OF zss_mitarbeiter.
    DATA ls_anspruch TYPE zss_urlaubsanspr.
    DATA lt_anspruch TYPE TABLE OF zss_urlaubsanspr.
    DATA ls_urlaubsantrag TYPE zss_urlaubsantr.
    DATA lt_urlaubsantrag TYPE TABLE OF zss_urlaubsantr.
    DATA ls_mitarbeiter_hans TYPE zss_mitarbeiter.
    DATA ls_mitarbeiter_lisa type zss_mitarbeiter.
    data ls_mitarbeiter_petra type zss_mitarbeiter.
    "Delete Mitarbeiter
    DELETE FROM Zss_mitarbeiter.
    out->write( |Deleted Mitarbeiter: { sy-dbcnt }| ).

    DELETE FROM zss_urlaubsanspr.
    out->write( |Deleted Urlaubsansprüche: { sy-dbcnt }| ).
    " Delete Urlaubsanträge
    DELETE FROM zss_urlaubsantr.
    out->write( |Deleted Urlaubsanträge: { sy-dbcnt }| ).

    "Create Mitarbeiter
    ls_mitarbeiter_hans-mandant = sy-mandt.
    TRY.
        ls_mitarbeiter_hans-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_mitarbeiter_hans-mitarbeiternummer = 1.
    ls_mitarbeiter_hans-vorname        = 'Hans'.
    ls_mitarbeiter_hans-nachname          = 'Maier'.
    ls_mitarbeiter_hans-eintrittsdatum  = '20000501'.
    ls_mitarbeiter_hans-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_mitarbeiter_hans-created_at.
    ls_mitarbeiter_hans-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_mitarbeiter_hans-last_changed_at.
    APPEND ls_mitarbeiter_hans TO lt_mitarbeiter.

    ls_mitarbeiter_lisa-mandant = sy-mandt.
    TRY.
        ls_mitarbeiter_lisa-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_mitarbeiter_lisa-mitarbeiternummer = 2.
    ls_mitarbeiter_lisa-vorname        = 'Lisa'.
    ls_mitarbeiter_lisa-nachname          = 'Müller'.
    ls_mitarbeiter_lisa-eintrittsdatum  = '20100701'.
    ls_mitarbeiter_lisa-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_mitarbeiter_lisa-created_at.
    ls_mitarbeiter_lisa-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_mitarbeiter_lisa-last_changed_at.
    APPEND ls_mitarbeiter_lisa TO lt_mitarbeiter.

    ls_mitarbeiter_petra-mandant = sy-mandt.
    TRY.
        ls_mitarbeiter_petra-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_mitarbeiter_petra-mitarbeiternummer = 3.
    ls_mitarbeiter_petra-vorname        = 'Petra'.
    ls_mitarbeiter_petra-nachname          = 'Schmid'.
    ls_mitarbeiter_petra-eintrittsdatum  = '20231001'.
    ls_mitarbeiter_petra-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_mitarbeiter_petra-created_at.
    ls_mitarbeiter_petra-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_mitarbeiter_petra-last_changed_at.
    APPEND ls_mitarbeiter_petra TO lt_mitarbeiter.

    "Insert Mitarbeiter
    INSERT zss_mitarbeiter FROM TABLE @lt_mitarbeiter.
    out->write( |Inserted Mitarbeiter: { sy-dbcnt }| ).

    "Create Urlaubsansprüche


    ls_anspruch-mandant = sy-mandt.
    TRY.
        ls_anspruch-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_anspruch-mitarbeiter_uuid = ls_mitarbeiter_hans-id_uuid.
    ls_anspruch-jahr = 2023.
    ls_anspruch-urlaubstage = 30.
    ls_anspruch-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_anspruch-created_at.
    ls_anspruch-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_anspruch-last_changed_at.
    APPEND ls_anspruch TO lt_anspruch.

    ls_anspruch-mandant = sy-mandt.
    TRY.
        ls_anspruch-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_anspruch-mitarbeiter_uuid = ls_mitarbeiter_lisa-id_uuid.
    ls_anspruch-jahr = 2023.
    ls_anspruch-urlaubstage = 30.
    ls_anspruch-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_anspruch-created_at.
    ls_anspruch-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_anspruch-last_changed_at.
    APPEND ls_anspruch TO lt_anspruch.

    ls_anspruch-mandant = sy-mandt.
    TRY.
        ls_anspruch-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_anspruch-mitarbeiter_uuid = ls_mitarbeiter_petra-id_uuid.
    ls_anspruch-jahr = 2023.
    ls_anspruch-urlaubstage = 7.
    ls_anspruch-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_anspruch-created_at.
    ls_anspruch-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_anspruch-last_changed_at.
    APPEND ls_anspruch TO lt_anspruch.

    "Insert Urlaubsansprüche

    INSERT zss_urlaubsanspr FROM TABLE @lt_anspruch.
    out->write( |Inserted Urlaubsansprüche: { sy-dbcnt }| ).

    " Create Urlaubsanträge
    ls_urlaubsantrag-mandant = sy-mandt.
    TRY.
        ls_urlaubsantrag-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_urlaubsantrag-antragsteller_uuid = ls_mitarbeiter_hans-id_uuid.
    ls_urlaubsantrag-genehmigender_uuid = ls_mitarbeiter_lisa-id_uuid.
    ls_urlaubsantrag-startdatum         = '20220701'.
    ls_urlaubsantrag-enddatum           = '20220710'.
    ls_urlaubsantrag-urlaubstage        = 8.
    ls_urlaubsantrag-kommentar          = 'Sommerurlaub'.
    ls_urlaubsantrag-status = 'G'.
    ls_urlaubsantrag-sbeschreibung = 'Genehmigt'.
    ls_urlaubsantrag-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-created_at.
    ls_urlaubsantrag-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-last_changed_at.
    APPEND ls_urlaubsantrag TO lt_urlaubsantrag.

    ls_urlaubsantrag-mandant = sy-mandt.
    TRY.
        ls_urlaubsantrag-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_urlaubsantrag-antragsteller_uuid = ls_mitarbeiter_hans-id_uuid.
    ls_urlaubsantrag-genehmigender_uuid = ls_mitarbeiter_lisa-id_uuid.
    ls_urlaubsantrag-startdatum         = '20221227'.
    ls_urlaubsantrag-enddatum           = '20221230'.
    ls_urlaubsantrag-urlaubstage        = 4.
    ls_urlaubsantrag-kommentar          = 'Weihnachtsurlaub'.
    ls_urlaubsantrag-status = 'A'.
    ls_urlaubsantrag-sbeschreibung = 'Abgelehnt'.
    ls_urlaubsantrag-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-created_at.
    ls_urlaubsantrag-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-last_changed_at.
    APPEND ls_urlaubsantrag TO lt_urlaubsantrag.

    ls_urlaubsantrag-mandant = sy-mandt.
    TRY.
        ls_urlaubsantrag-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_urlaubsantrag-antragsteller_uuid = ls_mitarbeiter_hans-id_uuid.
    ls_urlaubsantrag-genehmigender_uuid = ls_mitarbeiter_lisa-id_uuid.
    ls_urlaubsantrag-startdatum         = '20221228'.
    ls_urlaubsantrag-enddatum           = '20221230'.
    ls_urlaubsantrag-urlaubstage        = 3.
    ls_urlaubsantrag-kommentar          = 'Weihnachtsurlaub (2. Versuch)'.
    ls_urlaubsantrag-status = 'G'.
    ls_urlaubsantrag-sbeschreibung = 'Genehmigt'.
    ls_urlaubsantrag-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-created_at.
    ls_urlaubsantrag-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-last_changed_at.
    APPEND ls_urlaubsantrag TO lt_urlaubsantrag.

    ls_urlaubsantrag-mandant = sy-mandt.
    TRY.
        ls_urlaubsantrag-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_urlaubsantrag-antragsteller_uuid = ls_mitarbeiter_hans-id_uuid.
    ls_urlaubsantrag-genehmigender_uuid = ls_mitarbeiter_lisa-id_uuid.
    ls_urlaubsantrag-startdatum         = '20230527'.
    ls_urlaubsantrag-enddatum           = '20230614'.
    ls_urlaubsantrag-urlaubstage        = 14.
    ls_urlaubsantrag-kommentar          = ''.
    ls_urlaubsantrag-status = 'G'.
    ls_urlaubsantrag-sbeschreibung = 'Genehmigt'.
    ls_urlaubsantrag-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-created_at.
    ls_urlaubsantrag-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-last_changed_at.
    APPEND ls_urlaubsantrag TO lt_urlaubsantrag.

    ls_urlaubsantrag-mandant = sy-mandt.
    TRY.
        ls_urlaubsantrag-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_urlaubsantrag-antragsteller_uuid = ls_mitarbeiter_hans-id_uuid.
    ls_urlaubsantrag-genehmigender_uuid = ls_mitarbeiter_lisa-id_uuid.
    ls_urlaubsantrag-startdatum         = '20231220'.
    ls_urlaubsantrag-enddatum           = '20231231'.
    ls_urlaubsantrag-urlaubstage        = 8.
    ls_urlaubsantrag-kommentar          = 'Winterurlaub'.
    ls_urlaubsantrag-status = 'B'.
    ls_urlaubsantrag-sbeschreibung = 'Beantragt'.
    ls_urlaubsantrag-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-created_at.
    ls_urlaubsantrag-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-last_changed_at.
    APPEND ls_urlaubsantrag TO lt_urlaubsantrag.

    ls_urlaubsantrag-mandant = sy-mandt.
    TRY.
        ls_urlaubsantrag-id_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
    ls_urlaubsantrag-antragsteller_uuid = ls_mitarbeiter_petra-id_uuid.
    ls_urlaubsantrag-genehmigender_uuid = ls_mitarbeiter_hans-id_uuid.
    ls_urlaubsantrag-startdatum         = '20231227'.
    ls_urlaubsantrag-enddatum           = '20231231'.
    ls_urlaubsantrag-urlaubstage        = 3.
    ls_urlaubsantrag-kommentar          = 'Weihnachtsurlaub'.
    ls_urlaubsantrag-status = 'G'.
    ls_urlaubsantrag-sbeschreibung = 'Genehmigt'.
    ls_urlaubsantrag-created_by     = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-created_at.
    ls_urlaubsantrag-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD ls_urlaubsantrag-last_changed_at.
    APPEND ls_urlaubsantrag TO lt_urlaubsantrag.

    " Insert Travels
    INSERT zss_urlaubsantr FROM TABLE @lt_urlaubsantrag.
    out->write( |Inserted Urlaubsanträge: { sy-dbcnt }| ).


  ENDMETHOD.
ENDCLASS.
