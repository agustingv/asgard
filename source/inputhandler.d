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

module asgard.inputhandler;

import std.stdio,
       std.typecons;
import derelict.sdl2.image,
       derelict.sdl2.sdl;
import asgard.game,
       asgard.vector2d;

/**
  * Mouse button ids
  */
  // TODO: remove struct
enum MB
{
      LEFT = 0,
      MIDDLE = 1,
      RIGHT = 2
}

/**
 * Define input handleds. Keyboard, mouse, joystick.
 */
class InputHandler
{
  InputHandler* s_pInstance;

  private this() 
  {
    for (int i = 0; i < 3; i++)
    {
        m_mouseButtonStates[i] = false;
    }
  }

  private ~this() {}

  private __gshared InputHandler instance_;
  private static bool instantiated_;
  const int m_joystickDeadZone = 10000;

  bool[int][int] m_buttonStates;
  bool[int] m_mouseButtonStates;

  MB mb; // mouse buttons ids

  Vector2D m_mousePosition = new Vector2D(0,0);
  Uint8* m_keystate;

  /**
    * Sigleton instance
    */
  static InputHandler get()
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
      m_keystate = SDL_GetKeyboardState(null);
      while(SDL_PollEvent(&event))
      {

          switch(event.type)
          {
              case SDL_QUIT:
                  Game.get().quit();
                  break;
                  
              case SDL_JOYAXISMOTION:
                  onJoystickAxisMove(event);
                  break;
              case SDL_JOYBUTTONDOWN:
                  onJoystickButtonDown(event);
                  break;
              case SDL_JOYBUTTONUP:
                  onJoystickButtonUp(event);
                  break;
              case SDL_MOUSEMOTION:
                  onMouseMove(event);
                  break;
              case SDL_MOUSEBUTTONDOWN:
                  onMouseButtonDown(event);
                  break;
              case SDL_MOUSEBUTTONUP:
                  onMouseButtonUp(event);
                  break;
              case SDL_KEYDOWN:
                  onKeyDown();
                  break;
              case SDL_KEYUP:
                  onKeyUp();
                  break;
              default:
                  break;
          }
      }
  }

  bool getButtonState(int joy, int buttonNumber)
  {
      return m_buttonStates[joy][buttonNumber];
  }

  bool getMouseButtonState(int buttonNumber)
  {
      return m_mouseButtonStates[buttonNumber];
  }

  Vector2D getMousePosition()
  {
      return m_mousePosition;
  }

  void clean()
  {
      if (m_bJoysticksInitialised)
      {
          for (int i = 0; i < SDL_NumJoysticks(); i++)
          {
              SDL_JoystickClose(m_joysticks[i]);
          }
      }
  }

  void initialiseJoysticks() 
  {
      if (SDL_WasInit(SDL_INIT_JOYSTICK) == 0)
      {
          SDL_InitSubSystem(SDL_INIT_JOYSTICK);
      }

      if (SDL_NumJoysticks() > 0)
      {
          for (int i = 0; i < SDL_NumJoysticks(); i++)
          {
              SDL_Joystick* joy = SDL_JoystickOpen(i);
              if (joy)
              {
                  m_joysticks[i] = joy;
                  m_joystickValues[i]["first"] = new Vector2D(0,0);
                  m_joystickValues[i]["second"] = new Vector2D(0,0);

                  bool[int] tempButtons;

                  for (int j = 0; j < SDL_JoystickNumButtons(joy); j++)
                  {
                      tempButtons[j] = false;
                  }

                  m_buttonStates[i] = tempButtons;
              }
              else
              {
                  writeln(SDL_GetError());
              }
          }
          SDL_JoystickEventState(SDL_ENABLE);
          m_bJoysticksInitialised = true;

          writeln("Initialised");
      }
      else
      {
          m_bJoysticksInitialised = false;
      }
  }

  bool joysticksInitialised()
  {
      return m_bJoysticksInitialised;
  }

  SDL_Joystick*[int] m_joysticks;
  bool m_bJoysticksInitialised;


  Vector2D[string][int] m_joystickValues;

  int yvalue(int joy, int stick)
  {
      if (m_joystickValues.sizeof > 0)
      {
          if (stick == 1)
          {
              return cast(int)m_joystickValues[joy]["first"].y;
          }
          else if (stick == 2)
          {
              return cast(int)m_joystickValues[joy]["second"].y;
          }
      }
      return 0;
  }

  int xvalue(int joy, int stick)
  {
      if (m_joystickValues.sizeof > 0)
      {
          if (stick == 1)
          {
              return cast(int)m_joystickValues[joy]["first"].x;
          }
          else if (stick == 2)
          {
              return cast(int)m_joystickValues[joy]["second"].x;
          }
      }
      return 0;
  }

  bool isKeyDown(SDL_Scancode key)
  {
      if (m_keystate != cast(Uint8*)0)
      {
          if (m_keystate[key] == 1)
          {
            return true;
          }
      }
      else
      {
          return false;
      }
      return false;
  }

  private void onKeyDown()
  {
  }
  private void onKeyUp()
  {}

  private void onMouseMove(SDL_Event event)
  {
     m_mousePosition.x = event.motion.x;
     m_mousePosition.y = event.motion.y;
  }
  private void onMouseButtonDown(SDL_Event event)
  {
    if (event.button.button == SDL_BUTTON_LEFT)
    {
      m_mouseButtonStates[mb.LEFT] = true;
    }
    if (event.button.button == SDL_BUTTON_MIDDLE)
    {
      m_mouseButtonStates[mb.MIDDLE] = true;
    }
    if (event.button.button == SDL_BUTTON_RIGHT)
    {
      m_mouseButtonStates[mb.RIGHT] = true;
    }
  }

  private void onMouseButtonUp(SDL_Event event)
  {
    if (event.button.button == SDL_BUTTON_LEFT)
    {
       m_mouseButtonStates[mb.LEFT] = false;
    }
    if (event.button.button == SDL_BUTTON_MIDDLE)
    {
       m_mouseButtonStates[mb.MIDDLE] = false;
    }
    if (event.button.button == SDL_BUTTON_RIGHT)
    {
       m_mouseButtonStates[mb.RIGHT] = false;
    }
  }

  private void onJoystickAxisMove(SDL_Event event)
  {
      int whichOne = event.jaxis.which;

      if (event.jaxis.axis == 0)
      {
        if (event.jaxis.value > m_joystickDeadZone)
        {
          m_joystickValues[whichOne]["first"].x = 1;
        }
        else if(event.jaxis.value < m_joystickDeadZone)
        {
           m_joystickValues[whichOne]["first"].x = -1;
        }
        else
        {
           m_joystickValues[whichOne]["first"].x = 0;
        }
      }
      if (event.jaxis.axis == 1)
      {
        if (event.jaxis.value > m_joystickDeadZone)
        {
           m_joystickValues[whichOne]["first"].y = 1;
        }
        else if(event.jaxis.value < m_joystickDeadZone)
        {
           m_joystickValues[whichOne]["first"].y = -1;
        }
        else
        {
           m_joystickValues[whichOne]["first"].y = 0;
        }
      }
      if (event.jaxis.axis == 3)
      {
        if (event.jaxis.value > m_joystickDeadZone)
        {
           m_joystickValues[whichOne]["second"].x = 1;
        }
        else if(event.jaxis.value < m_joystickDeadZone)
        {
           m_joystickValues[whichOne]["second"].x = -1;
        }
        else
        {
           m_joystickValues[whichOne]["second"].x = 0;
        }
      }
      if (event.jaxis.axis == 4)
      {
        if (event.jaxis.value > m_joystickDeadZone)
        {
           m_joystickValues[whichOne]["second"].y = 1;
        }
        else if(event.jaxis.value < m_joystickDeadZone)
        {
          m_joystickValues[whichOne]["second"].y = -1;
        }
        else
        {
          m_joystickValues[whichOne]["second"].y = 0;
        }
      }
  }

  private void onJoystickButtonDown(SDL_Event event)
  {
     int whichOne = event.jaxis.which;
     m_buttonStates[whichOne][event.jbutton.button] = true;
  }

  private void onJoystickButtonUp(SDL_Event event)
  {
     int whichOne = event.jaxis.which;
     m_buttonStates[whichOne][event.jbutton.button] = false;
  }

}
