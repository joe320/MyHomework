#include<iostream>
using namespace std;
typedef struct StackNode {
	int data;
	struct StackNode *next;
}StackNode,*LinkStack;

int InitStack(LinkStack &S) {
	S = NULL;
	return 1;
}
int Push(LinkStack &S, int e) {
	StackNode *p;
	p = new StackNode;
	p->data = e;
	p->next = S;
	S = p;
	return 1;
}
int Pop(LinkStack &S, int &e) {
	if (S == NULL)
		return 0;
	e = S->data;
	StackNode *p;
	p = S;
	S = S->next;
	delete p;
	return 1;
}
int GetTop(LinkStack S) {
	if (S != NULL)
		return S->data;
}
void TraveStack(LinkStack S) {
	StackNode *p;
	p = S;
	while (p) {
		cout << p->data << " ";
		p = p->next;
	}
	cout << endl;
}

int main() {
	LinkStack S;
	int n,e, x = 0, tmp;
	if (InitStack(S))
		cout << "链栈初始化成功！\n";
	else
		cout << "链栈初始化失败！\n";
	cout << "请输入栈的元素个数：";
	cin >> n;
	if (n >= 1) {
		for (int i = 0; i < n;) {
			cout << "请输入第" << ++i << "个入栈的元素:";
			cin >> e;
			Push(S, e);
		}
		for (; x != 1;) {
			cout << "\n当前栈中元素：";
			TraveStack(S);
			cout << "\n请选择您的操作:\n(1)入栈(2)出栈(3)查询栈顶(0)结束:";
			cin >> tmp;
			switch (tmp) {
			case 1: {
				cout << "请输入入栈元素：";
				cin >> e;
				Push(S, e);
				break;
			}
			case 2: {
				cout << "出栈元素：" << Pop(S, e);
				break;
			}
			case 3: {
				cout << "栈顶元素：" << GetTop(S);
				break;
			}
			case 0: {
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
