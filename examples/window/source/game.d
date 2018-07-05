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

module examples.window.game;

import std.stdio;
       
import asgard;
import examples.window.inputhandler;

/**
 * Object Game example create sdl window
 */
class Game
{


  Game* s_pInstance;
  GameStateMachine m_pGameStateMachine;

  private:
  
    this(){}

    __gshared Game instance_;
    static bool instantiated_;
    SDL_Window* m_pWindow;
    SDL_Renderer* m_pRenderer;
    
  public:

    bool m_bRunning;
    
    /**
        * Sigleton instance
        */
    static Game get()
    {
        if (!instantiated_)
        {
        synchronized(Game.classinfo)
        {
            if (!instance_)
            {
            instance_ = new Game();
            }
            instantiated_ = true;
        }
        }
        return instance_;
    }



    int m_currentFrame;
    TextureManager m_textureManager;

    GameObject[int] m_gameObject;

    int m_gameHeight;
    int m_gameWidth;

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
    bool init(const char* title, int xpos, int ypos, int height, int width, SDL_WindowFlags flags)
    {
        if (SDL_Init(SDL_INIT_EVERYTHING) >= 0) 
        {
        writeln("SDL Init success\n");

        m_pWindow = SDL_CreateWindow(title, xpos, ypos, height, width, flags);

        if (m_pWindow != null)
        {
            m_gameHeight = height;
            m_gameWidth = width;

            writeln("Window creation success\n");

            m_pRenderer = SDL_CreateRenderer(m_pWindow, -1, 0);

            if (m_pRenderer != null)
            {
                writeln("renderer creation success\n");
                SDL_SetRenderDrawColor(m_pRenderer, 255, 255, 255, 255);

            }
            else 
            {
                writeln("renderer init fail!\n");
                return false;
            }

        }
        else 
        {
            writeln("Window init fail!\n");
            return false;
        }

        writeln("init success\n");
        m_bRunning = true;

        return true;
        }
        
        return true;
    }


    /**
    * Lanza los eventos draw de los objectos heredados
    */
    void draw(){}

    void render(){}

    void update(){}

    void handleEvents()
    {
        InputHandler.Instance().update();
    }

    void clean()
    {
        SDL_DestroyWindow(m_pWindow);
        SDL_DestroyRenderer(m_pRenderer);
        SDL_Quit();
    }

    bool running()
    {
        return m_bRunning;
    }


    SDL_Renderer* getRenderer() 
    {
        return m_pRenderer;
    }
   
    void quit() 
    {
        m_bRunning = false;
        SDL_Quit();
    }
            
    GameStateMachine getStateMachine() 
    {
      return new GameStateMachine();
    }

    int getGameWidth() 
    {
      return 1;
    }
            
    int getGameHeight() 
    {
      return 1;
    }

}
