DECLARE FUNCTION sumarMatrix! (x AS INTEGER, y AS INTEGER)
DECLARE FUNCTION okLimits! (x AS INTEGER, y AS INTEGER)
CONST TRUE = 1, FALSE = 0
'*********************************************************************
'* CONSTANTES PARA MODIFICAR EL COMPORTAMIENTO ***********************
'*********************************************************************
CONST MAXFALLOS = 5, MAXRETARDO = 3
'*********************************************************************


TYPE pnt
        x AS INTEGER
        y AS INTEGER
        dx AS INTEGER
        dy AS INTEGER
        fallos AS INTEGER
        retardo AS INTEGER
END TYPE

RANDOMIZE TIMER
SCREEN 13
DIM punto AS pnt
punto.fallos = MAXFALLOS
punto.retardo = MAXRETARDO
DIM s AS STRING, ix AS INTEGER, iy AS INTEGER

DO
       IF INKEY$ = CHR$(27) THEN
            OPEN "1.dat" FOR OUTPUT AS #1
            FOR iy = 0 TO 199
                s = ""
                FOR ix = 0 TO 319
                    s = s + CHR$(POINT(ix, iy) + 1)
                NEXT
                PRINT #1, s
            NEXT
            CLOSE #1
            END
       END IF
       IF punto.fallos = MAXFALLOS THEN
                punto.x = INT(RND * 320)
                punto.y = INT(RND * 200)
                punto.fallos = 0
       END IF
      
       punto.retardo = punto.retardo + 1
       IF punto.retardo >= MAXRETARDO + 1 THEN
                punto.retardo = 0
                IF INT(RND * 2) = 0 THEN
                        punto.dx = INT(RND * 3) - 1
                        punto.dy = 0
                ELSE
                        punto.dy = INT(RND * 3) - 1
                        punto.dx = 0
                END IF
       END IF

       IF okLimits(punto.x + punto.dx, punto.y + punto.dy) AND sumarMatrix(punto.x + punto.dx, punto.y + punto.dy) <= 2 THEN
        PSET (punto.x + punto.dx, punto.y + punto.dy), 1
        punto.x = punto.x + punto.dx
        punto.y = punto.y + punto.dy
       ELSE
        punto.fallos = punto.fallos + 1
       END IF
LOOP

FUNCTION okLimits (x AS INTEGER, y AS INTEGER)
        okLimits = FALSE
        IF x >= 0 AND x <= 319 AND y >= 0 AND y <= 199 THEN okLimits = TRUE
END FUNCTION

FUNCTION sumarMatrix (x AS INTEGER, y AS INTEGER)
        DIM sMatrix AS INTEGER
        sMatrix = 0
        IF okLimits(x - 1, y - 1) = TRUE AND POINT(x - 1, y - 1) = 1 THEN sMatrix = sMatrix + 1
        IF okLimits(x, y - 1) = TRUE AND POINT(x, y - 1) = 1 THEN sMatrix = sMatrix + 1
        IF okLimits(x + 1, y - 1) = TRUE AND POINT(x + 1, y - 1) = 1 THEN sMatrix = sMatrix + 1
        IF okLimits(x - 1, y) = TRUE AND POINT(x - 1, y) = 1 THEN sMatrix = sMatrix + 1
        IF okLimits(x + 1, y) = TRUE AND POINT(x + 1, y) = 1 THEN sMatrix = sMatrix + 1
        IF okLimits(x - 1, y + 1) = TRUE AND POINT(x - 1, y + 1) = 1 THEN sMatrix = sMatrix + 1
        IF okLimits(x, y + 1) = TRUE AND POINT(x, y + 1) = 1 THEN sMatrix = sMatrix + 1
        IF okLimits(x + 1, y + 1) = TRUE AND POINT(x + 1, y + 1) = 1 THEN sMatrix = sMatrix + 1
        sumarMatrix = sMatrix
END FUNCTION

