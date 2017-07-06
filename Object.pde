class Object{
  
  
    int num = 10;
    float objectSize = 250;
   
    ObjectComponent[] objectComponent = new ObjectComponent[num];
    
    //コンストラクタで初期化
    Object(){
      
       for(int i =0; i <  num; i ++){
           
             
                  objectComponent[i] = new ObjectComponent(new PVector(-1*objectSize * num / 2 + objectSize*i , -objectSize , -1*objectSize * num / 2 + objectSize*i) ,
                        new PVector(-1*objectSize * num / 2 + objectSize*i , 0, -1*objectSize * num / 2 + objectSize*i) ,
                          new PVector(random(10) - random(10) , random(10) - random(10), random(10) - random(10)) ,  new PVector(0.0, 0.0, 0.0), objectSize, #FF0320 );
                  
           
       }
       
    }
    //描画関数
    void render(){
        for(int i = 0; i < num; i ++){
          
               if(objectComponent[i].exist){
                   objectComponent[i].render();
               }
           
        }
    }
    void move(float region){
          for(int i = 0; i < num; i ++){
           
               if(objectComponent[i].exist){
                   objectComponent[i].move(region - 100*i);
               }
           
        }
    }
    void renderPosition(float rectCenterX, float rectCenterY){
      
       for(int i = 0; i < num; i ++){
           
               if(objectComponent[i].exist){
                 
                   pushMatrix();
                      fill(#080DFA);
                      translate(rectCenterX + objectComponent[i].position.x / 30 ,rectCenterY + objectComponent[i].position.z / 30 , 0 );
                      ellipse(0, 0, 2, 2);
                      fill(255);
                   popMatrix();
                   
               }
           
        }
      
    }
    
  
}