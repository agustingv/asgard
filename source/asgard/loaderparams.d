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

module asgard.loaderparams;


/**
 * Generic params loder.
 */
class LoaderParams
{
    public:

        this(int px, int py, int pwidth, int pheight, string ptextureID, int pNumFrames = 1, int pcallbackID = 0, int panimSpeed = 0)
        {
            x = px;
            y = py;
            width = pwidth;
            height = pheight;
            textureID = ptextureID;
            numFrames = pNumFrames;
            animSpeed = panimSpeed;
            callbackID = pcallbackID;
        }

        @property int x(int value) { return m_x = value; }
        @property int x() { return m_x; }

        @property int y(int value) { return m_y = value; }
        @property int y() { return m_y; }

        @property int width(int value) { return m_width = value; }
        @property int width() { return m_width; }

        @property int height(int value) { return m_height = value; }
        @property int height() { return m_height; }

        @property string textureID(string value) { return m_textureID = value; }
        @property string textureID() { return m_textureID; }

        @property int numFrames(int value) { return m_numFrames = value; }
        @property int numFrames() { return m_numFrames; }

        @property int animSpeed(int value) { return m_animSpeed = value; }
        @property int animSpeed() { return m_animSpeed; }

        @property int callbackID(int value) { return m_callbackID = value; }
        @property int callbackID() { return m_callbackID; }

    private:
        int m_x;
        int m_y;
        int m_width;
        int m_height;
        string m_textureID;
        int m_numFrames;
        int m_animSpeed;
        int m_callbackID;

}


