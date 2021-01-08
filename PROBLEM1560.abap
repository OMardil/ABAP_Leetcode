TYPES begin of t_ints,
  num TYPE i,
END OF t_ints.
TYPES tt_ints TYPE STANDARD TABLE OF tt_ints.

TYPES begin of t_counts,
  num TYPE i,
  count TYPE i,
END OF t_counts.

TYPES tt_counts TYPE HASHED TABLE OF t_counts WITH UNIQUE KEY num.

“IMPORTING i_sectors TYPE i
“        it_rounds TYPE tt_ints
“        RETURNING VALUE(rt_most_visited) TYPE tt_ints.

METHOD most_visited.
    DATA lt_most_visited TYPE tt_counts
    
    O(rounds)
    LOOP AT it_rounds INTO DATA(lw_round) FROM 2.
        DATA(l_begin) = it_rounds[ sy-tabix - 1 ]-num.
        DATA(l_end) = lw_round-num.
DATA(l_current_node) = l_begin.

O(sectors)
        WHILE l_current_node NE l_end.
                add_visit(im_sector = l_current_node
    ct_visits = lt_most_visited).
                l_current_node = l_current_node + 1.
                IF l_current_node > i_sectors.
                    l_current_node = 1.
                ENDIF.
ENDWHILE.

    ENDLOOP.
    
    add_visit(im_sector = it_rounds[ lines( it_rounds )-num
           ct_visits = lt_most_visited ).        
    
    O(sectors)
    rt_most_visited = generate_most_visited_list( lt_most_visited ).

    
ENDMETHOD.

METHOD add_visit.
    READ TABLE ct_visits INTO DATA(lw_visits) WITH KEY num = im_sector.
    IF sy-subrc = 0.
        Lw_visits-count = lw_visits-count + 1.
        MODIFY TABLE ct_visits FROM lw_visits INDEX sy-tabix.
    ELSE.
        Lw_visits-num = im_sector.
Lw_visits-count = 1.
INSERT lw_visits INTO TABLE ct_visits.
ENDIF.
        
ENDMETHOD.



Input: n = 2, rounds = [2,1,2,1,2,1,2,1,2]
Output: [2]

2,1,2,1,2,1,2,1,2

