//variaveis de personalizaçao do usuario
//float velocidade = 0.9;//Variável apra variar a velocidade de reprodução.
int padrao[]={7,4,4};
int grafico=0;//qual o grafico que vai ser gerado.
int rep=0;//quantas vezes o padrao vai ser desenhado na tabela

//variaveis de uso do programa
int Nbolas;//quantas bolinhas sao nesessarias para o padrao
int Hthrow=0;//Highest throw
int Qbola[]={};//Controla qual bola está sendo lançada
int contagem;//Diz a última bola que foi lançada
float paleta_cores[][];
float R[]={},G[]={},B[]={};//Vetores para guardar as cores de cada bolinha (cor da bolinha 0 = R[0], G[0] e B[0])

/*Tarefa atual:
Escrever os outros tipos de grafico;
opcao 1
{
  Qbola pre
  loop para imprimir a letra "X" numa ccordenada x+45*Qbola[i](ou algo parecido) //Como colocar as cores certas?
  Qbola pos
}
opcao 2 //vou tentar essa primeiro
{
  Qbola pre
  variavel temporaria para salvar o numero no Qbola[i]
  loop que imrime a letra "X" na cor indicada pela contagem, mudando as coordenadas x e y, e reduz a variavel temporaria
  Qbola pos
}
Tarefa secundaria
Desenhar as bolinhas coloridas; +
Cor definida automaticamente; - Até 5 bolinhas. E acho que com 5 bolas está errado, mas funciona
Gerar as cores automaticamente
*/


void calc_pad()//Define Nbolas
{
  int i;
  int s=0;
  
  for(i=0;i<padrao.length;i++)
  {
    s=s+padrao[i];
  }
  Nbolas=s/padrao.length;

  for(i=0;i<padrao.length;i++)
  {
    if(padrao[i]>Hthrow)
    Hthrow=padrao[i];
  }
}

void Qbola_init() //Faz o tamanho de Qbola ser=Nbolas e coloca um 0 em todas as posiçoes
{
  int i;
  for(i=0;i<Nbolas;i++)
  {
    Qbola=append(Qbola,0);
  }
}

void Qbola_pre(int l) //Checa qual é a primeira posiçao que contém um 0 e transforma ela no lançamento atual
{
  int i;
  for(i=0;i<Nbolas;i++)
  {
    if(Qbola[i]==0)
    {
      Qbola[i]=l;
      contagem=i;
      break;
    }
  }
}

void Qbola_pos() //reduz em 1 cada posicao de Qbola até um minimo de 0
{
  int i;
  for(i=0;i<Nbolas;i++)
  {
    if(Qbola[i]>0)
    {
      Qbola[i]--;
    }
  }
}

void paleta_cores_init()
{
  if(Nbolas==1)
  {
    R=append(R,255*1);
    G=append(G,255*0);
    B=append(B,255*0);
  }
  else if(Nbolas==2)
  {
    R=append(R,255*1);
    G=append(G,255*0);
    B=append(B,255*0);
    
    R=append(R,255*0);
    G=append(G,255*0.5);
    B=append(B,255*0.5); 
  }
  else if(Nbolas==3)
  {
    R=append(R,255*1);
    G=append(G,255*0);
    B=append(B,255*0);
    
    R=append(R,255*0);
    G=append(G,255*1);
    B=append(B,255*0);
    
    R=append(R,255*0);
    G=append(G,255*0);
    B=append(B,255*1);
  }
  else if(Nbolas==4)
  {
    R=append(R,255*1);
    G=append(G,255*0);
    B=append(B,255*0);
    
    R=append(R,255*0);
    G=append(G,255*0.5);
    B=append(B,255*0.5);
    
    R=append(R,255*0.3);
    G=append(G,255*0.6);
    B=append(B,255*0);
    
    R=append(R,255*0.3);
    G=append(G,255*0);
    B=append(B,255*0.6);
  }
  else if(Nbolas==5)
  {
    R=append(R,255*1);
    G=append(G,255*0);
    B=append(B,255*0);
    
    R=append(R,255*0);
    G=append(G,255*0.6);
    B=append(B,255*0.3);
    
    R=append(R,255*0);
    G=append(G,255*0.3);
    B=append(B,255*0.6);
    
    R=append(R,255*0.5);
    G=append(G,255*0);
    B=append(B,255*0.6);
    
    R=append(R,255*0.5);
    G=append(G,255*0.6);
    B=append(B,255*0);
  }  
}

