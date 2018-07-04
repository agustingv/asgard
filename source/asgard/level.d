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

module asgard.level;

import std.container.array,
       std.stdio;

import asgard.layer;

// TODO: move struct
struct Tileset
{
    int firstGridID;
    int tileWidth;
    int tileHeight;
    int spacing;
    int margin;
    int width;
    int height;
    int numColumns;
    string name;
}


/**
 * Render and update tilesets.
 */
class Level
{
    public:

        void update()
        {
            for (int i = 0; i < m_layers.length; i++)
            {
                m_layers.opIndex(i).update();
            }
        }

        void render()
        {
            for (int i = 0; i < m_layers.length; i++)
            {
                m_layers.opIndex(i).render();
            }
        }


        Array!Layer m_layers;

        Array!Layer *getLayers()
        {
            return &m_layers;
        }

        Array!Tileset m_tilesets;

        Array!Tileset *getTilesets()
        {
            return &m_tilesets;
        }

}
