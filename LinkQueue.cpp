#include<iostream>
#include<cstdlib>
#include<cassert>
using namespace std;
typedef struct Node {
	int data;
	Node *next;
}*NodePtr;
typedef struct LinkQueue {
	NodePtr front;
	NodePtr rear;
}*LinkQueuePtr;

static NodePtr Apply_Node(int val) {
	NodePtr s = (NodePtr)malloc(sizeof(Node));
	assert(s != NULL);
	s->data = val;
	s->next = NULL;
	return s;
}
int IsEmpty(LinkQueuePtr queue) {
	assert(queue != NULL);
	if (queue == NULL) {
		cout << "IsEmpty is error!\n";
		exit(0);
	}
	if (queue->front == NULL)
		return true;
	return false;
}
int InitLinkQueue(LinkQueuePtr queue) {
	assert(queue != NULL);
	if (queue == NULL) {
		cout << "Init is error!\n";
		exit(0);
	}
	queue->front = queue->rear = NULL;
	return true;
}
int Push(LinkQueuePtr queue, int val) {
	assert(queue != NULL);
	if (queue == NULL) {
		cout << "Push is error!\n";
		exit(0);
	}
	NodePtr s = Apply_Node(val);
	if (IsEmpty(queue)) {
		queue->front = s;
		queue->rear = s;
	}
	else {
		queue->rear->next = s;
		queue->rear = s;
	}
	return true;
}
int Pop(LinkQueuePtr queue) {
	assert(queue != NULL);
	if (queue == NULL) {
		cout << "Pop is error!\n";
		exit(0);
	}
	if (IsEmpty(queue))
		return false;
	NodePtr s = queue->front;
	queue->front = s->next;
	free(s);
	return true;
}
int GetHead(LinkQueuePtr queue) {
	assert(queue != NULL);
	if (queue == NULL) {
		cout << "GetHead is error!\n";
		exit(0);
	}
	if (IsEmpty(queue))
		return false;
	else
		return queue->front->data;
}
int DestroyLinkQueue(LinkQueuePtr queue) {
	assert(queue != NULL);
	if (queue == NULL) {
		cout << "Destroy is error!\n";
		exit(0);
	}
	if (IsEmpty(queue))
		return false;
	else {
		while (queue->front->next != NULL) {
			Pop(queue);
		}
		queue->front = queue->rear = NULL;
		return true;
	}
}
void DisplayQueue(LinkQueuePtr queue) {
	NodePtr p = queue->front;
	cout << "当前队列元素为:";
	while (p != NULL) {
		cout << p->data << " ";
		p = p->next;
	}
	if (queue->front == queue->rear)
		cout << "队列为空";
}
int main() {
	LinkQueue queue;
	InitLinkQueue(&queue);
	int N, e, x = 0, tmp;
	cout << "请输入队中元素个数：";
	cin >> N;
	if (N >= 1) {
		cout << "请输入队中元素：";
		for (int i = 0; i < N; i++) {
			cin >> e;
			Push(&queue, e);
		}
		for (; x != 1;) {
			DisplayQueue(&queue);
			cout << "\n请选择您的操作:\n(1)入队(2)出队(3)查询队头(0)结束:";
			cin >> tmp;
			switch (tmp) {
			case 1: {
				cout << "请输入入队元素：";
				cin >> e;
				Push(&queue, e);
				break;
			}
			case 2: {
				cout << "出队元素：" << Pop(&queue);
				break;
			}
			case 3: {
				cout << "队顶元素：" << GetHead(&queue);
				break;
			}
			case 0: {
				DestroyLinkQueue(&queue);
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
