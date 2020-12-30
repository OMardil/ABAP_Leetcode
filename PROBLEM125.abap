CLASS zproblem125 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      METHODS valid_palindrome
      IMPORTING im_word          TYPE string
      RETURNING VALUE(re_result) TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS is_valid_char
      IMPORTING
        im_char         TYPE char1
      RETURNING
        VALUE(r_result) TYPE abap_bool.

ENDCLASS.



CLASS zproblem125 IMPLEMENTATION.

  METHOD valid_palindrome.

    DATA(l_word) = im_word.
    DATA(l_word_len) = strlen( l_word ).

    IF l_word_len <= 1.
      re_result = abap_true.
      RETURN.
    ENDIF.

    DATA: l_left  TYPE i,
          l_right TYPE i.

    DATA: l_char_left  TYPE c LENGTH 1,
          l_char_right TYPE c LENGTH 1.

    l_left = 0.
    l_right = l_word_len - 1.
    WHILE l_left < l_right.

      l_char_left = l_word+l_left(1).
      l_char_right = l_word+l_right(1).

      WHILE NOT is_valid_char( l_char_left ).
        l_left = l_left + 1.
        IF l_left < l_right.
          l_char_left = l_word+l_left(1).
        ELSE.
          re_result = abap_true.
          RETURN.
        ENDIF.
      ENDWHILE.

      WHILE NOT is_valid_char( l_char_right ).
        l_right = l_right - 1.
        IF l_right > l_left.
          l_char_right = l_word+l_right(1).
        ELSE.
          re_result = abap_true.
          RETURN.
        ENDIF.
      ENDWHILE.

      TRANSLATE l_char_left TO UPPER CASE.
      TRANSLATE l_char_right TO UPPER CASE.

      IF l_char_left NE l_char_right.
        re_result = abap_false.
        RETURN.
      ELSE.
        l_left = l_left + 1.
        l_right = l_right - 1.
      ENDIF.

      CLEAR: l_char_left, l_char_right.

    ENDWHILE.

    re_result = abap_true.

  ENDMETHOD.


  METHOD is_valid_char.

    IF im_char CO '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.
      r_result = abap_true.
    ELSE.
      r_result = abap_false.
    ENDIF.

  ENDMETHOD.

ENDCLASS.