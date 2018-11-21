import java.util.Collections;

int cmtID,sizeBignode=50,marge,whight,Wwidth,YLine=330,XLine=600,space=40,Xellipse=320,Yellipse=500,Rayon=270;
ArrayList <Node> nodes,nodesBrut;
boolean drawArc,firstTime,AddArc, DelArc;
int idN1,IndexNodeClicked,teta;
double distance;
ArrayList <Float>Dist=new ArrayList<Float>();
PImage plus,minus,eraser;

void setup() {
  whight=650;
  Wwidth=1200;
  cmtID=0;  
  nodes=new ArrayList <Node>(); 
  nodesBrut=new ArrayList <Node>(); 
  firstTime=true; AddArc=true; DelArc=false;
  size(1200, 650);
  background(255);
  
  rect(1, 1,Wwidth-3, whight-3); 
  line(650, 1, 650,  whight-3);
  
  
    
  marge=(sizeBignode/2)+20;
  drawArc=false;
  
  loadPixels();
}


void draw() {
  fill(172,61,71);
  strokeWeight(1);
  rect(0,0,Wwidth,whight);
  rect(1, 1,Wwidth-3, whight-3); 
  stroke(1);
  fill(255,255,255);
  rect(650, 1,Wwidth-3, whight-3); 
  rect(650, whight-35,183, 33);
  rect(833, whight-35,183, 33);
  rect(1016, whight-35,183, 33);
    
  stroke(255);

  line(650, 1, 650,  whight-3);
  
  
  
  fill(0);
  textSize(15);
  text("Draw your graph here", 850, 15);
  text("Add Node or Arc", 660, whight-15);
  text("Delete node", 843, whight-15);
  text("New graph", 1036, whight-15);
  fill(255);
  
  plus=loadImage("plus.png");
  image(plus, 800, whight-33, 30, 30);
  
  minus=loadImage("delete.png");
  image(minus, 985, whight-33, 30, 30);
  
  eraser=loadImage("eraser.png");
  image(eraser, 1165, whight-33, 30, 30);
  stroke(255);
  //  Line graph not optimized
  line(30,YLine-160,600,YLine-160);
  
  //  Line graph
  line(30,YLine,600,YLine);
  stroke(255);
  //draw arcs
  for(int i=0;i<nodes.size();i++){    
    nodes.get(i).drawArc();
  }
  for(int i=0;i<nodesBrut.size();i++){
    nodesBrut.get(i).drawArcBrut(160);   
  }
  
  //strokeWeight(2);
  
  //  Line graph
  //draw arcs
  for(int i=0;i<nodes.size();i++){
    nodes.get(i).drawArc();
  }
  noFill();
  strokeWeight(2);
  //println((float)sin(radians(180)));
  ellipse(Xellipse, Yellipse, Rayon, Rayon); 
  if(nodes.size()!=0) teta=360/nodes.size();
  stroke(80);
  
  
   //draw nodes
  for(int i=0;i<nodes.size();i++){
    nodes.get(i).drawNode(sizeBignode);
  }
  
  if(drawArc){
    strokeWeight(3);
    if(distance<=23){stroke(80); line(nodes.get(idN1).getPosX(), nodes.get(idN1).getPosY(),mouseX,mouseY);stroke(255);}
  }else{
    strokeWeight(1);    
  }
  
  //cursor
  if(mouseX>=655 && mouseX<=830 && mouseY>=whight-35 && mouseY<=whight-3){//add node                
      cursor(HAND);
             
   }else{      
       if(mouseX>=830 && mouseX<=1015 && mouseY>=whight-35 && mouseY<=whight-3){//delete node           
            cursor(HAND);
           
         }else{             
             if(mouseX>=1017 && mouseX<=1195 && mouseY>=whight-35 && mouseY<=whight-3){//add node
               cursor(HAND);
   
             }else{
                 cursor(ARROW);
             }
         }
   }
   
   if(AddArc && mouseX>=650+marge && mouseX<=Wwidth-marge && mouseY>=marge && mouseY<=whight-marge-30){
     image(plus, mouseX-15, mouseY-15, 30, 30);
   }else{
     if(DelArc && mouseX>=650+marge && mouseX<=Wwidth-marge && mouseY>=marge && mouseY<=whight-marge-30){
       image(minus, mouseX, mouseY, 30, 30);
     }
   }
  
  //afficherArray();
  fill(255);
  textSize(14);
  text("NON-optimized line diagram ", 10, YLine-130);
  text("Optimized line diagram :", 10, YLine+30);
  text("Optimized circle diagram :", 10, YLine+290);
  
}

