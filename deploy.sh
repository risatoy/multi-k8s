docker build -t risatoy17/multi-client:latest -t risatoy17/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t risatoy17/multi-server:latest -t risatoy17/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t risatoy17/multi-worker:latest -t risatoy17/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push risatoy17/multi-client:latest
docker push risatoy17/multi-server:latest
docker push risatoy17/multi-worker:latest

docker push risatoy17/multi-client:$SHA
docker push risatoy17/multi-server:$SHA
docker push risatoy17/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=risatoy17/multi-server:$SHA
kubectl set image deployments/client-deployment client=risatoy17/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=risatoy17/multi-worker:$SHA