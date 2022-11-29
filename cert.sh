kubectl delete secret aframe-tls 2> /dev/null
chmod +x /home/metaverseops/project/aframe/cert-manager_install.sh && /home/metaverseops/project/aframe/cert-manager_install.sh
export EMAIL=metaverse-serv@metaverse-363005.iam.gserviceaccount.com
cat /home/metaverseops/project/aframe/letsencrypt-issuer.yaml | sed -e "s/email: ''/email: $EMAIL/g" | kubectl apply -f-