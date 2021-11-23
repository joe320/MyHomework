#include<stack>
#include<iostream>
#include<cstdlib>
#include<cstdio>
using namespace std;
int len,w;
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
int PreCreateTree(BiTree &root) {
	char x;
	cin >> x;
	if (x == '#')
		root = NULL;
	else {
		root = (BiTree)malloc(sizeof(BiTNode));
		root->data = x;
		PreCreateTree(root->lChild);
		PreCreateTree(root->rChild);
	}
	return 1;
}
void PreOrderBiTree(BiTree T) {
	if (T == NULL)
		return;
	BiTree p = T;
	stack<BiTree> s;
	while (p != NULL || !s.empty()) {
		while (p != NULL) {
			s.push(p);
			if(w==1) cout << (char)p->data << " ";
			else cout << p->data << " ";
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
			if(w==1)cout << (char)p->data << " ";
			else cout << p->data << " ";
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
				if(w==1)cout << (char)tmp->btnode->data << " ";
				else cout << tmp->btnode->data << " ";
				p = NULL;
			}
		}
	}
}
int main() {
	int flag,x=0;
	int a[505];
	BiTree tree = NULL;
	cout << "请选择:(1)以先序遍历输入各节点(2)输入各节点,以二叉排序树存储(数字限定)：";
	cin >> w;
	if (w == 1) {
		PreCreateTree(tree);
	}
	else if (w == 2) {
		cout << "请输入二叉树的初始节点数:";
		cin >> len;
		for (int i = 0; i < len; i++)
			cin >> a[i];
		CreateBiTree(tree, a);
	}
	else {
		cout << "非法输入！";
		return 0;
	}
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
