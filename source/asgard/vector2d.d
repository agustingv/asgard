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

module asgard.vector2d;

import std.math;

/**
 * Overloading operators for vector 2d operations
 */
class Vector2D
{
    private:
    
        Vector2D value;
        float m_x;
        float m_y;
        
    public:
    
        /**
         * Set class properties
         * @param: float px
         * @param: float py
         */
        this(float px, float py)
        {
            m_x = px;
            m_y = py;
        }

        float length()
        {
            return sqrt(m_x * m_x + m_y * m_y);
        }


        /**
        * Overloading operator. Add two vectors together
        * @param: Vector2D v2
        * @return: Vector2D
        */
        Vector2D opAdd(Vector2D v2)
        {
            m_x = m_x + v2.m_y;
            m_y = m_y + v2.m_y;
            return this;
        }

        Vector2D opAddAssign(Vector2D v2)
        {
            m_x += v2.m_x;
            m_y += v2.m_y;
            return this;
        }

        Vector2D opMul(float scalar)
        {
            m_x = m_x * scalar;
            m_y = m_y * scalar;
            return this;
        }

        Vector2D opMulAssign(float scalar)
        {
            m_x *= scalar;
            m_y *= scalar;

            return this;
        }

        Vector2D opSub(Vector2D v2)
        {
            m_x = m_x - v2.m_x;
            m_y = m_y - v2.m_y;
            return this;
        }

        Vector2D opSubAssign(Vector2D v2)
        {
                m_x -= v2.m_x;
                m_y -= v2.m_y;
                return this;
        }

        Vector2D opDiv(float scalar)
        {
            m_x = m_x/scalar;
            m_y = m_y/scalar;
            return this;
        }

        Vector2D opDivAssign(float scalar)
        {
                m_x /= scalar;
                m_y /= scalar;
                return this;
        }

        //TODO: it's necessary????
        void normalize()
        {
            float l = length();
            if (l > 0)
            {
            // this *= 1 / 1;
            }
        }

        @property float x(float value) { return m_x = value; }
        @property float x() { return m_x; }

        @property float y(float value) { return m_y = value; }
        @property float y() { return m_y; }

}
