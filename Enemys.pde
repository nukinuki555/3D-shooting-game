class Enemys{
     
     float regionX = 100;
     float regionY = 100;
     float regionZ = 100;
     PVector angle = new PVector(2.0f, 2.0f, 2.0f);
     
     //キャラクターはエネミークラスが持つ
     int num = 4;
     String[] name = new String[num];
     GameCharacter[] gameCharacter  = new GameCharacter[num];
     Enemys(){
        gameCharacter[0] = new GameCharacter(new PVector(600, -99, 60), new PVector(600, -99, 60),
              new PVector(300.0, 270.0, 0.0), new PVector(0.0, 0.0, 0.0),1,  10, 100.0f, #10C685);
        gameCharacter[1] = new GameCharacter(new PVector(-240, -400, 300), new PVector(-240, -400, 300),
              new PVector(400.0, 0.0, 220.0), new PVector(0.0, 0.0, 0.0),2,  10, 150.0f, #9B133C );
        gameCharacter[2] = new GameCharacter(new PVector(-400, -300, 1600), new PVector(-400, -300, 1600),
              new PVector(0.0, 508.0, -311.0), new PVector(0.0, 0.0, 0.0),3,  10, 70.0f, #14139B ); 
        gameCharacter[3] = new GameCharacter(new PVector(400, -1100, -1600), new PVector(400, -1300, -1600),
              new PVector(0.0, 0.0, 0.0), new PVector(4.0, 9.0, 10.0),4,  10, 470.0f, #CE450F);
        for(int i = 0; i < num; i ++){
            name[i]  = new String();
            name[i] = "teki" +(i+1);
        }
        
     }//コンストラクタ
     
     //敵を全て球として描画
     void render(){
         for(int i = 0; i < num; i ++){
             gameCharacter[i].render();
         }
     }
     void move(){
          for(int i = 0; i < num; i ++){
             gameCharacter[i].moveRevolution(500.0f + 100*i);
         }
     }
     //更新
     void update(){
         for(int i = 0; i < num; i ++){
             gameCharacter[i].update();
         }
     }
   
         
    
    
  
     
}