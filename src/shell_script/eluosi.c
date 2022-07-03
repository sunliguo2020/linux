#include<dos.h> 
#include<stdlib.h> 
#include<conio.h> 
#include<graphics.h> 
#include<stdio.h> 
#include<bios.h> 

#define LEFT 0x4b 
#define RIGHT 0x4d 
#define DOWN 0x50 
#define CHANGE 0x20 
#define ESC 0x1b 
#define INTR 0x1C 
#define DefaultX 5 
#define DefaultY 1 
#ifdef __cplusplus 
#define __CPPARGS ... 
#else 
#define __CPPARGS 
#endif 

static unsigned counter=0; 
static unsigned shape[7][4][4][4]={ 
{ 
{{0,1,1,0},{0,1,1,0},{0,0,0,0},{0,0,0,0}}, 
{{0,1,1,0},{0,1,1,0},{0,0,0,0},{0,0,0,0}}, 
{{0,1,1,0},{0,1,1,0},{0,0,0,0},{0,0,0,0}}, 
{{0,1,1,0},{0,1,1,0},{0,0,0,0},{0,0,0,0}}, 
}, 
{ 
{{0,0,0,0},{1,1,1,1},{0,0,0,0},{0,0,0,0}}, 
{{0,0,1,0},{0,0,1,0},{0,0,1,0},{0,0,1,0}}, 
{{0,0,0,0},{1,1,1,1},{0,0,0,0},{0,0,0,0}}, 
{{0,0,1,0},{0,0,1,0},{0,0,1,0},{0,0,1,0}}, 
}, 
{ 
{{0,1,0,0},{1,1,1,0},{0,0,0,0},{0,0,0,0}}, 
{{0,1,0,0},{0,1,1,0},{0,1,0,0},{0,0,0,0}}, 
{{0,0,0,0},{1,1,1,0},{0,1,0,0},{0,0,0,0}}, 
{{0,1,0,0},{1,1,0,0},{0,1,0,0},{0,0,0,0}}, 
}, 
{ 
{{1,0,0,0},{1,1,0,0},{0,1,0,0},{0,0,0,0}}, 
{{0,0,0,0},{0,1,1,0},{1,1,0,0},{0,0,0,0}}, 
{{1,0,0,0},{1,1,0,0},{0,1,0,0},{0,0,0,0}}, 
{{0,0,0,0},{0,1,1,0},{1,1,0,0},{0,0,0,0}}, 
}, 
{ 
{{0,1,0,0},{1,1,0,0},{1,0,0,0},{0,0,0,0}}, 
{{0,0,0,0},{1,1,0,0},{0,1,1,0},{0,0,0,0}}, 
{{0,1,0,0},{1,1,0,0},{1,0,0,0},{0,0,0,0}}, 
{{0,0,0,0},{1,1,0,0},{0,1,1,0},{0,0,0,0}}, 
}, 
{ 
{{1,0,0,0},{1,0,0,0},{1,1,0,0},{0,0,0,0}}, 
{{0,0,0,0},{1,1,1,0},{1,0,0,0},{0,0,0,0}}, 
{{1,1,0,0},{0,1,0,0},{0,1,0,0},{0,0,0,0}}, 
{{0,0,0,0},{0,0,1,0},{1,1,1,0},{0,0,0,0}}, 
}, 
{ 
{{0,1,0,0},{0,1,0,0},{1,1,0,0},{0,0,0,0}}, 
{{0,0,0,0},{1,0,0,0},{1,1,1,0},{0,0,0,0}}, 
{{1,1,0,0},{1,0,0,0},{1,0,0,0},{0,0,0,0}}, 
{{0,0,0,0},{1,1,1,0},{0,0,1,0},{0,0,0,0}}, 
}, 
}; 

unsigned back[22][14]={{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,0,0,0,0,0,0,0,0,0,0,1,1}, 
{1,1,1,1,1,1,1,1,1,1,1,1,1,1}, 
{1,1,1,1,1,1,1,1,1,1,1,1,1,1}}; 

