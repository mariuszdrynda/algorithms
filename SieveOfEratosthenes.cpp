#include <iostream>
#include <vector>
int sieve(const int count){
    if(count < 2) return 0;
    std::vector<bool> v(count, false);
    for(int p = 2; p * p <= count;){
        for(int i = 2*p ;i <= count; i += p){
            v[i] = true;
        }
        do{
            p++;
        }while(v[p]);
    }
    int result = 0;
    for(int i = 2; i <= count; i++){
        if(v[i] == false) result++;
    }
    return result;
}
int main(){
    constexpr int number = 1000000;
    std::cout << "Nr of primes between 0 and " << number << ": " << sieve(number);
}