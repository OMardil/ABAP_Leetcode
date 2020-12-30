" Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? 
" Find all unique triplets in the array which gives the sum of zero.
" Notice that the solution set must not contain duplicate triplets.

" Example 1:
" Input: nums = [-1,0,1,2,-1,-4]
" Output: [[-1,-1,2],[-1,0,1]]

" Example 2:
" Input: nums = []
" Output: []

" Example 3:
" Input: nums = [0]
" Output: []


TYPES BEGIN OF t_sum_3,
    num1 TYPE ingeter,
    num2 TYPE integer,
    num3 TYPE integer.
END OF t_sum_3.

TYPES tt_sum_3 TYPE STANDARD TABLE OF t_sum_3.

CLASS PROBLEM15 IMPLEMENTATION.

    "input  it_numbers TABLE OF INTEGERS
    "       im_target TYPE integer
    "output rt_sum_3 TABLE OF t_sum_3.
    METHOD find_sum_3.

        SORT it_numbers.
        LOOP AT it_numbers.

            DATA(l_a_index) = sy-tabix.
            DATA(l_b_index) = l_a_index + 1.
            DATA(l_c_index) = lines( it_numbers ).

            WHILE l_c_index > l_b_index.
                DATA(l_sum) = it_numbers[ l_a_index ] + it_numbers[ l_b_index ] + it_numbers[ l_c_index ].
                IF l_sum = 0.
                    DATA(lw_sum_3) = VALUE t_sum_3( num1 = it_numbers[ l_a_index ]
                                                    num2 = it_numbers[ l_b_index ]
                                                    num3 = it_numbers[ l_c_index ] ).
                    APPEND lw_sum_3 TO rt_sum_3.

                    ADD 1 to l_b_index.
                    SUBTRACT 1 FROM l_c_index.
                ELSEIF l_sum > 0.
                    DATA(l_old_number) = it_numbers[ l_c_index ].
                    WHILE l_old_number = it_numbers[ l_c_index ].
                        l_c_index = l_c_index - 1.
                    ENDWHILE.
                        
                ELSEIF l_sum < 0.
                    l_old_number = it_numbers[ l_b_index ].
                    WHILE l_old_number = it_numbers[ l_b_index ].
                        l_b_index = l_b_index + 1.
                    ENDWHILE.
                ENDIF.
            ENDWHILE.

        ENDLOOP.

    ENDMETHOD.

ENDCLASS.

[ -1 0 1 2 -1 -4 ]

"sort and remove dups
[-1 0 1 2 ]

a = -1
b = 0
c = 1
sum = 0
[
    [ -1 0 1 ]

]