void mouseReleased(){
      Node n;
        if(mouseX>=650+marge && mouseX<=Wwidth-marge && mouseY>=marge && mouseY<=whight-marge-30){//dessiner dans le graph                     
                              
          if(!drawArc){
            
              distance=nodeExiste(mouseX,mouseY);//detecter une colusion entre les noeuds
              
              if(distance>=50){//pas de colision avec les noeuds
                if(AddArc){//add node
                  n=new Node(mouseX,mouseY);
                  nodes.add(n); 
                  nodesBrut.add(new Node(n));
                  Dist.add(n.getDist());
                  Clustering();
                }
                
              }else{
                
                if(DelArc){
                  for(int i=0;i<nodes.size();i++){
                    nodes.get(i).removeNeighbor(IndexNodeClicked);                       
                  }
                  
                  int idx1;
                  idx1=getIdByName(nodes.get(IndexNodeClicked).getname());
                  for(int i=0;i<nodesBrut.size();i++){
                    nodesBrut.get(i).removeNeighbor(idx1);                       
                  }
                  nodesBrut.remove(idx1);
                  nodes.remove(IndexNodeClicked);
                  Dist.remove(IndexNodeClicked);
                  for(int i=0;i<nodesBrut.size();i++){
                      nodesBrut.get(i).setId(i);                                    
                  }
                  Clustering();
                }else{
                  idN1=IndexNodeClicked;
                  drawArc=true;                  
                }
                
              }    
              
          }else{
              distance=nodeExiste(mouseX,mouseY);//detecter une colusion entre les noeuds
            
              if(distance<=23 && idN1!=IndexNodeClicked){// colision avec un noeud
                 
                 nodes.get(idN1).addNeighbor(nodes.get(IndexNodeClicked));
                 nodes.get(IndexNodeClicked).addNeighbor(nodes.get(idN1));
                 
                 int idx1,indx2;
                 idx1=getIdByName(nodes.get(idN1).getname());
                 indx2=getIdByName(nodes.get(IndexNodeClicked).getname());
                 nodesBrut.get(idx1).addNeighbor(nodesBrut.get(indx2));
                 nodesBrut.get(indx2).addNeighbor(nodesBrut.get(idx1));
                 
                 Clustering();

              }
              
              drawArc=false;
              
          }
          
        }else{
             if(mouseX>=655 && mouseX<=830 && mouseY>=whight-35 && mouseY<=whight-3){//add node
                 AddArc=true;
                 DelArc=false;
             
             }else{
                
                 if(mouseX>=830 && mouseX<=1015 && mouseY>=whight-35 && mouseY<=whight-3){//delete node
                     DelArc=true;
                     AddArc=false;
                     
                   }else{
                       DelArc=false;
                       if(mouseX>=1017 && mouseX<=1195 && mouseY>=whight-35 && mouseY<=whight-3){//add node
                         nodes.clear();
                         nodesBrut.clear();
                         Dist.clear();
                         cmtID=0;
                       }else{
                           
                       }
                   }
             }
        
        }
}



void Clustering(){ 
  boolean stop=false;
  int cpt=0;
  println("****** Debut ******");
  afficherArray();
  while(!stop){
    println("appele numero "+cpt);
    cpt++;
      for(int i=0;i<nodes.size();i++){
        nodes.get(i).distance();                                    
      }
      
      Collections.sort(nodes);
      
      for(int i=0;i<nodes.size();i++){
        nodes.get(i).setId(i);                                    
      }
      
      
      boolean result=sameDist();
      println("Compare "+result);
      if(!result){
        SaveNewDist();            
      }else{
        stop=true;
      }
        
      
  }
  afficherArray();
  
}

boolean sameDist(){  
   if(nodes.size()!=Dist.size()) return false;
   
   for(int i=0;i<Dist.size();i++){
     /*println("compare "+i+" : "+Dist.get(i)+" and "+nodes.get(i).getDist());
     println("result "+i+" : "+(Dist.get(i).equals(nodes.get(i).getDist())));*/
    if(!Dist.get(i).equals(nodes.get(i).getDist())) return false;
  }
  return true;
}

void SaveNewDist(){
  Dist=new ArrayList<Float>();
  for(int i=0;i<nodes.size();i++){
    Dist.add(nodes.get(i).getDist());
  }
    
}

double nodeExiste(int x,int y){
  double mindist=50;
  IndexNodeClicked=-1;
  
  for(int i=0;i<nodes.size();i++){   
      //println("distance "+nodes.get(i).distance(x,y));    
     if(nodes.get(i).distance(x,y)<mindist){   
       //println("Colusion avec : "+nodes.get(i).getId()); 
        mindist=nodes.get(i).distance(x,y);
        IndexNodeClicked=i;
     }
   
  }
  
  return mindist;
}

void afficherArray(){
  for(int i=0;i<nodes.size();i++){   
    println("[ id :"+nodes.get(i).getname()+", Dist :"+nodes.get(i).getDist());  
      
  }
  println("---------------------------------------------------------------------------------------------------------------------------------");
}

public int getIdByName(int name){
    for(int i=0;i<nodesBrut.size();i++){   
     if(name==nodesBrut.get(i).getname()) return  i;
    }
  return -1;
}
