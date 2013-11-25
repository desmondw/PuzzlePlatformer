package
{
    import org.axgl.Ax;
	import org.axgl.render.AxColor;
    
    [SWF(width = "960", height = "640", backgroundColor = "#000000")]
 
    public class Main extends Ax
	{
        public function Main()
		{
            super(GameState, 0, 0, 4);
        }
		
		override public function create():void
		{
			Ax.background = new AxColor(0, .6, 1);
		}
    }
}