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

module asgard.texturemanager;

import std.stdio,
       std.algorithm,
       std.algorithm.iteration;

import derelict.sdl2.image,
       derelict.sdl2.sdl;

/**
 * Load and draw textures
 */
class TextureManager
{

    private:

        // private _ctor 
        this(){}

        __gshared TextureManager instance_;
        private static bool instantiated_;
  
    public:

        SDL_Texture*[string] m_textureMap;
        TextureManager* s_pInstance;


       /**
        * Sigleton instance
        */
        static TextureManager get()
        {
            if (!instantiated_)
            {
                synchronized(TextureManager.classinfo)
                {
                    if (!instance_)
                    {
                        instance_ = new TextureManager();
                    }
                    instantiated_ = true;
                }
            }
            return instance_;
        }


        bool load(const char* filename, string id, SDL_Renderer* pRenderer)
        {
            SDL_Surface* pTempSurface = IMG_Load(filename);
            if (pTempSurface == null)
            {
                return false;
            }
            SDL_Texture * pTexture = SDL_CreateTextureFromSurface(pRenderer, pTempSurface);
            SDL_FreeSurface(pTempSurface);
            if (pTexture != null)
            {
                m_textureMap[id] = pTexture;

                return true;
            }
            return false;
        }

        void draw(string id, int x, int y, int width, int height, SDL_Renderer* pRenderer, const SDL_RendererFlip flip = SDL_FLIP_NONE)
        {
            SDL_Rect srcRect;
            SDL_Rect destRect;

            srcRect.x = 0;
            srcRect.y = 0;
            srcRect.w = destRect.w = width;
            srcRect.h = destRect.h = height;
            destRect.x = x;
            destRect.y = y;

            const SDL_Point* point;
            SDL_RenderCopyEx(pRenderer, m_textureMap[id], &srcRect, &destRect, 0, point, flip);
        }

        void drawFrame(string id, int x, int y, int width, int height, int currentRow, int currentFrame, SDL_Renderer* pRenderer, SDL_RendererFlip flip = SDL_FLIP_NONE)
        {
            SDL_Rect srcRect;
            SDL_Rect destRect;

            srcRect.x = (width * currentFrame);
            srcRect.y = (height * (currentRow - 1));
            srcRect.w = destRect.w = width;
            srcRect.h = destRect.h = height;
            destRect.x = x;
            destRect.y = y;

            const SDL_Point* point;
            // TODO: add texturemap check id
            SDL_RenderCopyEx(pRenderer,m_textureMap[id], &srcRect, &destRect, 0, point, flip);
        }

        void drawTile(string id, int margin, int spacing, int x, int y, int width, int height, int currentRow, int currentFrame, SDL_Renderer* pRenderer)
        {
            SDL_Rect srcRect;
            SDL_Rect destRect;

            srcRect.x = margin + (spacing + width) * currentFrame;
            srcRect.y = margin + (spacing + height) * currentRow;
            srcRect.w = destRect.w = width;
            srcRect.h = destRect.h = height;
            destRect.x = x;
            destRect.y = y;

            const SDL_Point* point;
            // TODO: add texturemap check id
            SDL_RenderCopyEx(pRenderer,m_textureMap[id], &srcRect, &destRect, 0, point, SDL_FLIP_NONE);
        }
        void clearFromTextureMap(string id)
        {
            m_textureMap.remove(id);
        }

}