char ShapeColor[7]={8,10,11,12,13,14,15}; 
char DigitalShape[10]={128+119,3,62,31,128+75,128+93,128+125,19,128+127,128+95}; 
char ZodiacBack[11]={4,6,12,13,11,10,2,3,9,1,8}; 
char ZodiacSoft[18][14]={{0,0,0,0,96,0,0,0,0,0,0,0,60,0}, 
{255,248,0,0,96,0,0,0,0,248,0,0,124,0}, 
{255,248,0,0,97,128,0,0,3,248,0,0,192,0}, 
{0,112,0,0,97,128,0,0,7,0,0,1,128,48}, 
{0,224,0,0,96,0,0,0,14,0,0,1,128,48}, 
{1,192,0,0,96,0,0,0,12,0,0,1,128,48}, 
{3,128,120,15,97,128,240,60,12,0,15,15,249,255}, 
{7,0,252,31,225,131,248,127,14,0,31,143,249,255}, 
{7,1,142,48,225,135,24,227,7,240,49,193,128,48}, 
{14,3,134,96,97,142,24,192,3,252,112,193,128,48}, 
{28,3,6,96,97,140,25,192,0,28,96,193,128,48}, 
{56,3,6,96,97,140,25,128,0,6,96,193,128,48}, 
{56,3,6,96,97,140,25,128,0,6,96,193,128,48}, 
{120,3,6,96,97,140,25,128,0,6,96,193,128,48}, 
{224,1,140,48,225,142,25,195,24,14,49,129,128,48}, 
{255,249,252,63,225,135,252,255,28,28,63,129,128,48}, 
{255,248,240,15,97,131,236,60,15,248,30,1,128,48}, 
{0,0,0,0,0,0,0,0,7,224,0,1,128,0}}; 

unsigned long TotalMark=0; 
unsigned int Erasered=0,ETimes=0; 
int Speed=0; 
int CEr=0; 
int NumOfLev[5]={0,0,0,0,0}; 
int TimeDelay[10]={21,18,17,15,13,11,9,7,5,3}; 
char NewShape[2]; 
unsigned PerOnce[4]; 

void interrupt ( *oldhandler)(__CPPARGS); 
void interrupt handler(__CPPARGS) 
{ 
++counter; 
oldhandler(); 
} 

void DrawBackground() 
{ 
//setlinestyle 
} 
void DrawDigital(int x,int y,int a) 
{ 
int i=7; 
setcolor(((DigitalShape[a]>>i)&1)*7+4); 
//printf("%d",(DigitalShape[a]>>i)&1); 
i--; 
line(x,y+1,x,y+15); 
line(x+1,y+2,x+1,y+14); 
line(x+2,y+3,x+2,y+13); 
setcolor(((DigitalShape[a]>>i)&1)*7+4); 
i--; 
line(x,y+17,x,y+31); 
line(x+1,y+18,x+1,y+30); 
line(x+2,y+19,x+2,y+29); 
setcolor(((DigitalShape[a]>>i)&1)*7+4); 
i--; 
line(x,y+17,x,y+31); 
line(x+1,y+18,x+1,y+30); 
line(x+2,y+19,x+2,y+29); 
setcolor(((DigitalShape[a]>>i)&1)*7+4); 
i--; 
line(x+1,y,x+16,y); 
line(x+2,y+1,x+15,y+1); 
line(x+3,y+2,x+14,y+2); 
setcolor(((DigitalShape[a]>>i)&1)*7+4); 
i--; 
line(x+2,y+15,x+15,y+15); 
line(x+1,y+16,x+16,y+16); 
line(x+2,y+17,x+15,y+17); 
setcolor(((DigitalShape[a]>>i)&1)*7+4); 
i--; 
line(x+3,y+30,x+14,y+30); 
line(x+2,y+31,x+15,y+31); 
line(x+1,y+32,x+16,y+32); 
setcolor(((DigitalShape[a]>>i)&1)*7+4); 
i--; 
line(x+15,y+3,x+15,y+13); 
line(x+16,y+2,x+16,y+14); 
line(x+17,y+1,x+17,y+15); 
setcolor(((DigitalShape[a]>>i)&1)*7+4); 
line(x+15,y+19,x+15,y+29); 
line(x+16,y+18,x+16,y+30); 
line(x+17,y+17,x+17,y+31); 
} 

void ArtClear() 
{ 
for(int i=480;i>=0;i-=2) 
{ 
setcolor(3); 
line(0,i-6,639,i-6); 
setcolor(9); 
line(0,i-4,639,i-4); 
setcolor(1); 
line(0,i-2,639,i-2); 
setcolor(getbkcolor()); 
line(0,i,639,i); 
delay(1); 
} 
for(i=1;i<480;i+=2) 
{ 
setcolor(3); 
line(0,i+6,639,i+6); 
setcolor(9); 
line(0,i+4,639,i+4); 
setcolor(1); 
line(0,i+2,639,i+2); 
setcolor(getbkcolor()); 
line(0,i,639,i); 
delay(1); 
} 
} 

