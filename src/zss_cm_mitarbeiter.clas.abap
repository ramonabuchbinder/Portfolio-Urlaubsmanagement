CLASS zss_cm_mitarbeiter DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    " Interfaces
    INTERFACES if_abap_behv_message.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    " Message Constants
    CONSTANTS:
      BEGIN OF datumsvalidierung,
        msgid TYPE symsgid      VALUE 'ZSS_Mitarbeiter',
        msgno TYPE symsgno      VALUE '001',
        attr1 TYPE scx_attrname VALUE 'Kommentar',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF datumsvalidierung.

    CONSTANTS:
      BEGIN OF keineUrlaubstage,
        msgid TYPE symsgid      VALUE 'ZSS_Mitarbeiter',
        msgno TYPE symsgno      VALUE '002',
        attr1 TYPE scx_attrname VALUE 'Kommentar',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF keineUrlaubstage.

    CONSTANTS:
      BEGIN OF erfolgreichAbgelehnt,
        msgid TYPE symsgid      VALUE 'ZSS_Mitarbeiter',
        msgno TYPE symsgno      VALUE '003',
        attr1 TYPE scx_attrname VALUE 'IdUuid',
        attr2 TYPE scx_attrname VALUE 'Kommentar',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF erfolgreichAbgelehnt.

    CONSTANTS:
      BEGIN OF erfolgreichAngenommen,
        msgid TYPE symsgid      VALUE 'ZSS_Mitarbeiter',
        msgno TYPE symsgno      VALUE '004',
        attr1 TYPE scx_attrname VALUE 'IdUuid',
        attr2 TYPE scx_attrname VALUE 'Kommentar',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF erfolgreichAngenommen.

    CONSTANTS:
      BEGIN OF bereitsBearbeitet,
        msgid TYPE symsgid      VALUE 'ZSS_Mitarbeiter',
        msgno TYPE symsgno      VALUE '005',
        attr1 TYPE scx_attrname VALUE 'IdUuid',
        attr2 TYPE scx_attrname VALUE 'Kommentar',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF bereitsBearbeitet.


    " Attributs
    DATA urlaubstage TYPE i.
    DATA comment TYPE string.
    DATA IdUuid TYPE zss_urlaubsantr.


    " Constructor
    METHODS constructor
      IMPORTING
        severity  TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        textid    LIKE if_t100_message=>t100key         DEFAULT if_t100_message=>default_textid
        !previous LIKE previous OPTIONAL
        comment TYPE zss_kommentar OPTIONAL
        IdUuid    TYPE zss_urlaubsantr OPTIONAL.




PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS Zss_cm_mitarbeiter IMPLEMENTATION.
  METHOD constructor  ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    if_t100_message~t100key = textid.
    if_abap_behv_message~m_severity = severity.
    me->IdUuid = IdUuid.
    me->comment = comment.
  ENDMETHOD.
ENDCLASS.

