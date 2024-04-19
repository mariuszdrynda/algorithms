#include <iostream>
#include <vector>
#include <cstdint>

constexpr uint8_t SIZE = 9; //nr of rows / columns

bool is_number_fit(std::vector<std::vector<uint8_t>>& sudoku, const uint8_t x, const uint8_t y, const int num){
    for(uint8_t i = 0; i < SIZE; i++)
        if(sudoku[x][i] == num)
            return false;
    for(uint8_t i = 0; i < SIZE; i++)
        if(sudoku[i][y] == num)
            return false;
    uint8_t kw_x = x / 3;
    uint8_t kw_y = y / 3;
    for(uint8_t i = 0; i < 3; i++)
        for(uint8_t j = 0; j < 3; j++)
            if(sudoku[3*kw_x+i][3*kw_y+j] == num)
                return false;
    return true;
}

bool solve(const std::vector<std::vector<uint8_t>>& original, std::vector<std::vector<uint8_t>>& sudoku, const uint8_t x, const uint8_t y){
    if(y >= SIZE)
        return true;
    if(x >= SIZE)
        return solve(original, sudoku, 0, y+1);
    else if(original[x][y] != 0){
        sudoku[x][y] = original[x][y];
        return solve(original, sudoku, x+1, y);
    } else {
        for(uint8_t possible = 1; possible < 10; possible++){
            if(is_number_fit(sudoku, x, y, possible)){
                sudoku[x][y] = possible;
                if(solve(original, sudoku, x+1, y))
                    return true;
            }
        }
        sudoku[x][y] = 0;
        return false;
    }
}

void print_sudoku(const std::vector<std::vector<uint8_t>>& sudoku){
    for(uint8_t i = 0; i < SIZE; i++){
        for(uint8_t j = 0; j < SIZE; j++)
            std::cout << unsigned(sudoku[i][j]) << " ";
        std::cout << std::endl;
    }
}

int main(){
    std::vector<std::vector<uint8_t>> test1 = 
        {{5,0,0,1,0,6,0,0,4},
        {0,8,0,0,4,5,3,9,0},
        {0,0,0,8,3,2,0,5,0},
        {3,1,0,0,8,4,6,0,2},
        {4,0,0,0,0,0,0,3,1},
        {2,7,0,0,0,0,0,0,9},
        {6,2,0,0,0,8,4,0,5},
        {8,5,1,0,0,0,7,0,3},
        {0,4,0,5,0,0,0,2,0}};
    std::vector<std::vector<uint8_t>> test2 = 
        {{4,0,0,0,0,0,1,0,0},
        {0,0,0,9,4,0,0,3,0},
        {0,2,0,0,0,0,0,6,0},
        {0,0,1,7,0,0,0,0,0},
        {2,5,8,0,0,0,0,0,0},
        {0,0,6,1,0,3,0,0,0},
        {0,0,0,0,1,0,5,0,8},
        {0,0,0,0,0,5,0,0,0},
        {6,0,0,0,0,8,0,0,2}};
    std::vector<std::vector<uint8_t>> sudoku = test2;
    solve(test2, sudoku, 0, 0);
    print_sudoku(sudoku);
    return 0;
}