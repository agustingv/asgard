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

module asgard.igame;

import asgard.gamestatemachine;
import derelict.sdl2.sdl;

interface iGame
{
    private:

        __gshared iGame instance_;
        static bool instantiated_;
  
  public:
        /**
            * Sigleton instance
            */
        static iGame get();

        /**
        * Inicia el juego. Crea la ventana de juego, registra los objetos y el manejador de los dispositivos externos.
        * @param: const char* title Título de la ventana
        * @param: int xpos Posición del eje x
        * @param: int ypos Posición del eje y
        * @param: int height Alto de la ventana
        * @param: int width Ancho de la ventana
        * @param: SDL_WindowFlags flags Flags para la creación de la ventana (Ej: ventana completa)
        *
        * @return: bool 
        */
        bool init(const char* title, int xpos, int ypos, int height, int width, SDL_WindowFlags flags);
        
        /**
        * Lanza los eventos draw de los objectos heredados
        */
        void draw();

        void render();

        void update();

        void handleEvents();
        
        void clean();

        bool running();
        
        SDL_Renderer* getRenderer();

        void quit();
        
        GameStateMachine getStateMachine();

        int getGameWidth();
        
        int getGameHeight();
}
