package com.brianstoner.synth {
  
  public class PluckedString {
    
    private var _rootNote:int;
    private var _rootFreq:Number;
    
    private var _periodN: int = 0;
    private var _period: Vector.<Number>;
    private var _periodIndex: int = 0;
    private var _feedNoise: Boolean = false;
    private var _current: Number = 0.0;

    private var _sustain: Number = 0.60; // number between 0 and 1
    
    public function PluckedString(rootNote:int){
      _rootNote = rootNote;
      _rootFreq = noteToFreq(_rootNote);
      
      _periodN = 44100 / _rootFreq;
      _period = new Vector.<Number>( _periodN, true );
      _periodIndex = 0;
      
      _feedNoise = false;
      _current = 0.0;
    }
    
    public function getSampleData():Number{
      if( _periodIndex == _periodN ) {
        _periodIndex = 0;
        _feedNoise = false;
      }
      
      if( _feedNoise ){
        _period[ _periodIndex ] += Math.random() - Math.random();
      }
      
      _current += ( _period[ _periodIndex ] - _current ) * _sustain; 
      
      _period[ _periodIndex ] = _current;
      
      ++_periodIndex;
      
      return _current;
    }
    
    public function playNote(fret:int){
      playFrequency(noteToFreq(fret + _rootNote));
    }
    
    public function stopPlaying(){
      _feedNoise = false;
      
      _periodN = 44100 / _rootFreq;
      _period = new Vector.<Number>( _periodN, true );
      _periodIndex = 0;
      _current = 0.0;
    }
    
    private function playFrequency(freq:int){
      _periodN = 44100 / freq;
      _period = new Vector.<Number>( _periodN, true );
      _periodIndex = 0;
      _current = 0.0;
      _feedNoise = true;
    }
    
    private function noteToFreq(note:uint):Number {
      return 440.0 * Math.pow(2, (note - 69) / 12.0);
    }
  }
}
