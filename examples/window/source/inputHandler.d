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
module examples.window.inputhandler;

import asgard;
import examples.window.game;

class InputHandler : iInputHandler
{

    private:
        this() {}

        ~this() {}

        __gshared InputHandler instance_;
        static bool instantiated_;

    public:
    
        InputHandler* s_pInstance;
        
        /**
            * Sigleton instance
            */
        static InputHandler Instance()
        {
            if (!instantiated_)
            {
            synchronized(InputHandler.classinfo)
            {
                if (!instance_)
                {
                instance_ = new InputHandler();
                }
                instantiated_ = true;
            }
            }
            return instance_;
        }
        
        void update()
        {
            SDL_Event event;
            while(SDL_PollEvent(&event))
            {

                switch(event.type)
                {
                    case SDL_QUIT:
                        Game.get().quit();
                        break;
                    default:
                        break;
                }
            }  
        }
}
