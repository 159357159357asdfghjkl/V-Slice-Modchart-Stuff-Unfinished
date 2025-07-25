package funkin.play.modchart;

import flixel.FlxG;
import funkin.play.notes.Strumline;
import funkin.play.modchart.util.ModchartMath;
import openfl.geom.Vector3D;

using StringTools;

/**
 * Just a shit port
 */
class Modchart
{
  public var defaults:Map<String, Float> = new Map<String, Float>();

  private var modList:Map<String, Float>;
  private var altname:Map<String, String> = new Map<String, String>();
  final ARROW_SIZE:Int = Strumline.NOTE_SPACING;
  final SCREEN_HEIGHT = FlxG.height;

  function selectTanType(angle:Float, is_cosec:Float)
  {
    if (is_cosec != 0) return ModchartMath.fastCsc(angle);
    else
      return ModchartMath.fastTan(angle);
  }

  var dim_x:Int = 0;
  var dim_y:Int = 1;
  var dim_z:Int = 2;
  var expandSeconds:Float = 0;
  var tanExpandSeconds:Float = 0;
  var beatFactor:Array<Float> = [];

  public function CalculateNoteYPos(conductor:Conductor, strumTime:Float, vwoosh:Bool):Float
  {
    var vwoosh:Float = 1.0;
    return Constants.PIXELS_PER_MS * (conductor.songPosition - strumTime - Conductor.instance.inputOffset) * vwoosh;
  }

  function CalculateDrunkAngle(time:Float, speed:Float, col:Int, offset:Float, col_frequency:Float, y_offset:Float, period:Float, offset_frequency:Float):Float
  {
    return time * (1 + speed) + col * ((offset * col_frequency) + col_frequency) + y_offset * ((period * offset_frequency) + offset_frequency) / SCREEN_HEIGHT;
  }

  function CalculateBumpyAngle(y_offset:Float, offset:Float, period:Float):Float
  {
    return (y_offset + (100.0 * offset)) / ((period * 16.0) + 16.0);
  }

  function CalculateDigitalAngle(y_offset:Float, offset:Float, period:Float):Float
  {
    return Math.PI * (y_offset + (1.0 * offset)) / (ARROW_SIZE + (period * ARROW_SIZE));
  }

  function initDefaultMods()
  {
    var ZERO:Array<String> = [
      'boost',
      'brake',
      'wave',
      'waveoffset',
      'waveperiod',
      'parabolay',
      'boomerang',
      'expand',
      'expandperiod',
      'drunk',
      'drunkspeed',
      'drunkoffset',
      'drunkperiod',
      'tandrunk',
      'tandrunkspeed',
      'tandrunkoffset',
      'tandrunkperiod',
      'drunkz',
      'drunkzspeed',
      'drunkzoffset',
      'drunkzperiod',
      'tandrunkz',
      'tandrunkzspeed',
      'tandrunkzoffset',
      'tandrunkzperiod',
      'tanexpand',
      'tanexpandperiod',
      'tipsy',
      'tipsyspeed',
      'tipsyoffset',
      'tantipsy',
      'tantipsyspeed',
      'tantipsyoffset',
      'tornado',
      'tornadooffset',
      'tornadoperiod',
      'tantornado',
      'tantornadooffset',
      'tantornadoperiod',
      'tornadoz',
      'tornadozoffset',
      'tornadozperiod',
      'tantornadoz',
      'tantornadozoffset',
      'tantornadozperiod',
      'tornadoy',
      'tornadoyoffset',
      'tornadoyperiod',
      'tantornadoy',
      'tantornadoyoffset',
      'tantornadoyperiod',
      'movex',
      'movey',
      'movez',
      'movexoffset',
      'moveyoffset',
      'movezoffset',
      'movexoffset1',
      'moveyoffset1',
      'movezoffset1',
      'randomspeed',
      'reverse',
      'split',
      'divide',
      'alternate',
      'cross',
      'centered',
      'swap',
      'attenuatex',
      'attenuatexoffset',
      'attenuatey',
      'attenuateyoffset',
      'attenuatez',
      'attenuatezoffset',
      'beat',
      'beatoffset',
      'beatmult',
      'beatperiod',
      'beaty',
      'beatyoffset',
      'beatymult',
      'beatyperiod',
      'beatz',
      'beatzoffset',
      'beatzmult',
      'beatzperiod',
      'bumpyx',
      'bumpyxoffset',
      'bumpyxperiod',
      'tanbumpyx',
      'tanbumpyxoffset',
      'tanbumpyxperiod',
      'bumpyy',
      'bumpyyoffset',
      'bumpyyperiod',
      'tanbumpyy',
      'tanbumpyyoffset',
      'tanbumpyyperiod',
      'bumpy',
      'bumpyoffset',
      'bumpyperiod',
      'tanbumpy',
      'tanbumpyoffset',
      'tanbumpyperiod',
      'flip',
      'invert',
      'zigzag',
      'zigzagoffset',
      'zigzagperiod',
      'zigzagz',
      'zigzagzoffset',
      'zigzagzperiod',
      'sawtooth',
      'sawtoothoffset',
      'sawtoothperiod',
      'sawtoothz',
      'sawtoothzoffset',
      'sawtoothzperiod',
      'parabolax',
      'parabolaxoffset',
      'parabolay',
      'parabolayoffset',
      'parabolaz',
      'parabolazoffset',
      'digital',
      'digitalsteps',
      'digitaloffset',
      'digitalperiod',
      'tandigital',
      'tandigitalsteps',
      'tandigitaloffset',
      'tandigitalperiod',
      'digitaly',
      'digitalysteps',
      'digitalyoffset',
      'digitalyperiod',
      'tandigitaly',
      'tandigitalysteps',
      'tandigitalyoffset',
      'tandigitalyperiod',
      'digitalz',
      'digitalzsteps',
      'digitalzoffset',
      'digitalzperiod',
      'tandigitalz',
      'tandigitalzsteps',
      'tandigitalzoffset',
      'tandigitalzperiod',
      'square',
      'squareoffset',
      'squareperiod',
      'squarez',
      'squarezoffset',
      'squarezperiod',
      'bounce',
      'bounceoffset',
      'bounceperiod',
      'bouncey',
      'bounceyoffset',
      'bounceyperiod',
      'bouncez',
      'bouncezoffset',
      'bouncezperiod',
      'xmode',
      'tiny',
      'tipsyx',
      'tipsyxspeed',
      'tipsyxoffset',
      'tantipsyx',
      'tantipsyxspeed',
      'tantipsyxoffset',
      'tipsyz',
      'tipsyzspeed',
      'tipsyzoffset',
      'tantipsyz',
      'tantipsyzspeed',
      'tantipsyzoffset',
      'drunky',
      'drunkyspeed',
      'drunkyoffset',
      'drunkyperiod',
      'tandrunky',
      'tandrunkyspeed',
      'tandrunkyoffset',
      'tandrunkyperiod',
      'vibratex',
      'vibratey',
      'vibratez',
      'pulse',
      'pulseinner',
      'pulseouter',
      'pulseoffset',
      'pulseperiod',
      'shrinkmult',
      'shrinklinear',
      'noteskewx',
      'noteskewy',
      'zoomx',
      'zoomy',
      'tinyx',
      'tinyy',
      'tinyz',
      'confusionx',
      'confusionxoffset',
      'confusiony',
      'confusionyoffset',
      'confusion',
      'confusionoffset',
      'dizzy',
      'twirl',
      'roll',
      'stealth',
      'hidden',
      'hiddenoffset',
      'sudden',
      'suddenoffset',
      'blink',
      'randomvanish',
      'dark',
      'cosecant',
      'dizzyholds',
      'rotationx',
      'rotationy',
      'rotationz',
      'skewx',
      'skewy',
      'spiralx',
      'spiralxoffset',
      'spiralxperiod',
      'spiraly',
      'spiralyoffset',
      'spiralyperiod',
      'spiralz',
      'spiralzoffset',
      'spiralzperiod',
      'granulate',
      'gayholds',
      'arrowpath',
      'arrowpathgranulate',
      'arrowpathsize',
      'arrowpathdrawsize',
      'arrowpathdrawsizeback',
      'mini',
      'drawsize',
      'drawsizeback',
      'holdtiny',
      'tanpulse',
      'tanpulseinner',
      'tanpulseouter',
      'tanpulseoffset',
      'tanpulseperiod',
      'shrinklinearx',
      'shrinklineary',
      'shrinklinearz',
      'shrinkmultx',
      'shrinkmulty',
      'shrinkmultz',
      'vanishoffset',
      'tapstealth',
      'holdstealth',
      'centered2',
      'orient'
    ];

    // spiralholds = holdtype
    var ONE:Array<String> = [
      'xmod',
      'zoom',
      'zoomx',
      'zoomy',
      'zoomz',
      'stealthtype',
      'stealthpastreceptors',
      'scale',
      'scalex',
      'scaley',
      'scalez',
      'scrollspeedmult'
    ];
    for (i in 0...Strumline.KEY_COUNT)
    {
      ZERO.push('reverse$i');
      ZERO.push('movex$i');
      ZERO.push('movey$i');
      ZERO.push('movez$i');
      ZERO.push('movexoffset$i');
      ZERO.push('moveyoffset$i');
      ZERO.push('movezoffset$i');
      ZERO.push('movexoffset1$i');
      ZERO.push('moveyoffset1$i');
      ZERO.push('movezoffset1$i');
      ZERO.push('tiny$i');
      ZERO.push('holdtiny$i');
      ZERO.push('bumpy$i');
      ONE.push('scalex$i');
      ONE.push('scaley$i');
      ONE.push('scalez$i');
      ONE.push('scale$i');
      ZERO.push('noteskewx$i');
      ZERO.push('noteskewy$i');
      ZERO.push('tinyx$i');
      ZERO.push('tinyy$i');
      ZERO.push('tinyz$i');
      ZERO.push('confusionx$i');
      ZERO.push('confusiony$i');
      ZERO.push('confusion$i');
      ZERO.push('confusionxoffset$i');
      ZERO.push('confusionyoffset$i');
      ZERO.push('confusionoffset$i');
      ZERO.push('dark$i');
      ZERO.push('stealth$i');
      ZERO.push('tapstealth$i');
      ZERO.push('holdstealth$i');
      ZERO.push('arrowpath$i');
      ONE.push('zoom$i');
      ONE.push('zoomx$i');
      ONE.push('zoomy$i');
      ONE.push('zoomz$i');
    }

    for (mod in ZERO)
      defaults.set(mod, 0);

    for (mod in ONE)
      defaults.set(mod, 1);

    defaults.set('cmod', 2);
    altname.set('land', 'brake');
    altname.set('dwiwave', 'expand');
    altname.set('converge', 'centered');

    // in the groove 2 mod name
    altname.set('accel', 'boost');
    altname.set('decel', 'brake');
    altname.set('drift', 'drunk');
    altname.set('float', 'tipsy');

    // notitg names
    // idk why notitg makes tons of aliases fuck
    // i hate you
    altname.set('glitchytan', 'cosecant');
    altname.set('plannedomspeed', 'scrollspeedmult');
    altname.set('x', 'movex');
    altname.set('y', 'movey');
    altname.set('z', 'movez');
    altname.set('drunkspacing', 'drunkoffset');
    altname.set('drunkyspacing', 'drunkyoffset');
    altname.set('drunkzspacing', 'drunkzoffset');
    altname.set('tandrunkspacing', 'tandrunkoffset');
    altname.set('tandrunkyspacing', 'tandrunkyoffset');
    altname.set('tandrunkzspacing', 'tandrunkzoffset');
    altname.set('tipsyspacing', 'tipsyoffset');
    altname.set('tipsyxspacing', 'tipsyxoffset');
    altname.set('tipsyzspacing', 'tipsyzoffset');
    altname.set('tantipsyspacing', 'tantipsyoffset');
    altname.set('tantipsyxspacing', 'tantipsyxoffset');
    altname.set('tantipsyzspacing', 'tantipsyzoffset');
    altname.set('vanish', 'randomvanish');
    altname.set('grain', 'granulate');
    altname.set('arrowpathgrain', 'arrowpathgranulate');
    altname.set('arrowpathgirth', 'arrowpathsize');
    altname.set('arrowpathwidth', 'arrowpathsize');
    altname.set('drawsizefront', 'drawsize');
    altname.set('drawdistance', 'drawsize');
    altname.set('drawdistancefront', 'drawsize');
    altname.set('drawdistanceback', 'drawsizeback');
    altname.set('arrowpathdrawsizefront', 'arrowpathdrawsize');
    altname.set('arrowpathdrawdistance', 'arrowpathdrawsize');
    altname.set('arrowpathdrawdistancefront', 'arrowpathdrawsize');
    altname.set('arrowpathdrawdistanceback', 'arrowpathdrawsizeback');
    altname.set('hideholds', 'holdstealth');
    altname.set('hidetaps', 'tapstealth');
    for (i in 0...Strumline.KEY_COUNT)
    {
      altname.set('hideholds$i', 'holdstealth$i');
      altname.set('hidetaps$i', 'tapstealth$i');
    }
  }

