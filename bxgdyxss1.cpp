#include<stdio.h>
#include<math.h>
int map[100][100]={0};///map[i][j]为0表示i, j两点之间不通，为1表示有一条路
int stack[120],v[100]={0},top=0,m,n,start,end;
void dfs(int pos)//从pos点开始访问
{
	int i;
	if(pos==end){//到达终点
		for(i=0;i<top;i++)
			printf("%d ",stack[i]);
		printf("%d\n",end);	
		return;
	}
	v[pos]=1;//标记被访问过 
	stack[top++]=pos;//经过的路径加入队列
	for(i=1;i<=n;i++){
		if(!v[i]&&map[pos][i])//如果这个点没有被访问过，而且b与这个点相连，就继续搜索
			dfs(i);
	}
	v[pos]=0;//删除标记 
	top--;//队列里删除b
}

int main()
{
    int i,x,y;
    printf("分别输入顶点数n和路径数m："); 
    scanf("%d %d",&n,&m);//n是顶点数，m是边数 
    
    printf("输入m条路径："); 
    for(i=1; i<=m; i++) {
        scanf("%d %d", &x,&y);
        map[x][y] = 1;//这两点之间有路径
		//map[y][x] = 1; //无向图加上这一句即可 
    }
    
    printf("输入起始点和终点：");
    scanf("%d %d", &start,&end);
    
    printf("\n程序执行结果为：\n"); 
    dfs(start);
    return 0;
    
}


//以文章计算为例，文章有5个节点，7条边
//为了方便计算顶点16变成1，17变成2，18变成3，19变成4，20变成5，边如下：
// 第1条：1 2   第2条：1 3 第3条：2 3 第4条3 2  第5条：2 4
//第6条：3 4  七条：4 5
//起点终点自行定义即可