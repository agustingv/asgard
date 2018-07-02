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

module asgard.gamestatemachine;

import std.container.array,
       std.stdio;

import asgard.gamestate;

/**
 * Define finite state machine.
 */
class GameStateMachine
{
    private:
        Array!GameState m_gameState;

    public:

        void pushState(GameState pState)
        {
            m_gameState.insertBack(pState);
            m_gameState.back.onEnter();
        }

        void changeState(GameState pState)
        {
            if (!m_gameState.empty)
            {
                if (m_gameState.back.getStateID == pState.getStateID)
                {
                    return;
                }
                m_gameState.back.onExit();
                m_gameState.removeBack;
            }
            m_gameState.insertBack(pState);
            m_gameState.back.onEnter();
        }

        void popState()
        {
            if (!m_gameState.empty)
            {
                m_gameState.back.onExit();
                m_gameState.removeBack;
            }
        }

        void update()
        {
            if (!m_gameState.empty)
            {
                m_gameState.back.update();
            }
        }

        void render()
        {
            if (!m_gameState.empty)
            {
                m_gameState.back.render();
            }
        }

}
