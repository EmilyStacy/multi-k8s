docker build -t emilystacyandroid/multi-client:latest -t emilystacyandroid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t emilystacyandroid/multi-server:latest -t emilystacyandroid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t emilystacyandroid/multi-worker:latest -t emilystacyandroid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push emilystacyandroid/multi-client:latest
docker push emilystacyandroid/multi-server:latest
docker push emilystacyandroid/multi-worker:latest

docker push emilystacyandroid/multi-client:latest:$SHA
docker push emilystacyandroid/multi-server:latest:$SHA
docker push emilystacyandroid/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=emilystacyandroid/multi-server:$SHA
kubectl set image deployments/client-deployment client=emilystacyandroid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=emilystacyandroid/multi-worker:$SHA