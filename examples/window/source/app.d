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
module window;

import examples.window.game;

import std.stdio;


import derelict.sdl2.image,
       derelict.sdl2.sdl;
       
Game game;

const int FPS = 60;
const float DELAY_TIME = 1000.0f / FPS;

int main()
{

    Uint32 frameStart, frameTime;

    DerelictSDL2.load();
    DerelictSDL2Image.load();

    game = Game.get();

    game.init("Example window", 100, 100, 640, 480, 0);

    while (game.running())
    {
     // writeln(game.running());
      frameStart = SDL_GetTicks();

      game.handleEvents();
      game.update();
      game.render();

      frameTime = SDL_GetTicks() - frameStart;

      if (frameTime < DELAY_TIME)
      {
        SDL_Delay(cast(int)(DELAY_TIME - frameTime));
      }
    }

    game.clean();

    return 0;


}
