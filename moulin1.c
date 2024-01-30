#include <stdio.h>
#include <stdlib.h>


//##########################################
//			Structures :
//##########################################

// Structure des cases
// possède une valeur, un symbole associé et l'indice des cases voisines
typedef struct
{
	int valeur;
/* valeur de la case :
0 = vide
1 = case Joueur 1
2 = case Joueur 2
*/
	char symbole;
/* symbole de la case : 
# = vide	(ascii = 35)
X = case Joueur 1	(ascii = 88)
O = case Joueur 2	(ascii = 79)
*/
	int vn;		//voisin nord
	int ve;		//voisin est
	int vs;		//voisin sud
	int vo;		//voisin ouest
/* valeur de la case voisine, -1 si ce voisin n'existe pas
*/
}t_case;



//##########################################
//			Fonctions :
//##########################################


//Fonction d'affichage du plateau
void affiche_plateau(t_case p[24])
{
	printf("%c-----------%c-----------%c                         0-----------1-----------2\n",p[0].symbole,p[1].symbole,p[2].symbole);
	printf("|           |           |                         |           |           |\n");
	printf("|   %c-------%c-------%c   |                         |   3-------4-------5   |\n",p[3].symbole,p[4].symbole,p[5].symbole);
	printf("|   |       |       |   |                         |   |       |       |   |\n");
	printf("|   |   %c---%c---%c   |   |                         |   |   6---7---8   |   |\n",p[6].symbole,p[7].symbole,p[8].symbole);
	printf("|   |   |       |   |   |                         |   |   |       |   |   |\n");
	printf("%c---%c---%c       %c---%c---%c                         9---10--11      12--13--14\n",p[9].symbole,p[10].symbole,p[11].symbole,p[12].symbole,p[13].symbole,p[14].symbole);
	printf("|   |   |       |   |   |                         |   |   |       |   |   |\n");
	printf("|   |   %c---%c---%c   |   |                         |   |   15--16--17  |   |\n",p[15].symbole,p[16].symbole,p[17].symbole);
	printf("|   |       |       |   |                         |   |       |       |   |\n");
	printf("|   %c-------%c-------%c   |                         |   18------19------20  |\n",p[18].symbole,p[19].symbole,p[20].symbole);
	printf("|           |           |                         |           |           |\n");
	printf("%c-----------%c-----------%c                         21----------22----------23\n",p[21].symbole,p[22].symbole,p[23].symbole);
}

//initialise les valeurs du tableau avec des cases vides
void initialisation(t_case p[24])
{
	//initialisation des valeurs et symboles des cases à la valeur correspondant à une case vide
	for (int i = 0; i < 24; i++)
	{
		p[i].valeur = 0;	//case vide
		p[i].symbole = 35;	// 35 correspond à '#' en ascii
		p[i].vn = -1;		//pas de voisin nord
		p[i].ve = -1;		//pas de voisin est
		p[i].vs = -1;		//pas de voisin sud
		p[i].vo = -1;		//pas de voisin ouest
	}

//	mise en place des voisins :

	p[0].ve = 1;
	p[0].vs = 9;

	p[1].ve = 2;
	p[1].vs = 4;
	p[1].vo = 0;

	p[2].vs = 14;
	p[2].vo = 1;

	p[3].ve = 4;
	p[3].vs = 10;

	p[4].vn = 1;
	p[4].ve = 5;
	p[4].vs = 7;
	p[4].vo = 3;

	p[5].vs = 13;
	p[5].vo = 4;

	p[6].ve = 7;
	p[6].vs = 11;

	p[7].vn = 4;
	p[7].ve = 8;
	p[7].vo = 6;

	p[8].vs = 12;
	p[8].vo = 7;

	p[9].vn = 0;
	p[9].ve = 10;
	p[9].vs = 21;

	p[10].vn = 3;
	p[10].ve = 11;
	p[10].vs = 18;
	p[10].vo = 9;

	p[11].vn = 6;
	p[11].vs = 15;
	p[11].vo = 10;

	p[12].vn = 8;
	p[12].ve = 13;
	p[12].vs = 17;

	p[13].vn = 5;
	p[13].ve = 14;
	p[13].vs = 20;
	p[13].vo = 12;

	p[14].vn = 2;
	p[14].vs = 23;
	p[14].vo = 13;

	p[15].vn = 11;
	p[15].ve = 16;

	p[16].ve = 17;
	p[16].vs = 19;
	p[16].vo = 15;

	p[17].vn = 12;
	p[17].vo = 16;

	p[18].vn = 10;
	p[18].ve = 19;

	p[19].vn = 16;
	p[19].ve = 20;
	p[19].vs = 22;
	p[19].vo = 18;

	p[20].vn = 13;
	p[20].vo = 19;

	p[21].vn = 9;
	p[21].ve = 22;

	p[22].vn = 19;
	p[22].ve = 23;
	p[22].vo = 21;

	p[23].vn = 14;
	p[23].vo = 22;

}


