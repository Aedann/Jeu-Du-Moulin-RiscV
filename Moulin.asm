	.data

	# definition des chaines de characteres :

str_fin_de_partie_1_a : .asciz "Le joueur "
str_fin_de_partie_1_b : .asciz " a perdu !\n"
str_fin_de_partie_2_a : .asciz "bravo au joueur "
str_fin_de_partie_2_b : .asciz " !\n"
	
str_main_1_a:.asciz "Pas de coup possible pour le joueur "
str_main_1_b:.asciz " !\n"
str_main_newline:.asciz "\n"
str_main_3_a:.asciz "\n\n\nTour numéro : "
str_main_4_a:.asciz "\nnombre de pions de J1 = "
str_main_5_a:.asciz "\nnombre de pions de J2 = "

str_fct_capture_1_a:.asciz "Vous avez réalisé un moulin !\nToutes les pions adverses font partie d'un moulin, vous pouvez donc choisir n'importe quel pion adverse à capturer.\n"
str_fct_capture_2_a:.asciz "Vous avez réalisé un moulin !\nEntrez le numéro d'une case contenant un pion adverse que vous voulez capturer (ce pion ne peut pas faire partie d'un moulin)\n\n"
str_fct_capture_3_a:.asciz "Case entrée invalide, Veuillez recommencer\n"

str_affiche_plateau_1_a:.asciz "-----------"
str_affiche_plateau_1_b:.asciz "                         0-----------1-----------2\n"
str_affiche_plateau_2_a:.asciz "|           |           |                         |           |           |\n"  #Identique à L12
str_affiche_plateau_3_a:.asciz "|   "
str_affiche_plateau_3_b:.asciz "-------" #utilisee 4 fois
str_affiche_plateau_3_c:.asciz "   |                         |   3-------4-------5   |\n"
str_affiche_plateau_4_a:.asciz "|   |       |       |   |                         |   |       |       |   |\n" #Identique à L10
str_affiche_plateau_5_a:.asciz "|   |   " 	#Utilisee 2 fois
str_affiche_plateau_5_b:.asciz "---" 	#Utilisee 2 fois en L5 et L9 et 4 fois en L7
str_affiche_plateau_5_c:.asciz "   |   |                         |   |   6---7---8   |   |\n"
str_affiche_plateau_6_a:.asciz "|   |   |       |   |   |                         |   |   |       |   |   |\n"  #Identique à L8
str_affiche_plateau_7_a:.asciz "       "
str_affiche_plateau_7_b:.asciz "                         9---10--11      12--13--14\n"
str_affiche_plateau_9_b:.asciz "   |   |                         |   |   15--16--17  |   |\n"
str_affiche_plateau_11_b:.asciz"   |                         |   18------19------20  |\n"
str_affiche_plateau_13_b:.asciz "                         21----------22----------23\n"

str_place_pion_1_a:.asciz "Tour du Joueur "
str_place_pion_1_b:.asciz " :\nEntrez le numéro de la case vide sur laquelle vous voulez placer un pion\n\n"
str_place_pion_2_a:.asciz "Placement invalide, Veuillez recommencer\nEntrez le numéro de la case vide sur laquelle vous voulez placer un pion\n\n"

str_deplace_pion_1_a:.asciz "Tour du Joueur "
str_deplace_pion_1_b:.asciz " :\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer\n\n"
str_deplace_pion_2_a:.asciz "Case de départ invalide, Veuillez recommencer\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer\n\n"
str_deplace_pion_3_a:.asciz "Entrez le numéro de la case VIDE VOISINE sur laquelle vous souhaitez déplacer le pion séléctionné précédement\n\n"
str_deplace_pion_4_a:.asciz "Déplacement invalide, cette case n'est pas voisine, Veuillez tout recommencer\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer\n\n"

str_saut_pion_1_a:.asciz "Tour du Joueur "
str_saut_pion_1_b:.asciz " :\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer (il ne vous reste que 3 pions donc vous pourrez déplacer le pion sur n'importe quel case vide)\n\n"
str_saut_pion_2_a:.asciz "Case de départ invalide, Veuillez recommencer\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer (il ne vous reste que 3 pions donc vous pourrez déplacer le pion sur n'importe quel case vide)\n\n"
str_saut_pion_3_a:.asciz "Entrez le numéro de la case VIDE sur laquelle vous souhaitez déplacer le pion séléctionné précédement (il ne vous reste que 3 pions donc vous pouvez déplacer le pion sur n'importe quel case vide)\n\n"
str_saut_pion_4_a:.asciz "Déplacement invalide, cette case n'est pas vide, Veuillez tout recommencer\nEntrez le numéro de la case de VOTRE pion que vous souhaitez déplacer (il ne vous reste que 3 pions donc vous pourrez déplacer le pion sur n'importe quel case vide)\n\n"

	#Definition des variables globales :

	#Nombre de pièces sur le terrain
var_J1_nbr_de_pions : .word 0
var_J2_nbr_de_pions : .word 0

	#Phase du jeu (0 = fin du jeu ; 1 = pose des pions ; 2 = mouvement/saut des pions)
var_phase : .word 1

	#tour de quel joueur (1 = tour de Joueur 1 ; 2 = tour de Joueur 2)
var_tour_j : .word 1

	#numéro du tour (pour la phase 1)
var_tour : .word 0

	#tableau des cases (24 t_case ; taille d'une t_case = 1 int + 1 char + 4 int = 32 bits + 8 bits (32 bits quand alignés) + 32*4 bits => 6*32bits = 24 octets
var_tab_plateau : .space 576	#24 t_cases * 24 octets


	.text
main :
	#Affectation d'un bloc de pile pour le main
	addi sp, sp, -64
	addi fp, sp, 64

	#appel fonction fct_initialisation	(argument est deja une variable globale)
	jal fct_initialisation

	#appel fonction fct_affiche_plateau	(argument est deja une variable globale)
	jal fct_affiche_plateau

