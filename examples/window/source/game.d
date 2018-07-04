module examples.window.game;

import std.stdio;
       
import asgard;
       
/**
 * Object Game example create sdl window
 */
class Game : iGame
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

    void handleEvents(){}

    void clean()
    {
        writeln("cleaning game\n");
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

    bool m_bRunning;
    
    void quit() {}
            
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
