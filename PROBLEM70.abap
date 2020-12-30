CLASS zproblem70 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS climbing_stairs
      IMPORTING im_stairs     TYPE i
      RETURNING VALUE(r_ways) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES: BEGIN OF t_ways,
             stair_nr TYPE i,
             steps    TYPE i,
           END OF t_ways.

    DATA it_ways TYPE HASHED TABLE OF t_ways WITH UNIQUE KEY stair_nr.
ENDCLASS.



CLASS zproblem70 IMPLEMENTATION.

  METHOD climbing_stairs.

    "exit condition
    IF im_stairs < 0.
      r_ways = 0.
      RETURN.
    ELSEIF im_stairs = 0.
      r_ways = 1.
      RETURN.
    ENDIF.

    READ TABLE it_ways INTO DATA(lw_way) WITH KEY stair_nr = im_stairs.
    IF sy-subrc = 0.
      r_ways = lw_way-steps.
    ELSE.
      r_ways = climbing_stairs( im_stairs - 2 ) + climbing_stairs( im_stairs - 1 ).
      CLEAR lw_way.
      lw_way-stair_nr = im_stairs.
      lw_way-steps = r_ways.
      INSERT lw_way INTO TABLE it_ways.
    ENDIF.

  ENDMETHOD.

ENDCLASS.