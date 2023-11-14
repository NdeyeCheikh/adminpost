#!/bin/bash

while true; do
    clear
    echo "Menu principal :"
    echo "1. Ajouter un utilisateur"
    echo "2. Modifier un utilisateur"
    echo "3. Supprimer un utilisateur"
    echo "4. Sortie du script"
    read -p "Choisir une option : " option

    case $option in
        1)
            
            read -p "Nom d'utilisateur : " nom_utilisateur
            read -p "Chemin du dossier utilisateur : " chemin_dossier
            read -p "Date d'expiration (AAAA-MM-JJ) : " date_expiration
            read -p "Mot de passe(MDP) : " mdp
            read -p "Identifiant(ID) : " id

            
            if [ -z "$nom_utilisateur" ] || [ -z "$chemin_dossier" ] || [ -z "$date_expiration" ]; then
                echo "Erreur : Tous les champs sont obligatoires."
                read -p "Entrée si vous voulez continuer..."
                continue
            fi

            if id "$nom_utilisateur" &>/dev/null; then
                echo "Erreur : L'utilisateur $nom_utilisateur existe déjà."
                read -p "Entrée si vous voulez continuer..."
                continue
            fi

            if [ "$(date -d "$date_expiration" +%s)" -le "$(date +%s)" ]; then
                echo "Erreur : La date d'expiration doit être térieure à aujourd'hui."
                read -p " Entrée pour continuer..."
                continue
            fi

            useradd -m -d "$chemin_dossier" -e "$date_expiration" -p "$mot_de_passe" -u "$identifiant" "$nom_utilisateur"
            echo "L'utilisateur $nom_utilisateur a été ajouté avec succès."
            read -p " Entrée pour continuer..."
            ;;
        2)
            
            read -p "Nom d'utilisateur à modifier : " nom_utilisateur
            read -p "Nouveau nom d'utilisateur : " nouveau_nom_utilisateur
            read -p "Nouveau chemin du dossier utilisateur : " nouveau_chemin_dossier
            read -p "Nouvelle date d'expiration (AAAA-MM-JJ) : " nouvelle_date_expiration
            read -p "Nouveau mot de passe : " nouveau_mot_de_passe
            read -p "Nouvel identifiant : " nouvel_identifiant

            
            if [ -z "$nom_utilisateur" ] || [ -z "$nouveau_nom_utilisateur" ] || [ -z "$nouveau_chemin_dossier" ] || [ -z "$nouvelle_date_expiration" ]; then
                echo "Tous les champs sont obligatoires."
                read -p "Entrée pour continuer..."
                continue
            fi

            if ! id "$nom_utilisateur" &>/dev/null; then
                echo "L'utilisateur $nom_utilisateur n'existe pas."
                read -p "Entrée pour continuer..."
                continue
            fi

            if [ "$(date -d "$nouvelle_date_expiration" +%s)" -le "$(date +%s)" ]; then
                echo "Erreur : La nouvelle date d'expiration doit être ultérieure à aujourd'hui."
                read -p "Entrée pour continuer..."
                continue
            fi

            usermod -l "$nouveau_nom_utilisateur" -d "$nouveau_chemin_dossier" -e "$nouvelle_date_expiration" -p "$nouveau_mot_de_passe" -u "$nouvel_identifiant" "$nom_utilisateur"
            echo "Les informations de l'utilisateur $nom_utilisateur ont été modifiées avec succès."
            read -p " Entrée pour continuer..."
            ;;
        3)
            
            read -p "Nom d'utilisateur à supprimer : " nom_utilisateur
            read -p "Supprimer le dossier utilisateur (oui/non) : " sup_dos
            read -p "Supprimer l'utilisateur même s'il est connecté (oui/non) : " supp_si_connecte

            
            if [ -z "$nom_utilisateur" ]; then
                echo "Erreur : Le nom d'utilisateur doit être renseigné."
                read -p "Entrée pour continuer..."
                continue
            fi

            if ! id "$nom_utilisateur" &>/dev/null; then
                echo "Erreur : L'utilisateur $nom_utilisateur n'existe pas."
                read -p "Entrée pour continuer..."
                continue
            fi
            option_sup=""
            if [ "$sup_dos" == "oui" ]; then
                option_sup="$option_sup -r"
            fi

            if [ "$supprimer_si_connecte" == "oui" ]; then
                option_sup="$option_sup --force"
            fi
            userdel $options_suppression "$nom_utilisateur"
            echo "L'utilisateur $nom_utilisateur a été supprimé avec succès."
            read -p "Entrée pour continuer..."
            ;;
        4)
            echo "A bientôt!"
            exit 0
            ;;
        *)
            echo " Veuillez choisir une option de 1 à 4."
            read -p "Entrée pour continuer..."
            ;;
    esac
done