//Fonction qui teste la case (num_case) fait partie d'un moulin sur le plateau (p)
//retourne 1 si la case fait partie d'un moulin et 0 sinon
int test_moulin(t_case p[24], int num_case)
{
	//Tableau de Statuts, le statut correspond à un 1 si le voisin en question appartient aussi au joueur actif
	//dans l'ordre des indices : le voisin Nord, Est, Sud, Ouest
	int voisins_status[4];

	//inititalisation des valeurs à 0
	for (int i = 0; i < 4; i++)
	{
		voisins_status[i] = 0;
	}

	//test vers le nord
	if (p[num_case].vn != -1)	//test si il existe une case au nord
	{
		if (p[p[num_case].vn].valeur == p[num_case].valeur)	//test si la valeur de la case nord est identique
		{
			voisins_status[0] = 1;	//case voisine nord appartient aussi au joueur
	
			if (p[p[num_case].vn].vn != -1)	//test si il existe une case au double nord
			{
				if (p[p[p[num_case].vn].vn].valeur == p[num_case].valeur)	//test si la valeur de la case double nord est identique
				{
					return 1;
				}
			}
		}
	}

	//test vers l'Est
	if (p[num_case].ve != -1)	//test si il existe une case à l'Est
	{
		if (p[p[num_case].ve].valeur == p[num_case].valeur)	//test si la valeur de la case Est est identique
		{
			voisins_status[1] = 1;	//case voisine est appartient aussi au joueur
	
			if (p[p[num_case].ve].ve != -1)	//test si il existe une case au double Est
			{
				if (p[p[p[num_case].ve].ve].valeur == p[num_case].valeur)	//test si la valeur de la case double Est est identique
				{
					return 1;
				}
			}
		}
	}

	//test vers le sud
	if (p[num_case].vs != -1)	//test si il existe une case au Sud
	{
		if (p[p[num_case].vs].valeur == p[num_case].valeur)	//test si la valeur de la case Sud est identique
		{
			voisins_status[2] = 1;	//case voisine Sud appartient aussi au joueur
	
			if (p[p[num_case].vs].vs != -1)	//test si il existe une case au double Sud
			{
				if (p[p[p[num_case].vs].vs].valeur == p[num_case].valeur)	//test si la valeur de la case double Sud est identique
				{
					return 1;
				}
			}
		}
	}

	//test vers l'Ouest
	if (p[num_case].vo != -1)	//test si il existe une case au Ouest
	{
		if (p[p[num_case].vo].valeur == p[num_case].valeur)	//test si la valeur de la case Ouest est identique
		{
			voisins_status[3] = 1;	//case voisine Ouest appartient aussi au joueur
	
			if (p[p[num_case].vo].vo != -1)	//test si il existe une case au double Ouest
			{
				if (p[p[p[num_case].vo].vo].valeur == p[num_case].valeur)	//test si la valeur de la case double Ouest est identique
				{
					return 1;
				}
			}
		}
	}

	//test si la case est au milieu d'un moulin
	if ((voisins_status[0] && voisins_status[2]) || (voisins_status[1] && voisins_status[3]))
	{
		return 1;
	}
	return 0;
}

//teste si une capture est possible, si oui demande à l'utilisateur la case à capturer et effectue la capture
void capture(t_case p[24], int tour_j, int * J1_nbr_de_pions, int * J2_nbr_de_pions)
{

	//test si il existe une case adverse ne fesant pas partie d'un moulin :
	int tous_moulins = 1;

	//itération sur toutes les cases du tableau
	for (int i = 0; i < 24; i++)
	{
		//test si la case appartient à l'adversaire
		if (p[i].valeur != tour_j && p[i].valeur != 0)
		{
			//test si la case adverse ne fait pas partie d'un moulin
			if (!(test_moulin(p, i)))
			{
				tous_moulins = 0;
				break;
			}			
		}
	}

	if (tous_moulins)		//toutes les cases adverses font partie d'un moulin
	{
		printf("Vous avez réalisé un moulin !\nToutes les pions adverses font partie d'un moulin, vous pouvez donc choisir n'importe quel pion adverse à capturer.\n");
	}
	else					//il y a au moins une case adverse ne fesant pas partie d'un moulin
	{
		printf("Vous avez réalisé un moulin !\nEntrez le numéro d'une case contenant un pion adverse que vous voulez capturer (ce pion ne peut pas faire partie d'un moulin)\n\n");
	}

	//Capture :
	int input;
	capture: ;
	scanf("%d",&input);
	//test si le placement est invalide
	if ( (input < 0) || (input > 23) || (p[input].valeur == tour_j) || (p[input].valeur == 0) || ((test_moulin(p, input)) && !(tous_moulins)) )	//error bc out of range
	{
		printf("Case entrée invalide, Veuillez recommencer\n");
		goto capture;
	}

	//Capture du pion :
	p[input].valeur = 0;
	p[input].symbole = 35;	//#

	//reduction du nombre de pions du joueur adverse:
	if (tour_j == 1)
	{
		*J2_nbr_de_pions -= 1;
	}
	else
	{
		*J1_nbr_de_pions -= 1;
	}
}

