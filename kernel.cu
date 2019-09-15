#include <cstdio>

int main(void)
{
	const int  SIZE = 5;
	const int a[SIZE] = { 1,2,3,4,5 };
	int b[SIZE] = { 0,0,0,0,0 };

	//���� �� �� Ȯ��
	printf("a = {%d,%d,%d,%d,%d}\n", a[0], a[1], a[2], a[3], a[4]);

	int* dev_a = 0;
	int* dev_b = 0;

	//GPU �޸� ���� �Ҵ�
	cudaMalloc((void**)&dev_a, SIZE * sizeof(int));
	cudaMalloc((void**)&dev_b, SIZE * sizeof(int));

	//RAM -> VRAM �޸� ����
	//a -> dev_a
	cudaMemcpy(dev_a, a, SIZE * sizeof(int), cudaMemcpyHostToDevice);
	//dev_a -> dev_b
	cudaMemcpy(dev_b, dev_a, SIZE * sizeof(int), cudaMemcpyDeviceToDevice);
	//dev_b -> b
	cudaMemcpy(b, dev_b, SIZE * sizeof(int), cudaMemcpyDeviceToHost);

	//VRAM �Ҵ� ���� ����
	cudaFree(dev_a);
	cudaFree(dev_b);

	printf("b = {%d,%d,%d,%d,%d}\n", b[0], b[1], b[2], b[3], b[4]);

	return 0;
}