while_fct_main :		#while (phase)		//boucle infinie du jeu jusqu'à ce que le jeu se finisse (phase = 0)
	lw t0, var_phase	#t0 = phase
	beq t0, zero, suite_while_fct_main
	#code While :
	lw t1, var_tour		#t1 = tour
	addi t1, t1, 1		#tour++
	sw t1, var_tour, t2
	
	if_fct_main_1 :		#if (phase == 1)	// phase de pose des pions
		ori t3, zero, 1
		bne t0, t3, else_fct_main_1
		#code if :
		#//placement du pion par l'utilisateur :
		#appel fonction fct_place_pion	(argument sont deja des variables globales)
		jal fct_place_pion
		or a0, zero, a2		#a0 = retour de la fonction place_pion() ci dessus

		#appel fonction fct_test_moulin	(argument deja dans a0)
		jal fct_test_moulin
		or t0, zero, a0		#t0 = retour de la fonction test_moulin() ci dessus
		
		if_fct_main_2 :		#if(test_moulin(plateau, input))  <=> if (t0 != 0)
			beq t0, zero, suite_if_fct_main_2
			#code if :
			#//capture d'une pièce adverse si un moulin est formé
			#appel fonction fct_capture	(argument sont deja des variables globales)
			jal fct_capture
		suite_if_fct_main_2 :
		
		#//Passage en phase 2 après le tour 18 :
		if_fct_main_3 :	#if (tour == 18)
			lw t0, var_tour
			ori t1, zero, 18
			bne t0, t1, suite_if_fct_main_3
			#code if:
			ori t2, zero, 2 	#phase = t2 = 2
			sw t2, var_phase, t3
		suite_if_fct_main_3 :
		
		j suite_if_fct_main_1

	else_fct_main_1 :	 #// phase de mouvement/sauts des pions
	
		#//test si il ne reste que 3 pions au joueur actif :
		if_fct_main_4 : #if ( (tour_j == 1 && J1_nbr_de_pions == 3) || (tour_j == 2 && J2_nbr_de_pions == 3) )
		lw t0, var_tour_j
		ori t1, zero, 1
		ori t2, zero, 2
		ori t3, zero, 3
		lw t4, var_J1_nbr_de_pions
		lw t5, var_J2_nbr_de_pions
		
		bne t0, t1, test_if_fct_main_4			#if (tour_j != 1), jump to test_if_fct_main_4
			beq t4, t3, success_if_fct_main_4   	#if (J1_nbr_de_pions == 3), jump to success_if_fct_main_4
		test_if_fct_main_4:
		bne t0, t2, else_fct_main_4			#if (tour_j != 2), jump to else_fct_main_4
			beq t5, t3, success_if_fct_main_4   	#if (J1_nbr_de_pions == 3), jump to success_if_fct_main_4
		j else_fct_main_4

		success_if_fct_main_4 :
			#code if:
			#//saut du pion par l'utilisateur
			#appel fonction fct_saut_pion	(argument sont deja des variables globales)
			jal fct_saut_pion
			or s1, zero, a0		#input = s1 = retour de la fonction saut_pion() ci dessus
			j suite_if_fct_main_4
		else_fct_main_4 :
			#code else:
			#//test si il n'existe pas de coup possible
			#appel fonction fct_test_coup_possible	(argument sont deja des variables globales)
			jal fct_test_coup_possible
			or t0, zero, a0		#t0 = retour de la fonction test_coup_possible() ci dessus
			if_fct_main_5 :		#if (!(test_coup_possible(plateau, tour_j)))
				bne t0, zero, suite_if_fct_main_5
				#code if:
				#printf("Pas de coup possible pour le joueur %d\n",tour_j);
				
				ori a7,zero,4   #Print string "Pas de coup possible pour le joueur "
				la a0, str_main_1_a
				ecall

				ori a7,zero,11   #Print integer var_tour_j
				lw a0, var_tour_j
				ecall

				ori a7,zero,4   #Print string " !\n"
				la a0, str_main_1_b
				ecall

				j fct_fin_de_partie	#affiche les gagnants/perdants puis QUITTE le programme
			
			suite_if_fct_main_5 :
			#appel fonction fct_deplace_pion (argument sont deja des variables globales)
			jal fct_deplace_pion
			or s1, zero, a0		#input = s1 = retour de la fonction deplace_pion() ci dessus
		
		suite_if_fct_main_4 :
		#//test si un moulin a été formé avec la case jouée
		#appel fonction fct_test_moulin	(argument dans s1)
		or a0, zero, s1		#OUV
		jal fct_test_moulin
		or t0, zero, a0		#t0 = retour de la fonction test_moulin() ci dessus
		
		if_fct_main_6 :		#if(test_moulin(plateau, input))  <=> if (t0 != 0)
			beq t0, zero, suite_if_fct_main_6
			#code if :
			#//capture d'une pièce adverse si un moulin est formé
			#appel fonction fct_capture	(argument sont deja des var globales)
			jal fct_capture
		suite_if_fct_main_6 :
		
		#//Fin de partie lorseque un joueur a moins de 3 pions :
		if_fct_main_7 :	#if (J1_nbr_de_pions < 3 || J2_nbr_de_pions < 3)
		
			lw t0, var_J1_nbr_de_pions
			lw t1, var_J2_nbr_de_pions
			ori t2, zero, 3
		
			blt t0, t2, test_success_if_fct_main_7		# if (J1_nbr_de_pions < 3), jump to test_success_if_fct_main_7
			blt t1, t2, test_success_if_fct_main_7		# if (J2_nbr_de_pions < 3), jump to test_success_if_fct_main_7
			j suite_if_fct_main_7
		test_success_if_fct_main_7 :
			#code if:
			ori t0, zero, 0 	#phase = t0 = 0
			sw t0, var_phase, t1
		suite_if_fct_main_7 :

	suite_if_fct_main_1 :
	
		ori a7,zero,4   #Print string "\n\n\nTour numéro : "
		la a0, str_main_3_a
		ecall

		ori a7,zero,1   #Print integer var_tour
		lw a0, var_tour
		ecall

		ori a7,zero,4   #Print string "\nnombre de pions de J1 = "
		la a0, str_main_4_a
		ecall

		ori a7,zero,1   #Print integer var_J1_nbr_de_pions
		lw a0, var_J1_nbr_de_pions
		ecall

		ori a7,zero,4   #Print string "\nnombre de pions de J2 = "
		la a0, str_main_5_a
		ecall

		ori a7,zero,1   #Print integer var_J2_nbr_de_pions
		lw a0, var_J2_nbr_de_pions
		ecall

		ori a7,zero,4   #Print string "\n"
		la a0, str_main_newline
		ecall
		
		#appel fonction fct_affiche_plateau	(argument est deja une variable globale)
		jal fct_affiche_plateau

		ori a7,zero,4   #Print string "\n"
		la a0, str_main_newline
		ecall
	
		#//changement du tour
		if_fct_main_8 :	#if (tour_j == 1)
			lw t0, var_tour_j
			ori t1, zero, 1
			bne t0, t1, else_fct_main_8
			#code if:
			ori t0, zero, 2	#var_tour_j = 2
			sw t0, var_tour_j, t2
			j  suite_if_fct_main_8
		else_fct_main_8 :
			#code else:
			ori t0, zero, 1	#var_tour_j = 1
			sw t0, var_tour_j, t2
		suite_if_fct_main_8 :
	
	j while_fct_main

suite_while_fct_main :

	j fct_fin_de_partie	#affiche les gagnants/perdants puis QUITTE le programme
	#FIN MAIN




	#Fonction : initialise les valeurs du tableau avec des cases vides
fct_initialisation :
	addi sp, sp, -8		#PRO
	sw ra, 0(sp)		#PRO
	sw fp, 4(sp)		#PRO
	addi fp, sp, 8		#PRO
	
	#boucle for (int i = 0; i < 24; i++)
	add t0, zero, zero	# t0 = i = 0
for_fct_initialisation :
	slti t1, t0, 24		#test si i < 24 	resultat -> t1
	beq t1, zero, suite_for_fct_initialisation	#saut vers la fin du for loop si t1 = 0
	
	#code for :
	la t2, var_tab_plateau	# t2 = & plateau
	ori t5, zero, 24	# t5 = 24
	mul t3, t0, t5		# t3 = i*24 	(offset de l'& case i)
	add t3, t3, t2		# t3 = & plateau + offset de l'& case i = & case i
	li t4, 0		# t4 = valeur à stocker
	sw t4, 0(t3)		#p[i].valeur = 0;	//case vide
	li t4, 35
	sw t4, 4(t3)		#p[i].symbole = 35;	// 35 correspond à '#' en ascii
	li t4, -1
	sw t4, 8(t3)		#p[i].vn = -1;		//pas de voisin nord
	sw t4, 12(t3)		#p[i].ve = -1;		//pas de voisin est
	sw t4, 16(t3)		#p[i].vs = -1;		//pas de voisin sud
	sw t4, 20(t3)		#p[i].vo = -1;		//pas de voisin ouest	
	
	addi t0, t0, 1		#i++
	j for_fct_initialisation