void end() 
{ 
for(int j=0;j<4;j++) 
{ 
for(int i=j;i<480;i+=4) 
{ 
setcolor(3); 
line(0,i+8,639,i+8); 
setcolor(9); 
line(0,i+4,639,i+4); 
setcolor(1); 
line(0,i,639,i); 
setcolor(getbkcolor()); 
line(0,i,639,i); 
delay(1); 
} 
delay(5); 
} 
setcolor(YELLOW); 
outtextxy(260,200,"[ Game Over ]"); 
gotoxy(14,16); 
printf("This freeware is written by Daniel.Qu ZodiacSoft 2000"); 
gotoxy(12,17); 
printf("Please e-mail to swami@yeah.net or visit my homepage at"); 
gotoxy(12,18); 
printf("http://grocery.2699.com if you have question."); 
gotoxy(14,20); 
printf("I will soon provide something new,please wait..."); 
gotoxy(14,22); 
printf("We hold these truths to be self-evident,that all codes"); 
gotoxy(12,23); 
printf("are created FREE."); 
getch(); 
clrscr(); 
closegraph(); 
exit(0); 
} 

void ShowTitle() 
{ 
int gdriver=DETECT,gmode,errorcode,i,j,k; 
initgraph(&gdriver,&gmode,""); 
errorcode=graphresult(); 
if (errorcode!=grOk) 
{ 
printf("Graphics error: %s\n\007",grapherrormsg(errorcode)); 
exit(1); 
} 
setbkcolor(9);//This line needs to be changed 
for(i=0;i<11;i++) 
{ 
setcolor(ZodiacBack[i]); 
line(200,i*8+100,440,i*8+100); 
} 
delay(1000); 
for(j=0;j<17;j++) 
for(i=0;i<11;i++) 
{ 
setcolor(ZodiacBack[(i+j)%16]); 
line(200,i*8+100,440,i*8+100); 
delay(4); 
} 
for(j=0;j<18;j++) 
{ 
for(i=0;i<14;i++) 
{ 
for(k=7;k>=0;k--) 
if((ZodiacSoft[j][i]>>k)&1) 
{ 
putpixel(i*8-k+271,j+122,14); 
} 
} 
delay(10); 
} 
for(j=17;j>=0;j--) 
{ 
for(i=0;i<14;i++) 
for(k=7;k>=0;k--) 
{ 
if((ZodiacSoft[j][i]>>k)&1) 
putpixel(i*8-k+271,158-j,5); 
} 
delay(10); 
} 
setcolor(15); 
outtextxy(295,171,"Present"); 
getch(); 
ArtClear(); 
} 

void DrawShape(int x,int y,int color) 
{ 
//if(x<2||x>12||y>19) 
// return; 
setcolor(color); 
/*line(x<<4,y<<4,x<<4,(y<<4)+14); 
line(x<<4,(y<<4)+14,(x<<4)+14,(y<<4)+14); 
line((x<<4)+14,(y<<4)+14,(x<<4)+14,y*16); 
line((x<<4)+14,y<<4,x<<4,y*16); 
line((x<<4)+1,y<<4,(x<<4)+1,(y<<4)+14); 
line((x<<4)+1,(y<<4)+13,(x<<4)+14,(y<<4)+13); 
line((x<<4)+13,(y<<4)+13,(x<<4)+13,(y<<4)+1); 
line((x<<4)+13,(y<<4)+1,x<<4,(y<<4)+1); */ 
for(int i=0;i<15;i++) 
line(x<<4,(y<<4)+i,(x<<4)+14,(y<<4)+i); 
setcolor(8); 
line((x<<4)+15,(y<<4)+1,(x<<4)+15,(y<<4)+15); 
line((x<<4)+1,(y<<4)+15,(x<<4)+15,(y<<4)+15); 
setcolor(color-8); 
line((x<<4)+2,(y<<4)+2,(x<<4)+12,(y<<4)+2); 
line((x<<4)+2,(y<<4)+2,(x<<4)+2,(y<<4)+12); 
} 

void DrawNull(int x,int y) 
{ 
setcolor(getbkcolor()); 
for(int i=0;i<16;i++) 
line(x<<4,(y<<4)+i,(x<<4)+15,(y<<4)+i); 
} 

