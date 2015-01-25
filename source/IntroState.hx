package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import flixel.tweens.FlxTween;

/**
 * A FlxState which can be used for the game's menu.
 */
class IntroState extends FlxState
{

    var text:FlxText;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */

    private var readTime:Float = 0.1;
	override public function create():Void
	{
        text = new FlxText(0, 20, 400, "In The Beginning There was a ton of light and stuff in a galaxy far away or something. How cool isn't that?");
       
        text.alignment = "center";
        text.size = 20;
        text.x = (FlxG.stage.stageWidth - text.width) * 0.5;
        text.y = (FlxG.stage.stageHeight - text.height) * 0.5;
        text.alpha = 0;

        FlxTween.tween(text, { alpha:1.0 }, readTime, {complete:fadeOutThingy});

		super.create();
        add(text);
	}
	
    private function fadeOutThingy(tween:FlxTween):Void {
        FlxTween.tween(text, { alpha:0.0 }, readTime, {complete:showUsTheDude});
    }

    private var guyDude:IntroDude;
    private function showUsTheDude(tween:FlxTween):Void {

        guyDude = new IntroDude();
        add(guyDude);
        guyDude.x = FlxG.width / 2.0;
        guyDude.y = FlxG.height/ 2.0;
        FlxTween.tween(guyDude, { alpha:1.0 }, readTime * 0.3, {complete:
            function(tween:FlxTween) {
                guyDude.animation.play("default");
                FlxTween.tween(guyDude, {alpha:1.0}, readTime * 0.3 * 7, {complete:goToGame});
            }
        });

    }

    private function goToGame(tween:FlxTween):Void {
        FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
            FlxG.switchState(new PlayState());
        });
    }

	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
        /*
        if(FlxG.keys.justReleased.SPACE)
        {
            FlxG.switchState(new PlayState());
        }
        */
	}	
}
