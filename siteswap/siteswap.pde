//comentario de teste
//variaveis que podem ser alteradas para mudar o comportamento
float dbola=0.15;//diamentro da bolinha
float hmao=0.3;//distancia em metros da mão até o fim da janela
float mel=-0.15, mdl=0.15;//posição x de lançamento da mão esquerda e direita
float mer=-0.7,mdr=0.7;//posição x de recepção da mão esquerda e direita
float ritmo=0.4;//duração em segundos de 1 tempo
float g=-9.89;//aceleração da gravidade em m/s^2
float hold=0.7*ritmo;//tempo em segundos que a bolinha fica na mão (escrito em fração do ritimo)

float velocidade = 0.9;//Variável apra variar a velocidade de reprodução
int padrao[]={3};

float tempos_0[]={};
int Nbolas;
int bolas[]={};
char mao[]={};
int count;
boolean pronto = false;

float altura;//altura em metros que a altura da janela representará, isso definira toda a escala da animação este valor esta sendo calculado automaticamente na setup 
char periodicidade;

//int hi = height/6;
// int hf = (5*height)/6;
// int raiozinho = 40;
// int font_size = 32;

//void mouseClicked()
//{
// int i=0, j=0, px=0, py=0;
 
 
//   for(py=hi, i=0;i<4;py+=(hf-hi)/4, i++)
// {
//   for(px=0, j=0;j<4;px+=width/4,j++)
//   {
//     rect(px,py,width/4,(hf-hi)/4,raiozinho);
//   }
// }
//}

float metros2pixels(float metros)//conversão de ditancia linear de meltros para pixel
{
  return((height*metros)/altura);
}

float x(float xm)//conversão de posição x em metros a partitir do centro (+ para direita)para pixels
{
  return(metros2pixels(xm)+width/2);
}


float y(float ym)//conversão de posição y em metros a partir a linha das mãos (+ para cima) para pixels
{
  float y0;
  
  y0=height-metros2pixels(hmao);
  
  return(y0-metros2pixels(ym));
}

void ball(float tempo, float t0, char mao, int lancamento, int cor[])
{
  float tempo_voo;//tempo que a bolinha passará no ar
  float ml, mr;
 
  tempo_voo=lancamento*ritmo-hold;//tempo de voo é o ritimo vezes o lançamento menos o tempo que a bolinha passa na mão
  
  tempo=tempo-t0;
  
  fill(cor[0],cor[1],cor[2]);//cor da bolinha
  
  if(mao=='d')
  {
      ml=mdl;
      if(lancamento%2==0)
        mr=mdr;
      else
        mr=mer;
  }  
  else
  {
      ml=mel;
      if(lancamento%2==0)
        mr=mer;
      else
        mr=mdr;
  } 
  
  if (tempo>=0)
  {
    if (tempo<tempo_voo)
    {
      ellipse(x(ml+tempo*(mr-ml)/tempo_voo),y((g/2)*(tempo*tempo-tempo*tempo_voo)),metros2pixels(dbola),metros2pixels(dbola)); //(x, y, diametro x, diametro y)
    }
    else if(tempo<tempo_voo+hold)
    {
      tempo=tempo-tempo_voo;
      
      ml=mr;    
      if(ml==mdr) 
        mr=mdl;
      else
        mr=mel;
      
      ellipse(x(ml+tempo*(mr-ml)/hold),y(7*(tempo*tempo-tempo*hold)),metros2pixels(dbola),metros2pixels(dbola));
    }
  }  
}

float altura_calc(int N)//calcula a altura de um lançamento N (para N inpar >2)
{
  return(-g*(N*ritmo-hold)*(N*ritmo-hold))/8;//usei conservação de energia para descobrir a altura da bolinha jogada no numero N
  //onde N*ritmo-2*hold é o tempo de voo, -g pois preciso do módulo de g (que é negativo
}

void menu()//função onde será implementado um meno para saber qual o padrão e qual as cores da bolinha
{
  
}

void setup() 
{
  int i;
  int soma;
  int maior_lancamento=0;
  char aux;
  
  size(1000, 700);//tamnho da janela em pixels para o computador
  //size(screenWidth, screenHeight); //tamnho da janela para o iphone
  noStroke();//sem borda (seja lá o que isso signifique
  
  menu();
  
  for(i=0,soma=0;i<padrao.length;i++)
  {
    soma=soma+padrao[i];
    
    if(padrao[i]>maior_lancamento)
    {
      maior_lancamento=padrao[i];
    }
  }
  
  Nbolas=soma/padrao.length;

  altura = (altura_calc(maior_lancamento)+hmao+dbola/2)*1.1;//a;tura da bolinha + a distancia da mão ao fim da janela + o raio da bolinha + 10% para ficar visualmente mais agradevel
  
  if(padrao.length%2==0)
    periodicidade='p';
  else
    periodicidade='i';
  
    
  for(aux = 'd', count=0;count<Nbolas;count++)
  {
    bolas=append(bolas, padrao[count%padrao.length]);
    mao=append(mao, aux);
    if(aux=='d')
      aux = 'e';
    else
      aux = 'd';
      
    tempos_0=append(tempos_0,count*ritmo);
  }
}

void draw() 
{
  float tempo;
  int cor[]={255,0,0};
  
  int i;
  
  tempo=(millis()/1000.0)*velocidade;//convertendo o tempo apra segundos a adicionando velocidade de reprodução

  background(0);//fundo preto
  
  for(i=0;i<Nbolas;i++)
  {
    ball(tempo, tempos_0[i], mao[i], bolas[i], cor);
  }
  
  for(i=0;i<Nbolas;i++)
  {
    if(tempo>(tempos_0[i]+bolas[i]*ritmo))
    {
      tempos_0[i] = tempo;
      
      if(((mao[i] == 'd')&&(bolas[i]%2==0))||((mao[i] == 'e')&&(bolas[i]%2==1)))
        mao[i] = 'd';
      else
        mao[i] = 'e';
      
      bolas[i]=padrao[(count++)%padrao.length];
    }
  }
} 
