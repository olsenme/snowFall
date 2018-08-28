# snowFall Program
 Implement semantics of MiniMiniLogo Language that generates a drawn picture.

# Instructions
1) Install haskell platform <br>
2) Open terminal <br>
2) ```cd <your directory>``` <br>
3) ```ghci``` <br>
4) ```:l (name of file(no extensions))``` <br>
5) ```draw snowFall, snowWall, etc``` <br>

# Dicussion
We used a Haskell implementation of MiniMiniLogo, a derviative of the the <a href="http://el.media.mit.edu/logo-foundation/what_is_logo/logo_programming.html">Logo language </a> and Haskell to create this app.

# Requirements

```int 	::= 	(any integer) 	
prog 	::= 	ε   |   cmd ; prog 	sequence of commands
mode 	::= 	down   |   up 	pen status
cmd 	::= 	pen mode 	change pen mode
	| 	move ( int , int ) 	move pen to a new position
  ```
  
<ul>
  <li>implements a change in the state of the pen </li>
  <li> implements a list of lines to draw  </li>
  <li> implement ```cmd```, the semantic function for MiniMiniLogo commands (Cmd)</li>
  <li>Implement prog, the semantic function for MiniMiniLogo programs (Prog). </li>
