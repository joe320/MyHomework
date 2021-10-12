#include<iostream>
#include<cstdlib>
using namespace std;
typedef struct LNode
{
	int data;
	struct LNode *next;
}LinkNode;
void CreatListF(LinkNode *&L){
	int n;
	LinkNode *s;
	L=(LinkNode *)malloc(sizeof(LinkNode));
	L->next=NULL;
	cout<<"请输入初始长度：";
	cin>>n;
	cout<<"请输入初始数据：";
	for(int i=0;i<n;i++){
		s=(LinkNode *)malloc(sizeof(LinkNode));
		cin>>s->data;
		s->next=L->next;
		L->next=s;
	} 
}
void CreatListR(LinkNode *&L){
	int n;
	LinkNode *s,*r;
	L=(LinkNode *)malloc(sizeof(LinkNode));
	r=L;
	cout<<"请输入初始长度：";
	cin>>n;
	cout<<"请输入初始数据：";
	for(int i=0;i<n;i++){
		s=(LinkNode *)malloc(sizeof(LinkNode));
		cin>>s->data;
		r->next=s;
		r=s;
	} 
	r->next=NULL;
}
void InitList(LinkNode *&L){
	L=(LinkNode *)malloc(sizeof(LinkNode));
	L->next=NULL;
}
void DestroyList(LinkNode *&L){
	LinkNode *pre=L,*p=L->next;
	while(p!=NULL){
		free(pre);
		pre=p;
		p=pre->next;
	}
	free(pre);
}
bool IsEmpty(LinkNode *L){
	return (L->next==NULL);
}
int Listlength(LinkNode *L){
	int n=0;
	LinkNode *p=L;
	while(p->next!=NULL){
		n++;
		p=p->next; 
	}
	return n;
}
void Output(LinkNode *L){
	LinkNode *p=L->next;
	while(p!=NULL){
		cout<<p->data<<" ";
		p=p->next; 
	}
	cout<<endl;
}
bool GetValue(LinkNode *L,int i,int &e){
	int j=0;
	LinkNode *p=L;
	if(i<=0)
		return false;
	while(j<i&&p!=NULL){
		j++;
		p=p->next;
	} 
	if(p==NULL)
		return false;
	else{
		e=p->data;
		return true;
	}
}
int LocateValue(LinkNode *L,int e){
	int i=1;
	LinkNode *p=L->next;
	while(p!=NULL&&p->data!=e){
		p=p->next;
		i++;
	}
	if(p==NULL)
		return 0;
	else
		return i;
}
bool ListInsert(LinkNode *&L,int i,int e){
	int j=0;
	LinkNode *p=L,*s;
	if(i<=0)
		return false;
	while(j<i-1&&p!=NULL){
		j++;
		p=p->next;
	}
	if(p==NULL)
		return false;
	else{
		s=(LinkNode *)malloc(sizeof(LinkNode));
		s->data=e;
		s->next=p->next;
		p->next=s;
		return true;
	}
}
bool ListDelete(LinkNode *&L,int i,int &e){
	int j=0;
	LinkNode *p=L,*q;
	if(i<=0)
		return false;
	while(j<i-1&&p!=NULL){
		j++;
		p=p->next;
	}
	if(p==NULL)
		return false;
	else{
		q=p->next;
		if(q==NULL)
			return false;
		e=q->data;
		p->next=q->next;
		free(q);
		return true;
	}
}
int main(){
	LinkNode *s;
	int e,i;
	int T,tmp;
	int x=0;
	cout<<"请选择初始表插入方式：\n(1)头插法\n(2)尾插法：";
	cin>>T;
	if(T==1){
		CreatListF(s);
	}
	else if(T==2){
		CreatListR(s);
	}
	else{
		cout<<"非法输入！";
		return 0;
	}
	cout<<"初始表为："<<endl;
	Output(s);
	for(;x!=1;){
	cout<<"请选择您的操作：\n(1)向表中插入数据\n(2)从表中删除数据\n(3)检查表是否为空\n(4)查询某位置在表中的数据\n(5)查询表中是否存在某数据\n(6)查询表长度\n(0)退出 ：";
	cin>>tmp;
	switch(tmp){
		case 1:{
			cout<<"请输入数据及其位置："; 
			cin>>e>>i;
			ListInsert(s,i,e);
			Output(s);
			break;
		}
		case 2:{
			cout<<"请输入要删除的数据的位置：";
			cin>>i;
			ListDelete(s,i,e);
			Output(s);
			break;
		}
		case 3:{
			if(IsEmpty(s)==1)
				cout<<"此表是一个空表"<<endl;
			else
				cout<<"此表不是一个空表"<<endl;
			break;
		}
		case 4:{
			cout<<"请输入要查询的位置：";
			cin>>i;
			GetValue(s,i,e);
			cout<<"表中第"<<i<<"个数据为"<<e<<endl;
			break;
		} 
		case 5:{
			cout<<"请输入要查询的数据：";
			cin>>i;
			cout<<"数据的位置在第"<<LocateValue(s,i)<<"个"<<endl;
			break;
		}
		case 6:{
			cout<<"表长为"<<Listlength(s)<<endl;
			break;
		}
		case 0:{
			DestroyList(s);
			x=1;
			break;
		}
		default:{
			cout<<"非法输入！"<<endl;
			break;
		}
	}}
	return 0;
}
