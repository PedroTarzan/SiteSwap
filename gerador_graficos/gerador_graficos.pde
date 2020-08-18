//variaveis de personalizaçao do usuario
float velocidade = 0.9;//Variável apra variar a velocidade de reprodução
int padrao[]={6,3,1,4,1};
int grafico=0;//qual o grafico que vai ser gerado.
int rep=3;//quantas vezes o padrao vai ser desenhado na tabela

//variaveis de uso do programa
int Nbolas;//quantas bolinhas sao nesessarias para o padrao
int Qbola[]={};//Controla qual bola está sendo lançada

/*Tarefa atual:
*/


void calc_pad()
{
  int i;
  int s=0;
  
  for(i=0;i<padrao.length;i++)
  {
    s=s+padrao[i];
  }
  Nbolas=s/padrao.length;
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
      println(Qbola[i]);
    }
  }
}

int colorR()
{
  return 0;
}
int colorG()
{
  return 0;
}
int colorB()
{
  return 0;
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
          stroke(colorR(),colorG(),colorB());
          curve(200, 50+45*j , 450, 50+45*j, 450, (50+45*j)+45*padrao[i], 200, (50+45*j)+45*padrao[i]);
        }
        else
        {
          stroke(colorR(),colorG(),colorB());
          line(450,50+45*j,550,(50+45*j)+45*padrao[i]);
        }
      }      
      else
      {                       
        if(padrao[i]%2==0)
        {
          noFill();
          stroke(colorR(),colorG(),colorB());
          curve(800, 50+45*j, 550, 50+45*j, 550, (50+45*j)+45*padrao[i], 800, (50+45*j)+45*padrao[i]);
        }
        else
        {
          stroke(colorR(),colorG(),colorB());
          line(550,50+45*j,450,(50+45*j)+45*padrao[i]);
        }
      }
      j++;
      Qbola_pos();
    }
    k++;
  }
}

void modelo(int gr)//Decide qual o modelo de tabela foi pedido, desenha a estrutura básica e chama a funcao dados"X"
{
  int i;
  
  background(255);
  if (gr==0)
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
  else if (gr==1)
  {
    //dados1();
  }
  else if (gr==2)
  {
    //dados2();
  }
  else
  {
    textSize(32);
    text("Escolha 0 para o grafico em colunas; ", 10, 30); 
    fill(0,0,0);
    textSize(32);
    text("Escolha 1 para o grafico de tabela;", 10, 80); 
    fill(0,0,0);    
  }
}

void setup()
{
  size(1000,900);
  noStroke();
  
  calc_pad();
  Qbola_init();
  
  //A partir daqui, essas funcoes devem estar da draw para poder desenhar as bolinhas se movimentando
  modelo(grafico);

  
}

void draw()
{

}