  public function initMods()
  {
    modList = defaults.copy();
  }

  public function getModTable()
    return modList;

  public function createAliasForMod(alias:String, mod:String)
  {
    altname.set(alias, getName(mod));
  }

  public function setValue(s:String, val:Float):Void
  {
    modList.set(getName(s), val);
  }

  public function getValue(s:String):Float
  {
    var val:Null<Float> = modList.get(getName(s));
    if (val == null) return 0;
    return val;
  }

  var checkedName:Array<String> = [];

  public function getName(s:String):String
  {
    var s1:String = s.toLowerCase();
    var name:String = altname.exists(s1) ? altname.get(s1) : s1;
    if (!modList.exists(name))
    {
      if (!checkedName.contains(name))
      {
        checkedName.push(s1);
        lime.app.Application.current.window.alert('Modifier name "$s1" does not exist. Check your script!', 'Modchart Script');
      }
      return '';
    }
    return name;
  }

  function CalculateTipsyOffset(time:Float, offset:Float, speed:Float, col:Int, ?tan:Float = 0)
  {
    var time_times_timer:Float = time * ((speed * 1.2) + 1.2);
    var arrow_times_mag:Float = ARROW_SIZE * 0.4;
    return (tan == 0 ? ModchartMath.fastCos(time_times_timer + (col * ((offset * 1.8) + 1.8))) * arrow_times_mag : selectTanType(time_times_timer
      + (col * ((offset * 1.8) + 1.8)), getValue('cosecant')) * arrow_times_mag);
  }

  function UpdateBeat(d:Int, beat_offset:Float, beat_mult:Float)
  {
    var fAccelTime:Float = 0.2;
    var fTotalTime:Float = 0.5;
    var fBeat:Float = ((Conductor.instance.currentBeatTime + fAccelTime + beat_offset) * (beat_mult + 1));
    var bEvenBeat:Bool = (Std.int(fBeat) % 2) != 0;
    beatFactor[d] = 0;
    if (fBeat < 0) return;
    fBeat -= ModchartMath.trunc(fBeat);
    fBeat += 1;
    fBeat -= ModchartMath.trunc(fBeat);
    if (fBeat >= fTotalTime) return;
    if (fBeat < fAccelTime)
    {
      beatFactor[d] = ModchartMath.scale(fBeat, 0.0, fAccelTime, 0.0, 1.0);
      beatFactor[d] *= beatFactor[d];
    }
    else
    {
      beatFactor[d] = ModchartMath.scale(fBeat, fAccelTime, fTotalTime, 1.0, 0.0);
      beatFactor[d] = 1 - (1 - beatFactor[d]) * (1 - beatFactor[d]);
    }
    if (bEvenBeat) beatFactor[d] *= -1;
    beatFactor[d] *= 20.0;
  }

  public var baseHoldSize:Int = 80;

  public function update(elapsed:Float):Void
  {
    var time:Float = Conductor.instance.songPosition / 1000;
    expandSeconds = time;
    expandSeconds = ModchartMath.mod(expandSeconds, (Math.PI * 2) / (getValue('expandperiod') + 1));
    tanExpandSeconds = time;
    tanExpandSeconds = ModchartMath.mod(tanExpandSeconds, (Math.PI * 2) / (getValue('tanexpandperiod') + 1));

    UpdateBeat(dim_x, getValue('beatoffset'), getValue('beatmult'));
    UpdateBeat(dim_y, getValue('beatyoffset'), getValue('beatymult'));
    UpdateBeat(dim_z, getValue('beatzoffset'), getValue('beatzmult'));
  }

  public var scrollSpeed:Float = 1.0;

