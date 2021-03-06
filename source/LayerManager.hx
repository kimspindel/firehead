import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;

import flixel.tweens.FlxTween;

class LayerManager extends FlxGroup {

    var layers:Array<FlxSpriteGroup>;


    var time:Float = 0;
    public var  itemLayer:FlxSpriteGroup;
    private var foreground:FlxSpriteGroup;
    private var frontMountains:FlxSpriteGroup;

    public function new(maxSize:Int = 2)
    {
        super(10);
        layers = new Array<FlxSpriteGroup>();
        addLayer(AssetPaths.bg_night_clear__png, 1280, 724, 0.1);
        addLayer(AssetPaths.bg_day_clear__png, 1280, 724, 0.1);
        addLayer(AssetPaths.mountains__png, 1280, 724, 0.4);
        addLayer(AssetPaths.bg_texture_snow__png, 1280, 724, 1.0);

        itemLayer = new FlxSpriteGroup();
        add(itemLayer);
        layers.push(itemLayer);

        foreground = new FlxSpriteGroup();
        add(foreground);
        layers.push(foreground);

        addLayer(AssetPaths.fogfront__png, 1280, 724, 1.1);

        frontMountains = addLayer(AssetPaths.coolface__png, 1280, 724, 1.75);
        frontMountains.y = 70;
        night();
    }

    public function setTime(_time:Float):Void {
        time = _time;
        for(img in layers[1].members) {
            FlxTween.tween(cast(img, FlxSprite), { alpha:time }, .6);
        }
    }

    public function toggleDay():Void {
        if(time > 0){
            setTime(0);
        }else{
            setTime(1);
        }
    }

    public function makeMountainsHappy():Void {
        FlxTween.tween(frontMountains, { y:200, alpha:0.5 }, 1.0);
    }

    public function makeMountainsSad():Void {
        FlxTween.tween(frontMountains, { y:70, alpha:1.0 }, 1.0);
    }

    public function night():Void {
        setTime(0);
    }

    public function day():Void {
        setTime(1);
    }

    public function getForegroundLayer():FlxSpriteGroup {
        return foreground;
    }

    public function getItemLayer():FlxSpriteGroup {
        return itemLayer;
    }

    private function addLayer(name:String, width:Int, height:Int, scale:Float):BackgroundLayer{
        var bg:BackgroundLayer = new BackgroundLayer(5, scale, name,
                width, height);
        add(bg);

        layers.push(bg);
        return bg;
    }

    override public function update():Void {
        for(layer in layers){
            layer.update();
        }
    }
}
