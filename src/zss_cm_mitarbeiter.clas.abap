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
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF datumsvalidierung.

    CONSTANTS:
      BEGIN OF keineUrlaubstage,
        msgid TYPE symsgid      VALUE 'ZSS_Mitarbeiter',
        msgno TYPE symsgno      VALUE '002',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF keineUrlaubstage.

    " Attributs
    DATA urlaubstage type i.
    " Constructor
    METHODS constructor
      IMPORTING
        severity  TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        textid    LIKE if_t100_message=>t100key         DEFAULT if_t100_message=>default_textid
        !previous LIKE previous OPTIONAL.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS Zss_cm_mitarbeiter IMPLEMENTATION.
  METHOD constructor  ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    if_t100_message~t100key = textid.
    if_abap_behv_message~m_severity = severity.
  ENDMETHOD.
ENDCLASS.

