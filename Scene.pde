/**********************************************************************************
  シーンの親クラス    by 佐藤俊樹(2016/05/22)
  
    ○このクラスの公開関数:
      ・setup()関数
        シーンの初期化を行う関数。
        シーンのループ(draw())が回りはじめる前に1度だけ呼び出される必要がある。              
      ・draw()関数
        毎フレームループで呼び出すことでシーンが進む。
        
    ○このクラスの非公開関数
      ・initialize(), move(), render()にはそれぞれシーンの具体的な内容を記述する。
        Sceneクラスを継承して作成した子クラスでオーバーライドされる。
        
 **********************************************************************************/

class Scene{

  /* シーンの初期化 */
  public boolean setup(){
    return initialize();
  }
  
  /* シーンのループ */
  public void draw(){
    move();
    render();
  }
  
  /* この3つの関数は子供で定義される(オーバーライドされる) */
  protected boolean initialize(){    // 開始時(ループがまわりだす前)に1回だけ呼ばれる関数。ここで変数の初期化などを行う。
    return false;
  }
  protected void move(){}              // ループの中で毎フレーム呼ばれる。絵を動かす処理を記述する。
  protected void render(){}            // ループの中で毎フレーム呼ばれる。move()で動かした後に、絵を描画する処理を記述する。

}