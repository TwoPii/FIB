#include <iostream>
#include <vector>

using namespace std;

typedef vector<int> VI;
typedef vector<VI> VVI;

bool is_cyclic(const VVI& g) {
  int n = g.size();
  VI indeg(n, 0);
  for (int u = 0; u < n; ++u)
    for (int v : g[u])
      ++indeg[v];

  vector<int> cands;
  for (int u = 0; u < n; ++u)
    if (indeg[u] == 0)
      cands.push_back(u);

  while (not cands.empty()) {
    int u = cands.back();
    cands.pop_back();
    --n;
    for (int v : g[u]) {
      --indeg[v];
      if (indeg[v] == 0)
        cands.push_back(v);
    }
  }
  return n > 0;
}


int main() {
  int n;
  while (cin >> n) {
    VVI g(n);
    int m;
    cin >> m;
    for (int k = 0; k < m; ++k) {
      int x, y;
      cin >> x >> y;
      g[x].push_back(y);
    }
    if (is_cyclic(g)) cout << "yes" << endl;
    else              cout << "no"  << endl;
  }
}
