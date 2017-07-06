/**********************************************************************************
  シーンの子クラス(オープニング画面のシーン)    by 佐藤俊樹(2016/05/22)    
  概要:
    Sceneクラス(親クラス)で定義されていた中身の無いinitialize(), move()およびrender()を
    ここで改めて(オーバーライドして)内容を記述し、各シーンの具体的な処理を記述する。
 **********************************************************************************/
 
 class OpeningScene extends Scene{

  private PFont titleFont;          // オープニング画面だけで使う変数は、このようにこのクラスのprivate変数として宣言する
  private PVector titlePosition;    // タイトル文字の位置
  private PVector titlePositionDestination;    // タイトル位置が停止する位置
  
  /* 初期化 */
  protected boolean initialize(){    // 同じ関数を定義することで親クラスのinitialize()をオーバーライドしている
    titleFont = loadFont("Beirut-90.vlw");
    titlePosition = new PVector(0.0f, 1000.0f, 0.0f);
    titlePositionDestination = new PVector(-160.0f, 0.0f, 0.0f);
    //音源の再生
      openingSong.play();
      openingSong.rewind();
      
    return true;
  }  
  
  /* 動かす */
  protected void move(){
    //音源の再生
   
   
    
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
      text("Press J to start 3D Shooting!!", titlePosition.x, titlePosition.y);
      noFill();
      popMatrix();  
      
  } // render
  
}