  public function GetYOffset(conductor:Conductor, time:Float, speed:Float, vwoosh:Bool, iCol:Int, parentTime:Float):Float
  {
    scrollSpeed = getValue('xmod');
    if (getValue('cmod') > 0) scrollSpeed *= getValue('cmod') / 2;

    if (getValue('expand') != 0)
    {
      var fExpandMultiplier:Float = ModchartMath.scale(ModchartMath.fastCos(expandSeconds * 3 * (getValue('expandperiod') + 1)), -1, 1, 0.75, 1.75);
      scrollSpeed *= ModchartMath.scale(getValue('expand'), 0, 1, 1, fExpandMultiplier);
    }
    if (getValue('tanexpand') != 0)
    {
      var fExpandMultiplier:Float = ModchartMath.scale(selectTanType(tanExpandSeconds * 3 * (getValue('tanexpandperiod') + 1), getValue('cosecant')), -1, 1,
        0.75, 1.75);

      scrollSpeed *= ModchartMath.scale(getValue('tanexpand'), 0, 1, 1, fExpandMultiplier);
    }
    if (getValue('randomspeed') > 0)
    {
      var noteBeat:Float = (parentTime / 1000) * (Conductor.instance.bpm / 60);
      var seed:Int = (ModchartMath.BeatToNoteRow(noteBeat) << 8) + (iCol * 100);

      for (i in 0...3)
        seed = ((seed * 1664525) + 1013904223) & 0xFFFFFFFF;
      var fRandom:Float = seed / 4294967296.0;

      scrollSpeed *= ModchartMath.scale(fRandom, 0.0, 1.0, 1.0, getValue('randomspeed') + 1.0);
    }
    scrollSpeed *= getValue('scrollspeedmult');
    var fYOffset:Float = CalculateNoteYPos(conductor, time, vwoosh) * speed * -1;
    var fYAdjust:Float = 0;

    if (getValue('boost') != 0)
    {
      var fEffectHeight:Float = SCREEN_HEIGHT;
      var fNewYOffset:Float = fYOffset * 1.5 / ((fYOffset + fEffectHeight / 1.2) / fEffectHeight);
      var fAccelYAdjust:Float = getValue('boost') * (fNewYOffset - fYOffset);

      fAccelYAdjust = ModchartMath.clamp(fAccelYAdjust, -400, 400);
      fYAdjust += fAccelYAdjust;
    }
    if (getValue('brake') != 0)
    {
      var fEffectHeight:Float = SCREEN_HEIGHT;
      var fScale:Float = ModchartMath.scale(fYOffset, 0., fEffectHeight, 0, 1.);
      var fNewYOffset:Float = fYOffset * fScale;
      var fBrakeYAdjust:Float = getValue('brake') * (fNewYOffset - fYOffset);
      fBrakeYAdjust = ModchartMath.clamp(fBrakeYAdjust, -400, 400);
      fYAdjust += fBrakeYAdjust;
    }
    if (getValue('wave') != 0)
    {
      fYAdjust += getValue('wave') * 20 * ModchartMath.fastSin((fYOffset + getValue('waveoffset')) / ((getValue('waveperiod') * 38) + 38));
    }
    if (getValue('parabolay') != 0)
    {
      fYAdjust += getValue('parabolay') * (fYOffset / ARROW_SIZE) * (fYOffset / ARROW_SIZE);
    }

    fYOffset += fYAdjust;
    if (getValue('boomerang') != 0) fYOffset = ((-1 * fYOffset * fYOffset / SCREEN_HEIGHT) + 1.5 * fYOffset) * getValue('boomerang');
    fYOffset *= scrollSpeed;
    return fYOffset;
  }

  public function GetReversePercentForColumn(iCol:Int):Float
  {
    var f:Float = 0;
    var iNumCols:Int = 4;
    f += getValue('reverse');
    f += getValue('reverse${iCol}');
    if (iCol >= iNumCols / 2) f += getValue('split');
    if ((iCol % 2) == 1) f += getValue('alternate');
    var iFirstCrossCol = iNumCols / 4;
    var iLastCrossCol = iNumCols - 1 - iFirstCrossCol;
    if (iCol >= iFirstCrossCol && iCol <= iLastCrossCol) f += getValue('cross');
    if (f > 2) f = ModchartMath.mod(f, 2);
    if (f > 1) f = ModchartMath.scale(f, 1., 2., 1., 0.);
    return f;
  }

  public var notefieldZoom:Float = 1.0;

