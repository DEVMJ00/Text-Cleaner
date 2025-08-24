# Text-Cleaner

Text-Cleaner est un petit outil graphique en PowerShell pour nettoyer les textes contenant des caractères invisibles ou spéciaux (espaces insécables, zero-width space, retours de ligne cachés, etc.).  
Ces caractères sont souvent insérés (volontairement ou non) dans des textes issus d'une génération par IA. 
Il permet de nettoyer le texte et d’afficher le nombre de caractères supprimés, avec la possibilité de copier le résultat dans le presse-papier.

---

## Fonctionnalités

- Interface graphique simple (WinForms)  
- Nettoyage des caractères invisibles tout en conservant les accents et caractères Unicode visibles  
- Affichage du nombre de caractères supprimés  
- Copie du texte nettoyé dans le presse-papier  

---

## Installation

1. Télécharger le script `Text-Cleaner.ps1` depuis le dépôt GitHub.  
2. Ouvrir PowerShell (version 5 ou supérieure).  
3. Vérifier la politique d’exécution :  

```powershell
Get-ExecutionPolicy
