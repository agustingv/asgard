/**
    This file is part of AsGARD.

    AsGARD is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    AsGARD is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with AsGARD.  If not, see <https://www.gnu.org/licenses/>.
*/

module asgard.iinputhandler;

import std.stdio,
       std.typecons;
       
import derelict.sdl2.sdl;
       
import asgard.vector2d;

/**
 * Define input handleds. Keyboard, mouse, joystick.
 */
interface iInputHandler
{
 
  void update();

}