  public function GetXPos(iCol:Int, fYOffset:Float, pn:Int, xOffset:Array<Float>, isNote:Bool = false):Float
  {
    var time:Float = (Conductor.instance.songPosition / 1000);
    var f:Float = 0;
    var notefieldZoom:Float = getValue('zoom') * getValue('zoom$iCol');
    f += ARROW_SIZE * getValue('movex${iCol}') + getValue('movexoffset$iCol') + getValue('movexoffset1$iCol');

    f += ARROW_SIZE * getValue('movex') + getValue('movexoffset') + getValue('movexoffset1');

    if (getValue('drunk') != 0) f += getValue('drunk') * ModchartMath.fastCos(CalculateDrunkAngle(time, getValue('drunkspeed'), iCol, getValue('drunkoffset'),
      0.2, fYOffset, getValue('drunkperiod'), 10)) * ARROW_SIZE * 0.5;

    if (getValue('tandrunk') != 0) f += getValue('tandrunk') * selectTanType(CalculateDrunkAngle(time, getValue('tandrunkspeed'), iCol,
      getValue('tandrunkoffset'), 0.2, fYOffset, getValue('tandrunkperiod'), 10),
      getValue('cosecant')) * ARROW_SIZE * 0.5;

    if (getValue('attenuatex') != 0) f += getValue('attenuatex') * ((fYOffset + 100 * getValue('attenuatexoffset')) / ARROW_SIZE) * ((fYOffset
      + 100 * getValue('attenuatexoffset')) / ARROW_SIZE) * (xOffset[iCol] / ARROW_SIZE);

    if (getValue('beat') != 0)
    {
      var fShift:Float = beatFactor[dim_x] * ModchartMath.fastSin(((fYOffset / (getValue('beatperiod') * 30.0 + 30.0))) + (Math.PI / 2));
      f += getValue('beat') * fShift;
    }

    if (getValue('bumpyx') != 0) f += getValue('bumpyx') * 40 * ModchartMath.fastSin(CalculateBumpyAngle(fYOffset, getValue('bumpyxoffset'),
      getValue('bumpyxperiod')));

    if (getValue('tanbumpyx') != 0) f += getValue('tanbumpyx') * 40 * selectTanType(CalculateBumpyAngle(fYOffset, getValue('tanbumpyxoffset'),
      getValue('tanbumpyxperiod')), getValue('cosecant'));

    if (getValue('flip') != 0)
    {
      var iFirstCol:Int = 0;
      var iLastCol:Int = 3;
      var iNewCol:Int = Std.int(ModchartMath.scale(iCol, iFirstCol, iLastCol, iLastCol, iFirstCol));
      var fOldPixelOffset:Float = xOffset[iCol] * notefieldZoom;
      var fNewPixelOffset:Float = xOffset[iNewCol] * notefieldZoom;
      var fDistance:Float = fNewPixelOffset - fOldPixelOffset;
      f += fDistance * getValue('flip');
    }

    if (getValue('divide') != 0) f += getValue('divide') * (ARROW_SIZE * (iCol >= 2 ? 1 : -1));

    if (getValue('invert') != 0)
    {
      final iNumCols:Int = 4;
      final iNumSides:Int = 1;
      final iNumColsPerSide:Int = Std.int(iNumCols / iNumSides);
      final iSideIndex:Int = Std.int(iCol / iNumColsPerSide);
      final iColOnSide:Int = Std.int(iCol % iNumColsPerSide);

      final iColLeftOfMiddle:Int = Std.int((iNumColsPerSide - 1) / 2);
      final iColRightOfMiddle:Int = Std.int((iNumColsPerSide + 1) / 2);

      var iFirstColOnSide:Int = -1;
      var iLastColOnSide:Int = -1;
      if (iColOnSide <= iColLeftOfMiddle)
      {
        iFirstColOnSide = 0;
        iLastColOnSide = iColLeftOfMiddle;
      }
      else if (iColOnSide >= iColRightOfMiddle)
      {
        iFirstColOnSide = iColRightOfMiddle;
        iLastColOnSide = iNumColsPerSide - 1;
      }
      else
      {
        iFirstColOnSide = Std.int(iColOnSide / 2);
        iLastColOnSide = Std.int(iColOnSide / 2);
      }

      // mirror
      var iNewColOnSide:Int;
      if (iFirstColOnSide == iLastColOnSide) iNewColOnSide = 0;
      else
        iNewColOnSide = Std.int(ModchartMath.scale(iColOnSide, iFirstColOnSide, iLastColOnSide, iLastColOnSide, iFirstColOnSide));
      final iNewCol:Int = iSideIndex * iNumColsPerSide + iNewColOnSide;

      var fOldPixelOffset:Float = xOffset[iCol];
      var fNewPixelOffset:Float = xOffset[iNewCol];
      var invertDistance:Float = fNewPixelOffset - fOldPixelOffset;
      f += getValue('invert') * invertDistance;
    }

    if (getValue('zigzag') != 0)
    {
      var fResult:Float = ModchartMath.triangle((Math.PI * (1 / (getValue('zigzagperiod') + 1)) * ((fYOffset +
        (100.0 * (getValue('zigzagoffset')))) / ARROW_SIZE)));

      f += (getValue('zigzag') * ARROW_SIZE / 2) * fResult;
    }

    if (getValue('sawtooth') != 0) f += (getValue('sawtooth') * ARROW_SIZE) * ((0.5 / (getValue('sawtoothperiod') + 1) * (fYOffset
      + 100.0 * getValue('sawtoothoffset'))) / ARROW_SIZE
      - Math.floor((0.5 / (getValue('sawtoothperiod') + 1) * (fYOffset + 100.0 * getValue('sawtoothoffset'))) / ARROW_SIZE));

    if (getValue('parabolax') != 0) f += getValue('parabolax') * ((fYOffset + 2 * getValue('parabolaxoffset')) / ARROW_SIZE) * ((fYOffset
      + 2 * getValue('parabolaxoffset')) / ARROW_SIZE);

    if (getValue('digital') != 0) f += (getValue('digital') * ARROW_SIZE * 0.5) * Math.round((getValue('digitalsteps') +
      1) * ModchartMath.fastSin(CalculateDigitalAngle(fYOffset, getValue('digitaloffset'), getValue('digitalperiod')))) / (getValue('digitalsteps')
      + 1);

    if (getValue('tandigital') != 0) f += (getValue('tandigital') * ARROW_SIZE * 0.5) * Math.round((getValue('tandigitalsteps') +
      1) * selectTanType(CalculateDigitalAngle(fYOffset, getValue('tandigitaloffset'), getValue('tandigitalperiod')),
        getValue('cosecant'))) / (getValue('tandigitalsteps')
      + 1);

    if (getValue('square') != 0)
    {
      var fResult:Float = ModchartMath.square((Math.PI * (fYOffset + (1.0 * (getValue('squareoffset')))) / (ARROW_SIZE
        + (getValue('squareperiod') * ARROW_SIZE))));

      f += (getValue('square') * ARROW_SIZE * 0.5) * fResult;
    }

    if (getValue('bounce') != 0)
    {
      var fBounceAmt:Float = Math.abs(ModchartMath.fastSin(((fYOffset + (1.0 * (getValue('bounceoffset')))) / (60 + (getValue('bounceperiod') * 60)))));

      f += getValue('bounce') * ARROW_SIZE * 0.5 * fBounceAmt;
    }

    if (getValue('xmode') != 0) f += getValue('xmode') * (pn == 0 ? fYOffset : -fYOffset);

    if (getValue('tiny') != 0)
    {
      var fTinyPercent:Float = getValue('tiny');
      fTinyPercent = Math.min(Math.pow(0.5, fTinyPercent), 1.);
      f *= fTinyPercent;
    }

    if (getValue('tipsyx') != 0) f += getValue('tipsyx') * CalculateTipsyOffset(time, getValue('tipsyxoffset'), getValue('tipsyxspeed'), iCol);

    if (getValue('tantipsyx') != 0) f += getValue('tantipsyx') * CalculateTipsyOffset(time, getValue('tantipsyxoffset'), getValue('tantipsyxspeed'), iCol, 1);

    if (getValue('swap') != 0) f += FlxG.width / 2 * getValue('swap') * (pn == 1 ? -1 : 1);

    if (getValue('tornado') != 0)
    {
      var iTornadoWidth:Int = 2;
      var iStartCol:Int = iCol - iTornadoWidth;
      var iEndCol:Int = iCol + iTornadoWidth;
      iStartCol = ModchartMath.iClamp(iStartCol, 0, 3);
      iEndCol = ModchartMath.iClamp(iEndCol, 0, 3);
      var fMinX:Float = 3.402823466e+38;
      var fMaxX:Float = 1.175494351e-38;

      for (i in iStartCol...iEndCol + 1)
      {
        fMinX = Math.min(fMinX, xOffset[i]);
        fMaxX = Math.max(fMaxX, xOffset[i]);
      }
      var fRealPixelOffset:Float = xOffset[iCol] * notefieldZoom;
      var fPositionBetween:Float = ModchartMath.scale(fRealPixelOffset, fMinX * notefieldZoom, fMaxX * notefieldZoom, -1, 1);
      var fRads:Float = Math.acos(fPositionBetween);
      fRads += (fYOffset + getValue('tornadooffset')) * ((6 * getValue('tornadoperiod')) + 6) / SCREEN_HEIGHT;
      var fAdjustedPixelOffset:Float = ModchartMath.scale(ModchartMath.fastCos(fRads), -1, 1, fMinX * notefieldZoom, fMaxX * notefieldZoom);

      f += (fAdjustedPixelOffset - fRealPixelOffset) * getValue('tornado');
    }

    if (getValue('tantornado') != 0)
    {
      var iTornadoWidth:Int = 2;
      var iStartCol:Int = iCol - iTornadoWidth;
      var iEndCol:Int = iCol + iTornadoWidth;

      iStartCol = ModchartMath.iClamp(iStartCol, 0, 3);
      iEndCol = ModchartMath.iClamp(iEndCol, 0, 3);
      var fMinX:Float = 3.402823466e+38;
      var fMaxX:Float = 1.175494351e-38;

      for (i in iStartCol...iEndCol + 1)
      {
        fMinX = Math.min(fMinX, xOffset[i]);
        fMaxX = Math.max(fMaxX, xOffset[i]);
      }
      var fRealPixelOffset:Float = xOffset[iCol] * notefieldZoom;
      var fPositionBetween:Float = ModchartMath.scale(fRealPixelOffset, fMinX * notefieldZoom, fMaxX * notefieldZoom, -1, 1);
      var fRads:Float = Math.acos(fPositionBetween);

      fRads += (fYOffset + getValue('tantornadooffset')) * ((6 * getValue('tantornadoperiod')) + 6) / SCREEN_HEIGHT;
      var fAdjustedPixelOffset:Float = ModchartMath.scale(selectTanType(fRads, getValue('cosecant')), -1, 1, fMinX * notefieldZoom, fMaxX * notefieldZoom);
      f += (fAdjustedPixelOffset - fRealPixelOffset) * getValue('tantornado');
    }

    if (getValue('spiralx') != 0) f += fYOffset * getValue('spiralx') * ModchartMath.fastCos((fYOffset + getValue('spiralxoffset')) * (1
      + getValue('spiralxperiod')));

    var zoomx:Float = getValue('zoomx') * getValue('zoomx$iCol');
    var mini:Float = ModchartMath.scale(getValue('mini'), 0.0, 1.0, 1.0, 0.5);
    f += xOffset[iCol] * zoomx * notefieldZoom * mini;
    f -= getValue('skewx') * 100;

    if (isNote) f += getValue('skewx') * fYOffset;

    return f;
  }

