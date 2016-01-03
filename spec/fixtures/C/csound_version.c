#include <stdio.h>
#include "csound.h"

int main() { int v = csoundGetVersion(); printf("%d", v); exit(v); }
