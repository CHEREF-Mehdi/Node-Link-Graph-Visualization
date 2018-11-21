public class Node implements Comparable <Node>{
  
  private int Posx,Posy,id,name; 
  private int R,G,B;
  private Float Dist;
  private ArrayList <Node> neighbors;
  
  public Node(int x,int y){          
     id=cmtID; name=cmtID; Posx=x; Posy=y;      
     R=randomRGB(); G=randomRGB(); B=randomRGB();         
     neighbors= new ArrayList <Node>();
     cmtID++;  
     distance();
     //Collections.sort(nodes);
  }//end node
  
  public Node(Node n){          
     id=nodesBrut.size(); name=cmtID-1; Posx=n.Posx; Posy=n.Posy;      
     R=n.R; G=n.G; B=n.B;         
     neighbors= new ArrayList <Node>();               
  }//end node
  
  public int getPosX(){ return Posx;}
  public int getPosY(){ return Posy;}
  public int getId(){ return id;}
  public int getname(){ return name+1;}
  public Float getDist(){ return Dist;}
  public ArrayList <Node> getNeighbors(){ return neighbors;}
  
  
  public void setId(int newid){ id=newid;}
  
  public int compareTo(Node N) {     
    if(this.Dist - N.Dist >0)  return 1;
    if(this.Dist - N.Dist <0)  return -1;
    return 0;
  } 
  
  public double distance(int x,int y){
    return dist(Posx,Posy,x,y);
  }
  
  public void drawNode(int w){   
    int x=Xellipse;
    int y=Yellipse;
    stroke(0);
    fill(R,G,B);  
    ellipse(Posx, Posy, w, w); 
    stroke(255);
    
    //line graph
    ellipse(XLine-20-id*space, YLine, 20, 20); 
    
    float agl=TWO_PI/nodes.size();
    x=(int)controlePoint(agl,0,0);
    y=(int)controlePoint(agl,1,0);
    
    arc(x, y, 20, 20,0,2*PI); 
   
   
    fill(255);
    textSize(15);
    text(name+1, Posx-5, Posy+4);
    textSize(10);   
    text(name+1, XLine-20-id*space-5, YLine+4);
    text(name+1, x-5, y+4);
  
    
    fill(1);  
    stroke(255);
    //strokeWeight(1);
  }
  
  public void drawArc(){
    //line graph not optimized    
    int lineDistance;
    
    strokeWeight(2.5);

    for(int k=0;k<neighbors.size();k++){
      stroke(80);
      //REAL GRAPH
       line(Posx,Posy,nodes.get(neighbors.get(k).getId()).Posx,nodes.get(neighbors.get(k).getId()).Posy);
       stroke(255);
       
       if(id<neighbors.get(k).getId()){
         //Line GRAPH
         
         //println("line arc entre : "+id+" et "+neighbors.get(k).getId()); 
          lineDistance=(neighbors.get(k).getId()-id)*space;
         //println("line arc Point : "+(XLine-20-lineDistance/2)+" largeur "+lineDistance); 
          noFill();      
          arc(XLine-20-neighbors.get(k).getId()*space+lineDistance/2, YLine, lineDistance, (neighbors.get(k).getId()-id)*30, -2*PI/2, 0);
         
          //circle graph
          drawBezierArc(neighbors.get(k));
       }      
     
      
    }
    strokeWeight(1);
    
    
  }
  
   public void drawArcBrut(int marge){
    int lineDistance;
     
      strokeWeight(2.5);
    for(int k=0;k<neighbors.size();k++){
      
       if(id<neighbors.get(k).getId()){
         //Line GRAPH
         
         //println("line arc entre : "+id+" et "+neighbors.get(k).getId()); 
         lineDistance=(neighbors.get(k).getId()-id)*space;
         //println("line arc Point : "+(XLine-20-lineDistance/2)+" largeur "+lineDistance); 
          noFill();      
          arc(XLine-20-neighbors.get(k).getId()*space+lineDistance/2, YLine-marge, lineDistance, (neighbors.get(k).getId()-id)*20, -2*PI/2, 0);
                   
       }           
      
    }
    
    fill(R,G,B);
    ellipse(XLine-20-id*space, YLine-marge, 20, 20); 
    fill(255);
    textSize(10);
    text(name+1, XLine-20-id*space-5, YLine+4-marge);
    strokeWeight(1);
        
  }
  
  public void drawBezierArc(Node N){
    float[] controlP1,controlP2;
     
     controlP1=getControlePoint(30);
     controlP2=N.getControlePoint(30); 
     
     bezier(controlP2[0],controlP2[1],controlP2[2],controlP2[3],controlP1[2],controlP1[3],controlP1[0],controlP1[1]);
  }
  
  public float[] getControlePoint(float curve){
    float[] controlP=new float[4];         
    float agl=TWO_PI/nodes.size();
    
    controlP[0]=controlePoint(agl,0,0);
    controlP[1]=controlePoint(agl,1,0);
    controlP[2]=controlePoint(agl,0,curve);
    controlP[3]=controlePoint(agl,1,curve);
    
    return controlP;
  }
  
  public float controlePoint(float angel,int sin_cos,float curve){
      if(sin_cos==0) return Xellipse+ cos(id*angel)*(Rayon/2-curve);
      else return Yellipse+ sin(id*angel)*(Rayon/2-curve);
  }
  
  public int posEllipse(int x){
   
    if(x==1) return (int)(Xellipse+(Rayon/2*cos(radians(teta*id))));
    else return (int)(Yellipse-(Rayon/2*sin(radians(teta*id))));
  }
  
  public int randomRGB(){
    return (int)Math.floor(Math.random()*200);
  }
  
  public boolean addNeighbor(Node i){
    if(!NotNeighbor(i.getId())) {
      neighbors.add(i); 
      return true;
      //println("naighbor "+i.getId()+" is added successfully to "+id);
    }
    return false;
  }
  
  public void removeNeighbor(int id){
      for(int k=0;k<neighbors.size();k++){
        if(neighbors.get(k).getId()==id) {neighbors.remove(k); return;}
      }
  }
  
  public boolean NotNeighbor(int i){
    for(int k=0;k<neighbors.size();k++){
      if(neighbors.get(k).getId()==i) {/*println(i+" and "+(id-1)+" are naighbors");*/ return true;}
    }
    //println(i+" and "+(id-1)+" are not naighbors");
    return false;
    
  }
  
  public void distance(){
    Dist=(float)id;            
    for(int j=0;j<neighbors.size();j++) Dist+= neighbors.get(j).id;
    if(neighbors.size()!=0)Dist=Dist/(neighbors.size()+1); 
    else Dist=100.0*(id+1);
    //println("id : "+id+" nbr conn " +neighbors.size()+" dist : "+Dist);
    
  }
  
  
  
}