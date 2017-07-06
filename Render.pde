class Render{
  
  private PVector cameraPosition;
  private PVector cameraCenter;
  private PVector preCameraPosition ;
  private PVector cameraUp;
  private PVector velocity;
  private float magVelocity;
  private float acc;
  //関数内で初期値も設定
  private float region = 1300.0f;

  //コンストラクタ
  Render(PVector _cameraPosition, PVector _cameraCenter, PVector _cameraUp,
        PVector _preCameraPosition, PVector _velocity, float _magVelocity, float _acc){
    cameraPosition = _cameraPosition;
    cameraCenter = _cameraCenter;
    cameraUp = _cameraUp;
    preCameraPosition = _preCameraPosition;
    velocity = _velocity;
    magVelocity = _magVelocity;
    acc = _acc;
  }
  //値を渡す
  PVector getCameraPosition(){
    return cameraPosition.copy();
  }
  
  PVector getCameraCenter(){
    return cameraCenter.copy();
  }
   PVector getPreCameraPosition(){
    return preCameraPosition.copy();
  }
  float getRegion(){
     return region;
  }
  //------------------------カメラ用関数-----------------------------------
  
  //カメラの移動、操作
  public void updateWalkthroughCamera(){ 
    
    moveCamera();
     moveBound(region);
     
    cameraPosition.x += velocity.x;
    cameraPosition.y += velocity.y;
    cameraPosition.z += velocity.z;
    
    /* カメラの角度の計算 */
     panAngle += (float)(mouseX - pmouseX) / 2.5f;
     tiltAngle += -(float)(mouseY - pmouseY) / 2.5f;
     //カメラ角度を制限
     if(tiltAngle < 90.1f){
         cameraUp.y = -5;
     }else if(269.9f > tiltAngle && tiltAngle > 90.0f){
       cameraUp.y = 5;
     }else if(tiltAngle > 269.9f){
         cameraUp.y = -5;
     }else if(tiltAngle < 270f){
       cameraUp.y = 5;
     }
     println(tiltAngle);
     
     cameraCenter.x = cos( radians(tiltAngle) ) * cos(radians(panAngle)) + cameraPosition.x;
     cameraCenter.y = sin(radians(tiltAngle)) + cameraPosition.y;
     cameraCenter.z = cos( radians(tiltAngle) ) * sin(radians(panAngle)) + cameraPosition.z; 
     camera(cameraPosition.x, cameraPosition.y, cameraPosition.z, cameraCenter.x, cameraCenter.y, cameraCenter.z, cameraUp.x, cameraUp.y, cameraUp.z);
     perspective(45.0, (float)width / (float)height, 10.0, 5000.0);
    
   
    
  }
  void moveCamera(){
      //1フレーム前のカメラの位置を保存
    preCameraPosition = cameraPosition.copy();
     //eとfでナナメ右前に進む
    if( inputter.getKeyState('e') &&  inputter.getKeyState('f')){
         velocity.x = -1*cos( radians(panAngle + 45.0f) ) * magVelocity*acc;
         velocity.y =  sin( radians(tiltAngle) ) * magVelocity * acc;
        velocity.z = -1*sin( radians(panAngle + 45.0f) ) * magVelocity*acc;
        return;
    }
    //eとsでナナメ左前に進む
    if(inputter.getKeyState('e') &&  inputter.getKeyState('s')){
          velocity.x = -1*cos( radians(panAngle - 45.0f) ) * magVelocity*acc;
          velocity.y =  sin( radians(tiltAngle) ) * magVelocity * acc;
          velocity.z = -1*sin( radians(panAngle - 45.0f) ) * magVelocity*acc;
          return;
    } 
    //eとaで鉛直ナナメ前に進む
    if(inputter.getKeyState('e') &&  inputter.getKeyState('a')){
        velocity.x = cos( radians(tiltAngle + 45.0f) ) * cos( radians(panAngle) ) * magVelocity*acc;
        velocity.y = sin( radians(tiltAngle + 45.0f) ) * magVelocity*acc;
        velocity.z = cos( radians(tiltAngle + 45.0f) )* sin( radians(panAngle) )* magVelocity*acc;
        return;
    }
     /* dで後ろに下がる */
    if ( inputter.getKeyState('d') ){
        velocity.x = cos( radians(panAngle) ) * magVelocity *acc;
        velocity.y = -1*sin( radians(tiltAngle) ) * magVelocity * acc;
        velocity.z = sin( radians(panAngle) ) *  magVelocity*acc;
        return;
    }
    /* eで前に進む */
     if ( inputter.getKeyState('e') ){
       velocity.x = -1*cos( radians(panAngle) ) *magVelocity*acc;
       velocity.y =  sin( radians(tiltAngle) ) * magVelocity * acc;
       velocity.z = -1*sin( radians(panAngle) ) * magVelocity*acc;
       return;
    }
    
    /* sで左に水平移動 */
    if (  inputter.getKeyState('s') ){
        velocity.x = cos( radians(panAngle + 90.0f) ) * magVelocity*acc; 
        velocity.y =  sin( radians(tiltAngle) ) * magVelocity * acc;
        velocity.z = sin( radians(panAngle + 90.0f) ) * magVelocity*acc;
        return;
     }
    /* fで右に水平移動 */
     if ( inputter.getKeyState('f')){
        velocity.x = -1*cos( radians(panAngle + 90.0f) ) * magVelocity*acc;
        velocity.y =  sin( radians(tiltAngle) ) * magVelocity * acc;
        velocity.z = -1*sin( radians(panAngle + 90.0f) ) * magVelocity*acc; 
        return;
      }
    /*aで真上に移動*/
    if(  inputter.getKeyState('a') ){
        velocity.x = cos( radians(tiltAngle + 90.0f) ) * cos( radians(panAngle) ) * magVelocity*acc;
        velocity.y = sin( radians(tiltAngle + 90.0f) ) * magVelocity*acc;
        velocity.z = cos( radians(tiltAngle + 90.0f) )* sin( radians(panAngle) )* magVelocity*acc;
        return;
    }
    /*gで真下に移動*/
    if(  inputter.getKeyState('g') ){
        velocity.x = -1*cos( radians(tiltAngle + 90.0f) ) * cos( radians(panAngle) ) * magVelocity*acc;
        velocity.y = -1*sin( radians(tiltAngle + 90.0f) ) * magVelocity*acc;
        velocity.z = -1*cos( radians(tiltAngle + 90.0f) )* sin( radians(panAngle) ) * magVelocity*acc;
        return;
    }
  }
    //地面超えたり、原点からのある距離を超えたら跳ね返る
    void moveBound(float region){
        if(cameraPosition.y > 5.0f){
            velocity.y *= -1;
        }
        if(PVector.dist(cameraPosition, v0) > region){
            velocity.mult(-1.0f);
        }
    }
    
   
  
  void accInflation(){
    if(keyPressed){
        acc += 0.01f;
    } 
   else{
        acc = 1.0f;
    }
  }
  //2Dカメラ関数
  public void update2DCamera(){
    
    camera(0.0f, 0.0f, 1000.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f);
    ortho(-width / 2.0f, width / 2.0f, -height / 2.0f, height / 2.0f, 10.0, 5000.0);
    
     
  
  }
  
  //-------------------描画用関数----------------------------
  
  void clear(){
      background(#11CCF0);
  }
  
  //XYZ軸を描画
  public void renderXYZAxis(){ 
  
      pushMatrix();
        beginShape(LINES); 
        vertex(-100.0f, 0.0f, 0.0f); 
        vertex(2000.0f, 0.0f, 0.0f);
        vertex(0.0f, -100.0f, 0.0f); 
        vertex(0.0f, 2000.0f, 0.0f);
        vertex(0.0f, 0.0f, -100.0f);
        vertex(0.0f, 0.0f, 2000.0f);
        endShape();
      popMatrix();  
    
  }
  //キャラクター描画用(球体)の関数
  public void renderSphere(  PVector position, PVector rotation,  float radius, color col){
          
      pushMatrix();
        fill(col);
        translate(position.x, position.y, position.z); 
        rotateZ(rotation.z);
        rotateY(rotation.y);
        rotateX(rotation.x);
        sphere(radius);
        fill(255);
      popMatrix();
      
  } // renderModel
  
  //オブジェクト描画用(立方体)の関数
  public void  renderCube( PVector position, PVector rotation,  float _length, color col){
    
      pushMatrix();
        fill(col, 100);
        translate(position.x, position.y, position.z); 
        rotateZ(rotation.z);
        rotateY(rotation.y);
        rotateX(rotation.x);
        box(_length);
        fill(255);
      popMatrix();
    
  }
  //地面を描画
  public void renderGround( ){
 
        textureMode(NORMAL);
       beginShape(QUADS);
         texture(ground);
         vertex(region, 0, region, 1.0f, 1.0f);
         vertex(-1*region, 0, region, 0.0f, 1.0f);
         vertex(-1*region, 0, -1*region, 0.0f, 0.0f);
         vertex(region, 0, -1*region, 1.0f,0.0f );
       endShape(CLOSE);
        
   
    
  }
  //海を描画
   public void renderSeas( ){
              
         textureMode(NORMAL);
         
       beginShape(QUADS);
         texture(wall01);
         vertex(region, -1*region , region, 0.0f, 0.0f);
         vertex(-1*region, -1*region, region, 1.0f, 0.0f);
         vertex(-1*region, 0.0f, region,1.0f,  1.0f);
         vertex(region, 0.0f, region, 0.0f,1.0f );
       endShape(CLOSE);
       beginShape(QUADS);
         texture(wall02);
         vertex(region, -1*region , -1*region, 0.0f, 0.0f);
         vertex(-1*region, -1*region,-1* region, 1.0f, 0.0f);
         vertex(-1*region, 0.0f, -1*region,1.0f,  1.0f);
         vertex(region, 0.0f,-1* region, 0.0f,1.0f );
       endShape(CLOSE);
       
       beginShape(QUADS);
         texture(wall03);
         vertex(region, -1*region , region, 0.0f, 0.0f);
         vertex(region, -1*region,-1* region, 1.0f, 0.0f);
         vertex(region, 0.0f, -1*region,1.0f,  1.0f);
         vertex(region, 0.0f, region, 0.0f,1.0f );
       endShape(CLOSE);
       
       beginShape(QUADS);
         texture(wall04);
         vertex(-1*region, -1*region , region, 0.0f, 0.0f);
         vertex(-1*region, -1*region,-1* region, 1.0f, 0.0f);
         vertex(-1*region, 0.0f, -1*region,1.0f,  1.0f);
         vertex(-1*region, 0.0f, region, 0.0f,1.0f );
       endShape(CLOSE);
       
         beginShape(QUADS);
         texture(celling );
         vertex(region, -1*region, region, 1.0f, 1.0f);
         vertex(-1*region, -1*region, region, 0.0f, 1.0f);
         vertex(-1*region, -1*region, -1*region, 0.0f, 0.0f);
         vertex(region, -1*region, -1*region, 1.0f,0.0f );
       endShape(CLOSE);
    
      
  } // renderModel
  //画面にゲーム情報を描写
  public void renderMarks(float col){
     //カメラをオルソーに
    render.update2DCamera();
    
    //カメラ方向に目印を描画
     pushMatrix();
       stroke(col, 50);
       translate(0.0f, 0.0f, 0.0f);
       line(100, 100, 0, -100, -100, 0);
       line(-100, 100, 0, 100, -100, 0);
       stroke(255);    
    popMatrix();
    //位置マップを描写
    pushMatrix();
       fill(col, 50);
       translate(300.0f, -350.0f, 0.0f);
       rectMode(CENTER);
       rect(0, 0, 200, 200);
       fill(255);    
    popMatrix();
    
     noStroke();
     //障害物の座標を描写
    pushMatrix();
       fill(#FA0824);
       translate(300.0f + cameraPosition.x/30.0f, -350.0f + cameraPosition.z/300.0f, 0.0f);
       ellipse(0, 0,  4.0f, 4.0f);
       fill(255);    
    popMatrix();
    
    object.renderPosition(300.0f, -350.0f);
    
    stroke(255);
    
    //敵の名前、体力を描画
    
      for(int i = 0; i < enemys.num; i ++){
        pushMatrix();
         translate(300.0f, -100.0f + 20*i , 0.0f);
         textSize(20.0f);
         fill(#010C12);
         text(enemys.name[i] +"    "+ enemys.gameCharacter[i].radius / 10,  0.0f, 0.0f);
         popMatrix();
         fill(255);
      }
      //自分の体力を画面右下に表示
      pushMatrix();
        translate(300.0f, 50.0f, 0.0f);
        textSize(90.0f);
        fill(#010C12);
        text(player.hitPoint, 0.0f, 0.0f);
        textSize(20.0f);
      popMatrix();
   
    
    }
 
 
}