//demande à l'utilisateur de placer un pion, puis le place dans le plateau si placement valable:
//retourne l'indice de la case jouée
int place_pion(t_case * p, int tour_j, int * J1_nbr_de_pions, int * J2_nbr_de_pions)
{
	printf("Tour du Joueur %d :\nEntrez le numéro de la case vide sur laquelle vous voulez placer un pion\n\n",tour_j);
	phase1: ;
	int input;
	scanf("%d",&input);
	//test si le placement est invalide
	if ( (input < 0) || (input > 23) || (p[input].valeur != 0) )	//error bc out of range
	{
		printf("Placement invalide, Veuillez recommencer\nEntrez le numéro de la case vide sur laquelle vous voulez placer un pion\n\n");
		goto phase1;
	}

	//placement du pion
	p[input].valeur = tour_j;
	if (tour_j == 1)
	{
		*J1_nbr_de_pions += 1;
		p[input].symbole = 88;		//X
	}
	else
	{
		*J2_nbr_de_pions += 1;
		p[input].symbole = 79;		//O
	}
	return input;
}

//demande à l'utilisateur le pion à déplacer et la case de destination, puis le déplace si le déplacement est valable:
//retourne l'indice de la case de destination
int deplace_pion(t_case * p, int tour_j)
{
	printf("Tour du Joueur %d :\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer\n\n",tour_j);
	phase2: ;
	int depart;
	scanf("%d",&depart);
	//test si le départ est invalide
	if ( (depart < 0) || (depart > 23) || (p[depart].valeur != tour_j))	//error bc out of range
	{
		printf("Case de départ invalide, Veuillez recommencer\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer\n\n");
		goto phase2;
	}

	printf("Entrez le numéro de la case VIDE VOISINE sur laquelle vous souhaitez déplacer le pion séléctionné précédement\n\n");
	int destination;
	scanf("%d",&destination);
	//test si le déplacement est invalide :
	//test si la case n'est pas voisine
	if (p[depart].vn != destination && p[depart].ve != destination && p[depart].vs != destination && p[depart].vo != destination)
	{
		printf("Déplacement invalide, cette case n'est pas voisine, Veuillez tout recommencer\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer\n\n");
		goto phase2;
	}
	//test si la case n'est pas vide
	if (p[destination].valeur != 0)
	{
		printf("Déplacement invalide, cette case n'est pas vide, Veuillez tout recommencer\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer\n\n");
		goto phase2;
	}
		

	//déplacement du pion :
	p[depart].valeur = 0;
	p[depart].symbole = 35;			//#
	p[destination].valeur = tour_j;
	if (tour_j == 1)
	{
		p[destination].symbole = 88;		//O
	}
	else
	{
		p[destination].symbole = 79;		//X
	}
	return destination;
}

//demande à l'utilisateur le pion à déplacer et la case de destination, puis le déplace si le déplacement est valable:
//retourne l'indice de la case de destination
int saut_pion(t_case * p, int tour_j)
{
	printf("Tour du Joueur %d :\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer (il ne vous reste que 3 pions donc vous pourrez déplacer le pion sur n'importe quel case vide)\n\n",tour_j);
	phase3: ;
	int depart;
	scanf("%d",&depart);
	//test si le départ est invalide
	if ( (depart < 0) || (depart > 23) || (p[depart].valeur != tour_j))		//error bc out of range
	{
		printf("Case de départ invalide, Veuillez recommencer\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer (il ne vous reste que 3 pions donc vous pourrez déplacer le pion sur n'importe quel case vide)\n\n");
		goto phase3;
	}

	printf("Entrez le numéro de la case VIDE sur laquelle vous souhaitez déplacer le pion séléctionné précédement (il ne vous reste que 3 pions donc vous pouvez déplacer le pion sur n'importe quel case vide)\n\n");
	int destination;
	scanf("%d",&destination);
	//test si le déplacement est invalide :
	//test si la case n'est pas vide
	if (p[destination].valeur != 0)
	{
		printf("Déplacement invalide, cette case n'est pas vide, Veuillez tout recommencer\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer (il ne vous reste que 3 pions donc vous pourrez déplacer le pion sur n'importe quel case vide)\n\n");
		goto phase3;
	}
		

	//déplacement du pion :
	p[depart].valeur = 0;
	p[depart].symbole = 35;			//#
	p[destination].valeur = tour_j;
	if (tour_j == 1)
	{
		p[destination].symbole = 88;		//O
	}
	else
	{
		p[destination].symbole = 79;		//X
	}
	return destination;
}

