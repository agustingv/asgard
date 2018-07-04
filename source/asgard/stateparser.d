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

module asgard.stateparser;

import asgard.gameobject;
import asgard.loaderparams;
import asgard.gameobjectfactory;
import asgard.texturemanager;
import asgard.igame;

import std.container.array,
       std.stdio,
       dyaml,
       std.string;

/**
 * Parse tilesets files and create textures or objects
 */
class StateParser
{
    public:
        bool parseState(string stateFile, const string stateID, Array!GameObject *pObjects, Array!string *pTextureIDs)
        {
            try
            {
                Node root = Loader(stateFile).load();

                Node pStateRoot;
                pStateRoot = root["states"][stateID];

                Node pTextureRoot;
                pTextureRoot = pStateRoot["textures"];

                parseTextures(pTextureRoot, pTextureIDs);

                Node pObjectRoot;
                pObjectRoot = pStateRoot["objects"];

                parseObjects(pObjectRoot, pObjects);


                return true;
            }
            catch (YAMLException e)
            {
                writeln(e.msg);
                return false;
            }

        }

    private:
        void parseObjects(Node pObjectRoot, Array!GameObject *pObjects)
        {
            foreach (string id, Node object; pObjectRoot)
            {
                int x, y, width, height, numFrames, callbackID, animSpeed;
                string textureID;

                x = object["x"].as!int;
                y = object["y"].as!int;
                width = object["width"].as!int;
                height = object["height"].as!int;
                numFrames = object["numFrames"].as!int;
                callbackID = object["callbackID"].as!int;
                animSpeed = object["animSpeed"].as!int;
                textureID = object["textureID"].as!string;

                GameObject pGameObject = GameObjectFactory.get().create(object["type"].as!string);
                pGameObject.load(new LoaderParams(x, y, width, height, textureID, numFrames, callbackID, animSpeed));

                pObjects.insertBack(pGameObject);
                writeln("create gameobjexts");
            }
        }

        void parseTextures(Node pTextureRoot, Array!string *pTextureIDs)
        {

            foreach(string id, Node object; pTextureRoot)
            {

                 
                 string filename = object["filename"].as!string;
                 string idAttr = object["id"].as!string;
                 pTextureIDs.insertBack(idAttr);

                 const char *name = toStringz(filename);
//                  TextureManager.get().load(name, idAttr,iGame.get().getRenderer());
                 writeln("create textures");
            }
        
        }
}
