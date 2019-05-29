#header
<<
#include <string>
#include <iostream>
#include <cstdlib>

using namespace std;

// struct to store information about tokens
typedef struct {
  string kind;
  string text;
} Attrib;


// function to fill token information (predeclaration)
void zzcr_attr(Attrib *attr, int type, char *text);

// fields for AST nodes
#define AST_FIELDS string kind; string text;
#include "ast.h"

// macro to create a new AST node (and function predeclaration)
#define zzcr_ast(as,attr,ttype,textt) as=createASTnode(attr,ttype,textt)
AST* createASTnode(Attrib* attr, int ttype, char *textt);
>>

<<
#include <cstdlib>
#include <cmath>
#include <map>
#include <utility>


map<string, string> Q;
map<string, map<string,string> > A;
map<string, pair<string,string> > C;


// function to fill token information
void zzcr_attr(Attrib *attr, int type, char *text) {

    attr->kind = text;
    attr->text = "";
}

AST* createASTlist(AST* a){

    AST* n = new AST;
    n->kind = "list";
    n->down = a;
    n->right = NULL;
    return n;
}

int depthASTtree(AST* a){

}

// function to create a new AST node
AST* createASTnode(Attrib* attr, int type, char* text) {
  AST* as = new AST;
  as->kind = attr->kind; 
  as->text = attr->text;
  as->right = NULL; 
  as->down = NULL;
  return as;
}

/// get nth child of a tree. Count starts at 0.
/// if no such child, returns NULL
AST* child(AST *a,int n) {
 AST *c=a->down;
 for (int i=0; c!=NULL && i<n; i++) c=c->right;
 return c;
} 

/// print AST, recursively, with indentation
void ASTPrintIndent(AST *a,string s)
{
  if (a==NULL) return;

  cout<<a->kind;
  if (a->text!="") cout<<"("<<a->text<<")";
  cout<<endl;

  AST *i = a->down;
  while (i!=NULL && i->right!=NULL) {
    cout<<s+"  \\__";
    ASTPrintIndent(i,s+"  |"+string(i->kind.size()+i->text.size(),' '));
    i=i->right;
  }
  
  if (i!=NULL) {
      cout<<s+"  \\__";
      ASTPrintIndent(i,s+"   "+string(i->kind.size()+i->text.size(),' '));
      i=i->right;
  }
}

