#include <iostream>
#include <vector>

using namespace std;

void write(const vector<int>& x, const vector<bool>& sol) {
  cout << '{';
  bool first = true;
  for (int i = 0; i < int(x.size()); ++i)
    if (sol[i]) {
      if (first) first = false;
      else cout << ',';
      cout << x[i];
    }
  cout << '}' << endl;
}

void bt(int s, int k, const vector<int>& x, int sp, int sn, vector<bool>& sol) {
  if (sp > s or sp + sn < s) return;
  if (k == int(x.size())) write(x, sol);
  sol[k] = false;  bt(s, k+1, x,    sp,     sn - x[k], sol);
  sol[k] = true;   bt(s, k+1, x, sp + x[k], sn - x[k], sol);
}

int main() {
  int s, n;
  cin >> s >> n;
  vector<int> x(n);
  int sum = 0;
  for (int i = 0; i < n; ++i) {
    cin >> x[i];
    sum += x[i];
  }
  vector<bool> sol(n);
  bt(s, 0, x, 0, sum, sol);
}
