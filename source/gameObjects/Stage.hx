package gameObjects;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import gameObjects.background.*;
import meta.CoolUtil;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import meta.data.Conductor;
import meta.data.dependency.FNFSprite;
import meta.state.PlayState;

using StringTools;

/**
	This is the stage class. It sets up everything you need for stages in a more organised and clean manner than the
	base game. It's not too bad, just very crowded. I'll be adding stages as a separate
	thing to the weeks, making them not hardcoded to the songs.
**/
class Stage extends FlxTypedGroup<FlxBasic>
{
	public var cameraZoom:Float = 1.05;
	public var cameraSpeed:Float = 1.0;

	var halloweenBG:FNFSprite;
	var phillyCityLights:FlxTypedGroup<FNFSprite>;
	var phillyTrain:FNFSprite;
	var trainSound:FlxSound;

	public var limo:FNFSprite;

	public var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;

	var fastCar:FNFSprite;

	var upperBoppers:FNFSprite;
	var bottomBoppers:FNFSprite;
	var santa:FNFSprite;
	
	var moon:FNFSprite;
	var grandMoon:FNFSprite;
	
	var bgGirls:BackgroundGirls;

	public var curStage:String;

	var daPixelZoom = PlayState.daPixelZoom;

	public var foreground:FlxTypedGroup<FlxBasic>;

	var red:FNFSprite;
	var pink:FNFSprite;
	var yellow:FNFSprite;
	var green:FNFSprite;

	var redCooldown:Int = 0;
	var pinkCooldown:Int = 0;
	var yellowCooldown:Int = 0;
	var greenCooldown:Int = 0;