suite_for_fct_initialisation :	#fin boucle for

	#mise en place des voisins :

	la t0, var_tab_plateau	# t0 = & plateau

	li t1, 1		# t1 = valeur à stocker
	sw t1, 12(t0)		#p[0].ve = 1;		0*24 + 3*4
	li t1, 9
	sw t1, 16(t0)		#p[0].vs = 9;		0*24 + 4*4

	li t1, 2
	sw t1, 36(t0)		#p[1].ve = 2;		1*24 + 3*4
	li t1, 4
	sw t1, 40(t0)		#p[1].vs = 4;		1*24 + 4*4
	li t1, 0
	sw t1, 44(t0)		#p[1].vo = 0;		1*24 + 5*4

	li t1, 14
	sw t1, 64(t0)		#p[2].vs = 14;		2*24 + 4*4
	li t1, 1
	sw t1, 68(t0)		#p[2].vo = 1;		2*24 + 5*4

        li t1,4 
        sw t1,84(t0)            #p[3].ve = 4;         3*24 + 3*4 
        li t1,10 
        sw t1,88(t0)            #p[3].vs = 10;         3*24 + 4*4 

        li t1,1 
        sw t1,104(t0)           #p[4].vn = 1;         4*24 + 2*4 
        li t1,5 
        sw t1,108(t0)           #p[4].ve = 5;         4*24 + 3*4 
        li t1,7 
        sw t1,112(t0)           #p[4].vs = 7;         4*24 + 4*4 
        li t1,3 
        sw t1,116(t0)           #p[4].vo = 3;         4*24 + 5*4 
        li t1,13 

        sw t1,136(t0)           #p[5].vs = 13;         5*24 + 4*4 
        li t1,4 
        sw t1,140(t0)           #p[5].vo = 4;         5*24 + 5*4 
        li t1,7 

        sw t1,156(t0)           #p[6].ve = 7;         6*24 + 3*4 
        li t1,11 
        sw t1,160(t0)           #p[6].vs = 11;         6*24 + 4*4 
        li t1,4 

        sw t1,176(t0)           #p[7].vn = 4;         7*24 + 2*4 
        li t1,8 
        sw t1,180(t0)           #p[7].ve = 8;         7*24 + 3*4 
        li t1,6 
        sw t1,188(t0)           #p[7].vo = 6;         7*24 + 5*4 
        li t1,12 

        sw t1,208(t0)           #p[8].vs = 12;         8*24 + 4*4 
        li t1,7 
        sw t1,212(t0)           #p[8].vo = 7;         8*24 + 5*4 
        li t1,0 

        sw t1,224(t0)           #p[9].vn = 0;         9*24 + 2*4 
        li t1,10 
        sw t1,228(t0)           #p[9].ve = 10;         9*24 + 3*4 
        li t1,21 
        sw t1,232(t0)           #p[9].vs = 21;         9*24 + 4*4 
        li t1,3 

        sw t1,248(t0)           #p[10].vn = 3;         10*24 + 2*4 
        li t1,11 
        sw t1,252(t0)           #p[10].ve = 11;         10*24 + 3*4 
        li t1,18 
        sw t1,256(t0)           #p[10].vs = 18;         10*24 + 4*4 
        li t1,9 
        sw t1,260(t0)           #p[10].vo = 9;         10*24 + 5*4 
        li t1,6 

        sw t1,272(t0)           #p[11].vn = 6;         11*24 + 2*4 
        li t1,15 
        sw t1,280(t0)           #p[11].vs = 15;         11*24 + 4*4 
        li t1,10 
        sw t1,284(t0)           #p[11].vo = 10;         11*24 + 5*4 
        li t1,8 

        sw t1,296(t0)           #p[12].vn = 8;         12*24 + 2*4 
        li t1,13 
        sw t1,300(t0)           #p[12].ve = 13;         12*24 + 3*4 
        li t1,17 
        sw t1,304(t0)           #p[12].vs = 17;         12*24 + 4*4 
        li t1,5 

        sw t1,320(t0)           #p[13].vn = 5;         13*24 + 2*4 
        li t1,14 
        sw t1,324(t0)           #p[13].ve = 14;         13*24 + 3*4 
        li t1,20 
        sw t1,328(t0)           #p[13].vs = 20;         13*24 + 4*4 
        li t1,12 
        sw t1,332(t0)           #p[13].vo = 12;         13*24 + 5*4 
        li t1,2 

        sw t1,344(t0)           #p[14].vn = 2;         14*24 + 2*4 
        li t1,23 
        sw t1,352(t0)           #p[14].vs = 23;         14*24 + 4*4 
        li t1,13 
        sw t1,356(t0)           #p[14].vo = 13;         14*24 + 5*4 
        li t1,11 

        sw t1,368(t0)           #p[15].vn = 11;         15*24 + 2*4 
        li t1,16 
        sw t1,372(t0)           #p[15].ve = 16;         15*24 + 3*4 
        li t1,17 

        sw t1,396(t0)           #p[16].ve = 17;         16*24 + 3*4 
        li t1,19 
        sw t1,400(t0)           #p[16].vs = 19;         16*24 + 4*4 
        li t1,15 
        sw t1,404(t0)           #p[16].vo = 15;         16*24 + 5*4 
        li t1,12 

        sw t1,416(t0)           #p[17].vn = 12;         17*24 + 2*4 
        li t1,16 
        sw t1,428(t0)           #p[17].vo = 16;         17*24 + 5*4 
        li t1,10 

        sw t1,440(t0)           #p[18].vn = 10;         18*24 + 2*4 
        li t1,19 
        sw t1,444(t0)           #p[18].ve = 19;         18*24 + 3*4 
        li t1,16 

        sw t1,464(t0)           #p[19].vn = 16;         19*24 + 2*4 
        li t1,20 
        sw t1,468(t0)           #p[19].ve = 20;         19*24 + 3*4 
        li t1,22 
        sw t1,472(t0)           #p[19].vs = 22;         19*24 + 4*4 
        li t1,18 
        sw t1,476(t0)           #p[19].vo = 18;         19*24 + 5*4 
        li t1,13 

        sw t1,488(t0)           #p[20].vn = 13;         20*24 + 2*4 
        li t1,19 
        sw t1,500(t0)           #p[20].vo = 19;         20*24 + 5*4 
        li t1,9 

        sw t1,512(t0)           #p[21].vn = 9;         21*24 + 2*4 
        li t1,22 
        sw t1,516(t0)           #p[21].ve = 22;         21*24 + 3*4 
        li t1,19 

        sw t1,536(t0)           #p[22].vn = 19;         22*24 + 2*4 
        li t1,23 
        sw t1,540(t0)           #p[22].ve = 23;         22*24 + 3*4 
        li t1,21 
        sw t1,548(t0)           #p[22].vo = 21;         22*24 + 5*4 
        li t1,14 

        sw t1,560(t0)           #p[23].vn = 14;         23*24 + 2*4 
        li t1,22 
        sw t1,572(t0)           #p[23].vo = 22;         23*24 + 5*4 

	lw ra, 0(sp)		#EPI
	lw fp, 4(sp)		#EPI
	addi sp, sp, 8		#EPI
	jr ra			#EPI
	#FIN
	

