float bx,by,rx,ry,bw,bh,rw,rh,sbx,sby,pbx,pby;
int gamestatus=0;
int score;
wall[] warray;
void setup(){
  size(400,600);
  background(255);
  score=0;
  start();
}

void draw(){
  //switch(gamestatus){
  //  case 0:
  //    break;
  //  case 1:
  //    game();
  //    break;
  //}
  game();
 
}

void gamesettting(){
   for(int i=0;i<warray.length;i++){
    warray[i].wallwr();
  }
  fill(255,0,0);
  ellipse(bx,by,bw,bh);
}

void start(){
  bx=width/2;
  by=350;
  bw=10;
  bh=10;
  rx=width/2;
  ry=550;
  rw=50;
  rh=20;
  sbx=-4;
  sby=5;
  warray= new wall[25];
  for(int i=0;i<warray.length;i++){
    warray[i]=new wall((i%5)*80,(i/5)*32,i);
  }
}
void game(){
  pbx=bx;
  pby=by;
  background(255);
  fill(0);
  text("score:"+score,0,580);
  ship();
  bullet();
  for(int i=0;i<warray.length;i++){
    warray[i].wallwr();
    warray[i].wallbr();
  }
  reset();
}

void ship(){
  //移動
  rx=min(mouseX,width-rw/2); 
 if(mouseX<0)rx=0;
  fill(0);
  rectMode(CENTER);
  rect(rx,ry,rw,rh);
  rectMode(CORNER);
}

void bullet(){
  fill(255,0,0);
  bx+=sbx;
  by+=sby;
  shiptouch();
  sidetouch();
  ellipse(bx,by,bw,bh);
}
      //shipとの当たり判定
void shiptouch(){
 if((bx>=rx-rw/2) && (bx<=rx+rw/2)&&(by>ry-rh/2)&&(by<ry+rh/2)){
     sby*=-1;
 }
}
    //側面との接触
void sidetouch(){
  //横面
  if((bx<0) || (bx>width) ){
    sbx*=-1;
  }
  //天井
  if(by<0){
    sby*=-1;
  }
}

void reset(){
  if(keyPressed && key==' '){
    for(int i=0;i<warray.length;i++){
      warray[i].ws=1;
    }
  }
 }
  
//ブロック関連
public class wall{
  private float wx,wy;
  private float cr=0;
  private float cb=0;
  private float cg=0;
  private float ww=80;
  private float wh=34;
  private int i;
  private int ws=1;
  public wall(float wx,float wy,int i){
      this.wx=wx;
      this.wy=wy;
      this.i=i%5;
      switch(this.i){
       case 1:
         cr=255;
         break;
       case 2:
         cr=255;
         cg=255;
         break;
       case 3:
         cg=255;
         break; 
       case 4:
         cg=255;
         cb=255;
         break;
       case 5:
         cb=255;
         break;
       case 0:
         cb=255;
         cr=255;
         break;
      };
    }
    
  public void wallwr(){
   if(ws==1){
    fill(cr,cg,cb);
    rect(wx,wy,ww,wh);
   }
  }
  public void wallbr(){
    if(bx>wx && bx<wx+ww && by>wy && by<wy+wh && ws==1){
      score+=10;
      ws=0;
      if(pbx>wx && pbx<wx+ww){
        sby*=-1;
      }else if(pby>wy && pby<wy+wh){
        sbx*=-1;
      }else{
        sbx*=-1;
        sby*=-1;
      }
    }
  }
}