/// print AST 
void ASTPrint(AST *a)
{
  while (a!=NULL) {
    cout<<" ";
    ASTPrintIndent(a,"");
    a=a->right;
  }
}
void followinstr(AST *instr, int seed, string name, string chatbot){

    ///instr conte els passos a seguir
    AST *evaluated;
    evaluated = instr;
    if(evaluated != NULL ){
        if(evaluated->kind == "THEN"){
            int i = 0;
            while(child(evaluated,i) != NULL){
                followinstr(child(evaluated,i),seed,name,chatbot);
                i++;
            }
         }
         else if (evaluated->kind == "OR"){
            srand(seed);
            int i = 0;
            while(child(evaluated,i) != NULL) ++i;
            int picked = rand()%i;
            followinstr(child(evaluated,picked), seed, name,chatbot);
         }
         else { ///Tenim una conversa
            ///Buscar les converses al mapa, obtenir la pregunta i resposta, buscar-les i escriure-les.
            pair<string,string> qanda;
            cout << chatbot << " > ";
            std::string ctag = evaluated->kind;
            qanda = C.find(ctag)->second;
            std::string qtag = qanda.first;
            std::string atag = qanda.second;
            cout << name << ", " << Q.find(qtag)->second << endl;
            map<string, string> anss = A.find(atag)->second;
            map<string,string>::iterator it = anss.begin();
            while(it != anss.end()){
              cout << it->first << ": " << it->second << endl;
              it++;
            }
            string number;
            cout << name << " > ";
            std::getline(std::cin,number);

         }
        
    }
    

}
void executepart(AST *instr, string exec, int seed,string name){

    int x = 0;
    while(child(instr,x)->kind != exec) ++x;
    followinstr(child(child(instr,x),0),seed, name,exec);
    
}
void generateChat(AST *a) {

    int seed = atoi((child(child(a,2),0)->kind).c_str());
    int x = 1;
    while(child(child(a,2),x) != NULL){
        string exec = child(child(a,2),x)->kind;
        cout << exec + " > WHAT IS YOUR NAME ? _ " << endl;
        string name;
        std::getline(std::cin, name);
        executepart(child(a,1), exec, seed,name);
        cout << exec << " > " << "THANKS FOR THE CHAT " << name << "!" << endl;
        x++;
    }
}
void generate(AST *a) {
    int x = 0;
    while(child(a,x) != NULL){
      AST *qac = child(a,x);
      std::string tag = qac->kind;
      if(child(qac,0)->kind == "->"){ ///Una conversa
        std::pair<std::string,std::string> qanda;
        qanda = std::make_pair(child(child(qac,0),0)->kind, child(child(qac,0),1)->kind);
        C.insert(std::make_pair(tag,qanda));
      }
      else {
        AST *qa = child(qac,0);
        if(child(child(qa,0),0) != NULL){ ///Una resposta te mes profunditat que una resposta
          AST *ans = qa;
          map<string,string> answs;
          int x = 0;
          while(child(ans,x) != NULL){
            string num = child(ans,x)->kind;
            string phrase;
            int t = 0;
            while(child(child(child(ans,x),0),t) != NULL){
              phrase += child(child(child(ans,x),0),t)->kind + " ";
              t++;
            }
            answs.insert(std::make_pair(num,phrase));
            x++;
          }
          A.insert(std::make_pair(tag,answs));
        }
        else{ ///Resposta
          AST *quest = qa;
          std::string phrase;
          int x = 0;
          while(child(quest,x)!= NULL){
            phrase = phrase + child(quest,x)->kind+ " ";
            x++;
          }
          phrase = phrase + " ?";
          Q.insert(std::make_pair(tag, phrase));
        }
      }
      ++x;
    }
    
}


int main() {


    AST *root = NULL;
    ANTLR(chatbot(&root), stdin);
    ASTPrint(root);
    generate(child(root,0));
    generateChat(root);

}
>>

#lexclass START
#token CHATBOT "CHATBOT"
#token THEN "THEN"
#token OR "OR"
#token END "END"
#token INTERACTION "INTERACTION"
#token CONVERSATION "CONVERSATION"
#token QT "QUESTION"
#token ANSWERS "ANSWERS"
#token NUM "[0-9]+"
#token WORD "[a-zA-Z0-9]+"
#token SPACE "[\ \n]" << zzskip();>>
#token COLON "\:"
#token SEMICOLON "\;"
#token QMARK "\?"
#token HASH "\#"
#token LEFTBRAKET "\["
#token RIGHTBRAKET "\]"
#token LEFTPAR "\("
#token RIGHTPAR "\)"
#token COMA "\,"
#token ARROW "\->"

chatbot: conversations chats startchat <<#0=createASTlist(_sibling);>>;

part: WORD^ COLON! (question | answer | conversation);
question: QT! listwords QMARK! ;
listwords: (WORD)+ <<#0=createASTlist(_sibling);>>;
justoneanswer: (NUM^ COLON! listwords SEMICOLON!) |( LEFTPAR! NUM^ COMA! listwords RIGHTPAR!);
answer: ANSWERS! (typeanswer1|typeanswer2);
typeanswer1: (justoneanswer)+ <<#0=createASTlist(_sibling);>>;
typeanswer2: LEFTBRAKET! (justoneanswer) (COMA! justoneanswer)* RIGHTBRAKET! <<#0=createASTlist(_sibling);>>;
conversation: CONVERSATION! HASH! WORD ARROW^ HASH! WORD;
conversations: (part)* <<#0=createASTlist(_sibling);>>;
startchat: INTERACTION! NUM (WORD)* END! <<#0=createASTlist(_sibling);>> ;
op: inner (OR^ inner)* ;
chat: CHATBOT! WORD^ COLON! op;
chats: (chat)*<<#0=createASTlist(_sibling);>> ;
inner: par (THEN^ inner)* ;
par: HASH! WORD | LEFTPAR! inner OR^ inner (OR! inner)*  RIGHTPAR! ;