  public function GetYPos(iCol:Int, fYOffset:Float, pn:Int, xOffset:Array<Float>, height:Float, WithReverse:Bool = true):Float
  {
    var f:Float = fYOffset;

    var time:Float = (Conductor.instance.songPosition / 1000);
    var notefieldZoom:Float = getValue('zoom') * getValue('zoom$iCol');
    if (WithReverse)
    {
      f -= getValue('centered2') * ARROW_SIZE;
      var zoom:Float = 1 - 0.5 * getValue('mini');
      if (Math.abs(zoom) < 0.01) zoom = 0.01;
      var yReversedOffset:Float = (SCREEN_HEIGHT - height - Constants.STRUMLINE_Y_OFFSET * 2) / zoom;
      var fPercentReverse:Float = GetReversePercentForColumn(iCol);
      var fShift:Float = fPercentReverse * yReversedOffset;
      fShift = ModchartMath.scale(getValue('centered'), 0., 1., fShift, yReversedOffset / 2);
      fShift = ModchartMath.scale(getValue('centered2'), 0., 1., fShift, ARROW_SIZE);
      var fScale:Float = ModchartMath.scale(fPercentReverse, 0.0, 1.0, 1.0, -1.0);
      f *= fScale;
      f += fShift;
    }
    f += ARROW_SIZE * getValue('movey$iCol') + getValue('moveyoffset$iCol') + getValue('moveyoffset1$iCol');

    f += ARROW_SIZE * getValue('movey') + getValue('moveyoffset') + getValue('moveyoffset1');

    if (getValue('attenuatey') != 0) f += getValue('attenuatey') * ((fYOffset + 100 * getValue('attenuateyoffset')) / ARROW_SIZE) * ((fYOffset
      + 100 * getValue('attenuateyoffset')) / ARROW_SIZE) * (xOffset[iCol] / ARROW_SIZE);

    if (getValue('parabolay') != 0) f += getValue('parabolay') * ((fYOffset + 2 * getValue('parabolayoffset')) / ARROW_SIZE) * ((fYOffset
      + 2 * getValue('parabolayoffset')) / ARROW_SIZE);

    if (getValue('tipsy') != 0) f += getValue('tipsy') * CalculateTipsyOffset(time, getValue('tipsyoffset'), getValue('tipsyspeed'), iCol);

    if (getValue('tantipsy') != 0) f += getValue('tantipsy') * CalculateTipsyOffset(time, getValue('tantipsyoffset'), getValue('tantipsyspeed'), iCol, 1);

    if (getValue('beaty') != 0) f += getValue('beaty') * (beatFactor[dim_y] * ModchartMath.fastSin(fYOffset / ((getValue('beatyperiod') * 15) + 15)
      + Math.PI / 2));

    if (getValue('drunky') != 0) f += getValue('drunky') * ModchartMath.fastCos(CalculateDrunkAngle(time, getValue('drunkyspeed'), iCol,
      getValue('drunkyoffset'), 0.2, fYOffset, getValue('drunkyperiod'), 10)) * ARROW_SIZE * 0.5;

    if (getValue('tandrunky') != 0) f += getValue('tandrunky') * selectTanType(CalculateDrunkAngle(time, getValue('tandrunkyspeed'), iCol,
      getValue('tandrunkyoffset'), 0.2, fYOffset, getValue('tandrunkyperiod'), 10),
      getValue('cosecant')) * ARROW_SIZE * 0.5;

    if (getValue('bouncey') != 0)
    {
      var fBounceAmt:Float = Math.abs(ModchartMath.fastSin(((fYOffset + (1.0 * (getValue('bounceyoffset')))) / (60 + (getValue('bounceyperiod') * 60)))));

      f += getValue('bouncey') * ARROW_SIZE * 0.5 * fBounceAmt;
    }

    if (getValue('bumpyy') != 0) f += getValue('bumpyy') * 40 * ModchartMath.fastSin(CalculateBumpyAngle(fYOffset, getValue('bumpyyoffset'),
      getValue('bumpyyperiod')));

    if (getValue('tanbumpyy') != 0) f += getValue('tanbumpyy') * 40 * selectTanType(CalculateBumpyAngle(fYOffset, getValue('tanbumpyyoffset'),
      getValue('tanbumpyyperiod')), getValue('cosecant'));

    if (getValue('tornadoy') != 0)
    {
      var iTornadoWidth:Int = 2;
      var iStartCol:Int = iCol - iTornadoWidth;
      var iEndCol:Int = iCol + iTornadoWidth;
      iStartCol = ModchartMath.iClamp(iStartCol, 0, 3);
      iEndCol = ModchartMath.iClamp(iEndCol, 0, 3);

      var fMinX:Float = 3.402823466e+38;
      var fMaxX:Float = 1.175494351e-38;

      for (i in iStartCol...iEndCol + 1)
      {
        fMinX = Math.min(fMinX, xOffset[i]);
        fMaxX = Math.max(fMaxX, xOffset[i]);
      }

      var fRealPixelOffset:Float = xOffset[iCol] * notefieldZoom;
      var fPositionBetween:Float = ModchartMath.scale(fRealPixelOffset, fMinX * notefieldZoom, fMaxX * notefieldZoom, -1, 1);
      var fRads:Float = Math.acos(fPositionBetween);
      fRads += (fYOffset + getValue('tornadoyoffset')) * ((6 * getValue('tornadoyperiod')) + 6) / SCREEN_HEIGHT;

      var fAdjustedPixelOffset:Float = ModchartMath.scale(ModchartMath.fastCos(fRads), -1, 1, fMinX * notefieldZoom, fMaxX * notefieldZoom);

      f += (fAdjustedPixelOffset - fRealPixelOffset) * getValue('tornadoy');
    }

    if (getValue('tantornadoy') != 0)
    {
      var iTornadoWidth:Int = 2;
      var iStartCol:Int = iCol - iTornadoWidth;
      var iEndCol:Int = iCol + iTornadoWidth;
      iStartCol = ModchartMath.iClamp(iStartCol, 0, 3);
      iEndCol = ModchartMath.iClamp(iEndCol, 0, 3);

      var fMinX:Float = 3.402823466e+38;
      var fMaxX:Float = 1.175494351e-38;

      for (i in iStartCol...iEndCol + 1)
      {
        fMinX = Math.min(fMinX, xOffset[i]);
        fMaxX = Math.max(fMaxX, xOffset[i]);
      }

      var fRealPixelOffset:Float = xOffset[iCol] * notefieldZoom;
      var fPositionBetween:Float = ModchartMath.scale(fRealPixelOffset, fMinX * notefieldZoom, fMaxX * notefieldZoom, -1, 1);
      var fRads:Float = Math.acos(fPositionBetween);
      fRads += (fYOffset + getValue('tantornadoyoffset')) * ((6 * getValue('tantornadoyperiod')) + 6) / SCREEN_HEIGHT;

      var fAdjustedPixelOffset:Float = ModchartMath.scale(selectTanType(fRads, getValue('cosecant')), -1, 1, fMinX * notefieldZoom, fMaxX * notefieldZoom);

      f += (fAdjustedPixelOffset - fRealPixelOffset) * getValue('tantornadoy');
    }
    if (getValue('digitaly') != 0) f += (getValue('digitaly') * ARROW_SIZE * 0.5) * Math.round((getValue('digitalysteps') +
      1) * ModchartMath.fastSin(CalculateDigitalAngle(fYOffset, getValue('digitalyoffset'), getValue('digitalyperiod')))) / (getValue('digitalysteps')
      + 1);

    if (getValue('tandigitaly') != 0) f += (getValue('tandigitaly') * ARROW_SIZE * 0.5) * Math.round((getValue('tandigitalysteps') +
      1) * selectTanType(CalculateDigitalAngle(fYOffset, getValue('tandigitalyoffset'), getValue('tandigitalyperiod')),
      getValue('cosecant'))) / (getValue('tandigitalysteps') + 1);

    if (getValue('spiraly') != 0) f += fYOffset * getValue('spiraly') * ModchartMath.fastSin((fYOffset + getValue('spiralyoffset')) * (1
      + getValue('spiralyperiod')));

    f *= (ModchartMath.scale(getValue('mini'), 0.0, 1.0, 1.0, 0.5) < 0 ? -1 : 1);
    f *= (Preferences.downscroll ? -1 : 1);
    var zoomy:Float = getValue('zoomy') * getValue('zoomy$iCol');
    f -= ((notefieldZoom * zoomy) - 1) * 100;
    f -= getValue('skewy') * 100;
    return f;
  }

