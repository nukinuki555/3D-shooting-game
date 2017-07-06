
class Inputter{

  boolean[] keyState;    // キーの状態を入れる配列。indexはASCIIコード(7bitまで)を想定

  Inputter(){  
    keyState = new boolean[127];
    for (int i = 0; i < 127; i++){
      keyState[i] = false;
    }
  }
  
  /* キー状態の取得用関数 */
  public boolean getKeyState(int code){
    if ( key > 0 && key < 127 ){
      return keyState[code];
    }else{
      return false;
    }
  }
}
Inputter inputter = new Inputter();

/* キーが押された場合、keyをindexにした配列keyStateをtrueにする */
void keyPressed(){
  if ( key > 0 && key < 127 ){
    inputter.keyState[key] = true;     
  }
}

/* 同じく離された場合、falseにする */
void keyReleased(){
  if ( key > 0 && key < 127 ){
    inputter.keyState[key] = false;  
  }
}