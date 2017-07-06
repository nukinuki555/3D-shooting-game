class EndingScene extends Scene{
  
     private PFont titleFont;          // オープニング画面だけで使う変数は、このようにこのクラスのprivate変数として宣言する
     private PVector titlePosition;    // タイトル文字の位置
     private PVector titlePositionDestination;    // タイトル位置が停止する位置
      
      /* 初期化 */
      protected boolean initialize(){    // 同じ関数を定義することで親クラスのinitialize()をオーバーライドしている
        titleFont = loadFont("HanziPenTC-W5-48.vlw");
        titlePosition = new PVector(0.0f, 1000.0f, 0.0f);
        titlePositionDestination = new PVector(-160.0f, 0.0f, 0.0f);
        
        if(player.hitPoint <= 0){
             //音源の再生
             endingEffectFailure.play();
             endingEffectFailure.rewind();
             endingSongFailure.play();
             endingSongFailure.rewind();
             
          }
          else{
             //音源の再生
             endingEffectClear.play();
             endingEffectClear.rewind();
             
          }
        
        return true;
      }  
      
      /* 動かす */
      protected void move(){
        titlePosition.x += (titlePositionDestination.x - titlePosition.x) / 10.0f;    // 画面外から出てくるようにしてみる 
        titlePosition.y += (titlePositionDestination.y - titlePosition.y) / 10.0f;
      }
      
      /* タイトルの描画 */
      protected void render(){
        
        render.clear();
             
          /* 2Dカメラの初期化 */
          render.update2DCamera();  
          
          /* 文字の描画 */
          pushMatrix();
          fill(0, 0, 0);
          scale(2.0f, 2.0f, 2.0f);
          
          if(player.hitPoint <= 0){
             
            text("Failure!!\n Press K and Back to OpeningScene", titlePosition.x, titlePosition.y);
          }
          else{
            
             
            
             text("Geme Clear\n Press K and Back to OpeningScene!!", titlePosition.x, titlePosition.y);
          }
          noFill();
          popMatrix();  
          
  } // render
  
  
  
}