# Fonction d'affichage du plateau
fct_affiche_plateau : 
	addi sp, sp, -8		#PRO
	sw ra, 0(sp)		#PRO
	sw fp, 4(sp)		#PRO
	addi fp, sp, 8		#PRO
	
	la t2, var_tab_plateau	# t2 = & plateau

	ori a7,zero,11   #Print p[0].symbole
	lw a0,4(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_1_a
	ecall

	ori a7,zero,11   #Print p[1].symbole
	lw a0,28(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_1_a
	ecall

	ori a7,zero,11   #Print p[2].symbole
	lw a0,52(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_1_b
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_2_a
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_3_a
	ecall

	ori a7,zero,11   #Print p[3].symbole
	lw a0,76(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_3_b
	ecall

	ori a7,zero,11   #Print p[4].symbole
	lw a0,100(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_3_b
	ecall

	ori a7,zero,11   #Print p[5].symbole
	lw a0,124(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_3_c
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_4_a
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_5_a
	ecall

	ori a7,zero,11   #Print p[6].symbole
	lw a0,148(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_5_b
	ecall

	ori a7,zero,11   #Print p[7].symbole
	lw a0,172(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_5_b
	ecall

	ori a7,zero,11   #Print p[8].symbole
	lw a0,196(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_5_c
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_6_a
	ecall

	ori a7,zero,11   #Print p[9].symbole
	lw a0,220(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_5_b
	ecall

	ori a7,zero,11   #Print p[10].symbole
	lw a0,244(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_5_b
	ecall

	ori a7,zero,11   #Print p[11].symbole
	lw a0,268(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_7_a
	ecall

	ori a7,zero,11   #Print p[12].symbole
	lw a0,292(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_5_b
	ecall

	ori a7,zero,11   #Print p[13].symbole
	lw a0,316(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_5_b
	ecall

	ori a7,zero,11   #Print p[14].symbole
	lw a0,340(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_7_b
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_6_a
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_5_a
	ecall

	ori a7,zero,11   #Print p[15].symbole
	lw a0,364(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_5_b
	ecall

	ori a7,zero,11   #Print p[16].symbole
	lw a0,388(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_5_b
	ecall

	ori a7,zero,11   #Print p[17].symbole
	lw a0,412(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_9_b
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_4_a
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_3_a
	ecall

	ori a7,zero,11   #Print p[18].symbole
	lw a0,436(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_3_b
	ecall


	ori a7,zero,11   #Print p[19].symbole
	lw a0,460(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_3_b
	ecall

	ori a7,zero,11   #Print p[20].symbole
	lw a0,484(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_11_b
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_2_a
	ecall

	ori a7,zero,11   #Print p[21].symbole
	lw a0,508(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_1_a
	ecall

	ori a7,zero,11   #Print p[22].symbole
	lw a0,532(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_1_a
	ecall

	ori a7,zero,11   #Print p[23].symbole
	lw a0,556(t2)
	ecall

	ori a7,zero,4   #Print string
	la a0,str_affiche_plateau_13_b
	ecall

	lw ra, 0(sp)		#EPI
	lw fp, 4(sp)		#EPI
	addi sp, sp, 8		#EPI
	jr ra			#EPI
	#FIN

	
#Fonction qui teste si la case entree en parametre fait partie d'un moulin
#retourne 1 si la case fait partie d'un moulin et 0 sinon
fct_test_moulin : 
	#TO DO : écrire la fonction
	addi sp, sp, -48	#PRO
	sw ra, 0(sp)		#PRO
	sw fp, 4(sp)		#PRO
	sw s1, 8(sp)		#PRO
	sw s2, 12(sp)		#PRO
	sw s3, 16(sp)		#PRO
	sw s4, 20(sp)		#PRO
	sw s5, 24(sp)		#PRO
	sw s6, 28(sp)		#PRO
	sw s8, 32(sp)		#PRO
	sw s9, 36(sp)		#PRO
	sw s10, 40(sp)		#PRO
	sw s11, 44(sp)		#PRO
	addi fp, sp, 48		#PRO

	#//Registres stockant les Statuts des voisins, le statut correspond à un 1 si le voisin en question appartient aussi au joueur actif
	ori s8, zero, 0		#s8 = voisin Nord status
	ori s9, zero, 0		#s9 = voisin Est status
	ori s10, zero, 0	#s10 = voisin Sud status
	ori s11, zero, 0	#s11 = voisin Ouest status

	#enregistrement dans des registres des valeurs/adresses utilisées plusieurs fois ci dessous
	or s1, zero, a0		#s1 = num_case = argument fonction
	la s2, var_tab_plateau	#s2 = &plateau
	ori s3, zero, 24	#s3 = 24
	mul s4, s1, s3		#s4 = num_case * 24
	add s4, s4, s2		#s4 = &p[num_case]
	lw s5, 0(s4)		#s5 = p[num_case].valeur
	ori s6, zero, -1	#s6 = -1

	#//test vers le nord	
	if_fct_test_moulin_1 : 	#if (p[num_case].vn != -1)	//test si il existe une case au nord
		lw t1,8(s4)		#t1 = p[num_case].vn
		beq t1, s6, suite_if_fct_test_moulin_1
		#code if:
		if_fct_test_moulin_2 :	#if (p[p[num_case].vn].valeur == p[num_case].valeur)	//test si la valeur de la case nord est identique
			mul t2, t1, s3		#t2 = p[num_case].vn * 24
			add t2, t2, s2		#t2 = &p[p[num_case].vn]
			lw t3, 0(t2)		#t3 = p[p[num_case].vn].valeur
			bne t3, s5, suite_if_fct_test_moulin_2
			#code if:
			ori s8, zero, 1		#//case voisine nord appartient aussi au joueur
			if_fct_test_moulin_3 :	#if (p[p[num_case].vn].vn != -1)	//test si il existe une case au double nord
				lw t3, 8(t2)		#t3 = p[p[num_case].vn].vn
				beq t3, s6, suite_if_fct_test_moulin_3
				#code if:
				if_fct_test_moulin_4 :	#if (p[p[p[num_case].vn].vn].valeur == p[num_case].valeur)	//test si la valeur de la case double nord est identique
					mul t4, t3, s3		#t4 = p[p[num_case].vn].vn * 24
					add t4, t4, s2		#t4 = &p[p[p[num_case].vn].vn]
					lw t5, 0(t4)		#t5 = p[p[p[num_case].vn].vn].valeur
					bne t5, s5, suite_if_fct_test_moulin_4
					#code if:
					j return_success_fct_test_moulin	#return 1
				suite_if_fct_test_moulin_4 :
			suite_if_fct_test_moulin_3 :
		suite_if_fct_test_moulin_2 :
	suite_if_fct_test_moulin_1 :
	
	#//test vers l'Est
	if_fct_test_moulin_5 : 	#if (p[num_case].ve != -1)	//test si il existe une case à l'Est
		lw t1,12(s4)		#t1 = p[num_case].ve
		beq t1, s6, suite_if_fct_test_moulin_5
		#code if:
		if_fct_test_moulin_6 :	#if (p[p[num_case].ve].valeur == p[num_case].valeur)	//test si la valeur de la case Est est identique
			mul t2, t1, s3		#t2 = p[num_case].ve * 24
			add t2, t2, s2		#t2 = &p[p[num_case].ve]
			lw t3, 0(t2)		#t3 = p[p[num_case].ve].valeur
			bne t3, s5, suite_if_fct_test_moulin_6
			#code if:
			ori s9, zero, 1		#//case voisine Est appartient aussi au joueur
			if_fct_test_moulin_7 :	#if (p[p[num_case].ve].ve != -1)	//test si il existe une case au double Est
				lw t3, 12(t2)		#t3 = p[p[num_case].ve].ve
				beq t3, s6, suite_if_fct_test_moulin_7
				#code if:
				if_fct_test_moulin_8 :	#if (p[p[p[num_case].ve].ve].valeur == p[num_case].valeur)	//test si la valeur de la case double Est est identique
					mul t4, t3, s3		#t4 = p[p[num_case].ve].ve * 24
					add t4, t4, s2		#t4 = &p[p[p[num_case].ve].ve]
					lw t5, 0(t4)		#t5 = p[p[p[num_case].ve].ve].valeur
					bne t5, s5, suite_if_fct_test_moulin_8
					#code if:
					j return_success_fct_test_moulin	#return 1
				suite_if_fct_test_moulin_8 :
			suite_if_fct_test_moulin_7 :
		suite_if_fct_test_moulin_6 :
	suite_if_fct_test_moulin_5 :
	
	#//test vers le Sud
	if_fct_test_moulin_9 : 	#if (p[num_case].vs != -1)	//test si il existe une case au sud
		lw t1,16(s4)		#t1 = p[num_case].vs
		beq t1, s6, suite_if_fct_test_moulin_9
		#code if:
		if_fct_test_moulin_10 :	#if (p[p[num_case].vs].valeur == p[num_case].valeur)	//test si la valeur de la case Sud est identique
			mul t2, t1, s3		#t2 = p[num_case].vs * 24
			add t2, t2, s2		#t2 = &p[p[num_case].vs]
			lw t3, 0(t2)		#t3 = p[p[num_case].vs].valeur
			bne t3, s5, suite_if_fct_test_moulin_10
			#code if:
			ori s10, zero, 1	#//case voisine Sud appartient aussi au joueur
			if_fct_test_moulin_11 :	#if (p[p[num_case].vs].vs != -1)	//test si il existe une case au double Sud
				lw t3, 16(t2)		#t3 = p[p[num_case].vs].vs
				beq t3, s6, suite_if_fct_test_moulin_11
				#code if:
				if_fct_test_moulin_12 :	#if (p[p[p[num_case].vs].vs].valeur == p[num_case].valeur)	//test si la valeur de la case double Sud est identique
					mul t4, t3, s3		#t4 = p[p[num_case].vs].vs * 24
					add t4, t4, s2		#t4 = &p[p[p[num_case].vs].vs]
					lw t5, 0(t4)		#t5 = p[p[p[num_case].vs].vs].valeur
					bne t5, s5, suite_if_fct_test_moulin_12
					#code if:
					j return_success_fct_test_moulin	#return 1
				suite_if_fct_test_moulin_12 :
			suite_if_fct_test_moulin_11 :
		suite_if_fct_test_moulin_10 :
	suite_if_fct_test_moulin_9 :
	
	#//test vers l'Ouest
	if_fct_test_moulin_13 : 	#if (p[num_case].vo != -1)	//test si il existe une case à l'Ouest
		lw t1,20(s4)		#t1 = p[num_case].vo
		beq t1, s6, suite_if_fct_test_moulin_13
		#code if:
		if_fct_test_moulin_14 :	#if (p[p[num_case].vo].valeur == p[num_case].valeur)	//test si la valeur de la case Ouest est identique
			mul t2, t1, s3		#t2 = p[num_case].vo * 24
			add t2, t2, s2		#t2 = &p[p[num_case].vo]
			lw t3, 0(t2)		#t3 = p[p[num_case].vo].valeur
			bne t3, s5, suite_if_fct_test_moulin_14
			#code if:
			ori s11, zero, 1		#//case voisine Ouest appartient aussi au joueur
			if_fct_test_moulin_15 :	#if (p[p[num_case].vo].vo != -1)	//test si il existe une case au double Ouest
				lw t3, 20(t2)		#t3 = p[p[num_case].vo].vo
				beq t3, s6, suite_if_fct_test_moulin_15
				#code if:
				if_fct_test_moulin_16 :	#if (p[p[p[num_case].vo].vo].valeur == p[num_case].valeur)	//test si la valeur de la case double Ouest est identique
					mul t4, t3, s3		#t4 = p[p[num_case].vo].vo * 24
					add t4, t4, s2		#t4 = &p[p[p[num_case].vo].vo]
					lw t5, 0(t4)		#t5 = p[p[p[num_case].vo].vo].valeur
					bne t5, s5, suite_if_fct_test_moulin_16
					#code if:
					j return_success_fct_test_moulin	#return 1
				suite_if_fct_test_moulin_16 :
			suite_if_fct_test_moulin_15 :
		suite_if_fct_test_moulin_14 :
	suite_if_fct_test_moulin_13 :
	
	#//test si la case est au milieu d'un moulin
	if_fct_test_moulin_17 : #if ((voisin Nord status && voisin Sud status) || (voisin Est status && voisin Ouest status))
		and t0, s8, s10		#t0 = (voisin Nord status && voisin Sud status)
		and t1, s9, s11		#t1 = (voisin Est status && voisin Ouest status)
		or t2, t0, t1		#t2 = ((voisin Nord status && voisin Sud status) || (voisin Est status && voisin Ouest status))
		bne t2, zero, return_success_fct_test_moulin

	ori a0, zero, 0				#return 0
	j exit_fct_test_moulin
	
	return_success_fct_test_moulin : 	#return 1
	ori a0, zero, 1
	
	exit_fct_test_moulin :

	lw ra, 0(sp)		#EPI
	lw fp, 4(sp)		#EPI
	lw s1, 8(sp)		#EPI
	lw s2, 12(sp)		#EPI
	lw s3, 16(sp)		#EPI
	lw s4, 20(sp)		#EPI
	lw s5, 24(sp)		#EPI
	lw s6, 28(sp)		#EPI
	lw s8, 32(sp)		#EPI
	lw s9, 36(sp)		#EPI
	lw s10, 40(sp)		#EPI
	lw s11, 44(sp)		#EPI
	addi sp, sp, 48		#EPI
	jr ra			#EPI
	#FIN
	
#teste si une capture est possible, si oui demande à l'utilisateur la case à capturer et effectue la capture
fct_capture : 
	#TO DO : écrire la fonction
	addi sp, sp, -32	#PRO
	sw ra, 0(sp)		#PRO
	sw fp, 4(sp)		#PRO
	sw s1, 8(sp)		#PRO
	sw s2, 12(sp)		#PRO
	sw s3, 16(sp)		#PRO
	sw s4, 20(sp)		#PRO
	sw s5, 24(sp)		#PRO
	sw s6, 28(sp)		#PRO
	addi fp, sp, 32		#PRO

	la s1, var_tab_plateau	#s1 = &plateau
	lw s2, var_tour_j	#s2 = var_tour_j


	#//test si il existe une case adverse ne fesant pas partie d'un moulin :

	ori s3, zero, 1		#s3 = int tous_moulins = 1;

	#//itération sur toutes les cases du tableau
	addi s4, zero, 0	#s4 = int i = 0
	ori s5, zero, 24	#s5 = 24
	for_fct_capture : 	#for (int i = 0; i < 24; i=i++)
		bge s4, s5, suite_for_fct_capture
		#code for:
		#//test si la case appartient à l'adversaire
		if_fct_capture_1 :	#if (p[i].valeur != tour_j && p[i].valeur != 0)
			mul t3, s4, s5		#t3 = i*24
			add t3, t3, s1		#t3 = &p[i]
			lw t4, 0(t3)		#t4 = p[i].valeur
			beq t4, s2, suite_if_fct_capture_1
			beq t4, zero, suite_if_fct_capture_1
			#code if:
			if_fct_capture_2 :	#//test si la case adverse ne fait pas partie d'un moulin
				#appel fonction fct_test_moulin	(argument dans s4)
				or a0, zero, s4		#OUV	#Argument
				jal fct_test_moulin
				or t0, zero, a0		#t0 = retour de la fonction test_moulin() ci dessus
				bne t0, zero, suite_if_fct_capture_2
				#code if :
				ori s3, zero, 0		#s3 = tous_moulins = 0;
			suite_if_fct_capture_2 :
		suite_if_fct_capture_1 :
		#fin code for:
		addi s4, s4, 1
		j for_fct_capture
	suite_for_fct_capture :

	if_fct_capture_3 : 	#if (tous_moulins)	//toutes les cases adverses font partie d'un moulin
		beq s3, zero, else_fct_capture_3
		#code if:
		ori a7,zero,4   #Print string	"Vous avez réalisé un moulin !\nToutes les pions adverses font partie d'un moulin, vous pouvez donc choisir n'importe quel pion adverse à capturer.\n"
		la a0, str_fct_capture_1_a
		ecall
		j suite_if_fct_capture_3
	else_fct_capture_3:			#//il y a au moins une case adverse ne fesant pas partie d'un moulin
		ori a7,zero,4   #Print string	"Vous avez réalisé un moulin !\nEntrez le numéro d'une case contenant un pion adverse que vous voulez capturer (ce pion ne peut pas faire partie d'un moulin)\n\n"
		la a0, str_fct_capture_2_a
		ecall
	suite_if_fct_capture_3 :
		
	#Capture :
	capture_fct_capture:
	ori a7,zero,5	#scanf("%d");
	ecall
	or s6, zero, a0	#s6 = input
	#//test si le placement est invalide
	if_fct_capture_4 : #if ( (input < 0) || (input > 23) || (p[input].valeur == tour_j) || (p[input].valeur == 0) || ((test_moulin(p, input)) && !(tous_moulins)) )	//error bc out of range
		blt s6, zero, if_success_fct_capture_4	#test (input < 0)
		ori t0, zero, 24
		bge s6, t0, if_success_fct_capture_4	#test (input > 23)
		mul t0, s6, s5		#t0 = input*24
		add t0, t0, s1		#t0 = &p[input]
		lw t1, 0(t0)		#t1 = p[input].valeur
		beq t1, s2, if_success_fct_capture_4	#test (p[input].valeur == tour_j)
		beq t1, zero, if_success_fct_capture_4	#test (p[input].valeur == 0)

		#appel fonction fct_test_moulin	(argument déjà dans a0)
		jal fct_test_moulin
		or t0, zero, a0		#t0 = retour de la fonction test_moulin() ci dessus
		beq t0, zero, suite_if_fct_capture_4	#test (test_moulin() == 0) -> jump to suite_if
		beq s3, zero, if_success_fct_capture_4	#test (tous_moulins == 0) -> jump to sucess_if
		#si on est arrivé ici, toutes les conditions testées étaient fausses -> jump to suite_if
		j suite_if_fct_capture_4
	if_success_fct_capture_4 :
		#code if:
		ori a7,zero,4   #Print string	"Case entrée invalide, Veuillez recommencer\n"
		la a0, str_fct_capture_3_a
		ecall
		j capture_fct_capture	#on redemande à l'utilisateur d'entrer un nombre
	suite_if_fct_capture_4 :


	#//Capture du pion :
	mul t0, s6, s5		#t0 = input*24
	add t0, t0, s1		#t0 = &p[input]
	sw zero, 0(t0)		#p[input].valeur = 0;
	ori t1, zero, 35	#t1 = 35 = symbole '#'
	sb t1, 4(t0)		#p[input].symbole = 35

	#//reduction du nombre de pions du joueur adverse:
	if_fct_capture_5 :	#if (tour_j == 1)
		ori t0, zero, 1
		bne s2, t0, else_fct_capture_5
		#code if:
		lw t1, var_J2_nbr_de_pions
		sub t1, t1, t0	#var_J2_nbr_de_pions--	
		sw t1, var_J2_nbr_de_pions, t6
		j suite_if_fct_capture_5
	else_fct_capture_5 :
		lw t1, var_J1_nbr_de_pions
		sub t1, t1, t0	#var_J1_nbr_de_pions--	
		sw t1, var_J1_nbr_de_pions, t6
	suite_if_fct_capture_5 :

	lw ra, 0(sp)		#EPI
	lw fp, 4(sp)		#EPI
	lw s1, 8(sp)		#EPI
	lw s2, 12(sp)		#EPI
	lw s3, 16(sp)		#EPI
	lw s4, 20(sp)		#EPI
	lw s5, 24(sp)		#EPI
	lw s6, 28(sp)		#EPI
	addi sp, sp, 32		#EPI
	jr ra			#EPI
	#FIN

#demande à l'utilisateur de placer un pion, puis le place dans le plateau si placement valable:
#retourne l'indice de la case jouée
fct_place_pion :
	#TO DO : écrire la fonction
	addi sp, sp, -8	#PRO
	sw ra, 0(sp)		#PRO
	sw fp, 4(sp)		#PRO
	addi fp, sp, 8		#PRO
	
	la a0, str_place_pion_1_a	#Tour du Joueur :
	ori a7,zero,4   		#Print string
	ecall

	la t2, var_tour_j		#t2 = @var_tour_j
	lw t5,0(t2)			#t5 = var_tour_j
	
	ori a7,zero,1   
	or a0,zero,t5
	ecall				#Print tour_j

	la a0, str_place_pion_1_b	#Tour du Joueur :
	ori a7,zero,4   		#Print string
	ecall

	if_place_pion_1:
		ori a7,zero,5   		#Read integer input
		ecall
		ori a2,a0,0			#retourne dans a2 = a0

		ori t2,zero,0
		blt a2,t2,else_place_pion_1 	#Jump if input<0 :
		ori t2,zero,23
		blt t2,a2,else_place_pion_1 	#Jump if 23<input :
	
		la t4, var_tab_plateau		#t4 = &plateau
		ori t3, zero, 24
		mul t1,a2,t3			#input*24
		add t1,t1,t4
		lw t3,0(t1)			#t3 = p[input].valeur		#Et modifié sa pour que sa compile, non testé
		bne t3,zero,else_place_pion_1	#Jump if p[input].valeur == 0

		sw t5, 0(t1)			#p[input].valeur = tour_j	#Et modifié sa pour que sa compile, non testé
	
		j fin_if_place_pion_1
		else_place_pion_1:
			la a0, str_place_pion_2_a	#Placement invalide...
			ori a7,zero,4   		#Print string
			ecall
			j if_place_pion_1
	fin_if_place_pion_1 :
	

	if_place_pion_2 :
		ori t2,zero,1
		bne t5,t2,fin_if_place_pion_2   #If tour_j = 1 :

		la t4, var_J1_nbr_de_pions	#t4 = &J1_nbr_de_pions
		lw t2,0(t4)			#t2 = J1_nbr_de_pions
		addi t3,t2,1			#t3 = t2 + 1
		sw t3,0(t4)			#J1_nbr_de_pions = t3

		addi t4, t1, 4			#t4 = var_tab_plateau[input].valeur + 4 
		ori t3,zero,88			#t3 = 88
		sw t3,0(t4)			#var_tab_plateau[input].symbole = 88
	fin_if_place_pion_2:

	if_place_pion_3 :
		ori t2,zero,2
		bne t5,t2,fin_if_place_pion_3	#If tour_j = 2 :

		la t4, var_J2_nbr_de_pions	#t4 = &J2_nbr_de_pions
		lw t2,0(t4)			#t2 = J2_nbr_de_pions
		addi t3,t2,1			#t3 = t2 + 1
		sw t3,0(t4)			#J2_nbr_de_pions = t3

		la t4, var_tab_plateau		#t4 = &var_tab_plateau
		addi t4, t1, 4			#t4 = var_tab_plateau[input].valeur + 4 
		ori t3,zero,79			#t3 = 79
		sw t3,0(t4)			#var_tab_plateau[input].symbole = 79
	fin_if_place_pion_3:

	lw ra, 0(sp)		#EPI
	lw fp, 4(sp)		#EPI
	addi sp, sp, 8		#EPI
	jr ra			#EPI
	#FIN

#demande à l'utilisateur le pion à déplacer et la case de destination, puis le déplace si le déplacement est valable:
#retourne l'indice de la case de destination
fct_deplace_pion :

	addi sp, sp, -12	#PRO
	sw ra, 0(sp)		#PRO
	sw fp, 4(sp)		#PRO
	sw s3, 8(sp)		#PRO
	addi fp, sp, 12		#PRO
	
	la a0, str_deplace_pion_1_a	#Tour du Joueur :
	ori a7,zero,4   		#Print string
	ecall

	la t2, var_tour_j
	lw t5,0(t2)			#t5 prend var_tour_j
	
	ori a7,zero,1   
	or a0,zero,t5
	ecall				#Print tour_j

	la a0, str_deplace_pion_1_b	# :\nEntrez le numéro de la case de VOTRE...
	ori a7,zero,4   		#Print string
	ecall

	if_deplace_pion_1:
		ori a7,zero,5   		#Read integer depart
		ecall
		ori s3,a0,0			#s3 = input

		ori t2,zero,0
		blt s3,t2,code_if_deplace_pion_1 #Jump if input<0 :
		ori t2,zero,23
		blt t2,s3,code_if_deplace_pion_1 #Jump if 23<input :
	
		la t4, var_tab_plateau		#t4 = &plateau
		ori t3, zero, 24
		mul t1,s3,t3
		add t1,t1,t4
		lw t3,0(t1)			#t3 = p[input].valeur
		bne t3,t5,code_if_deplace_pion_1 #Jump if p[input].valeur != var_tour_j
	
		j fin_if_deplace_pion_1
		code_if_deplace_pion_1:
			la a0, str_deplace_pion_2_a	#Case de départ invalide ....
			ori a7,zero,4   		#Print string
			ecall
			j if_deplace_pion_1
	fin_if_deplace_pion_1 :
	
	la a0, str_deplace_pion_3_a	#Entrez le numéro de la case VIDE VOISINE...
	ori a7,zero,4   		#Print string
	ecall
	
	ori a7,zero,5   		#Read integer destination
	ecall	
	or t6,zero,a0
	
	if_deplace_pion_2 :
		ori t3,zero,24
		mul t3,s3,t3		#t3 = depart*24
		add t0,t4,t3		#t0 = &p[depart]
		lw t2, 8(t0)		#t2 = p[depart].vn
		beq t2,t6,fin_if_deplace_pion_2 #p[depart].vn == destination
		lw t2, 12(t0)		#t2 = p[depart].ve
		beq t2,t6,fin_if_deplace_pion_2 #p[depart].ve == destination
		lw t2, 16(t0)		#t2 = p[depart].vs
		beq t2,t6,fin_if_deplace_pion_2 #p[depart].vs == destination
		lw t2, 20(t0)		#t2 = p[depart].vo
		beq t2,t6,fin_if_deplace_pion_2 #p[depart].vo != destination
		
		j success_deplace_pion_2
	
	success_deplace_pion_2 :
		la a0, str_deplace_pion_4_a	#Déplacement invalide, cette case...
		ori a7,zero,4   		#Print string
		ecall
		
		j if_deplace_pion_1
	fin_if_deplace_pion_2 :
	
	if_deplace_pion_3 :
		ori t3,zero,24
		mul t3,t6,t3		#t3 = destination*24
		add t0,t4,t3		#t0 = &p[destination]
		lw t2,0(t0)
		bne t2,zero,success_deplace_pion_3
		j fin_if_deplace_pion_3
	success_deplace_pion_3 :
		la a0, str_deplace_pion_4_a	#Déplacement invalide, cette case...
		ori a7,zero,4   		#Print string
		ecall
		
		j if_deplace_pion_1
	fin_if_deplace_pion_3 :

	la t2, var_tour_j
	lw t2,0(t2)			#t2 prend var_tour_j
	
	ori t4,zero,24
	mul t1,t4,s3			#t1 = 24*depart
	la t4, var_tab_plateau		#t4 = &var_tab_plateau
	add t1, t4, t1			#t1 = &var_tab_plateau[depart].valeur
	ori t3,zero,0			#t3 = 0
	sw t3,0(t1)			#var_tab_plateau[depart].valeur = 0
	
	addi t1, t1, 4			#t1 = var_tab_plateau[depart].symbole
	ori t3,zero,35			#t3 = 35
	sw t3,0(t1)			#var_tab_plateau[depart].symoble = 35 
	
	ori t4,zero,24
	mul t1,t4,t6			#t1 = 24*destination
	la t4, var_tab_plateau		#t4 = &var_tab_plateau
	add t1, t4, t1			#t1 = &var_tab_plateau[destination].valeur
	sw t2,0(t1)			#var_tab_plateau[destination].valeur = var_tour_j

	
	if_deplace_pion_4 :
		ori t4,zero,1
		bne t2,t4,else_deplace_pion_4	#If tour_j = 1 :
		ori t4,zero,24
		mul t1,t4,t6			#t1 = 24*destination
		la t4, var_tab_plateau		#t4 = &var_tab_plateau
		add t4, t4, t1			#t4 = &var_tab_plateau[destination]
		addi t4, t4, 4			#t4 = &var_tab_plateau[destination].symbole
		ori t3,zero,88			#t3 = 88
		sw t3,0(t4)			#var_tab_plateau[input].symbole = 88
	else_deplace_pion_4 :	
		ori t4,zero,2
		bne t2,t4,fin_if_deplace_pion_4	#If tour_j = 2 :
		ori t4,zero,24
		mul t1,t4,t6			#t1 = 24*destination
		la t4, var_tab_plateau		#t4 = &var_tab_plateau
		add t4, t4, t1			#t4 = &var_tab_plateau[destination]
		addi t4, t4, 4			#t4 = &var_tab_plateau[destination].symbole
		ori t3,zero,79			#t3 = 79
		sw t3,0(t4)			#var_tab_plateau[input].symbole = 79
	fin_if_deplace_pion_4 :
	or a0,zero,t6
	
	lw ra, 0(sp)		#EPI
	lw fp, 4(sp)		#EPI
	lw s3, 8(sp)		#EPI
	addi sp, sp, 12		#EPI
	jr ra			#EPI
	#FIN

#demande à l'utilisateur le pion à déplacer et la case de destination, puis le déplace si le déplacement est valable:
#retourne l'indice de la case de destination
fct_saut_pion :
	addi sp, sp, -12	#PRO
	sw ra, 0(sp)		#PRO
	sw fp, 4(sp)		#PRO
	sw s3, 8(sp)		#PRO
	addi fp, sp, 12		#PRO
	
	la a0, str_saut_pion_1_a	#Tour du Joueur :
	ori a7,zero,4   		#Print string
	ecall

	la t2, var_tour_j
	lw t5,0(t2)			#t5 prend var_tour_j
	
	ori a7,zero,1   
	or a0,zero,t5
	ecall				#Print tour_j

	la a0, str_saut_pion_1_b	# :\nEntrez le numéro de la case de VOTRE...
	ori a7,zero,4   		#Print string
	ecall

	if_saut_pion_1:
		ori a7,zero,5   		#Read integer depart
		ecall
		ori s3,a0,0			#s3 = input

		ori t2,zero,0
		blt s3,t2,code_if_saut_pion_1 #Jump if input<0 :
		ori t2,zero,23
		blt t2,s3,code_if_saut_pion_1 #Jump if 23<input :
	
		la t4, var_tab_plateau		#t4 = &plateau
		ori t3, zero, 24
		mul t1,s3,t3
		add t1,t1,t4
		lw t3,0(t1)			#t3 = p[input].valeur
		bne t3,t5,code_if_saut_pion_1 #Jump if p[input].valeur != var_tour_j

		j fin_if_saut_pion_1
		code_if_saut_pion_1:
			la a0, str_saut_pion_2_a	#Case de départ invalide ....
			ori a7,zero,4   		#Print string
			ecall
			j if_saut_pion_1
	fin_if_saut_pion_1 :
	
	la a0, str_saut_pion_3_a	#Entrez le numéro de la case VIDE VOISINE...
	ori a7,zero,4   		#Print string
	ecall
	
	ori a7,zero,5   		#Read integer destination
	ecall	
	or t6,zero,a0
	
	if_saut_pion_3 :
		ori t3,zero,24
		mul t3,t6,t3		#t3 = destination*24
		add t0,t4,t3		#t0 = &p[destination]
		lw t2,0(t0)
		bne t2,zero,success_saut_pion_3
		j fin_if_saut_pion_3
	success_saut_pion_3 :
		la a0, str_saut_pion_4_a	#Déplacement invalide, cette case...
		ori a7,zero,4   		#Print string
		ecall
		
		j if_saut_pion_1
	fin_if_saut_pion_3 :

	la t2, var_tour_j
	lw t2,0(t2)			#t2 prend var_tour_j
	
	ori t4,zero,24
	mul t1,t4,s3			#t1 = 24*depart
	la t4, var_tab_plateau		#t4 = &var_tab_plateau
	add t1, t4, t1			#t1 = &var_tab_plateau[depart].valeur
	ori t3,zero,0			#t3 = 0
	sw t3,0(t1)			#var_tab_plateau[depart].valeur = 0
	
	addi t1, t1, 4			#t1 = var_tab_plateau[depart].symbole
	ori t3,zero,35			#t3 = 35
	sw t3,0(t1)			#var_tab_plateau[depart].symoble = 35 
	
	ori t4,zero,24
	mul t1,t4,t6			#t1 = 24*destination
	la t4, var_tab_plateau		#t4 = &var_tab_plateau
	add t1, t4, t1			#t1 = &var_tab_plateau[destination].valeur
	sw t2,0(t1)			#var_tab_plateau[destination].valeur = var_tour_j

	
	if_saut_pion_4 :
		ori t4,zero,1
		bne t2,t4,else_saut_pion_4	#If tour_j = 1 :
		ori t4,zero,24
		mul t1,t4,t6			#t1 = 24*destination
		la t4, var_tab_plateau		#t4 = &var_tab_plateau
		add t4, t4, t1			#t4 = &var_tab_plateau[destination]
		addi t4, t4, 4			#t4 = &var_tab_plateau[destination].symbole
		ori t3,zero,88			#t3 = 88
		sw t3,0(t4)			#var_tab_plateau[input].symbole = 88
	else_saut_pion_4 :	
		ori t4,zero,2
		bne t2,t4,fin_if_saut_pion_4	#If tour_j = 2 :
		ori t4,zero,24
		mul t1,t4,t6			#t1 = 24*destination
		la t4, var_tab_plateau		#t4 = &var_tab_plateau
		add t4, t4, t1			#t4 = &var_tab_plateau[destination]
		addi t4, t4, 4			#t4 = &var_tab_plateau[destination].symbole
		ori t3,zero,79			#t3 = 79
		sw t3,0(t4)			#var_tab_plateau[input].symbole = 79
	fin_if_saut_pion_4 :
	or a0,zero,t6
	
	lw ra, 0(sp)		#EPI
	lw fp, 4(sp)		#EPI
	lw s3, 8(sp)		#EPI
	addi sp, sp, 12		#EPI
	jr ra			#EPI
	#FIN	

#teste si un coup est possible pour le joueur actif (renvoie 1 si oui, 0 sinon)
fct_test_coup_possible :
	#TO DO : écrire la fonction	
	addi sp, sp, -28	#PRO
	sw ra, 0(sp)		#PRO
	sw fp, 4(sp)		#PRO
	sw s1, 8(sp)		#PRO
	sw s2, 12(sp)		#PRO
	sw s3, 16(sp)		#PRO
	sw s4, 20(sp)		#PRO
	sw s5, 24(sp)		#PRO
	addi fp, sp, 28		#PRO


	la s1, var_tab_plateau	#s1 = &plateau
	ori s2, zero, 24	#s2 = 24
	lw s5, var_tour_j	#s5 = var_tour_j

	#//itération sur toutes les cases du tableau
	addi s3, zero, 0	#s3 = int i = 0
	ori s4, zero, 576	#s4 = 24*24 = 576
	for_fct_test_coup_possible :		#for (int i = 0; i < 576; i=i+24)	#itère sur les adresses des cases du tableau
		bge s3, s4, suite_for_fct_test_coup_possible
		#code for:

		#//test si la case appartient au joueur
		if_fct_test_coup_possible_1 :	#if (p[i].valeur == tour_j)
			add t0, s1, s3		#t0 = &p[i/24]
			lw t1, 0(t0)		#t1 = p[i/24].valeur
			bne t1, s5, suite_if_fct_test_coup_possible_1
			#code if:
			#//test si la case à au moins un voisin vide
			if_fct_test_coup_possible_2_a :	#if ( (p[i].vn != -1 && p[p[i].vn].valeur == 0) || (p[i].ve != -1 && p[p[i].ve].valeur == 0) || (p[i].vs != -1 && p[p[i].vs].valeur == 0) || (p[i].vo != -1 && p[p[i].vo].valeur == 0) )
				lw t2, 8(t0)	#t2 = p[i/24].vn
				ori t4,zero,-1  
				beq t2,t4,if_fct_test_coup_possible_2_b #p[i].vn != -1
				ori t4,zero,24
				mul t3,t2,t4	
				add t3,t3,t0	#t3 = &p[p[i].vn]]
				lw t3, 0(t3)	#t3 = p[p[i].vn].valeur
				ori t4,zero,0
				bne t3,t4,if_fct_test_coup_possible_2_b #p[p[i].vn].valeur == 0
				j success_fct_test_coup_possible_1
			if_fct_test_coup_possible_2_b:
				lw t2, 12(t0)	#t2 = p[i/24].ve
				ori t4,zero,-1  
				beq t2,t4,if_fct_test_coup_possible_2_c #p[i].ve != -1
				ori t4,zero,24
				mul t3,t2,t4	
				add t3,t3,t0	#t3 = &p[p[i].ve]]
				lw t3, 0(t3)	#t3 = p[p[i].ve].valeur
				ori t4,zero,0
				bne t3,t4,if_fct_test_coup_possible_2_c #p[p[i].ve].valeur == 0
				j success_fct_test_coup_possible_1
			if_fct_test_coup_possible_2_c:
				lw t2, 16(t0)	#t2 = p[i/24].vs
				ori t4,zero,-1  
				beq t2,t4,if_fct_test_coup_possible_2_d #p[i].vs != -1
				ori t4,zero,24
				mul t3,t2,t4	
				add t3,t3,t0	#t3 = &p[p[i].vs]]
				lw t3, 0(t3)	#t3 = p[p[i].vs].valeur
				ori t4,zero,0
				bne t3,t4,if_fct_test_coup_possible_2_d #p[p[i].vs].valeur == 0
				j success_fct_test_coup_possible_1
			if_fct_test_coup_possible_2_d:
				lw t2, 16(t0)	#t2 = p[i/24].vo
				ori t4,zero,-1  
				beq t2,t4,suite_if_fct_test_coup_possible_1 #p[i].vo != -1
				ori t4,zero,24
				mul t3,t2,t4
				add t3,t3,t0	#t3 = &p[p[i].vo]]
				lw t3, 0(t3)	#t3 = p[p[i].vo].valeur
				ori t4,zero,0
				bne t3,t4,suite_if_fct_test_coup_possible_1 #p[p[i].vo].valeur == 0
		success_fct_test_coup_possible_1:
			ori a0,zero,1         #Return 1
			j fin_for_fct_test_coup_possible
		suite_if_fct_test_coup_possible_1 :
		#fin code for:
		addi s3, s3, 24
		j for_fct_test_coup_possible
	suite_for_fct_test_coup_possible:
	
	ori a0,zero, 0         #Return 0
	fin_for_fct_test_coup_possible :
	lw ra, 0(sp)		#EPI
	lw fp, 4(sp)		#EPI
	lw s1, 8(sp)		#EPI
	lw s2, 12(sp)		#EPI
	lw s3, 16(sp)		#EPI
	lw s4, 20(sp)		#EPI
	lw s5, 24(sp)		#EPI
	addi sp, sp, 28		#EPI
	jr ra			#EPI
	#FIN
	
#Affiche le vainqueur et quite le programme
fct_fin_de_partie :
	# pas besoin de prologue/épilogue car la fonction quite le programme à la fin
	
	ori t0, zero, 1		# t0 = gagnant = 1 par defaut
	lw t1, var_tour_j	# t1 = perdant = var_tour_j
	bne t0, t1, suite_if_fct_fin_de_partie		# test (var_tour_j != 1)	//if (perdant == 1)
	ori t0, zero, 2		# t0 = gagnant = 0
suite_if_fct_fin_de_partie :
	
	#Affichage du message	printf("Le joueur %d a perdu !\n",perdant);
	ori a7, zero, 4
	la a0, str_fin_de_partie_1_a
	ecall

	ori a7, zero, 1
	ori a0, t1, 0
	ecall

	ori a7, zero, 4
	la a0, str_fin_de_partie_1_b
	ecall
	#Affichage du message	printf("bravo au joueur %d !\n",gagnant);
	ori a7, zero, 4
	la a0, str_fin_de_partie_2_a
	ecall
	ori a7, zero, 1
	ori a0, t0, 0
	ecall
	ori a7, zero, 4
	la a0, str_fin_de_partie_2_b
	ecall
	
	ori a7, zero, 10	# exit()
	ecall
	#FIN