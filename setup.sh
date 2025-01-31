

export NAMESPACE=openweb-ui
export FQDN=ds.domain.tld

test -d runtime && echo ERROR remove ./runtime dir first
test -d ./runtime && exit 1
mkdir ./runtime
chmod 700 ./runtime
for y in *.yml
do
  cp -av $y ./runtime/$y
  sed -i "s/__NAMESPACE__/$NAMESPACE/g"      ./runtime/$y
  sed -i "s/__FQDN__/$FQDN/g"                ./runtime/$y
done

echo "# current vars
NAMESPACE=$NAMESPACE
FQDN=$FQDN
" > ./runtime/env.sh

ls -l ./runtime

echo enter to appy
read x

kubectl create namespace $NAMESPACE
kubectl config set-context --current --namespace=$NAMESPACE


for y in runtime/*.yml
do
  echo $y
  kubectl apply -f $y
done