	public function new(curStage)
	{
		super();
		this.curStage = curStage;

		/// get hardcoded stage type if chart is fnf style
		if (PlayState.determinedChartType == "FNF")
		{
			// this is because I want to avoid editing the fnf chart type
			// custom stage stuffs will come with forever charts
			switch (CoolUtil.spaceToDash(PlayState.SONG.song.toLowerCase()))
			{
				case 'christrash':
					curStage = 'whithw';
				case 'newtrash':
					curStage = 'whithwerect';
				default:
					curStage = 'stage';
			}

			PlayState.curStage = curStage;
		}

		// to apply to foreground use foreground.add(); instead of add();
		foreground = new FlxTypedGroup<FlxBasic>();

		//
		switch (curStage)
		{
			case 'whithw':
		  	cameraZoom = 0.62;
				curStage = 'whithw';
			  
			  var bg:FlxSprite = new FlxSprite(-2000, -2500).makeGraphic(6969, 6969, FlxColor.WHITE);
				bg.antialiasing = true;
				add(bg);
				
				var pud:FNFSprite = new FNFSprite(678.5, -25).loadGraphic(Paths.image('backgrounds/' + curStage + '/pudim'));
				pud.scale.set(1.32, 1.32);
				pud.updateHitbox();
				pud.antialiasing = true;
				add(pud);
				
			case 'whithwerect':
		  	cameraZoom = 0.72;
				curStage = 'whithwerect';
			  
			  var bg:FlxSprite = new FlxSprite(-2000, -2500).makeGraphic(6969, 6969, FlxColor.fromString('0xFF231752'));
				bg.antialiasing = true;
				add(bg);
				
				grandMoon = new FNFSprite(-2100, -2100).loadGraphic(Paths.image('backgrounds/' + curStage + '/uff'));
				grandMoon.scale.set(10.50, 10.50);
				grandMoon.alpha = 0;
				grandMoon.updateHitbox();
				grandMoon.antialiasing = true;
				add(grandMoon);
				
				moon = new FNFSprite(898, -430).loadGraphic(Paths.image('backgrounds/' + curStage + '/lua'));
				moon.scale.set(1.32, 1.32);
				moon.scrollFactor.set(0.67, 0.71);
				moon.updateHitbox();
				moon.antialiasing = true;
				add(moon);
				
				var nuv:FNFSprite = new FNFSprite(-225.5, 206.66);
				nuv.frames = Paths.getSparrowAtlas('backgrounds/' + curStage + '/nuvem');
				nuv.animation.addByPrefix('idle', "nuvem", 2);
				nuv.animation.play('idle');
				nuv.scrollFactor.set(0.89, 0.87);
				nuv.scale.set(1.32, 1.32);
				nuv.updateHitbox();
				add(nuv);
				
				red = new FNFSprite(-490, -200);
				red.frames = Paths.getSparrowAtlas('backgrounds/' + curStage + '/fogos');
				red.animation.addByPrefix('idle', "red", 12, false);
				red.scrollFactor.set(0.67, 0.69);
				red.scale.set(0.79, 0.79);
				red.updateHitbox();
				add(red);
				redCooldown = FlxG.random.int(1, 8);
				
				pink = new FNFSprite(-100, 500);
				pink.frames = Paths.getSparrowAtlas('backgrounds/' + curStage + '/fogos');
				pink.animation.addByPrefix('idle', "pink", 12, false);
				pink.scrollFactor.set(0.67, 0.69);
				pink.scale.set(0.79, 0.79);
				pink.updateHitbox();
				add(pink);
				pinkCooldown = FlxG.random.int(1, 8);
				
				yellow = new FNFSprite(580, -20);
				yellow.frames = Paths.getSparrowAtlas('backgrounds/' + curStage + '/fogos');
				yellow.animation.addByPrefix('idle', "yellow", 12, false);
				yellow.scrollFactor.set(0.67, 0.69);
				yellow.scale.set(0.79, 0.79);
				yellow.updateHitbox();
				add(yellow);
				yellowCooldown = FlxG.random.int(1, 8);
				
				green = new FNFSprite(1280, 570);
				green.frames = Paths.getSparrowAtlas('backgrounds/' + curStage + '/fogos');
				green.animation.addByPrefix('idle', "green", 12, false);
				green.scrollFactor.set(0.67, 0.69);
				green.scale.set(0.79, 0.79);
				green.updateHitbox();
				add(green);
				greenCooldown = FlxG.random.int(1, 8);
				
				var pud:FNFSprite = new FNFSprite(678.5, -25).loadGraphic(Paths.image('backgrounds/' + curStage + '/pudim'));
				pud.scale.set(1.32, 1.32);
				pud.updateHitbox();
				pud.antialiasing = true;
				add(pud);
			
			default:
				cameraZoom = 0.9;
				curStage = 'stage';
				var bg:FNFSprite = new FNFSprite(-600, -200).loadGraphic(Paths.image('backgrounds/' + curStage + '/stageback'));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;

				// add to the final array
				add(bg);

				var stageFront:FNFSprite = new FNFSprite(-650, 600).loadGraphic(Paths.image('backgrounds/' + curStage + '/stagefront'));
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
				stageFront.updateHitbox();
				stageFront.antialiasing = true;
				stageFront.scrollFactor.set(0.9, 0.9);
				stageFront.active = false;

				// add to the final array
				add(stageFront);

				var stageCurtains:FNFSprite = new FNFSprite(-500, -300).loadGraphic(Paths.image('backgrounds/' + curStage + '/stagecurtains'));
				stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
				stageCurtains.updateHitbox();
				stageCurtains.antialiasing = true;
				stageCurtains.scrollFactor.set(1.3, 1.3);
				stageCurtains.active = false;

				// add to the final array
				add(stageCurtains);
		}
	}

	// return the girlfriend's type
	public function returnGFtype(curStage)
	{
		var gfVersion:String = 'gf';

		switch (curStage)
		{
			case 'stage':
				gfVersion = 'fuckfuck';
			case 'whithw' | 'whithwerect':
				gfVersion = 'girl';
		}

		return gfVersion;
	}

	// get the dad's position
	public function dadPosition(curStage, boyfriend:Character, dad:Character, gf:Character, camPos:FlxPoint):Void
	{
		var characterArray:Array<Character> = [dad, boyfriend];
		for (char in characterArray)
		{
			switch (char.curCharacter)
			{
				case 'gf':
					char.setPosition(gf.x, gf.y);
					gf.visible = false;
					/*
						if (isStoryMode)
						{
							camPos.x += 600;
							tweenCamIn();
					}*/
					/*
						case 'spirit':
							var evilTrail = new FlxTrail(char, null, 4, 24, 0.3, 0.069);
							evilTrail.changeValuesEnabled(false, false, false, false);
							add(evilTrail);
					 */
			}
		}
	}

