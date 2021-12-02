#include<iostream>
using namespace std;
#define MAXVEX 100
#define INFINITY 65536
int vis[MAXVEX];
typedef struct {
	int vex[MAXVEX];
	int arc[MAXVEX][MAXVEX];
	int numVEX, numEdge;
}MGraph;
typedef struct {
	int data[MAXVEX];
	int front, rear;
}Queue;
void init_queue(Queue* Q) {
	Q->front = Q->rear = 0;
}
void push(Queue* Q, int e) {
	if ((Q->rear + 1) % MAXVEX == Q->front)
		return;
	Q->data[Q->rear] = e;
	Q->rear = (Q->rear + 1) % MAXVEX;
}
bool IsEmpty(Queue* Q) {
	if (Q->front == Q->rear)
		return true;
	else
		return false;
}
void pop(Queue* Q,int* e) {
	if (Q->front == Q->rear)
		return;
	*e = Q->data[Q->front];
	Q->front = (Q->front + 1) % MAXVEX;
}
void create_graph(MGraph* G) {
	cin >> G->numVEX >> G->numEdge;
	cout << "接下来" << G->numEdge << "行每行分别输入两个整数a b表示a到b连边:\n";
	for (int i = 0; i < G->numVEX; i++)
		G->vex[i] = i + 1;
	for (int i = 0; i < G->numVEX; i++)
		for (int j = 0; j < G->numVEX; j++)
			G->arc[i][j] = INFINITY;
	for (int i, j, k = 0; k < G->numEdge; k++) {
		cin >> i >> j;
		G->arc[i - 1][j - 1] = 1;
		G->arc[j - 1][i - 1] = G->arc[i - 1][j - 1];
	}
}
void DFSR(MGraph* G, int i, Queue* tmp1) {
	vis[i] = true;
	push(tmp1, G->vex[i]);
	for (int j = 0; j < G->numVEX; j++)
		if (G->arc[i][j] != INFINITY && !vis[j])
			DFSR(G, j, tmp1);
}
void DFS(MGraph* G) {
	Queue tmp1;
	init_queue(&tmp1);
	for (int i = 0; i < G->numVEX; i++)
		vis[i] = false;
	for (int i = 0; i < G->numVEX; i++)
		if (!vis[i])
			DFSR(G, i, &tmp1);
	for (int i = 0; i < G->numVEX - 1; i++) {
		int out;
		pop(&tmp1, &out);
		cout << out << " ";
	}
	int out;
	pop(&tmp1, &out);
	cout << out << endl;
}
void BFS(MGraph* G) {
	Queue Q;
	init_queue(&Q);
	Queue tmp2;
	init_queue(&tmp2);
	for (int i = 0; i < G->numVEX; i++)
		vis[i] = false;
	for(int i=0;i<G->numVEX;i++)
		if (!vis[i]) {
			vis[i] = true;
			push(&tmp2, G->vex[i]);
			push(&Q, i);
			while (!IsEmpty(&Q)) {
				pop(&Q, &i);
				for(int j=0;j<G->numVEX;j++)
					if (!vis[j] && G->arc[i][j] != INFINITY) {
						vis[j] = true;
						push(&tmp2, G->vex[j]);
						push(&Q, j);
					}
			}
		}
	for (int i = 0; i < G->numVEX - 1; i++) {
		int out;
		pop(&tmp2, &out);
		cout << out << " ";
	}
	int out;
	pop(&tmp2, &out);
	cout << out << endl;
}
int main() {
	int flag, x = 0;
	MGraph G;
	cout << "请输入顶点数和边数：";
	create_graph(&G);
	for (; x != 1;) {
		cout << "请选择：(1)DFS(2)BFS(0)退出:";
		cin >> flag;
		switch (flag) {
		case 1: {
			DFS(&G);
			cout << endl;
			break;
		}
		case 2: {
			BFS(&G);
			cout << endl;
			break;
		}
		case 0: {
			x = 1;
			break;
		}
		default: {
			cout << "非法输入！" << endl;
			break;
		}
		}
	}
	return 0;
}
