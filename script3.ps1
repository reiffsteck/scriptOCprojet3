param 
(
        [string] $n=' '
)

# Recuperer la liste des groupes dont un utilisateur est membre
# question interactif ou non
# dans le lancement du script donner le nom de l'utilisateur
Function GetListeGrp() 
{
    param 
    (
        [string] $UtilisateurPrenom ,
        [string] $UtilisateurNom  ,
        [string] $UtilisateurLogin ,
        [string] $n
    )

            if ($n -eq ' ' )

                {
                #importation depuis un fichier CSV 
                write-host "le chemin d'importation est connu  C:\Scripts\AD_USERS\usergroupe.csv"
                $CSVFile = "C:\Scripts\AD_USERS\usergroupe.csv"
                $CSVData = Import-CSV -Path $CSVFile -Delimiter ";" -Encoding UTF8 
                Write-Host "Fichier Importé"

                Foreach ($Utilisateur in $CSVData)
                        {
                            $UtilisateurPrenom = $Utilisateur.Prenom
                            $UtilisateurNom = $Utilisateur.Nom
                            $UtilisateurLogin = ($UtilisateurPrenom).Substring(0, 1) + $UtilisateurNom
                            Write-Host " les groupes dont l'utilisateur " $UtilisateurLogin "est membre sont: " -ForegroundColor Red
                            Get-ADPrincipalGroupMembership -Identity $UtilisateurLogin | Select-Object Name 
                            # probleme de temps de reaction entre l'affichage et la commande
                            #Write-Host " "
                            #Write-Host "Fin de la liste des groupes de "$UtilisateurLogin -ForegroundColor Green
                            #Write-Host " "
                            #Write-Host " "
                        }
                }
            else 
                {
                #paramétre inclus dans l'appel du script 
                # nom de l'utilisateur dans le lancement du script
                Write-Output " les groupes dont l'utilisateur " $n "est membre sont: " 
                Get-ADPrincipalGroupMembership -Identity $n | Select-Object SamAccountName
                }
}

GetListeGrp -n $n