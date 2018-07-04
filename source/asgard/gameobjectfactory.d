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

module asgard.gameobjectfactory;

import asgard.gameobject;
import asgard.basecreator;

// some standard import
import std.container.array,
       std.stdio;

/**
 * Register types and create game objects
 */
class GameObjectFactory
{
    public:

        /**
         * Sigleton instance
         * @source: https://wiki.dlang.org/Low-Lock_Singleton_Pattern
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

        /**
         * Register games types objects (EJ: Players or enemies)
         * @param: string typeID
         * @param: BaseCreator pCreator
         * @return: bool
         */
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

        private this(){}

        BaseCreator[string] m_creators;

}
