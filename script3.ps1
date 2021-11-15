param 
(
        [string] $n=' '
       
)

$ErrorActionPreference = "SilentlyContinue"
$Error.Clear()  #purge des erreurs
# Recuperer la liste des groupes dont un seul utilisateur est membre soit en interactif ou depuis *.csv
# question interactif , dans la ligne de commande indiqué le nom de l'utilisateur $n
# dans le lancement du script donner le nom de l'utilisateur
Function GetListeGrp() 
{
    param 
    (
        [string] $UtilisateurPrenom ,
        [string] $UtilisateurNom  ,
        [string] $UtilisateurLogin ,
        [string] $UtilisateurExist,
        [string] $n
    )

            if ($n -eq ' ' )

                {
               
                # importation depuis un fichier CSV 
                # un seul utilisateur dans le fichier CSV pour l'exemple du projet
                # une seule ligne exporté depuis le fichier excel client
                write-host "le chemin d'importation est connu  C:\Scripts\AD_USERS\usergroupe.csv"
                $CSVFile = "C:\Scripts\AD_USERS\usergroupe.csv"
                $CSVData = Import-CSV -Path $CSVFile -Delimiter ";" -Encoding UTF8 
                Foreach ($Utilisateur in $CSVData)
                        {
                            $UtilisateurPrenom = $Utilisateur.Prenom
                            $UtilisateurNom = $Utilisateur.Nom
                            $UtilisateurLogin = ($UtilisateurPrenom).Substring(0, 1) + $UtilisateurNom

                            # verification si l'utilisateur existe
        $UtilisateurExist = $UtilisateurLogin
        if ($UtilisateurExist = Get-ADUser -Filter { SamAccountName -eq $UtilisateurLogin }) 
      {
          Write-Output "le login est" $UtilisateurLogin "l'utilisateur existe"
          Write-Host " les groupes dont l'utilisateur " $UtilisateurLogin "est membre sont: " 
          Get-ADPrincipalGroupMembership -Identity $UtilisateurLogin | Select-Object Name -ErrorAction SilentlyContinue
          SortieErreur
      }
      else
      {
          Write-Output "le login est" $UtilisateurLogin "l'utilisateur nexiste pas"
          exit              
      }
                        }
                }
            else 
                {
                
                #paramétre inclus dans l'appel du script, nom de l'utilisateur dans le lancement du script
                # verification si l'utilisateur existe
                $UtilisateurExist = $n
                if ($UtilisateurExist = Get-ADUser -Filter { SamAccountName -eq $n })
                {
                Write-Output " les groupes dont l'utilisateur " $n "est membre sont: " 
                Get-ADPrincipalGroupMembership -Identity $n | Select-Object SamAccountName -ErrorAction SilentlyContinue
                SortieErreur
                }
                else
                {
                Write-Output "le login est" $UtilisateurLogin "l'utilisateur nexiste pas"
                exit              
                }
                }
}

Function SortieErreur( )
{
    param ()

    
    if($Error.Count -ieq 0)
    {
   
     Write-Output "Pas de Code de sortie en Erreur" $error[0] #affichage erreur
    $LastExitCode
    }

    Else
    {
        Write-Host "Erreur:"
        Write-Host $error[0] #affichage erreur
        $LastexitCode
        exit
    }
}

GetListeGrp -n $n