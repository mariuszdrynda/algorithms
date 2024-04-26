#include <iostream>
#include <vector>

int max(int a, int b){
    return a > b ? a : b;
}

std::vector<bool> knapsack(int c, int n, std::vector<int> w, std::vector<int> p){
    int V[n+1][c+1];
    for(int i = 0; i <= n; i++){
        for(int j = 0; j <= c; j++){
            if(i == 0 || j == 0) V[i][j] = 0;
            else if(w[i] > j) V[i][j] = V[i-1][j];
            else V[i][j] = max(V[i-1][j], V[i-1][j-w[i]]+p[i]);
        }
    }
    std::cout << "max value = " << V[n][c] << std::endl;
    std::vector<bool> solution(n+1, false);
    for(int i = n, j = c; i >= 0; ){
        if(V[i][j] > V[i-1][j]){
            solution[i] = true;
            j -= w[i];
        }
        i--;
    }
    return solution;
}

int main(){
    constexpr int capacity = 8;
    constexpr int nr_of_items = 4;
    std::vector<int> weights = {0, 2, 1, 4, 4};
    std::vector<int> prices = {0, 4, 3, 6, 8};
    std::vector<bool> solution = knapsack(capacity, nr_of_items, weights, prices);
    for(int i = 0; i <= nr_of_items; i++){
        std::cout << solution[i] << " ";
    }
}