package uiwidgets {
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
import flash.ui.Keyboard;

import sound.*;
	import translation.*;

public class Piano extends Sprite {

	private var color:int;
	private var instrument:int;
	private var callback:Function;

    private var selectedKey:int;

	private var keys:Array = [];
	private var shape:Shape;
	private var label:TextField;

	private var notePlayer:NotePlayer;

	public function Piano(color:int, instrument:int = 0, callback:Function = null, firstKey:int = 48, lastKey:int = 72) {
		this.color = color;
		this.instrument = instrument;
		this.callback = callback;
		addShape();
		addLabel();
		addKeys(firstKey, lastKey);
		fixLayout();
	}

	private function addShape():void {
		addChild(shape = new Shape);
	}

	private function addLabel():void {
		addChild(label = new TextField);
		label.selectable = false;
		label.defaultTextFormat = new TextFormat(CSS.font, 12, 0xFFFFFF);
	}

	private function addKeys(firstKey:int, lastKey:int):void {
		for (var n:int = firstKey; n <= lastKey; n++) {
			addKey(n);
		}
		for each (var k:PianoKey in keys) {
			if (k.isBlack) addChild(k);
		}
	}

	private function addKey(n:int):void {
		var key:PianoKey = new PianoKey(n, this);
		addChild(key);
		keys.push(key);
	}

	public function selectNote(n:int):void {
        selectedKey = n;
		setLabel(getNoteLabel(n));
        playSoundForNote(n);
	}

	private function stopPlaying():void {
		if (notePlayer) {
			notePlayer.stopPlaying();
			notePlayer = null;
		}
	}

	public function playSoundForNote(n:int):void {
		stopPlaying();
		notePlayer = SoundBank.getNotePlayer(instrument, n);
		if (!notePlayer) return;
		notePlayer.setNoteAndDuration(n, 3);
		notePlayer.startPlaying();
	}

    public function finalize(key:PianoKey):void {
        callback(key.note);
        hide();
    }

    private function getKey(n:int):PianoKey {
        for each (var key:PianoKey in keys) {
            if (key.note == n) {
                return key;
            }
        }
        return null;
    }

	public function showOnStage(s:Stage, x:Number = NaN, y:Number = NaN):void {
		addShadowFilter();
		this.x = int(x === x ? x : s.mouseX);
		this.y = int(y === y ? y : s.mouseY);
		s.addChild(this);
        s.focus = getKey(selectedKey);
        s.addEventListener(KeyboardEvent.KEY_DOWN, function(evt:KeyboardEvent):void {
            if (evt.keyCode == Keyboard.ESCAPE) {
                s.removeEventListener(KeyboardEvent.KEY_DOWN, arguments.callee);
                hide();
            }
        })
	}

	public function hide():void {
		if (!stage) return;
		stage.removeChild(this);
	}

	private function addShadowFilter():void {
		var f:DropShadowFilter = new DropShadowFilter();
		f.blurX = f.blurY = 5;
		f.distance = 3;
		f.color = 0x333333;
		filters = [f];
	}

	private function fixLayout():void {
		fixKeyLayout();
		fixLabelLayout();
		redraw();
	}

	private function fixKeyLayout():void {
		var x:int = 1;
		for each (var k:PianoKey in keys) {
			if (k.isBlack) {
				k.x = int(x - k.width / 2);
				k.y = 0;
			} else {
				k.x = x;
				k.y = 1;
				x += k.width;
			}
		}
	}

	private function redraw():void {
		var g:Graphics = shape.graphics;
		g.beginFill(color, 1);
		g.drawRect(0, 0, width + 1, 64);
		g.endFill();
	}

	private function setLabel(s:String):void {
		label.text = s;
		fixLabelLayout();
	}

	private function fixLabelLayout():void {
		label.x = int((width - label.textWidth) / 2);
		label.y = int(52 - label.textHeight / 2);
	}

	public static function isBlack(n:int):Boolean {
		n = getNoteOffset(n);
		return n < 4 && n % 2 === 1 || n > 4 && n % 2 === 0;
	}

	private static function getNoteLabel(n:int):String {
		return getNoteName(n) + ' (' + n + ')';
	}

	private static var noteNames:Array = ['C', 'C#', 'D', 'Eb', 'E', 'F', 'F#', 'G', 'G#', 'A', 'Bb', 'B'];
	private static function getNoteName(n:int):String {
		var o:int = getNoteOffset(n);
		return o ? noteNames[o] : getOctaveName(n / 12);
	}

	private static var octaveNames:Array = ['Low C', 'Middle C', 'High C'];
	private static function getOctaveName(n:int):String {
		return n >= 4 && n <= 6 ? Translator.map(octaveNames[n - 4]) : 'C';
	}

	private static function getNoteOffset(n:int):int {
		n = n % 12;
		if (n < 0) n += 12;
		return n;
	}

}}

import flash.display.*;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

import uiwidgets.*;

class PianoKey extends Sprite {

	public const keyHeight:int = 44;
	public const blackKeyHeight:int = 26;
	public const keyWidth:int = 14;
	public const blackKeyWidth:int = 7;

	public var note:int;
	public var isBlack:Boolean;
	public var isSelected:Boolean;
    public var piano:Piano;

	public function PianoKey(n:int, parent:Piano) {
		note = n;
        piano = parent;
		isBlack = Piano.isBlack(n);
        this.tabIndex = 1;
		redraw();
        var self:PianoKey = this;
        addEventListener(FocusEvent.FOCUS_IN, handleFocus);
        addEventListener(FocusEvent.FOCUS_OUT, handleUnfocus);
        addEventListener(MouseEvent.MOUSE_OVER, handleFocus);
        addEventListener(MouseEvent.MOUSE_OUT, handleUnfocus);
        addEventListener(KeyboardEvent.KEY_DOWN, function(evt:KeyboardEvent):void {
            if (evt.keyCode == Keyboard.ENTER) {
                piano.finalize(self);
            }
        });
        addEventListener(MouseEvent.MOUSE_DOWN, function(evt:MouseEvent):void {
            piano.finalize(self);
        });
	}

    private function handleUnfocus(evt:Event):void {
        deselect();
    }

    private function handleFocus(evt:Event):void {
        select();
    }

	public function select():void {
		setSelected(true);
	}

	public function deselect():void {
		setSelected(false);
	}

	public function setSelected(flag:Boolean):void {
		isSelected = flag;
        if (flag)
            piano.selectNote(note);
		redraw();
	}

	private function redraw():void {
		var h:int = isBlack ? blackKeyHeight : keyHeight;
		var w:int = isBlack ? blackKeyWidth : keyWidth;
		graphics.beginFill(isSelected ? 0xFFFF00 : isBlack ? 0 : 0xFFFFFF);
		if (isSelected && isBlack) graphics.lineStyle(1, 0, 1, true);
		graphics.drawRect(0, 0, w, h);
		graphics.endFill();
		if (!isBlack) {
			graphics.beginFill(0, 0);
			graphics.drawRect(w, 0, 1, h);
			graphics.endFill();
		}
	}

}
