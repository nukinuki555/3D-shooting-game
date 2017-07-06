class Bullet{
    
   PVector position;
   PVector prePosition;
   PVector velocity;
   PVector cameraVec;
   boolean exists = false;
   float radius;
   color col;
   
   Bullet(){
     position = new PVector();
     
   }
   
   Bullet(PVector _position, PVector _velocity, PVector _cameraVec,  float _radius, color _col){//コンストラクタ
     position = _position;
     velocity = _velocity;
     cameraVec = _cameraVec;
     radius = _radius;
     col = _col;
   }
   //弾が存在していれば描画関数を呼び出し
   void render(PVector _position){
       if(exists){
           noStroke();
           render.renderSphere(_position,  v0, 1.0f, #DB0B43); 
           stroke(255);
       }
   }
   
   void create(PVector playerPosition){
     exists = true;
     position = playerPosition.copy();
     velocity = PVector.mult(PVector.sub(render.getCameraCenter() , render.getCameraPosition()), 20) ;
   }
   
   void updateMove(){
     prePosition = position.copy();
     if(exists){
       //保存したカメラベクトル方向に弾を動かす
       position.add(velocity);
       velocity.y += 0.006f;
       velocity.mult(0.9998);
     }
     if(position.mag() > 2000 ){
       exists = false;
     }
     
   }
    
    //当たり判定
    public boolean isHit(PVector objPos, float objSize){
        if(exists){
            if(objSize - PVector.dist(position, objPos) > 0){
              exists = false;
              return true;
             } else {
                    float temp = PVector.dot(velocity, PVector.sub(objPos, prePosition))/ pow(PVector.dist(position, prePosition), 2);
                    //println(temp);
                    if(0 <= temp && temp <= 1){
                          PVector nearestPos = new PVector();
                          nearestPos.set(PVector.add(prePosition, PVector.mult(PVector.sub(position, prePosition), temp))); 
                          if(objSize - PVector.dist(nearestPos, objPos) > 0){
                             exists = false;
                             return true;
                           }
                     }
             }
        }return false;
      
     }
     //試作、当たり判定
     public boolean isTest(PVector objPos , float objSize){
           if(PVector.dist(position, objPos) < objSize){
                 exists = false;
                 return true;
           }
           return false;
     }
  
  
}