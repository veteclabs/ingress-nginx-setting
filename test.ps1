# helm install cert-manager jetstack/cert-manager --namespace ingress --version v1.13.3 --set installCRDs=true

$yamlContent = @"
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    email: tjkim@vetec.co.kr
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt
    solvers:
    - http01:
        ingress:
          ingressClassName: nginx
"@

# 임시 파일 경로 생성
$tempFile = [System.IO.Path]::GetTempFileName() + ".yaml"

# YAML 내용을 임시 파일에 저장
$yamlContent | Out-File -FilePath $tempFile

# kubectl apply 명령어 실행
kubectl apply -n ingress -f $tempFile

# 임시 파일 삭제
Remove-Item -Path $tempFile