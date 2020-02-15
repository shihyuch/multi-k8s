docker build -t dockershih0512/multi-client:latest -t dockershih0512/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dockershih0512/multi-server:latest -t dockershih0512/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dockershih0512/multi-worker:latest -t dockershih0512/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dockershih0512/multi-client:latest
docker push dockershih0512/multi-server:latest
docker push dockershih0512/multi-worker:latest

docker push dockershih0512/multi-client:$SHA
docker push dockershih0512/multi-server:$SHA
docker push dockershih0512/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=dockershih0512/multi-client:$SHA
kubectl set image deployments/server-deployment server=dockershih0512/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dockershih0512/multi-worker:$SHA


