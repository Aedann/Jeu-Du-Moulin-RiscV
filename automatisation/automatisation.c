#include <stdlib.h>
#include <stdio.h>



int main(){
    FILE *fichier = fopen("./voisins.txt","r");
    for(int i = 0; i<66;i++){
        int p;
        char v;
        int val=666;
        int v2;
        fscanf(fichier,"p[%d].v%c = %d;\n",&p,&v,&val);
        if(v=='n'){
            v2=2;
        }else if(v=='e'){
            v2=3;
        }
        else if(v=='s'){
            v2=4;
        }
        else if(v=='o'){
            v2=5;
        }
        int rang = p*24 + v2*4;
        printf("\n        li t1,%d \n        sw t1,%d(t0)           #p[%d].v%c = %d;         %d*24 + %d*4 ",val,rang,p,v,val,p,v2);
    }
}
