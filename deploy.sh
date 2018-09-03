docker build -t dhf0820/multi-client:latest -t dhf0820/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dhf0820/multi-server:latest -t dhf0820/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dhf0820/multi-worker:latest -t dhf0820/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dhf0820/multi-client:latest
docker push dhf0820/multi-server:latest
docker push dhf0820/multi-worker:latest

docker push dhf0820/multi-client:$SHA
docker push dhf0820/multi-server:$SHA
docker push dhf0820/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dhf0820/multi-server:$SHA
kubectl set image deployments/client-deployment client=dhf0820/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dhf0820/multi-worker:$SHA