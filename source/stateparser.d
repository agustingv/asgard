module source.stateparser;

import source.gameobject,
       source.texturemanager,
       source.game,
       source.loaderparams,
       source.gameobjectfactory;


import std.container.array,
       std.stdio,
       dyaml,
       std.string;

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
                 TextureManager.get().load(name, idAttr,Game.get().getRenderer());
                 writeln("create textures");
            }
        
        }
}
