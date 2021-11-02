#include<iostream>
#include<cstdlib>
using namespace std;
typedef struct Stack {
	int *base;
	int *top;
	int stackSize;
}Stack;

Stack InitStack() {
	Stack stack;
	stack.base = (int *)malloc(20 * sizeof(int));
	if (stack.base == NULL)
		exit(0);
	stack.top = stack.base;
	stack.stackSize = 20;
	return stack;
}
void DestoryStack(Stack *stack) {
	if (stack->base == NULL) {
		cout << "未初始化顺序栈\n";
		return;
	}
	free(stack->base);
	stack->top = stack->base = NULL;
	stack->stackSize = 0;
}
bool IsEmpty(Stack *stack) {
	if (stack->base == NULL) {
		cout << "未初始化顺序栈\n";
		return 0;
	}
	if (stack->base == stack->top)
		return 0;
	else
		return 1;
}
int GetTop(Stack *stack) {
	int data = 0;
	if (stack->base == NULL) {
		cout << "未初始化顺序栈\n";
		return data;
	}
	if (stack->base == stack->top)
		return data;
	data = *(stack->top - 1);
	return data;
}
void Push(Stack *stack, int elem) {
	if (stack->base == NULL) {
		cout << "未初始化顺序栈\n";
		return;
	}
	if (stack->top - stack->base >= stack->stackSize) {
		stack->base = (int *)realloc(stack->base, 5 * sizeof(int));
		if (stack->base == NULL)
			exit(0);
		stack->top = stack->base + stack->stackSize;
		stack->stackSize += 5;
	}
	*stack->top++ = elem;
}
int Pop(Stack *stack) {
	int data = 0;
	if (stack->base == NULL) {
		cout << "未初始化顺序栈\n";
		return data;
	}
	if (stack->base == stack->top)
		return 0;
	data = *(--stack->top);
	return data;
}
void Display(Stack *stack) {
	if (stack->base == NULL) {
		cout << "未初始化栈\n";
		return;
	}
	int *p = stack->base;
	while (p != stack->top)
		cout << *p++ << " ";
	cout << endl;
}

int main() {
	Stack stack = InitStack();
	int N, e, x = 0, tmp;
	cout << "请输入栈的元素个数：";
	cin >> N;
	if (N >= 1) {
		for (int i = 0; i < N;) {
			cout << "请输入第" << ++i << "个入栈的元素:";
			cin >> e;
			Push(&stack, e);
		}
		for (; x != 1;) {
			cout << "\n当前栈中元素：";
			Display(&stack);
			cout << "\n请选择您的操作:\n(1)入栈(2)出栈(3)查询栈顶(0)结束:";
			cin >> tmp;
			switch (tmp) {
			case 1: {
				cout << "请输入入栈元素：";
				cin >> e;
				Push(&stack, e);
				break;
			}
			case 2: {
				cout << "出栈元素：" << Pop(&stack);
				break;
			}
			case 3: {
				cout << "栈顶元素：" << GetTop(&stack);
				break;
			}
			case 0: {
				DestoryStack(&stack);
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