void dados0()//É chamada pela modelo() e desenha as linhas dos lançamentos de cada bolinha
{
  int i;
  int j=0,k=0;
  
  while(k<rep)
  {
    for(i=0;i<padrao.length;i++)
    {
      Qbola_pre(padrao[i]);
      if(j%2==0)
      {
        if(padrao[i]%2==0)
        {
          noFill();
          stroke(R[contagem],G[contagem],B[contagem]);
          curve(200, 50+45*j , 450, 50+45*j, 450, (50+45*j)+45*padrao[i], 200, (50+45*j)+45*padrao[i]);
        }
        else
        {
          stroke(R[contagem],G[contagem],B[contagem]);
          line(450,50+45*j,550,(50+45*j)+45*padrao[i]);
        }
      }      
      else
      {                       
        if(padrao[i]%2==0)
        {
          noFill();
          stroke(R[contagem],G[contagem],B[contagem]);
          curve(800, 50+45*j, 550, 50+45*j, 550, (50+45*j)+45*padrao[i], 800, (50+45*j)+45*padrao[i]);
        }
        else
        {
          stroke(R[contagem],G[contagem],B[contagem]);
          line(550,50+45*j,450,(50+45*j)+45*padrao[i]);
        }
      }
      j++;
      Qbola_pos();
    }
    k++;
  }
}

void dados1()
{
  int i,j,k;
  int l=0;
  int Qbola_controle;
  
  for(k=0;k<rep;k++)
  {
    for(i=0;i<padrao.length;i++)
    {
      Qbola_pre(padrao[i]);
      Qbola_controle=Qbola[contagem];
      
      for(j=0;j<Qbola_controle;j++)
      {
        textSize(32);
        fill(R[contagem],G[contagem],B[contagem]);
        text('X',68+(Qbola_controle-j)*45,85+45*j+45*l);
      }
      
      l++;
      Qbola_pos();
    }
  }
}

void modelo()//Decide qual o modelo de tabela foi pedido, desenha a estrutura básica e chama a funcao dados"X"
{
  int i;
  int j=0,k=0;
  int max;
  
  background(255);
  if (grafico==0)
  {
    stroke(0);
    line(450,50,450,860);
    stroke(0);
    line(550,50,550,860);      
    
    for(i=0;i<20;i++)
    {
      line(445,50+45*i,455,50+45*i);
      line(545,50+45*i,555,50+45*i);
    } 
    dados0();
  }
  else if (grafico==1)
  {
    for(i=0;i<Hthrow+1;i++) //draw the vertical lines
    {
      stroke(0);
      line(100+45*i,50,100+45*i,860);
    }
    
    max=100+45*(i-1);
    for(i=0;i<20;i++)//draw the horizontal lines
    {
      line(50,50+45*i,max,50+45*i);
    } 
    
    while(k<rep)//write the pattern numbers
    {
      for(i=0;i<padrao.length;i++)
      {
        Qbola_pre(padrao[i]);
        
        textSize(32);
        fill(R[contagem],G[contagem],B[contagem]);
        text(padrao[i],50,85+45*j);
        
        j++;
        Qbola_pos();
      }
      k++;
    }
    
    for(i=0;i<Nbolas;i++)//reset Qbola
    {
      if(Qbola[i]>0)
      {
        Qbola[i]=0;
      }
    }
    dados1();
  }
  else if (grafico==2)
  {
    //dados2();
  }
  else
  {
    textSize(32);
    fill(0,0,0);
    text("grafico=0 para o grafico em colunas; ", 10, 30); 
    
    fill(0,0,0);
    text("grafico=1 para o grafico de tabela;", 10, 80);    
    
    fill(0,0,0);
    text("grafico=2 para o grafico em linha;", 10, 130);
  }
}

void setup()
{
  size(1000,900);
  noStroke();
  
  calc_pad();
  
  if(rep==0)
  rep=Hthrow;
  
  Qbola_init();
  paleta_cores_init();
  
  
  //A partir daqui, essas funcoes devem estar da draw para poder desenhar as bolinhas se movimentando
  modelo();
 
  noStroke(); //to roubando
  fill(255,255,255);
  rect(0, 865, 1000, 900);

  
}

void draw()
{

}

//e se as cores forem definidas com um loop binario?
//0,1,10,11,100,101,110,111,1000,1001,1010,1100,
//0,1,2,10,11,12,20,21,22,100,101,102,110,111,
