#include "Player.hh"
#include <iostream>
#include <vector>
#include <queue>
#include <map>

/**
 * Write the name of your player and save this file
 * with the same name and .cc extension.
 */
#define PLAYER_NAME TheGreatFox


struct PLAYER_NAME : public Player {

  /**
   * Factory: returns a new instance of this class.
   * Do not modify this function.
   */
  static Player* factory () {
    return new PLAYER_NAME;
  }

  /**
   * Types and attributes for your player can be defined here.
   */
bool pos_ok(int x, int y){
  return x>= 0 and x < board_rows() and y>= 0 and y < board_cols();
}

// Buscar distancies minimes als veins i decidir direcció en funció d'això.
bool bfs_food(Pos pos, int &dist){
	map<Pos, bool> visited;
	if(cell(pos).type == Water) return false;
	else if(cell(pos).bonus != None){
		dist = 1;
		return true;
	}
	visited.insert(make_pair(pos,true));
	queue<pair<Pos,int> > q;
	q.push(make_pair(pos, 1));
	while(!q.empty){
		pair<Pos,int> p = q.front();
		q.pop();
		for(int i = 0; i < 4; i++){
			x = p.first.i + mov_x[i];
			y = p.first.j + mov_y[i];
			if(pos_ok(x,y) and visited.find(p.first) == visited.end()){
				if(pos_ok(x,y) and cell(Pos(x,y)).bonus != None){
					dist = p.second + 1;
					return true;
				} else if(pos_ok(x,y) and cell(Pos(x,y)).type == Soil){
					visited.insert(make_pair(Pos(x,y),true));
					q.push(make_pair(Pos(x,y), p.second + 1));
				}
			}
		}
	}
	return false;
}



  void command_workers(){
    vector<int> my_worker_ids = workers(me());
    vector<int> perm = random_permutation(my_worker_ids.size());
    for (int k = 0; k < int(perm.size()); ++k) {
      int worker_id = my_worker_ids[perm[k]];
      Ant worker = ant(worker_id);
      Pos p = worker.pos;
      Pos food;
      Pos anterior;
      map<Pos, Pos> prev;
      if(worker.bonus == None){
         cerr << "before bfs"    << endl;
        if(bfs_food(p,prev, food)){
          map<Pos, Pos>::iterator it = prev.begin();
          it = prev.find(food);
           cerr << "bfs"    << endl;
          while(it != prev.end()){
            anterior = it->second;
            it = prev.find(anterior);
          }
          if(anterior == (p + Down)) move(worker_id,Up);
          else if(anterior == (p + Right)) move(worker_id,Left);
          else if(anterior == (p + Left)) move(worker_id,Right);
          else if(anterior == (p + Up)) move(worker_id,Down);
        }
        else{
          //To think
        }
      }
    }

  }
  /**
   * Play method, invoked once per each round.
   */
  virtual void play () {
    command_workers();
  }
    
  };


/**
 * Do not modify the following line.
 */
RegisterPlayer(PLAYER_NAME);
