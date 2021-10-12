#include<iostream>
#include<cstdlib>
#define MaxSize 100
using namespace std;
typedef struct
{
	int data[MaxSize];
	int length;
}SeqList;
void InitList(SeqList &L){
	for(int i=0;i<MaxSize;i++)
		L.data[i]=0;
	L.length=0;
}
void Output(SeqList L){
	cout<<"顺序表中的数据有："<<endl;
	for(int i=0;i<L.length;i++)
		cout<<L.data[i]<<" ";
	cout<<endl;
}
void ListInsert(SeqList &L,int e,int i){
	if(i<0||i>L.length+1){
		cout<<"位置非法！"<<endl;
		return;
	}
	for(int j=L.length-1;j>=i-1;j--)
		L.data[j+1]=L.data[j];
	L.data[i-1]=e;
	L.length++;
}
void ListDelete(SeqList &L,int i){
	if(i<0||i>L.length+1){
		cout<<"位置非法！"<<endl;
		return;
	}
	for(int j=i-1;j<L.length;j++)
		L.data[j]=L.data[j+1];
	L.length--; 
}
void IsEmpty(SeqList L){
	int flag=1;
	if(!L.length)
		flag=0;
	if(flag)
		cout<<"此表不是一个空表"<<endl;
	else
		cout<<"此表是一个空表"<<endl; 
}
void GetValue(SeqList L,int i,int &e){
	e=L.data[i-1];
}
int LocateValue(SeqList L,int e){
	for(int i=0;i<L.length;i++)
		if(L.data[i]==e)
			return i+1;
	return 0;
} 
int ListLength(SeqList L){
	return L.length;
}
void DestroyList(SeqList L){
	SeqList *p=&L;
	free(p); 
}
int main()
{
	SeqList s1;
	int e;
	InitList(s1);
	int a[1005],n,i;
	int tmp,x=0;
	cout<<"请输入初始表的长度："; 
	cin>>n;
	cout<<"请输入初始表的数据：";
	for(int i=0;i<n;i++)
		cin>>a[i],ListInsert(s1,a[i],i+1);
	for(;x!=1;){
	cout<<"请选择您的操作：\n(1)向表中插入数据\n(2)从表中删除数据\n(3)检查表是否为空\n(4)查询某位置在表中的数据\n(5)查询表中是否存在某数据\n(6)查询表达长度\n(0)退出 ：";
	cin>>tmp;
	switch(tmp){
		case 1:{
			cout<<"请输入数据及其位置："; 
			cin>>e>>i;
			ListInsert(s1,e,i);
			Output(s1);
			break;
		}
		case 2:{
			cout<<"请输入要删除的数据的位置：";
			cin>>i;
			ListDelete(s1,i);
			Output(s1);
			break;
		}
		case 3:{
			IsEmpty(s1);
			break;
		}
		case 4:{
			cout<<"请输入要查询的位置：";
			cin>>i;
			GetValue(s1,i,e);
			cout<<"表中第"<<i<<"个数据为"<<e<<endl;
			break;
		} 
		case 5:{
			cout<<"请输入要查询的数据：";
			cin>>i;
			cout<<"数据的位置在第"<<LocateValue(s1,i)<<"个"<<endl;
			break;
		}
		case 6:{
			cout<<"表长为"<<ListLength(s1)<<endl;
			break;
		}
		case 0:{
			DestroyList(s1);
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
