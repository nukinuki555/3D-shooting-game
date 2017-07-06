class Player{
  
  Object objectCopy;
  
  PVector position;
  PVector prePosition;
  PVector getObjectPosition = new PVector(0.0f, 0.0f, 0.0f);
  PVector getEnemyPosition = new PVector(0.0f, 0.0f, 0.0f);
  int hitPoint = 50;
  int num = 100;
  Bullet[] bullet = new Bullet[num];
  
  Player(Object objectPtr){
    objectCopy = objectPtr;
    ////カメラの座標とプレイヤーの座標を同期
    //position = cameraPosition.copy();
    //prePosition = preCameraPosition.copy();
    //弾はプレイヤーが持つ
    for(int i = 0; i < num; i++){
      bullet[i] = new Bullet();
    }
    
  }
   //動きはカメラと同期なので省略　 
  
    //----------------プレイヤーの弾の処理--------------------------
   //クリックすると起動、プレイヤーフラグを有効に
  void shoot(){
    for(int i = 0; i < num; i++){
      if(!bullet[i].exists){
        bullet[i].create(render.getCameraPosition());
        break;
      }
    }
  }
  //弾を描画する
  void renderBullet(){
      for(int i = 0; i < num; i ++){
           player.bullet[i].render(player.bullet[i].position);
      }
  }
  //弾を動かす
  void moveBullet(){
     for(int i = 0; i < num; i ++){
           player.bullet[i].updateMove();
      }
  }
  //敵と弾の当たり判定
  void isHit(){
       for(int i = 0; i < num; i++){
           for(int j = 0; j < enemys.num; j ++){
              if(bullet[i].isHit(enemys.gameCharacter[j].getPosition(),enemys.gameCharacter[j].getSize())){
                   enemys.gameCharacter[j].isHit();
              }
           }
       }    
  }
  //敵と自分の当たり判定
  boolean damageFromEnemy(){
    for(int i = 0; i < enemys.num; i ++){
        if(PVector.dist(render.getCameraPosition(), enemys.gameCharacter[i].getPosition()) < enemys.gameCharacter[i].getSize() ){
              return true;
        }
    }
    return false;
  }
  //障害物と自分の当たり判定
  boolean damageFromObject(PVector cameraPosition){
    for(int i = 0; i < objectCopy.num; i ++){
          
               if(objectCopy.objectComponent[i].exist){
                  if(objectCopy.objectComponent[i].objectBorder(cameraPosition) ){
                       return true;
                  }
               }
           
        }return false;
    
    
  }
  //更新
  void update(){
    //敵と当たっていればダメージを受ける
       if(damageFromEnemy()){
           hitPoint  -= 10;
           playerDamageEffect.play();
            playerDamageEffect.rewind();
       }
       //障害物と当たっていればダメージを受ける
       if(damageFromObject(render.getCameraPosition())){
           hitPoint -= 1;
       }
       
  }
  
}//クラス定義終了
//グローバル関数、マウスがクリックされると球が発射される
  void mouseClicked(){
    player.shoot();
    //弾丸の効果音
    bulletEffect.play();
    bulletEffect.rewind();
  }