  public function GetZPos(iCol:Int, fYOffset:Float, pn:Int, xOffset:Array<Float>):Float
  {
    var f:Float = 0;
    var time:Float = (Conductor.instance.songPosition / 1000);
    var notefieldZoom:Float = getValue('zoom') * getValue('zoom$iCol');
    f += ARROW_SIZE * getValue('movez$iCol') + getValue('movezoffset$iCol') + getValue('movezoffset1$iCol');

    f += ARROW_SIZE * getValue('movez') + getValue('movezoffset') + getValue('movezoffset1');

    if (getValue('tornadoz') != 0)
    {
      var iTornadoWidth:Int = 2;
      var iStartCol:Int = iCol - iTornadoWidth;
      var iEndCol:Int = iCol + iTornadoWidth;
      iStartCol = ModchartMath.iClamp(iStartCol, 0, 3);
      iEndCol = ModchartMath.iClamp(iEndCol, 0, 3);

      var fMinX:Float = 3.402823466e+38;
      var fMaxX:Float = 1.175494351e-38;

      for (i in iStartCol...iEndCol + 1)
      {
        fMinX = Math.min(fMinX, xOffset[i]);
        fMaxX = Math.max(fMaxX, xOffset[i]);
      }

      var fRealPixelOffset:Float = xOffset[iCol] * notefieldZoom;
      var fPositionBetween:Float = ModchartMath.scale(fRealPixelOffset, fMinX * notefieldZoom, fMaxX * notefieldZoom, -1, 1);
      var fRads:Float = Math.acos(fPositionBetween);
      fRads += (fYOffset + getValue('tornadozoffset')) * ((6 * getValue('tornadozperiod')) + 6) / SCREEN_HEIGHT;

      var fAdjustedPixelOffset:Float = ModchartMath.scale(ModchartMath.fastCos(fRads), -1, 1, fMinX * notefieldZoom, fMaxX * notefieldZoom);

      f += (fAdjustedPixelOffset - fRealPixelOffset) * getValue('tornadoz');
    }

    if (getValue('tantornadoz') != 0)
    {
      var iTornadoWidth:Int = 2;
      var iStartCol:Int = iCol - iTornadoWidth;
      var iEndCol:Int = iCol + iTornadoWidth;
      iStartCol = ModchartMath.iClamp(iStartCol, 0, 3);
      iEndCol = ModchartMath.iClamp(iEndCol, 0, 3);

      var fMinX:Float = 3.402823466e+38;
      var fMaxX:Float = 1.175494351e-38;

      for (i in iStartCol...iEndCol + 1)
      {
        fMinX = Math.min(fMinX, xOffset[i]);
        fMaxX = Math.max(fMaxX, xOffset[i]);
      }

      var fRealPixelOffset:Float = xOffset[iCol] * notefieldZoom;
      var fPositionBetween:Float = ModchartMath.scale(fRealPixelOffset, fMinX * notefieldZoom, fMaxX * notefieldZoom, -1, 1);
      var fRads:Float = Math.acos(fPositionBetween);
      fRads += (fYOffset + getValue('tantornadozoffset')) * ((6 * getValue('tantornadozperiod')) + 6) / SCREEN_HEIGHT;

      var fAdjustedPixelOffset:Float = ModchartMath.scale(selectTanType(fRads, getValue('cosecant')), -1, 1, fMinX * notefieldZoom, fMaxX * notefieldZoom);

      f += (fAdjustedPixelOffset - fRealPixelOffset) * getValue('tantornadoz');
    }

    if (getValue('drunkz') != 0) f += getValue('drunkz') * ModchartMath.fastCos(CalculateDrunkAngle(time, getValue('drunkzspeed'), iCol,
      getValue('drunkzoffset'), 0.2, fYOffset, getValue('drunkzperiod'), 10)) * ARROW_SIZE * 0.5;

    if (getValue('tandrunkz') != 0) f += getValue('tandrunkz') * selectTanType(CalculateDrunkAngle(time, getValue('tandrunkzspeed'), iCol,
      getValue('tandrunkzoffset'), 0.2, fYOffset, getValue('tandrunkzperiod'), 10),
      getValue('cosecant')) * ARROW_SIZE * 0.5;

    if (getValue('bouncez') != 0)
    {
      var fBounceAmt:Float = Math.abs(ModchartMath.fastSin(((fYOffset + (1.0 * (getValue('bouncezoffset')))) / (60 + (getValue('bouncezperiod') * 60)))));

      f += getValue('bouncez') * ARROW_SIZE * 0.5 * fBounceAmt;
    }

    if (getValue('bumpy') != 0) f += getValue('bumpy') * 40 * ModchartMath.fastSin(CalculateBumpyAngle(fYOffset, getValue('bumpyoffset'),
      getValue('bumpyperiod')));

    if (getValue('tanbumpy') != 0) f += getValue('tanbumpy') * 40 * selectTanType(CalculateBumpyAngle(fYOffset, getValue('tanbumpyoffset'),
      getValue('tanbumpyperiod')), getValue('cosecant'));

    if (getValue('bumpy$iCol') != 0) f += getValue('bumpy$iCol') * 40 * ModchartMath.fastSin(CalculateBumpyAngle(fYOffset, getValue('bumpyoffset'),
      getValue('bumpyperiod')));

    if (getValue('beatz') != 0) f += getValue('beatz') * (beatFactor[dim_x] * ModchartMath.fastSin(fYOffset / ((getValue('beatzperiod') * 15) + 15)
      + Math.PI / 2));

    if (getValue('digitalz') != 0) f += (getValue('digitalz') * ARROW_SIZE * 0.5) * Math.round((getValue('digitalzsteps') +
      1) * ModchartMath.fastSin(CalculateDigitalAngle(fYOffset, getValue('digitalzoffset'), getValue('digitalzperiod')))) / (getValue('digitalzsteps')
      + 1);

    if (getValue('tandigitalz') != 0) f += (getValue('tandigitalz') * ARROW_SIZE * 0.5) * Math.round((getValue('tandigitalzsteps') +
      1) * selectTanType(CalculateDigitalAngle(fYOffset, getValue('tandigitalzoffset'), getValue('tandigitalzperiod')),
      getValue('cosecant'))) / (getValue('tandigitalzsteps') + 1);

    if (getValue('zigzagz') != 0)
    {
      var fResult:Float = ModchartMath.triangle((Math.PI * (1 / (getValue('zigzagzperiod') + 1)) * ((fYOffset +
        (100.0 * (getValue('zigzagzoffset')))) / ARROW_SIZE)));

      f += (getValue('zigzagz') * ARROW_SIZE / 2) * fResult;
    }

    if (getValue('sawtoothz') != 0) f += (getValue('sawtoothz') * ARROW_SIZE) * ((0.5 / (getValue('sawtoothzperiod') + 1) * (fYOffset
      + 100.0 * getValue('sawtoothzoffset'))) / ARROW_SIZE
      - Math.floor((0.5 / (getValue('sawtoothperiod') + 1) * (fYOffset + 100.0 * getValue('sawtoothzoffset'))) / ARROW_SIZE));

    if (getValue('squarez') != 0)
    {
      var fResult:Float = ModchartMath.square((Math.PI * (fYOffset + (1.0 * (getValue('squarezoffset')))) / (ARROW_SIZE
        + (getValue('squarezperiod') * ARROW_SIZE))));

      f += (getValue('squarez') * ARROW_SIZE * 0.5) * fResult;
    }

    if (getValue('parabolaz') != 0) f += getValue('parabolaz') * ((fYOffset + 2 * getValue('parabolazoffset')) / ARROW_SIZE) * ((fYOffset
      + 2 * getValue('parabolazoffset')) / ARROW_SIZE);

    if (getValue('attenuatez') != 0) f += getValue('attenuatez') * ((fYOffset + 100 * getValue('attenuatezoffset')) / ARROW_SIZE) * ((fYOffset
      + 100 * getValue('attenuatezoffset')) / ARROW_SIZE) * (xOffset[iCol] / ARROW_SIZE);

    if (getValue('tipsyz') != 0) f += getValue('tipsyz') * CalculateTipsyOffset(time, getValue('tipsyzoffset'), getValue('tipsyzspeed'), iCol);

    if (getValue('tantipsyz') != 0) f += getValue('tantipsyz') * CalculateTipsyOffset(time, getValue('tantipsyzoffset'), getValue('tantipsyzspeed'), iCol, 1);

    if (getValue('spiralz') != 0) f += fYOffset * getValue('spiralz') * ModchartMath.fastCos((fYOffset + getValue('spiralzoffset')) * (1
      + getValue('spiralzperiod')));

    return f;
  }

  public function GetRotationZ(iCol:Int, fYOffset:Float, noteBeat:Float, isHoldHead:Bool = false, travelDir:Float):Float
  {
    var fRotation:Float = 0;
    var beat:Float = Conductor.instance.currentBeatTime;
    if (!isHoldHead)
    {
      if (getValue('confusion$iCol') != 0) fRotation += getValue('confusion$iCol') * 180.0 / Math.PI;

      if (getValue('confusionoffset') != 0) fRotation += getValue('confusionoffset') * 180.0 / Math.PI;

      if (getValue('confusionoffset$iCol') != 0) fRotation += getValue('confusionoffset$iCol') * 180.0 / Math.PI;

      if (getValue('confusion') != 0)
      {
        var fConfRotation:Float = beat;
        fConfRotation *= getValue('confusion');
        fConfRotation = ModchartMath.mod(fConfRotation, 2 * Math.PI);
        fConfRotation *= -180 / Math.PI;
        fRotation += fConfRotation;
      }
    }
    if (getValue('dizzy') != 0 && (getValue('dizzyholds') != 0 || !isHoldHead))
    {
      var fDizzyRotation = noteBeat - beat;
      fDizzyRotation *= getValue('dizzy');
      fDizzyRotation = ModchartMath.mod(fDizzyRotation, 2 * Math.PI);
      fDizzyRotation *= 180 / Math.PI;
      fRotation += fDizzyRotation;
    }
    if (getValue('rotationz') != 0)
    {
      fRotation += getValue('rotationz') * 100;
    }
    if (getValue('orient') != 0) fRotation += (ModchartMath.deg * travelDir - 90 * (1 - GetReversePercentForColumn(iCol))) * getValue('orient');
    return fRotation;
  }

  public function GetRotationX(iCol:Int, fYOffset:Float, isHoldHead:Bool = false):Float
  {
    var fRotation:Float = 0;
    var beat:Float = Conductor.instance.currentBeatTime;
    if (!isHoldHead)
    {
      if (getValue('confusionx$iCol') != 0) fRotation += getValue('confusionx$iCol') * 180.0 / Math.PI;

      if (getValue('confusionxoffset') != 0) fRotation += getValue('confusionxoffset') * 180.0 / Math.PI;

      if (getValue('confusionxoffset$iCol') != 0) fRotation += getValue('confusionxoffset$iCol') * 180.0 / Math.PI;

      if (getValue('confusionx') != 0)
      {
        var fConfRotation:Float = beat;
        fConfRotation *= getValue('confusionx');
        fConfRotation = ModchartMath.mod(fConfRotation, 2 * Math.PI);
        fConfRotation *= -180 / Math.PI;
        fRotation += fConfRotation;
      }
    }
    if (getValue('roll') != 0)
    {
      fRotation += getValue('roll') * fYOffset / 2;
    }
    if (getValue('rotationx') != 0)
    {
      fRotation += getValue('rotationx') * 100;
    }
    return fRotation;
  }

