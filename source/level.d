module source.level;

import std.container.array,
       std.stdio;

import source.layer;

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
