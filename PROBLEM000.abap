CLASS zproblem000 DEFINITION PUBLIC.

    PUBLIC SECTION.
  
      TYPES: BEGIN OF t_numbers,
             num TYPE i,
             END OF t_numbers.
      TYPES tt_numbers TYPE STANDARD TABLE OF t_numbers.
  
  
      METHODS find_peak
        IMPORTING it_numbers    TYPE tt_numbers
        RETURNING VALUE(r_peak) TYPE i.
  
      METHODS find_num
          IMPORTING it_numbers TYPE tt_numbers
                    im_target TYPE i
          RETURNING VALUE(r_result) TYPE sy-tabix.
  
  
    PRIVATE SECTION.
  
  ENDCLASS.
  
  
  
  CLASS zproblem000 IMPLEMENTATION.
  
    METHOD find_peak.
      "sorted ascendingly before peak
      "sorted descendingly after peak
  
      "first approach -> sorting it_numbers and binary search... O(nlogn + logn).. O(nlogn)
      "second approach -> traverse the list... O(n)
      "third approach -> 1. find peak 2. binary search left 3. inverted binary search right -> O(logn + logn + logn)
  
      DATA(l_left) = 1.
      DATA(l_right) = lines( it_numbers ).
  
      WHILE l_left < l_right.
        DATA(l_mid_index) = ( l_left + l_right ) / 2.
          
        IF l_mid_index - 1 >= 1.
          DATA(l_before_num) = it_numbers[ l_mid_index - 1 ]-num.
        ENDIF.
        DATA(l_mid_num) = it_numbers[ l_mid_index ]-num.
        IF l_mid_index + 1 <= lines( it_numbers ).
          DATA(l_after_num) =  it_numbers[ l_mid_index + 1 ]-num.
        ENDIF.
  
        IF l_mid_num > l_before_num AND l_mid_num > l_after_num.
          r_peak = l_mid_index.
          RETURN.
        ELSEIF l_mid_num < l_after_num AND l_mid_num > l_before_num.
          l_left = l_mid_index + 1.
          r_peak = l_left. "TODO
        ELSE.
          l_right = l_mid_index - 1.
          r_peak = l_right. "TODO
        ENDIF.
      ENDWHILE.
  
    ENDMETHOD.
  
  
    METHOD find_num.
      "1. find the peak of the table
      DATA(l_peak) = find_peak( it_numbers ).
  
      "2. binary searchs on left / right of peak
      DATA: l_left_1  TYPE i,
            l_right_1 TYPE i.
  
      DATA: l_left_2  TYPE i,
            l_right_2 TYPE i.
  
      l_left_1 = 1.
      l_right_1 = l_peak.
  
      l_left_2 = l_peak + 1.
      l_right_2 = lines( it_numbers ).
  
  
      WHILE l_left_1 <= l_right_1 OR l_left_2 <= l_right_2.
  
        "Check left side of mid, numbers going up
        IF l_left_1 <= l_right_1.
          DATA(l_mid_1) = ( l_left_1 + l_right_1 ) / 2.
          IF it_numbers[ l_mid_1 ]-num = im_target.
            r_result = l_mid_1.
            RETURN.
          ELSEIF it_numbers[ l_mid_1 ]-num > im_target.
            l_right_1 = l_mid_1 - 1.
          ELSEIF it_numbers[ l_mid_1 ]-num < im_target.
            l_left_1 = l_mid_1 + 1.
          ENDIF.
        ENDIF.
  
        "Check right side of mid, numbers going down
        IF l_left_2 <= l_right_2.
          DATA(l_mid_2) = ( l_left_2 + l_right_2 ) / 2.
          IF it_numbers[ l_mid_2 ]-num = im_target.
            r_result = l_mid_2.
            RETURN.
          ELSEIF it_numbers[ l_mid_2 ]-num > im_target.
            l_left_2 = l_mid_2 + 1.
          ELSEIF it_numbers[ l_mid_2 ]-num < im_target.
            l_right_2 = l_mid_2 - 1.
          ENDIF.
        ENDIF.
  
      ENDWHILE.
  
    ENDMETHOD.
  
  ENDCLASS.