  public function GetRotationY(iCol:Int, fYOffset:Float, isHoldHead:Bool = false):Float
  {
    var fRotation:Float = 0;
    var beat:Float = Conductor.instance.currentBeatTime;
    if (!isHoldHead)
    {
      if (getValue('confusiony$iCol') != 0) fRotation += getValue('confusiony$iCol') * 180.0 / Math.PI;

      if (getValue('confusionyoffset') != 0) fRotation += getValue('confusionyoffset') * 180.0 / Math.PI;

      if (getValue('confusionyoffset$iCol') != 0) fRotation += getValue('confusionyoffset$iCol') * 180.0 / Math.PI;

      if (getValue('confusiony') != 0)
      {
        var fConfRotation:Float = beat;
        fConfRotation *= getValue('confusiony');
        fConfRotation = ModchartMath.mod(fConfRotation, 2 * Math.PI);
        fConfRotation *= -180 / Math.PI;
        fRotation += fConfRotation;
      }
    }
    if (getValue('twirl') != 0)
    {
      fRotation += getValue('twirl') * fYOffset / 2;
    }
    if (getValue('rotationy') != 0)
    {
      fRotation += getValue('rotationy') * 100;
    }
    return fRotation;
  }

  public function ReceptorGetRotationZ(iCol:Int, travelDir:Float):Float
  {
    var fRotation:Float = 0;
    var beat:Float = Conductor.instance.currentBeatTime;
    if (getValue('confusion$iCol') != 0) fRotation += getValue('confusion$iCol') * 180.0 / Math.PI;

    if (getValue('confusionoffset') != 0) fRotation += getValue('confusionoffset') * 180.0 / Math.PI;

    if (getValue('confusionoffset$iCol') != 0) fRotation += getValue('confusionoffset$iCol') * 180.0 / Math.PI;

    if (getValue('confusion') != 0)
    {
      var fConfRotation:Float = beat;
      fConfRotation *= getValue('confusion');
      fConfRotation = ModchartMath.mod(fConfRotation, 2 * Math.PI);
      fConfRotation *= -180 / Math.PI;
      fRotation += fConfRotation;
    }
    if (getValue('rotationz') != 0)
    {
      fRotation += getValue('rotationz') * 100;
    }
    if (getValue('orient') != 0) fRotation += (ModchartMath.deg * travelDir - 90 * (1 - GetReversePercentForColumn(iCol))) * getValue('orient');
    return fRotation;
  }

  public function ReceptorGetRotationX(iCol:Int):Float
  {
    var fRotation:Float = 0;
    var beat:Float = Conductor.instance.currentBeatTime;
    if (getValue('confusionx$iCol') != 0) fRotation += getValue('confusionx$iCol') * 180.0 / Math.PI;

    if (getValue('confusionxoffset') != 0) fRotation += getValue('confusionxoffset') * 180.0 / Math.PI;

    if (getValue('confusionxoffset$iCol') != 0) fRotation += getValue('confusionxoffset$iCol') * 180.0 / Math.PI;

    if (getValue('confusionx') != 0)
    {
      var fConfRotation:Float = beat;
      fConfRotation *= getValue('confusionx');
      fConfRotation = ModchartMath.mod(fConfRotation, 2 * Math.PI);
      fConfRotation *= -180 / Math.PI;
      fRotation += fConfRotation;
    }
    if (getValue('rotationx') != 0)
    {
      fRotation += getValue('rotationx') * 100;
    }
    return fRotation;
  }

  public function ReceptorGetRotationY(iCol:Int):Float
  {
    var fRotation:Float = 0;
    var beat:Float = Conductor.instance.currentBeatTime;
    if (getValue('confusiony$iCol') != 0) fRotation += getValue('confusiony$iCol') * 180.0 / Math.PI;

    if (getValue('confusionyoffset') != 0) fRotation += getValue('confusionyoffset') * 180.0 / Math.PI;

    if (getValue('confusionyoffset$iCol') != 0) fRotation += getValue('confusionyoffset$iCol') * 180.0 / Math.PI;

    if (getValue('confusiony') != 0)
    {
      var fConfRotation:Float = beat;
      fConfRotation *= getValue('confusiony');
      fConfRotation = ModchartMath.mod(fConfRotation, 2 * Math.PI);
      fConfRotation *= -180 / Math.PI;
      fRotation += fConfRotation;
    }
    if (getValue('rotationy') != 0)
    {
      fRotation += getValue('rotationy') * 100;
    }
    return fRotation;
  }

  var FADE_DIST_Y:Float = 40;

  function GetHiddenSudden():Float
    return getValue('hidden') * getValue('sudden');

  function GetHiddenEndLine():Float
    return SCREEN_HEIGHT / 2
      + FADE_DIST_Y * ModchartMath.scale(GetHiddenSudden(), 0., 1., -1.0, -1.25)
      + SCREEN_HEIGHT / 2 / (1 - getValue('mini') * 0.5) * getValue('hiddenoffset');

  function GetHiddenStartLine():Float
    return SCREEN_HEIGHT / 2
      + FADE_DIST_Y * ModchartMath.scale(GetHiddenSudden(), 0., 1., 0.0, -0.25)
      + SCREEN_HEIGHT / 2 / (1 - getValue('mini') * 0.5) * getValue('hiddenoffset');

  function GetSuddenEndLine():Float
    return SCREEN_HEIGHT / 2
      + FADE_DIST_Y * ModchartMath.scale(GetHiddenSudden(), 0., 1., -0.0, 0.25)
      + SCREEN_HEIGHT / 2 / (1 - getValue('mini') * 0.5) * getValue('suddenoffset');

  function GetSuddenStartLine():Float
    return SCREEN_HEIGHT / 2
      + FADE_DIST_Y * ModchartMath.scale(GetHiddenSudden(), 0., 1., 1.0, 1.25)
      + SCREEN_HEIGHT / 2 / (1 - getValue('mini') * 0.5) * getValue('suddenoffset');

  public function ArrowGetPercentVisible(fYPosWithoutReverse:Float, iCol:Int, fYOffset:Float, isHoldHead:Bool, isHoldBody:Bool):Float
  {
    var fDistFromCenterLine:Float = fYPosWithoutReverse - SCREEN_HEIGHT * 0.5 / (1 - getValue('mini') * 0.5);

    var fYPos:Float;
    if (getValue('stealthtype') != 0) fYPos = fYOffset;
    else
      fYPos = fYPosWithoutReverse;

    if (fYPos < 0 && getValue('stealthpastreceptors') == 0) return 1;

    var fVisibleAdjust:Float = 0;
    if (getValue('hidden') != 0)
    {
      var fHiddenVisibleAdjust:Float = ModchartMath.scale(fYPos, GetHiddenStartLine(), GetHiddenEndLine(), 0, -1);
      fHiddenVisibleAdjust = ModchartMath.clamp(fHiddenVisibleAdjust, -1, 0);
      fVisibleAdjust += getValue('hidden') * fHiddenVisibleAdjust;
    }
    if (getValue('sudden') != 0)
    {
      var fSuddenVisibleAdjust:Float = ModchartMath.scale(fYPos, GetSuddenStartLine(), GetSuddenEndLine(), -1, 0);
      fSuddenVisibleAdjust = ModchartMath.clamp(fSuddenVisibleAdjust, -1, 0);
      fVisibleAdjust += getValue('sudden') * fSuddenVisibleAdjust;
    }

    if (getValue('stealth') != 0) fVisibleAdjust -= getValue('stealth');
    if (getValue('stealth$iCol') != 0)
    {
      fVisibleAdjust -= getValue('stealth$iCol');
    }
    if (getValue('holdstealth') != 0 && isHoldBody) fVisibleAdjust -= getValue('holdstealth');
    if (getValue('holdstealth$iCol') != 0 && isHoldBody)
    {
      fVisibleAdjust -= getValue('holdstealth$iCol');
    }
    if (getValue('tapstealth') != 0 && !isHoldBody && !isHoldHead) fVisibleAdjust -= getValue('tapstealth');
    if (getValue('tapstealth$iCol') != 0 && !isHoldBody && !isHoldHead)
    {
      fVisibleAdjust -= getValue('tapstealth$iCol');
    }
    if (getValue('blink') != 0)
    {
      var f:Float = ModchartMath.fastSin(Conductor.instance.songPosition / 1000 * 10);
      f = ModchartMath.Quantize(f, 0.3333);
      fVisibleAdjust += ModchartMath.scale(f, 0, 1, -1, 0);
    }
    if (getValue('randomvanish') != 0)
    {
      var fRealFadeDist:Float = 80;
      fVisibleAdjust += ModchartMath.scale(Math.abs(fDistFromCenterLine), fRealFadeDist + 100 * getValue('vanishoffset'),
        2 * (fRealFadeDist + 100 * getValue('vanishoffset')), -1, 0) * getValue('randomvanish');
    }
    return ModchartMath.clamp(1 + fVisibleAdjust, 0, 1);
  }

