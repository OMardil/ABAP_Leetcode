"Given a string s, find the length of the longest substring without repeating characters.

CLASS PROBLEM3 DEFINITION.

    TYPES begin of t_characters, 
        character TYPE CHAR1,
        index TYPE
    END of t_characters.

    TYPES tt_characters TYPE STANDARD TABLE of t_characters.
    

ENDCLASS.


CLASS PROBLEM3 IMPLEMENTATION.

    "inputs = String s (english characters, can be empty)
    "outputs = integer len
    "O(n) n is the strlen of s.
    " OPTIMIZATION: is there any way to avoid traversing all of n?
    METHOD longest_substring.
        DATA lt_characters TYPE tt_characters.

        DATA(l_strlen) = strlen( s ).
        DATA l_index TYPE integer value 0.
        DATA l_longest_substring TYPE integer VALUE 0.

        WHILE l_index < l_strlen.
              DATA(l_current_char) = s+l_index(1).
              
              "find if character is on table
              READ TABLE lt_characters TRANSPORTING NO FIELDS
                WITH KEY character = l_current_char.
              IF sy-subrc = 0.
                DELETE lt_characters INDEX 1 TO sy-tabix.
              ENDIF.
              
              APPEND l_current_char TO lt_characters.
              
              IF l_longest_substring < lines( lt_characters ).
                l_longest_substring = lines( lt_characters ).
              ENDIF.

              ADD 1 to l_index.

              "exit loop early if remaining characters are not enough to beat longest substring
              DATA(l_remaining_characters) = l_strlen - l_index.
              IF lines(lt_characters) + l_remaining_characters < l_longest_substring.
                EXIT.
              ENDIF.
        ENDWHILE.

    ENDMETHOD

    "Example test cases
    " 'abcdca" -> 
        l_remaining_characters  = 1
        l_index                 = 5
        l_current_char          = a
        lt_characters           = [ d c ]
        l_longest_substring     = 4

    " ''

    " 'abcabcdefgabcd'
    " 'aaaaaaa'


    "1. brute force solution
    " try every combination ("abcd" a, ab, abc, abcd, b, bc, bcd, c ... )

    "2. table, if i find a new character, i will add it to the table.
    " abcdada

    "table [ d a ]
    "longest_substring_so_far = 4

    "if my longest substring is greater than current table + characters remaining on string 

ENDCLASS.