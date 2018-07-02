module source.gamestate;

class GameState
{
    public void update()
    {}

    public void render()
    {}

    public bool onEnter()
    {
        return false;
    }

    public bool onExit()
    {
        return false;
    }

    public string getStateID()
    {
        return "MENU";
    }
}
