Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


# Fonction de nettoyage


function Nettoyer-Texte {
    param([string]$texte)
    $avant = $texte.Length

    # Remplacement spécifique avant nettoyage
    $texte = $texte -replace '¿', "'"

    # Supprime uniquement les caractères invisibles (catégorie Unicode "Other")
    $nettoye = ($texte -replace '[\p{C}\p{Z}--[ \t\r\n]]', '')
    $apres = $nettoye.Length
    $supprimes = $avant - $apres
    return ,@($nettoye, $supprimes)
}

# Formulaire
$form = New-Object System.Windows.Forms.Form
$form.Text = "Text-Cleaner"
$form.Size = New-Object System.Drawing.Size(686,560)
$form.BackColor = [System.Drawing.Color]::FromArgb(255, 255, 255, 255)
$form.StartPosition = "CenterScreen"

# Empêche le redimensionnement
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.MinimizeBox = $true



# Label Input
$labelInput = New-Object System.Windows.Forms.Label
$labelInput.Text = "Texte à nettoyer"
$labelInput.Location = New-Object System.Drawing.Point(10,6)
$form.Controls.Add($labelInput)

# Zone de saisie
$textBoxInput = New-Object System.Windows.Forms.TextBox
$textBoxInput.Multiline = $true
$textBoxInput.ScrollBars = "Vertical"
$textBoxInput.Size = New-Object System.Drawing.Size(650,150)
$textBoxInput.Location = New-Object System.Drawing.Point(10,30)
$form.Controls.Add($textBoxInput)

# Bouton Nettoyer
$buttonClean = New-Object System.Windows.Forms.Button
$buttonClean.Text = "Nettoyer"
$buttonClean.Size = New-Object System.Drawing.Size(100,30)
$buttonClean.Location = New-Object System.Drawing.Point(10,190)
$form.Controls.Add($buttonClean)

# Label Stats
$labelStats = New-Object System.Windows.Forms.Label
$labelStats.Text = "Caractères supprimés : 0"
$labelStats.Location = New-Object System.Drawing.Point(120,195)
$labelStats.Size = New-Object System.Drawing.Size(200,50)
$form.Controls.Add($labelStats)

# Label Output
$labelOutput = New-Object System.Windows.Forms.Label
$labelOutput.Text = "Texte corrigé :"
$labelOutput.Location = New-Object System.Drawing.Point(10,224)
$form.Controls.Add($labelOutput)

# Zone de sortie
$textBoxOutput = New-Object System.Windows.Forms.TextBox
$textBoxOutput.Multiline = $true
$textBoxOutput.ScrollBars = "Vertical"
$textBoxOutput.ReadOnly = $true
$textBoxOutput.Size = New-Object System.Drawing.Size(650,200)
$textBoxOutput.Location = New-Object System.Drawing.Point(10,250)
$form.Controls.Add($textBoxOutput)

# Bouton Copier dans presse-papier
$buttonCopy = New-Object System.Windows.Forms.Button
$buttonCopy.Text = "Copier le texte"
$buttonCopy.Size = New-Object System.Drawing.Size(200,30)
$buttonCopy.Location = New-Object System.Drawing.Point(250,460)
$form.Controls.Add($buttonCopy)


# Label Footer
$labelFooter = New-Object System.Windows.Forms.Label
$labelFooter.Text = "Made with ❤ by DEVMJ"
#$labelFooter.ForeColor = [System.Drawing.Color]::Gainsboro
$labelFooter.ForeColor = [System.Drawing.Color]::FromArgb(50, 179, 179, 179)  
$labelFooter.Font = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Regular)
$labelFooter.AutoSize = $true
#$labelFooter.Location = New-Object System.Drawing.Point(300,492)
# Centrage horizontal et vertical
$LabelFooter.Location = New-Object System.Drawing.Point(
    (($Form.ClientSize.Width - $LabelFooter.Width) / 2),
    ($Form.ClientSize.Height - $LabelFooter.Height - 1)
)
# Création du tooltip
$toolTip = New-Object System.Windows.Forms.ToolTip
$toolTip.SetToolTip($labelFooter, "En savoir plus")

# Curseur en forme de main
$LabelFooter.Cursor = [System.Windows.Forms.Cursors]::Hand

# Action au clic -> ouvre GitHub
$LabelFooter.Add_Click({
    Start-Process "https://github.com/DEVMJ00/Text-Cleaner"
})

$form.Controls.Add($labelFooter)


# Action Nettoyer
$buttonClean.Add_Click({
    $texteSource = $textBoxInput.Text
    $resultat = Nettoyer-Texte $texteSource
    $textBoxOutput.Text = $resultat[0]
    $labelStats.Text = "Caractères supprimés : " + $resultat[1]
})

# Action Copier
$buttonCopy.Add_Click({
    if ([string]::IsNullOrWhiteSpace($textBoxOutput.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Aucun texte à copier. Saisissez d'abord un texte à nettoyer, puis cliquez sur le bouton 'Nettoyer'.",
                                                "Erreur",
                                                [System.Windows.Forms.MessageBoxButtons]::OK,
                                                [System.Windows.Forms.MessageBoxIcon]::Warning)
    }
    else {
        [System.Windows.Forms.Clipboard]::SetText($textBoxOutput.Text)
        [System.Windows.Forms.MessageBox]::Show("Texte copié dans le presse-papier. 'Ctrl+V' pour coller le texte. ",
                                                "Succès",
                                                [System.Windows.Forms.MessageBoxButtons]::OK,
                                                [System.Windows.Forms.MessageBoxIcon]::Information)
    }
})

# Affiche le formulaire
[void]$form.ShowDialog()
