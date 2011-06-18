package com.brianstoner.synth {
  
  import flash.events.TimerEvent;
  import flash.utils.Timer;

  import com.brianstoner.synth.*;
  
  public class Guitar {
    
    private var _strings:Array;
    private var _current:Number = 0.0;
    
    private var _notesToPlay:Array;
    private var _strumTimer:Timer;
    
    public function Guitar(){
      
      // for now just load 6 strings, standard tuning, TODO add API for
      // passing in from javascript later
      _strings = new Array();
    
      _strings.push(new PluckedString(64));
      _strings.push(new PluckedString(59));
      _strings.push(new PluckedString(55));
      _strings.push(new PluckedString(50));
      _strings.push(new PluckedString(45));
      _strings.push(new PluckedString(40));
      
      // expose this timer delay as strum velocity, and expose strum direction too (down vs. up)
      _strumTimer = new Timer(40);
      _strumTimer.addEventListener(TimerEvent.TIMER, playNextNote);
    }
    
    public function getSampleData():Number{
      _current = 0.0;
      
      for(var i:int = 0;i<_strings.length;i++){
        _current += _strings[i].getSampleData();
      }
      
      return _current;
    }
    
    public function playNotes(notes:Array){

      // if there's no notes, stop playing all strings:
      if(notes.length==0){
        stopPlaying();
        return;
      }

      // delay the notes starting from low to high to simulate 
      // a down strum.

      _notesToPlay = notes;
      
      _strumTimer.start();
    }
    
    public function stopPlaying(){
      for(var i:int = 0;i<_strings.length;i++){
        _strings[i].stopPlaying();
      }
    }
    
    public function playNextNote(e:TimerEvent):void{
      if(_notesToPlay.length==0){
        _strumTimer.stop();
        return;
      }
      
      var note:Object = _notesToPlay.pop();
      
      _strings[note.str].playNote(note.fret);
    }
    
  }
}
