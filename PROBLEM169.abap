CLASS zproblem169 DEFINITION PUBLIC.


    PUBLIC SECTION.
  
      TYPES: BEGIN OF  t_numbers,
               num TYPE i,
             END OF T_numbers.
  
      TYPES: BEGIN OF  t_frequency,
               num   TYPE i,
               count TYPE i,
             END OF t_frequency.
      TYPES tt_numbers TYPE STANDARD TABLE OF t_numbers.
  
      METHODS majority_element
        IMPORTING it_numbers      TYPE tt_numbers
        RETURNING VALUE(r_result) TYPE i.
  
  
    PRIVATE SECTION.
  
  
  
  
  ENDCLASS.
  
  CLASS zproblem169 IMPLEMENTATION.
  
    METHOD majority_element.
  
      DATA: it_frequency TYPE HASHED TABLE OF t_frequency WITH UNIQUE KEY num.
  
      DATA: l_max_number TYPE i,
            l_max_count  TYPE i.
  
      LOOP AT it_numbers INTO DATA(lw_numbers).
  
        READ TABLE it_frequency INTO DATA(lw_freq)
            WITH KEY num = lw_numbers-num.
        IF sy-subrc = 0.
          lw_freq-count = lw_freq-count + 1.
          MODIFY TABLE it_frequency FROM lw_freq.
        ELSE.
          lw_freq-num = lw_numbers-num.
          lw_freq-count = 1.
          INSERT lw_freq INTO TABLE it_frequency.
        ENDIF.
  
        IF lw_freq-count > l_max_count.
          l_max_count = lw_freq-count.
          l_max_number = lw_freq-num.
        ENDIF.
  
        "the number is already found!
        IF l_max_count > lines( it_numbers ) / 2.
          EXIT.
        ENDIF.
  
      ENDLOOP.
  
      r_result = l_max_number.
  
    ENDMETHOD.
  
  ENDCLASS.
  
  
  
  