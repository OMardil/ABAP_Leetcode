CLASS zproblem168 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_excel_column_title
      IMPORTING im_number     TYPE i
      RETURNING VALUE(re_txt) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS convert_to_char
      IMPORTING
        im_number       TYPE i
      RETURNING
        value(r_result) TYPE string.
ENDCLASS.



CLASS zproblem168 IMPLEMENTATION.

  METHOD get_excel_column_title.

    IF im_number < 0.
        clear re_txt.
        RETURN.
    ENDIF.

    DATA(l_number) = im_number.

    WHILE l_number > 0.
        DATA l_new_number TYPE i.
        l_new_number = l_number MOD 26.
        l_number = l_number / 26.
        DATA(l_letter) = convert_to_char( l_new_number ).
        re_txt = |{ l_letter }{ re_txt }|.
    ENDWHILE.

  ENDMETHOD.


  METHOD convert_to_char.

    "DATA l_integer TYPE I.
    "l_integer = 'A'- 1 + im_number.
    "r_result = l_integer.

    case im_number.
      when 1.
        r_result = 'A'.
      when 2.
        r_result = 'B'.
      when 3.
        r_result = 'C'.
      when 4.
        r_result = 'D'.
    endcase.

  ENDMETHOD.

ENDCLASS.