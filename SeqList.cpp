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
	cout<<"˳����е������У�"<<endl;
	for(int i=0;i<L.length;i++)
		cout<<L.data[i]<<" ";
	cout<<endl;
}
void ListInsert(SeqList &L,int e,int i){
	if(i<0||i>L.length+1){
		cout<<"λ�÷Ƿ���"<<endl;
		return;
	}
	for(int j=L.length-1;j>=i-1;j--)
		L.data[j+1]=L.data[j];
	L.data[i-1]=e;
	L.length++;
}
void ListDelete(SeqList &L,int i){
	if(i<0||i>L.length+1){
		cout<<"λ�÷Ƿ���"<<endl;
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
		cout<<"�˱���һ���ձ�"<<endl;
	else
		cout<<"�˱���һ���ձ�"<<endl; 
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
	cout<<"�������ʼ��ĳ��ȣ�"; 
	cin>>n;
	cout<<"�������ʼ������ݣ�";
	for(int i=0;i<n;i++)
		cin>>a[i],ListInsert(s1,a[i],i+1);
	for(;x!=1;){
	cout<<"��ѡ�����Ĳ�����\n(1)����в�������\n(2)�ӱ���ɾ������\n(3)�����Ƿ�Ϊ��\n(4)��ѯĳλ���ڱ��е�����\n(5)��ѯ�����Ƿ����ĳ����\n(6)��ѯ��ﳤ��\n(0)�˳� ��";
	cin>>tmp;
	switch(tmp){
		case 1:{
			cout<<"���������ݼ���λ�ã�"; 
			cin>>e>>i;
			ListInsert(s1,e,i);
			Output(s1);
			break;
		}
		case 2:{
			cout<<"������Ҫɾ�������ݵ�λ�ã�";
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
			cout<<"������Ҫ��ѯ��λ�ã�";
			cin>>i;
			GetValue(s1,i,e);
			cout<<"���е�"<<i<<"������Ϊ"<<e<<endl;
			break;
		} 
		case 5:{
			cout<<"������Ҫ��ѯ�����ݣ�";
			cin>>i;
			cout<<"���ݵ�λ���ڵ�"<<LocateValue(s1,i)<<"��"<<endl;
			break;
		}
		case 6:{
			cout<<"��Ϊ"<<ListLength(s1)<<endl;
			break;
		}
		case 0:{
			DestroyList(s1);
			x=1;
			break;
		}
		default:{
			cout<<"�Ƿ����룡"<<endl;
			break;
		}
	}}
	return 0;
}