//Affiche le vainqueur et autres informations ?
void fin_de_partie(int perdant)
{
	int gagnant = 1;
	if (perdant == 1)
	{
		gagnant = 0;
	}
	printf("Le joueur %d a perdu !\n",perdant);
	printf("bravo au joueur %d !\n",gagnant);
	exit(0);
}

//teste si un coup est possible pour le joueur tour_j (renvoie 1 si oui, 0 sinon)
int test_coup_possible(t_case p[24], int tour_j)
{
	//itération sur toutes les cases du tableau
	for (int i = 0; i < 24; i++)
	{
		//test si la case appartient au joueur
		if (p[i].valeur == tour_j)
		{
			//test si la case à au moins un voisin vide
			if ( (p[i].vn != -1 && p[p[i].vn].valeur == 0) || (p[i].ve != -1 && p[p[i].ve].valeur == 0) || (p[i].vs != -1 && p[p[i].vs].valeur == 0) || (p[i].vo != -1 && p[p[i].vo].valeur == 0) )
			{
				return 1;
			}			
		}
	}
	return 0;
}


//##########################################
//			Main :
//##########################################

int main(void)
{
	//Definition des variables principales : (variables globales dans risc V)

	// Nombre de pièces sur le terrain
	int J1_nbr_de_pions = 0;
	int J2_nbr_de_pions = 0;

	// Phase du jeu (0 = fin du jeu ; 1 = pose des pions ; 2 = mouvement/saut des pions)
	int phase = 1;

	// tour de quel joueur (1 = tour de Joueur 1 ; 2 = tour de Joueur 2)
	int tour_j = 1;

	// numéro du tour (pour la phase 1)
	int tour = 0;

	// tableau des cases
	t_case plateau[24];


	//initialisation du plateau :
	initialisation(plateau);

	affiche_plateau(plateau);

	while (phase)		//boucle infinie du jeu jusqu'à ce que le jeu se finisse (phase = 0)
	{
		tour++;
		
		//selection de la phase du jeu :

		if (phase == 1)		// phase de pose des pions
		{
			//placement du pion par l'utilisateur
			int input = place_pion(plateau, tour_j, &J1_nbr_de_pions, &J2_nbr_de_pions);

			//test si un moulin a été formé avec la case jouée
			if(test_moulin(plateau, input))
			{
				//capture d'une pièce adverse si un moulin est formé
				capture(plateau, tour_j, &J1_nbr_de_pions, &J2_nbr_de_pions);
			}

			//Passage en phase 2 après le tour 18 :
			if (tour == 18)
			{
				phase = 2;
			}
		}
		else			 // phase de mouvement/sauts des pions
		{
			int input;
			//test si il ne reste que 3 pions au joueur actif :
			if ( (tour_j == 1 && J1_nbr_de_pions == 3) || (tour_j == 2 && J2_nbr_de_pions == 3) )
			{
				//saut du pion par l'utilisateur
				input = saut_pion(plateau, tour_j);
			}
			else
			{
				//test si il n'existe pas de coup possible
				if (!(test_coup_possible(plateau, tour_j)))
				{
					printf("Pas de coup possible pour le joueur %d\n",tour_j);
					fin_de_partie(tour_j);
				}
				//deplacement du pion par l'utilisateur
				input = deplace_pion(plateau, tour_j);
			}

			//test si un moulin a été formé avec la case jouée
			if(test_moulin(plateau, input))
			{
				//capture d'une pièce adverse si un moulin est formé
				capture(plateau, tour_j, &J1_nbr_de_pions, &J2_nbr_de_pions);
			}

			//Fin de partie lorseque un joueur a moins de 3 pions :
			if (J1_nbr_de_pions < 3 || J2_nbr_de_pions < 3)
			{
				phase = 0;
			}
		}
		
		printf("\n\n\n");
		printf("Tour numéro : %d\n",tour);
		printf("nombre de pions de J1 = %d\n", J1_nbr_de_pions);
		printf("nombre de pions de J2 = %d\n", J2_nbr_de_pions);
		printf("\n");
		affiche_plateau(plateau);
		printf("\n");

		//changement du tour
		if (tour_j == 1)
		{
			tour_j++;
		}
		else
		{
			tour_j--;
		}
	}

	//affiche les messages de fins et ferme le programme
	fin_de_partie(tour_j);	
	return 0;
}
