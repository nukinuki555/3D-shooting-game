class ShootingGameScene extends Scene{
  
   /* 初期化 */
  protected boolean initialize(){
    
    render = new Render(new PVector(0.0f, -1000.0f, 0.0f), new PVector(0.0f, -3.0f, 0.0f), new PVector(0.0f, 5.0f, 0.0f), new PVector(0.0f, -5.0f, 0.0f),
     new PVector(0.0f, 0.0f, 0.0f),  1.4f, 3.0f);
    object = new Object();
    player = new Player(object);
    enemys = new Enemys();
    //音源を再生
    shootingGameSong01.play();
    shootingGameSong01.rewind();
    shootingGameSong02.play();
    shootingGameSong02.rewind();
    
    return true;
  }
  
  protected  void move(){
  
            
            //更新(開始)---------------------
            //動き--------------
              //弾を動かす
            player.moveBullet();
            //敵を動かす
             enemys.move();
             //障害物を動かす
             object.move(render.getRegion());
              //render.collisionObject();
              //動き終了----------------
              //その他の情報を更新
              player.isHit();
              enemys.update();
              player.update();
             render.accInflation();
             //音源の停止
             //bulletEffect.close();
            //更新(終了)---------------------
    }
    protected void render(){
            //描画(開始)------------------------------------------------------------------
            background(#11CCF0);
            //弾の飛んでいく方向を描画
            render.renderMarks(#000203);
            //カメラ(自分)の移動
            render.updateWalkthroughCamera(); 
            //生成されている弾を描画
            player.renderBullet();
            //地面を描画
            render.renderGround();
            //海を描画
            render.renderSeas();
            //XYZ軸を描く
            render.renderXYZAxis();  
            //障害物を描画
            object.render();
            //敵を描画
            enemys.render();
            //描画(終了)----------------------------------------------------------------------------
    }
   

  
  
  
  
}