	public function repositionPlayers(curStage, boyfriend:Character, dad:Character, gf:Character):Void
	{
		// REPOSITIONING PER STAGE
	}

	var curLight:Int = 0;
	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;
	var startedMoving:Bool = false;

	public function stageUpdate(curBeat:Int, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
	{
		// trace('update backgrounds');
		switch (PlayState.curStage)
		{
			case 'highway':
				// trace('highway update');
				grpLimoDancers.forEach(function(dancer:BackgroundDancer)
				{
					dancer.dance();
				});
			case 'mall':
				upperBoppers.animation.play('bop', true);
				bottomBoppers.animation.play('bop', true);
				santa.animation.play('idle', true);

			case 'school':
				bgGirls.dance();

			case 'philly':
				if (!trainMoving)
					trainCooldown += 1;

				if (curBeat % 4 == 0)
				{
					var lastLight:FlxSprite = phillyCityLights.members[0];

					phillyCityLights.forEach(function(light:FNFSprite)
					{
						// Take note of the previous light
						if (light.visible == true)
							lastLight = light;

						light.visible = false;
					});

					// To prevent duplicate lights, iterate until you get a matching light
					while (lastLight == phillyCityLights.members[curLight])
					{
						curLight = FlxG.random.int(0, phillyCityLights.length - 1);
					}

					phillyCityLights.members[curLight].visible = true;
					phillyCityLights.members[curLight].alpha = 1;

					FlxTween.tween(phillyCityLights.members[curLight], {alpha: 0}, Conductor.stepCrochet * .016);
				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
					trainCooldown = FlxG.random.int(-4, 0);
					trainStart();
				}
			case 'whithwerect':
				if (curBeat % 4 == 0)
				{
				  grandMoon.alpha = 1;
				  FlxTween.tween(grandMoon, {alpha: 0}, 0.50, {ease: FlxEase.linear});
				}

				redCooldown--;
				if (redCooldown <= 0)
				{
					if (red.animation.curAnim != null)
					{
						red.animation.stop();
						red.animation.curAnim.curFrame = 0;
					}
					red.animation.play('idle', true);
					redCooldown = FlxG.random.int(4, 16);
				}

				pinkCooldown--;
				if (pinkCooldown <= 0)
				{
					if (pink.animation.curAnim != null)
					{
						pink.animation.stop();
						pink.animation.curAnim.curFrame = 0;
					}
					pink.animation.play('idle', true);
					pinkCooldown = FlxG.random.int(4, 16);
				}

				yellowCooldown--;
				if (yellowCooldown <= 0)
				{
					if (yellow.animation.curAnim != null)
					{
						yellow.animation.stop();
						yellow.animation.curAnim.curFrame = 0;
					}
					yellow.animation.play('idle', true);
					yellowCooldown = FlxG.random.int(4, 16);
				}

				greenCooldown--;
				if (greenCooldown <= 0)
				{
					if (green.animation.curAnim != null)
					{
						green.animation.stop();
						green.animation.curAnim.curFrame = 0;
					}
					green.animation.play('idle', true);
					greenCooldown = FlxG.random.int(4, 16);
				}
		}
	}

	public function stageUpdateConstant(elapsed:Float, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
	{
		switch (PlayState.curStage)
		{
			case 'philly':
				if (trainMoving)
				{
					trainFrameTiming += elapsed;

					if (trainFrameTiming >= 1 / 24)
					{
						updateTrainPos(gf);
						trainFrameTiming = 0;
					}
				}
		}
	}

	// PHILLY STUFFS!
	function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
			trainSound.play(true);
	}

	function updateTrainPos(gf:Character):Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			gf.playAnim('hairBlow');
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
					trainFinishing = true;
			}

			if (phillyTrain.x < -4000 && trainFinishing)
				trainReset(gf);
		}
	}

	function trainReset(gf:Character):Void
	{
		gf.playAnim('hairFall');
		phillyTrain.x = FlxG.width + 200;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}

	override function add(Object:FlxBasic):FlxBasic
	{
		if (Init.trueSettings.get('Disable Antialiasing') && Std.isOfType(Object, FlxSprite))
			cast(Object, FlxSprite).antialiasing = false;
		return super.add(Object);
	}
}