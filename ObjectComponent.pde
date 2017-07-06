//障害物の性質情報をまとめる
class ObjectComponent{
    
    PVector startPosition;
    PVector position;
    PVector velocity;
    PVector rotation;
    float size;
    color col;
    boolean exist = true;
    float error = 15.0f;
    
   
    
    //コンストラクタ
    ObjectComponent(PVector _startPosition , PVector _position, PVector _velocity, PVector _rotation, float _size, color _col){
       
       startPosition = _startPosition;
       position = _position;
       velocity = _velocity;
       rotation = _rotation;
       size = _size;
       col = _col;
      
    }
    //コンストラクタ
    ObjectComponent(){
      
    }
    
    //描画
    void render(){
      
       render.renderCube(position, rotation, size, col);
       
    }
    //動かす
    void move(float region){
       
        position.add(velocity);
       if(PVector.dist(position, startPosition) > region){
            velocity.mult(-1);
       }
       if(position.y > 0){
           velocity.y *= -1;
       }
    }
    //当たり判定(障害物内部に入ろうとしたら、位置座標をその手前に戻す)
    boolean objectBorder(PVector v ){
         if((position.x + size/2  > v.x)&&(position.x - size/2  < v.x)&&(position.z + size/2   > v.z)&&(position.z - size/2  < v.z)
            &&((position.y + size/2   > v.y)&&(position.y - size/2  < v.y))){
               return true;
         }return false;
    }
    //値を渡す
    PVector getPosition(){
         return position;
    }
    
     
     
}