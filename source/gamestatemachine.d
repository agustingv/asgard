module source.gamestatemachine;

import std.container.array,
       std.stdio;

import source.gamestate;

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
