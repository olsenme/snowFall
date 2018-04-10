--- Alex Bailey (baileyal), Meagan Olsen(olsenme), Kevin Deming(demingk)

module HW3 where

import MiniMiniLogo
import Render

--
-- * Semantics of MiniMiniLogo
--

-- NOTE:
--   * MiniMiniLogo.hs defines the abstract syntax of MiniMiniLogo and some
--     functions for generating MiniMiniLogo programs. It contains the type
--     definitions for Mode, Cmd, and Prog.
--   * Render.hs contains code for rendering the output of a MiniMiniLogo
--     program in HTML5. It contains the types definitions for Point and Line.

-- | A type to represent the current state of the pen.
type State = (Mode,Point)

-- | The initial state of the pen.
start :: State
start = (Up,(0,0))

-- | A function that renders the image to HTML. Only works after you have
--   implemented `prog`. Applying `draw` to a MiniMiniLogo program will
--   produce an HTML file named MiniMiniLogo.html, which you can load in
--   your browser to view the rendered image.
draw :: Prog -> IO ()
draw p = let (_,ls) = prog p start in toHTML ls


-- Semantic domains:
--   * Cmd:  State -> (State, Maybe Line)
--   * Prog: State -> (State, [Line])


-- | Semantic function for Cmd.
--   
--   >>> cmd (Pen Down) (Up,(2,3))
--   ((Down,(2,3)),Nothing)
--
--   >>> cmd (Pen Up) (Down,(2,3))
--   ((Up,(2,3)),Nothing)
--
--   >>> cmd (Move 4 5) (Up,(2,3))
--   ((Up,(4,5)),Nothing)
--
--   >>> cmd (Move 4 5) (Down,(2,3))
--   ((Down,(4,5)),Just ((2,3),(4,5)))
--
cmd :: Cmd -> State -> (State, Maybe Line)
cmd (Move x2 y2) (Down,(x1,y1)) = ((Down, (x2,y2)),Just ((x1,y1),(x2,y2)))
cmd ( Pen u ) (_, ( x , y ))        = ((u,(x,y)), Nothing)
cmd ( Move x y ) ( u ,_)            = ((u,(x,y)),Nothing)
-- cmd _ _ = error "Error Bad Input"
-- We tried to add a warning for bad input, but we ran into redundancy issues and it never really triggered.


-- | Semantic function for Prog.
--
--   >>> prog (nix 10 10 5 7) start
--   ((Down,(15,10)),[((10,10),(15,17)),((10,17),(15,10))])
--
--   >>> prog (steps 2 0 0) start
--   ((Down,(2,2)),[((0,0),(0,1)),((0,1),(1,1)),((1,1),(1,2)),((1,2),(2,2))])
prog :: Prog -> State -> (State, [Line])
prog gram begin = (prog_help_state gram begin, prog_help gram begin)

--------------------------
prog_help :: [Cmd] -> State -> [Line]
prog_help [] b          = [] 
prog_help a (m,(x1,y1)) = case ((cmd (head a) (m,(x1,y1)))) of
                            (state1, Just line1) -> [line1] ++ (prog_help (tail a) state1)
                            (state1, Nothing)    -> [] ++ (prog_help (tail a) state1)


--prog_help a (m,(x1,y1)) = [] ++ (prog_help (tail a) state1) where (state1, (c)) = (cmd (head a) (m,(x1,y1)))

---------------------------------
prog_help_state :: [Cmd] -> State -> State
prog_help_state [] b           = b
prog_help_state a (m1,(x1,y1)) = prog_help_state (tail a) state1 where (state1, line1) = (cmd (head a) (m1,(x1,y1)))


--
-- * Extra credit
--

-- | This should be a MiniMiniLogo program that draws an amazing picture.
--   Add as many helper functions as you want.
amazing :: Prog
amazing = undefined



--------------------
dline :: Point -> Point -> Prog
dline (x1,y1) (x2,y2) = [Pen Up, Move x1 y1, Pen Down, Move x2 y2, Pen Up]




--------------------
snowflake :: Point -> Prog
snowflake (x,y) = (dline (x,y) (x,y+4)) ++ (dline (x-1,y) (x,y+1)) ++ (dline (x+1,y) (x,y+1)) ++ (dline (x,y+3) (x-1,y+4)) ++ (dline (x,y+3) (x+1,y+4)) ++
                  (dline (x+2,y) (x-2,y+4)) ++ (dline (x+1,y) (x+1,y+1)) ++ (dline (x+2,y+1) (x+1,y+1)) ++ (dline (x-1,y+3) (x-2,y+3)) ++ (dline (x-1,y+3) (x-1,y+4)) ++
                  (dline (x-2,y) (x+2,y+4)) ++ (dline (x-1,y) (x-1,y+1)) ++ (dline (x-2,y+1) (x-1,y+1)) ++ (dline (x+1,y+3) (x+1,y+4)) ++ (dline (x+1,y+3) (x+2,y+3)) ++
                  (dline (x-2,y+2) (x+2,y+2)) ++ (dline (x-1,y+2) (x-2,y+3)) ++ (dline (x-1,y+2) (x-2,y+1)) ++ (dline (x+1,y+2) (x+2,y+3)) ++ (dline (x+1,y+2) (x+2,y+1))


-------------------
snowWall :: Point -> Prog
snowWall (x,y) = snowflake (x,y) ++ snowflake (x+4,y) ++ snowflake (x+8,y) ++
                 snowflake (x,y+4) ++ snowflake (x+4,y+4) ++ snowflake (x+8,y+4) ++
                 snowflake (x,y+8) ++ snowflake (x+4,y+8) ++ snowflake (x+8,y+8)



------------------
snowLine :: Point -> Prog
snowLine (x, y) = snowflake (x,y) ++ snowflake (x+15,y) ++ snowflake (x+30,y) ++ snowflake (x+45,y) ++ snowflake (x+60,y) ++ snowflake (x+75,y)

------------------
snowFall :: Prog
snowFall = snowLine (5,35) ++ snowLine (10,26) ++ snowLine (13,18) ++ snowWall (4,0)