  public function GetAlpha(fYPosWithoutReverse:Float, iCol:Int, fYOffset:Float, isHoldHead:Bool, isHoldBody:Bool):Float
  {
    var fPercentVisible:Float = ArrowGetPercentVisible(fYPosWithoutReverse, iCol, fYOffset, isHoldHead, isHoldBody);
    var fDrawDistanceBeforeTargetsPixels:Float = SCREEN_HEIGHT;
    var fFullAlphaY:Float = fDrawDistanceBeforeTargetsPixels;
    if (fYPosWithoutReverse > fFullAlphaY)
    {
      var f = ModchartMath.scale(fYPosWithoutReverse, fFullAlphaY, fDrawDistanceBeforeTargetsPixels, 1.0, 0.0);
      return f;
    }
    return (fPercentVisible > 0.5) ? 1.0 : 0.0;
  }

  public function GetGlow(fYPosWithoutReverse:Float, iCol:Int, fYOffset:Float, isHoldHead:Bool, isHoldBody:Bool):Float
  {
    var fPercentVisible:Float = ArrowGetPercentVisible(fYPosWithoutReverse, iCol, fYOffset, isHoldHead, isHoldBody);
    var fPercentFadeToFail:Float = -1;
    if (fPercentFadeToFail != -1) fPercentVisible = 1 - fPercentFadeToFail;
    var fDistFromHalf:Float = Math.abs(fPercentVisible - 0.5);
    return ModchartMath.scale(fDistFromHalf, 0, 0.5, 1.3, 0);
  }

  public function GetScale(iCol:Int, fYOffset:Float, pn:Int, defaultScale:Array<Float>, isHoldBody:Bool = false):Array<Float>
  {
    var x:Float = defaultScale[0];
    var y:Float = defaultScale[1];
    var z:Float = 1;

    x *= getValue('scale') * getValue('scale$iCol') * getValue('scalex$iCol') * getValue('scalex');
    y *= getValue('scale') * getValue('scale$iCol') * getValue('scaley$iCol') * getValue('scaley');
    z *= getValue('scale') * getValue('scale$iCol') * getValue('scalez$iCol') * getValue('scalez');

    x *= getValue('zoomx') * getValue('zoomx$iCol');
    y *= getValue('zoomy') * getValue('zoomy$iCol');
    z *= getValue('zoomz') * getValue('zoomz$iCol');
    // notitg's tinyx tinyy mod
    x *= Math.pow(0.5, getValue('tinyx'));
    x *= Math.pow(0.5, getValue('tinyx$iCol'));
    if (!isHoldBody)
    {
      y *= Math.pow(0.5, getValue('tinyy'));
      y *= Math.pow(0.5, getValue('tinyy$iCol'));
    }
    z *= Math.pow(0.5, getValue('tinyz'));
    z *= Math.pow(0.5, getValue('tinyz$iCol'));
    if (isHoldBody)
    {
      x *= Math.pow(0.5, getValue('holdtiny'));
      x *= Math.pow(0.5, getValue('holdtiny$iCol'));
      y *= Math.pow(0.5, getValue('holdtiny'));
      y *= Math.pow(0.5, getValue('holdtiny$iCol'));
      z *= Math.pow(0.5, getValue('holdtiny'));
      z *= Math.pow(0.5, getValue('holdtiny$iCol'));
    }
    if (getValue('shrinkmultx') != 0 && fYOffset >= 0) x *= 1 / (1 + (fYOffset * (getValue('shrinkmultx') / 100.0)));
    if (getValue('shrinklinearx') != 0 && fYOffset >= 0) x += fYOffset * (0.5 * getValue('shrinklinearx') / ARROW_SIZE);
    if (getValue('shrinkmulty') != 0 && fYOffset >= 0) y *= 1 / (1 + (fYOffset * (getValue('shrinkmulty') / 100.0)));
    if (getValue('shrinklineary') != 0 && fYOffset >= 0) y += fYOffset * (0.5 * getValue('shrinklineary') / ARROW_SIZE);
    if (getValue('shrinkmultz') != 0 && fYOffset >= 0) z *= 1 / (1 + (fYOffset * (getValue('shrinkmultz') / 100.0)));
    if (getValue('shrinklinearz') != 0 && fYOffset >= 0) z += fYOffset * (0.5 * getValue('shrinklinearz') / ARROW_SIZE);
    // skewx skewy
    var skewx:Float = 0;
    var skewy:Float = 0;
    if (!isHoldBody)
    {
      skewx += getValue('noteskewx') + getValue('noteskewx$iCol');
      skewy += getValue('noteskewy') + getValue('noteskewy$iCol');
    }
    skewx += getValue('skewx');
    skewy += getValue('skewy');
    return [x, y, skewx, skewy, z];
  }

  public function GetZoom(iCol:Int, fYOffset:Float, pn:Int):Float
  {
    var fZoom:Float = ModchartMath.scale(getValue('mini'), 0.0, 1.0, 1.0, 0.5); // the same as 1 - mini * 0.5
    var fPulseInner:Float = 1.0;
    var notefieldZoom:Float = getValue('zoom') * getValue('zoom$iCol');
    fZoom *= notefieldZoom;

    if (getValue('pulseinner') != 0 || getValue('pulseouter') != 0 || getValue('pulse') != 0)
    {
      var inner:Float = getValue('pulseinner') == 0 ? getValue('pulse') : getValue('pulseinner');
      fPulseInner = ((inner * 0.5) + 1);
      if (fPulseInner == 0) fPulseInner = 0.01;
    }

    if (getValue('pulseinner') != 0 || getValue('pulseouter') != 0 || getValue('pulse') != 0)
    {
      var outer:Float = getValue('pulseouter') == 0 ? getValue('pulse') : getValue('pulseouter');
      var sine:Float = ModchartMath.fastSin(((fYOffset + (100.0 * (getValue('pulseoffset')))) / (0.4 * (ARROW_SIZE + (getValue('pulseperiod') * ARROW_SIZE)))));

      fZoom *= (sine * (outer * 0.5)) + fPulseInner;
    }

    if (getValue('tanpulseinner') != 0 || getValue('tanpulseouter') != 0 || getValue('tanpulse') != 0)
    {
      var inner:Float = getValue('tanpulseinner') == 0 ? getValue('tanpulse') : getValue('tanpulseinner');
      fPulseInner = ((inner * 0.5) + 1);
      if (fPulseInner == 0) fPulseInner = 0.01;
    }

    if (getValue('tanpulseinner') != 0 || getValue('tanpulseouter') != 0 || getValue('tanpulse') != 0)
    {
      var outer:Float = getValue('tanpulseouter') == 0 ? getValue('tanpulse') : getValue('tanpulseouter');
      var sine:Float = selectTanType(((fYOffset + (100.0 * (getValue('tanpulseoffset')))) / (0.4 * (ARROW_SIZE + (getValue('tanpulseperiod') * ARROW_SIZE)))),
        getValue('cosecant'));

      fZoom *= (sine * (outer * 0.5)) + fPulseInner;
    }

    if (getValue('shrinkmult') != 0 && fYOffset >= 0) fZoom *= 1 / (1 + (fYOffset * (getValue('shrinkmult') / 100.0)));

    if (getValue('shrinklinear') != 0 && fYOffset >= 0) fZoom += fYOffset * (0.5 * getValue('shrinklinear') / ARROW_SIZE);

    if (getValue('tiny') != 0)
    {
      var fTinyPercent = getValue('tiny');
      fTinyPercent = Math.pow(0.5, fTinyPercent);
      fZoom *= fTinyPercent;
    }
    if (getValue('tiny$iCol') != 0)
    {
      var fTinyPercent = Math.pow(0.5, getValue('tiny$iCol'));
      fZoom *= fTinyPercent;
    }
    return fZoom;
  }

  @:nullSafety
  public function modifyPos(pos:Vector3D, xoff:Array<Float>):Void
  {
    if (getValue('rotationx') != 0 || getValue('rotationy') != 0 || getValue('rotationz') != 0)
    {
      var originPos:Vector3D = new Vector3D(0, SCREEN_HEIGHT / 2);
      var s:Vector3D = pos.subtract(originPos);
      var out:Vector3D = ModchartMath.rotateVector3(s, getValue('rotationx') * 100, getValue('rotationy') * 100, getValue('rotationz') * 100);
      var newpos:Vector3D = out.add(originPos);
      pos.x = newpos.x;
      pos.y = newpos.y;
      pos.z = newpos.z;
    }
  }

  public var opened:Bool = false;

  public function new()
  {
    initDefaultMods();
    opened = true;
  }
}
