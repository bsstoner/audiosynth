package com.brianstoner.synth {
  
  import com.brianstoner.synth.Guitar;
  
  import flash.events.SampleDataEvent;
  import flash.media.Sound;
  import flash.media.SoundChannel;

  public class SoundOutputBuffer {
    
    private const NUM_SAMPLES: int = 3072;

    private var _sound: Sound;
    private var _channel: SoundChannel;
    private var _instrument: Guitar;
    
    private var _current: Number = 0.0;
    
    public function SoundOutputBuffer(){
      _sound = new Sound();
      _sound.addEventListener( SampleDataEvent.SAMPLE_DATA, onSampleData );
    }
    
    public function addInstrument(ins: Guitar){
      _instrument = ins;
    }
    
    public function flush(){
      _current = 0.0;
      _instrument.stopPlaying();
    }
    
    public function turnOn(){
      _channel = _sound.play();
    }
    
    public function turnOff(){
      _channel.stop();
    }
    
    private function onSampleData(event: SampleDataEvent): void{
      for( var i: int = 0 ; i < NUM_SAMPLES ; ++i ){
        
        _current = _instrument.getSampleData();
        
        event.data.writeFloat( _current );
        event.data.writeFloat( _current );
      }
    }
  }
}
