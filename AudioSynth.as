package  {

  import flash.display.Sprite;
  import flash.external.ExternalInterface;

  import com.brianstoner.synth.*;

  public class AudioSynth extends Sprite {

    private var _buf:SoundOutputBuffer;
    private var _instrument:Guitar;

    public function AudioSynth(){

      _buf = new SoundOutputBuffer();
      _instrument = new Guitar();

      _buf.addInstrument(_instrument);

      onComplete: ExternalInterface.addCallback("soundOff", onSoundOff);
      onComplete: ExternalInterface.addCallback("soundOn", onSoundOn);
      onComplete: ExternalInterface.addCallback("stop", onStopSound);

      onComplete: ExternalInterface.addCallback("playNotes", onPlayNotes);

      //onComplete: demo();
    }

    private function demo():void{
      _buf.turnOn();
      _instrument.playNotes([{ str:2, fret: 1 },{ str:3, fret: 2},{ str:4, fret:2 },{ str:5, fret:0 }]);
    }

    private function onSoundOn():void{
      _buf.turnOn();
    }

    private function onSoundOff():void{
      _buf.turnOff();
    }

    private function onPlayNotes(notes:Array):void{
      _instrument.playNotes(notes);
    }

    private function onStopSound():void{
      _buf.flush();
    }

  }
}

