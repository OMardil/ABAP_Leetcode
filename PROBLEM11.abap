
CLASS PROBLEM11 DEFINITION.

ENDCLASS.

CLASS PROBLEM11 IMPLEMENTATION.

    "input - it_heights
    "output - re_area
    METHOD max_area.
        DATA(l_left) = 1.
        DATA(l_right) = lines( it_heights ).
        DATA l_area TYPE integer VALUE 0.
        DATA l_area_max TYPE integer VALUE 0.

        WHILE l_left < l_right.
            
            DATA(l_distance) = l_right - l_left.

            l_area = calculate_area(heights = it_heights
                                    one = l_left    
                                    two = l_right
                                    distance = l_distance ).
            IF l_area > l_area_max.
                l_area_max = l_area.
            ENDIF.

            DATA l_new_index_l TYPE integer.
            DATA l_spaces_moved_l TYPE integer.
            l_spaces_moved_l = 0.
            l_new_index = l_left.
            WHILE it_heights[ l_new_index_l ] >= it_heights[ l_new_index_l ] AND l_new_index_l < l_right.
                l_new_index = l_new_index_l + 1.
                l_spaces_moved_l = l_spaces_moved_l + 1.
            ENDWHILE.
            
            DATA l_new_index_r TYPE integer.
            DATA l_spaces_moved_r TYPE integer.
            l_spaces_moved_r = 0.
            l_new_index_r = l_right.
            WHILE it_heights[ l_new_index_r ] >= it_heights[ l_new_index_r ] AND l_new_index_r > l_left.
                l_new_index = l_new_index_r + 1.
                l_spaces_moved_r = l_spaces_moved_r + 1.
            ENDWHILE.

            IF l_spaces_moved_r = 0 AND l_spaces_moved_l = 0.
                RETURN.
            ELSEIF l_spaces_moved_r >= l_spaces_moved_l.
                l_left = l_left + l_spaces_moved_l.
            ELSE.
                l_right = l_right - l_spaces_moved_r.
            ENDIF.
                
        ENDWHILE.


    ENDMETHOD.
ENDCLASS.