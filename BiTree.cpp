#include<stack>
#include<iostream>
#include<cstdlib>
using namespace std;
int len;
typedef struct BiTNode {
	int data;
	struct BiTNode *lChild, *rChild;
}BiTNode,*BiTree;
typedef struct Node {
	BiTree btnode;
	bool isfirst;
}Node,*node;
void SearchTreeNode(BiTree &root, BiTree &s) {
	if (root == NULL)
		return;
	if (s->data > root->data) {
		if (root->rChild == NULL) {
			root->rChild = s;
			return;
		}
		SearchTreeNode(root->rChild, s);
	}
	else if (s->data < root->data) {
		if (root->lChild == NULL) {
			root->lChild = s;
			return;
		}
		SearchTreeNode(root->lChild, s);
	}
}
void InsertNode(BiTree &tree, BiTree &s) {
	if (tree == NULL)
		tree = s;
	else
		SearchTreeNode(tree, s);
}
void CreateBiTree(BiTree &tree,int *a) {
	for (int i = 0; i < len; i++) {
		BiTree s = (BiTree)malloc(sizeof(BiTNode));
		s->data = a[i];
		s->lChild = NULL;
		s->rChild = NULL;
		InsertNode(tree, s);
	}
}
void PreOrderBiTree(BiTree T) {
	if (T == NULL)
		return;
	BiTree p = T;
	stack<BiTree> s;
	while (p != NULL || !s.empty()) {
		while (p != NULL) {
			s.push(p);
			cout << p->data << " ";
			p = p->lChild;
		}
		if (!s.empty()) {
			p = s.top();
			s.pop();
			p = p->rChild;
		}
	}
}
void InOrderBiTree(BiTree T) {
	if (T == NULL)
		return;
	BiTree p = T;
	stack<BiTree> s;
	while (p != NULL || !s.empty()) {
		while (p != NULL) {
			s.push(p);
			p = p->lChild;
		}
		if (!s.empty()) {
			p = s.top();
			cout << p->data << " ";
			s.pop();
			p = p->rChild;
		}
	}
}
void PostOrderBiTree(BiTree T) {
	if (T == NULL)
		return;
	stack<node> s;
	BiTree p = T;
	node tmp;
	while (p != NULL || !s.empty()) {
		while (p != NULL) {
			node btn = (node)malloc(sizeof(Node));
			btn->btnode = p;
			btn->isfirst = true;
			s.push(btn);
			p = p->lChild;
		}
		if (!s.empty()) {
			tmp = s.top();
			s.pop();
			if (tmp->isfirst == true) {
				tmp->isfirst = false;
				s.push(tmp);
				p = tmp->btnode->rChild;
			}
			else {
				cout << tmp->btnode->data << " ";
				p = NULL;
			}
		}
	}
}
int main() {
	int x=0,flag;
	cout << "请输入二叉树的初始节点数:";
	cin >> len;
	int a[505];
	cout << "请输入各节点,将以二叉排序树存储：";
	for (int i = 0; i < len; i++)
		cin >> a[i];
	BiTree tree = NULL;
	CreateBiTree(tree, a);
	for (; x != 1;) {
		cout << "请选择您的操作：\n(1)输出先序遍历结果\n(2)输出中序遍历结果\n(3)输出后序遍历结果\n(0)退出：";
		cin >> flag;
		switch (flag) {
		case 1: {
			PreOrderBiTree(tree);
			cout << endl;
			break;
		}
		case 2: {
			InOrderBiTree(tree);
			cout << endl;
			break;
		}
		case 3: {
			PostOrderBiTree(tree);
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