void show(int x,int y,int CurrentShape,int Status) 
{ 
int temp; 
for(int i=0;i<20;i++) 
for(int j=2;j<12;j++) 
{ 
if(back[i][j]==1) 
DrawShape(6+j,4+i,8); 
else 
DrawNull(6+j,4+i); 
} //no matter what the status be,I will draw the background 
for(int l=0;l<4;l++) 
for(int p=0;p<4;p++) 
{ 
if(l+x<2||x+l>11||p+y>19) 
continue; 
//if(shape[CurrentShape][Status][p][l]+back[y+p][x+l]==1) 
// DrawShape(3+l+x,3+p+y,8+CurrentShape); 
//else 
//cout<<'O'; 
// DrawNull(3+j,3+i); 
if(shape[CurrentShape][Status][p][l]==1) 
DrawShape(6+l+x,4+p+y,ShapeColor[CurrentShape]); 
if(back[y+p][x+l]==1) 
DrawShape(6+l+x,4+p+y,8); 
} 
} 
void DrawScore() 
{ 
int temp=TotalMark; 
for(int i=0;i<7;i++) 
{ 
DrawDigital(477-i*20,65,temp%10); 
temp/=10; 
} 
temp=Erasered; 
for(i=0;i<4;i++) 
{ 
DrawDigital(491-i*20,111,temp%10); 
temp/=10; 
} 
if(Erasered==0) 
return; 
for(i=1;i<5;i++) 
{ 
setfillstyle(1,8); 
bar(378,163+i*14,508,170+i*14); 
setfillstyle(1,5); 
bar(378,163+i*14,378+130*NumOfLev[i]/ETimes,170+i*14); 
} 
DrawDigital(466,293,Speed); 
return; 
} 

int CreateNewShape() 
{ 
NewShape[1]=NewShape[0]; 
NewShape[0]=rand()%7; 
setfillstyle(1,0); 
bar(447,240,514,288); 
for(int l=0;l<4;l++) 
for(int p=0;p<4;p++) 
if(shape[NewShape[0]][0][p][l]==1) 
DrawShape(28+l,15+p,ShapeColor[7]); 
return NewShape[1]; 
} 

int Possible(int x,int y,int CurrentShape,int Status) 
{ 
for(int i=0;i<4;i++) 
{ 
for(int j=0;j<4;j++) 
{ 
if(shape[CurrentShape][Status][i][j]+back[y+i][x+j]==2) 
//this line can also write as the following type: 
//if(shape[CurrentShape][Status][i][j]&&back[y+i][x+j]) 
return 0; 
} 
} 
return 1; 
} 

void GoLeft(int&x,int&y,int&CurrentShape,int&Status) 
{ 
if(Possible(x-1,y,CurrentShape,Status)) 
x--; 
show(x,y,CurrentShape,Status); 
} 

void GoRight(int&x,int&y,int&CurrentShape,int&Status) 
{ 
if(Possible(x+1,y,CurrentShape,Status)) 
x++; 
show(x,y,CurrentShape,Status); 
} 

void GoDown(int&x,int&y,int&CurrentShape,int&Status) 
{ 
int AllAreOne=1,temp=0; 
if(Possible(x,y+1,CurrentShape,Status)) 
{ 
y++; 
show(x,y,CurrentShape,Status); 
return; 
} 
TotalMark+=3*CurrentShape; 
for(int i=0;i<4;i++) 
for(int j=0;j<4;j++) 
back[i+y][j+x]+=shape[CurrentShape][Status][i][j]; 
for(int r=1;r<20;r++) 
{ 
for(int l=2;l<13;l++) 
{ 
if(back[r][l]==0) 
AllAreOne=0; 
} 
if(AllAreOne==1) 
{ 
for(int rr=r;rr>0;rr--) 
for(int ll=2;ll<13;ll++) 
back[rr][ll]=back[rr-1][ll]; 
Erasered++; 
CEr++; 
temp++; 
} 
AllAreOne=1; 
} 
CurrentShape=CreateNewShape(); 
x=DefaultX;y=DefaultY;Status=0; 
NumOfLev[temp]++; 
TotalMark+=5*temp; 
show(x,y,CurrentShape,Status); 
counter=0; 
if(!Possible(x,y,CurrentShape,Status)) 
{ 
getch(); 
end(); 
} 
if(CEr>=30) 
{ 
Speed=(Speed+1)%10; 
CEr/=30; 
} 
if(temp) 
ETimes++; 
DrawScore(); 
return; 
} 

void ChageShape(int&x,int&y,int&CurrentShape,int&Status) 
{ 
if(Possible(x,y,CurrentShape,(Status+1)%4)) 
Status=(Status+1)%4; 
show(x,y,CurrentShape,Status); 
} 

