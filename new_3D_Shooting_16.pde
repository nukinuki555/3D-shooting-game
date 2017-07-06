import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;



import processing.opengl.*;

public  float panAngle = 0.0;
public  float tiltAngle = 180.0f;
public PVector v0 = new PVector(0, 0, 0);
boolean flagGameStarted = false;
//画像用の関数
public PImage ground;
public PImage wall01;
public PImage wall02;
public PImage wall03;
public PImage wall04;
public PImage celling;

//グローバルクラスの宣言
Scene currentScene;
Minim minim;
//音源用の変数
 AudioPlayer bulletEffect;
 AudioPlayer playerDamageEffect;
 AudioPlayer enemyDamageEffect;
 AudioPlayer openingSong;
 AudioPlayer shootingGameSong01;
 AudioPlayer shootingGameSong02;
 AudioPlayer endingEffectFailure;
 AudioPlayer endingSongFailure;
 AudioPlayer endingEffectClear;
 AudioPlayer endingSongClear;


//敵を倒した数を記憶
int gameCounter = 0;

Render render;
Player player;
Object object;
Enemys enemys;

void setup(){
  
  size(1028, 960, OPENGL);
  
  render = new Render(new PVector(0.0f, -1000.0f, 0.0f), new PVector(0.0f, -3.0f, 0.0f), new PVector(0.0f, 5.0f, 0.0f), new PVector(0.0f, -5.0f, 0.0f),
     new PVector(0.0f, 0.0f, 0.0f),  1.4f, 3.0f);
  object = new Object();
  
  player = new Player(object);
  
  enemys = new Enemys();
  
   //音源クラスを初期化
  minim = new Minim(this);
  //音源の読み込み
  bulletEffect = minim.loadFile("bulletEffect.mp3");
  playerDamageEffect = minim.loadFile("playerDamageEffect.mp3");
  enemyDamageEffect = minim.loadFile("enemyEffectDamage.mp3");
  openingSong = minim.loadFile("openingSong.mp3");
  shootingGameSong01 = minim.loadFile("shootingGameSong.mp3");
  shootingGameSong02 = minim.loadFile("shootingGameSongWater.mp3");
  endingEffectClear = minim.loadFile("endingEffectClear.mp3");
  endingEffectFailure = minim.loadFile("endingEffectFailure.mp3");
  endingSongFailure = minim.loadFile("endingSongFailure.mp3");
  if(endingSongFailure == null){
      print("Error");
  }
  
  
  /* 最初のシーンを初期化 */
  currentScene = new OpeningScene();
  currentScene.setup();
 //画像の読み込み
   ground = loadImage("ground.jpg");
  wall01 = loadImage("wall01.jpg");
  wall02 = loadImage("wall07.jpg");
  wall03 = loadImage("wall03.jpg");
  wall04 = loadImage("wall04.jpg");
  celling = loadImage("celling.jpg");
}

/* シーンの切り替え */
void switchScene(){
  
  /* Jでシューティングゲームスタート */
  if ( flagGameStarted == false && inputter.getKeyState('j') ){
    currentScene = new ShootingGameScene();
    currentScene.setup();
    flagGameStarted = true;
    //音源の停止
    openingSong.pause();
    return;
  }
  //ゲームカウンターが全ての敵の数と一致、または自分の体力が無くなったら
  if((flagGameStarted == true && player.hitPoint <= 0)||(flagGameStarted == true && gameCounter >= enemys.num)){
      
       //音源を停止
       shootingGameSong01.pause();
       shootingGameSong02.pause();
       
      currentScene =  new EndingScene();
      currentScene.setup();
       flagGameStarted = false;
       
      return;
      
  }
  //Kでリスタート
  if((flagGameStarted == false && player.hitPoint <= 0 &&  inputter.getKeyState('k'))||(flagGameStarted == false && gameCounter >= enemys.num &&  inputter.getKeyState('k'))){
      currentScene =  new OpeningScene();
      currentScene.setup();
      gameCounter = 0;
      //音源の停止
      endingEffectFailure.pause();
      endingSongFailure.pause();
      endingEffectClear.pause();

      return;
  }
}



  


void draw(){
  
  /* シーンの切り替え */
  switchScene();
  
  /* 現在のシーンのMove */
  currentScene.move();
  
  /* 現在のシーンのRender */
  currentScene.render();
  
    
}
//スケッチが終了すると起動
void stop(){
    
  
  
}