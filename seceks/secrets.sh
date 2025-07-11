IMAGE=$(aws secretsmanager get-secret-value \
  --secret-id MYEks \
  --query SecretString --output text | jq -r .EKSImage)
 echo $IMAGE
		  
sed "s|__ECR_IMAGE_URI__|${IMAGE}|g" values.yaml > values.final.yaml

rm -rf values.yaml
mv values.final.yaml values.yaml
cd ..
helm install seceks ./seceks
helm upgrade seceks ./seceks