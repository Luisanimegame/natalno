package meta.state.menus;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import meta.MusicBeat.MusicBeatState;
import meta.data.dependency.Discord;

using StringTools;

/**
	This is the main menu state! Not a lot is going to change about it so it'll remain similar to the original, but I do want to condense some code and such.
	Get as expressive as you can with this, create your own menu!
**/
class MainMenuState extends MusicBeatState
{
	
	var bg:FlxSprite;
	var freeplay:FlxSprite;
  var options:FlxSprite;
	override function create()
	{
		super.create();

		// set the transitions to the previously set ones
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		// make sure the music is playing
		ForeverTools.resetMenuMusic();

		#if discord_rpc
		Discord.changePresence('MENU SCREEN', 'Main Menu');
		#end
		
		#if desktop
		FlxG.mouse.visible = true;
    #end

		// background
		bg = new FlxSprite(-85);
    bg.loadGraphic(Paths.image('menus/base/menualtBG'));
    bg.updateHitbox();
    bg.screenCenter();
    bg.antialiasing = true;
    add(bg);
    
    var idklool:FlxSprite = new FlxSprite(-85);
    idklool.frames = Paths.getSparrowAtlas('menus/base/idkloolmenu');
    idklool.animation.addByPrefix('idle', "porrafeia", 2);
    idklool.updateHitbox();
    idklool.screenCenter();
    idklool.antialiasing = true;
    add(idklool);
    
    freeplay = new FlxSprite(10, 350);
    freeplay.frames = Paths.getSparrowAtlas('menus/base/storymode');
    freeplay.animation.addByPrefix('idle', "freeplay", 2);
    freeplay.updateHitbox();
    freeplay.antialiasing = true;
    add(freeplay);
    
    options = new FlxSprite(960, 400);
    options.frames = Paths.getSparrowAtlas('menus/base/config');
    options.animation.addByPrefix('idle', "config", 2);
    options.updateHitbox();
    options.antialiasing = true;
    add(options);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Forever Engine Legacy v" + Main.gameVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
	}
	
	var selectedSomethin:Bool = false; //bro
	override function update(elapsed:Float)
	{
	  
  for (option in [freeplay, options, idklool])
  {
    option.animation.play('idle');
  }
	 
	if (controls.BACK #if android || FlxG.android.justReleased.BACK #end && !selectedSomethin) {
	Main.switchState(new TitleState());
	selectedSomethin = true;
	}
	
	if (!selectedSomethin)
	{
	 selectedSomethin = true;
	 FlxG.sound.play(Paths.sound('confirmMenu'));
			
	if (FlxG.mouse.overlaps(freeplay) && FlxG.mouse.justPressed)
  {
  selectedSomethin = true;
  FlxG.mouse.visible = false;
  Main.switchState(new FreeplayState());
  }
  if (FlxG.mouse.overlaps(options) && FlxG.mouse.justPressed)
  {
  selectedSomethin = true;
  FlxG.mouse.visible = false;
  Main.switchState(new OptionsMenuState());
  }
	}
	}
}
