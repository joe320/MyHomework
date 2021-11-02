#include<iostream>
#include<cstdlib>
using namespace std;
typedef struct queue {
	int data[200];
	int front;
	int rear;
	int maxsize;
}queue;

queue * InitQueue() {
	queue *q;
	q = (queue*)malloc(sizeof(queue));
	if (q == NULL)
		return NULL;
	q->rear = q->front = 0;
	q->maxsize = 200;
	return q;
}
void DestroyQueue(queue *q) {
	free(q);
	q = NULL;
}
void ClearQueue(queue *q) {
	q->rear = q->front = 0;
}
bool IsEmpty(queue *q) {
	return q->front == q->rear ? true : false;
}
bool IsFull(queue *q) {
	return (q->rear + 1) % q->maxsize == q->front ? true : false;
}
int LengthQueue(queue *q) {
	return (q->rear + q->maxsize - q->front) % q->maxsize;
}
void Push(queue *q, int e) {
	if (IsFull(q))
		cout << "队列已满，无法入队！\n";
	else {
		q->data[q->rear] = e;
		q->rear = (q->rear + 1) % q->maxsize;
	}
}
int Pop(queue *q) {
	if (IsEmpty(q)) {
		cout << "队列为空，无法出队！\n";
		return -0x7f;
	}
	else {
		int e = q->data[q->front];
		q->front = (q->front + 1) % q->maxsize;
		return e;
	}
}
void DisplayQueue(queue *q) {
	if (q->front == q->rear)
		cout << "\n当前队列为空！";
	else {
		int flag = 0;
		cout << "\n当前队列元素为：";
		while (q->front != q->rear) {
			cout << q->data[q->front]<<" ";
			q->front++;
			flag++;
		}
		for (; flag != 0;flag--) {
			q->front--;
		}
	}
}
int main() {
	int N, e, x = 0, tmp;
	cout << "请输入队的元素个数：";
	cin >> N;
	if (N>=1) {
		queue *q;
		q = InitQueue();
		cout << "请输入入队元素：";
		for (int i = 0; i < N; i++) {
			cin >> e;
			Push(q, e);
		}
		for (; x != 1;) {
			DisplayQueue(q);
			cout << "\n请选择您的操作:\n(1)入队(2)出队(0)结束:";
			cin >> tmp;
			switch (tmp) {
				case 1: {
					cout << "请输入入队元素：";
					cin >> e;
					Push(q, e);
					break;
				}
				case 2: {
					cout << "出队元素：" << Pop(q);
					break;
				}
				case 0: {
					DestroyQueue(q);
					x = 1;
					break;
				}
				default: {
					cout << "非法输入！";
					break;
				}
			}
		}
	}
	else
		cout << "非法输入！";
	return 0;
}