void DrawFace() 
{ 
int temp; 
setcolor(15); 
line(351,59,519,59); 
line(351,60,518,60); 
line(351,59,351,156); 
line(352,59,352,155); 
setcolor(7); 
line(518,61,518,154); 
line(519,60,519,154); 
line(353,155,519,155); 
line(352,156,519,156); 
setcolor(8); 
for(int i=61;i<155;i++) 
line(353,i,517,i); 
setcolor(7); 
line(427,106,512,106); 
line(428,107,511,107); 
line(427,106,427,147); 
line(428,106,428,146); 
setcolor(15); 
line(512,106,512,147); 
line(511,107,511,146); 
line(428,146,511,146); 
line(427,147,512,147); 
settextstyle(DEFAULT_FONT,HORIZ_DIR,1); 
setcolor(14); 
outtextxy(357,119,"Erasered"); 
outtextxy(370,130,"Level:"); 
setcolor(15); 
line(352,167,519,167); 
line(352,168,518,168); 
line(352,169,352,407); 
line(353,169,353,406); 
setcolor(7); 
line(519,167,519,407); 
line(518,168,518,406); 
line(352,407,519,407); 
line(353,406,519,406); 
line(524,55,89,55); //outter border 1st 
line(524,55,524,411); 
line(89,411,524,411); 
line(89,55,89,411); 
line(524,56,89,56); //outter border 2nd 
line(525,55,525,411); 
line(89,410,524,410); 
line(88,55,88,411); 
setfillstyle(8,7); 
bar(94,59,336,406); 
//setfillstyle(1,3); 
//bar(128,78,296,386); 
for(i=0;i<8;i++) 
DrawDigital(357+i*20,65,0); 
for(i=0;i<4;i++) 
DrawDigital(431+i*20,111,0); 
setfillstyle(1,8); 
setcolor(12); 
for(i=0;i<4;i++) 
{ 
temp=i+'1'; 
outtextxy(364,177+14*i,(char*)&temp); 
bar(378,177+i*14,508,184+i*14); 
} 
setcolor(14); 
outtextxy(366,250,"Next Shape"); 
setcolor(10); 
outtextxy(366,294,"Current"); 
outtextxy(382,309,"Level"); 
setcolor(6); 
outtextxy(366,334,"Message:"); 
bar(362,348,509,398); 
DrawDigital(466,293,Speed); 
} 

void WannaQuit() 
{ 
int choise=0,temp; 
setfillstyle(1,8); 
bar(362,348,509,398); 
setcolor(15); 
outtextxy(378,355,"Are you sure to"); 
outtextxy(368,368,"quit game?"); 
outtextxy(410,388,"Yes"); 
outtextxy(470,388,"No"); 
setcolor(14); 
circle(399,392,4); 
while((temp=bioskey(0))!=7181) 
{ 
if(temp==19200) 
{ 
setcolor(8); 
circle(459,392,4); 
choise=0; 
setcolor(14); 
circle(399,392,4); 
} 
if(temp==19712) 
{ 
setcolor(8); 
circle(399,392,4); 
choise=1; 
setcolor(14); 
circle(459,392,4); 
} 
} 
if(choise==0) 
{ 
end(); 
} 
setfillstyle(1,8); 
bar(362,348,509,398); 
return; 
} 

void main() 
{ 
ShowTitle(); 
unsigned c; 
int CurrentShape,x=6,y=0,Status=0; 
oldhandler=getvect(INTR); 
setvect(INTR,handler); 
randomize(); 
NewShape[0]=rand()%7; 
DrawFace(); 
CurrentShape=CreateNewShape(); 
show(x,y,CurrentShape,Status); 
while(1) 
{ 
if(kbhit()) 
{ 
c=getch(); 
if(c==0) 
c=getch(); 
switch(c) 
{ 
case 's' :Speed=(Speed+1)%10;DrawDigital(466,293,Speed);break; 
case DOWN :GoDown(x,y,CurrentShape,Status);break; 
case LEFT :GoLeft(x,y,CurrentShape,Status);break; 
case RIGHT :GoRight(x,y,CurrentShape,Status);break; 
case CHANGE :ChageShape(x,y,CurrentShape,Status);break; 
case ESC :WannaQuit(); 
} 
} 
if((counter%=TimeDelay[Speed])==(TimeDelay[Speed]-1)) 
{ 
GoDown(x,y,CurrentShape,Status); 
counter=0; 
} 
} 
}
