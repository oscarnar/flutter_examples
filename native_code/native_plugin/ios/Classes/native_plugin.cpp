#include <stdint.h>
#include <cmath>

extern "C"
{
    __attribute__((visibility("default"))) __attribute__((used)) int32_t
    getPrime(int32_t rangenumber)
    {
        int c = 0, num = 2, i, letest = 0;
        while (c != rangenumber)
        {
            int count = 0;

            for (i = 2; i <= sqrt(num); i++)
            {
                if (num % i == 0)
                {
                    count++;
                    break;
                }
            }
            if (count == 0)
            {
                c++;
                letest = num;
            }
            num = num + 1;
        }
        return letest;
    }

    __attribute__((visibility("default"))) __attribute__((used))
    int32_t
    native_plugin(int32_t x, int32_t y)
    {
        return x * y;
    }
}
