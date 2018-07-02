module source.gameobjectfactory;

import source.basecreator,
       source.gameobject,
       source.game;

import std.container.array,
       std.stdio;

class GameObjectFactory
{
    public:

        /**
         * Sigleton instance
         */
        static GameObjectFactory get()
        {
            if (!instantiated_)
            {
                synchronized(GameObjectFactory.classinfo)
                {
                    if (!instance_)
                    {
                        instance_ = new GameObjectFactory();
                    }
                    instantiated_ = true;
                }
           }
           return instance_;
        }

        bool registerType(string typeID, BaseCreator pCreator)
        {
            if (m_creators.get(typeID,null))
            {
                pCreator.destroy();
                return false;
            }
            m_creators[typeID] = pCreator;

            return true;
        }

        GameObject create(string typeID)
        {
            if (!m_creators.get(typeID,null))
            {
                return null;
            }
            return m_creators[typeID].createGameObject();
        }

    private:

        __gshared GameObjectFactory instance_;
        static bool instantiated_;
        GameObjectFactory* s_pInstance;

        private this()
        {}

        BaseCreator[string] m_creators;

}
