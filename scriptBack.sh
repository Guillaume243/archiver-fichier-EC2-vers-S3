

#echo "Debut de l'archivage"
#arch=tar -czf backup$(date).tar.gz /home/ec2-user/laback

#echo "copie vers s3"
#aws s3 cp echo $(`arch`) s3://backuplab/lab/ --region us-east-1 

#echo "copie terminer"

#!/usr/bin/bash

echo "Début de l'archivage"
#arch=`tar -cvf backup.tar /home/ec2-user/laback1/`

tar -cvf backu2pp.tar /home/ec2-user/laback 

#echo ""

#echo "Copie vers s3"
#aws s3 cp $arch s3://backuplab/lab/ --region us-east-1

#echo "Copie terminée"





#!/bin/bash

# Chemin du dossier à zipper
folder_to_zip="/home/ec2-user/laback1/"

# Obtenir la date et l'heure actuelles
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Nom du fichier zip
zip_file_name="backup_ec2.zip"

# Nom du bucket S3
bucket_name="backuplab"

# Chemin S3 où stocker le fichier zip
s3_object_key="https://backuplab.s3.amazonaws.com/lab/"

# Créer le fichier zip
zip -r "$zip_file_name" "$folder_to_zip"

# Créer une session AWS en utilisant le rôle IAM attaché à l'instance EC2
aws s3 cp "$zip_file_name" "s3://$bucket_name/$s3_object_key" --profile default

if [ $? -eq 0 ]; then
    echo "Transfert du dossier zippé vers S3 réussi."
else
    echo "Une erreur s'est produite lors du transfert."
fi

# Supprimer le fichier zip local
# rm "$zip_file_name"