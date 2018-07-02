module source.vector2d;

import std.math;

class Vector2D
{
    private Vector2D value;
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

    private float m_x;
    private float m_y;
}
