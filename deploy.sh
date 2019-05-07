docker build -t jithupauljacob/multi-client:latest -t jithupauljacob/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t jithupauljacob/multi-server:latest -t jithupauljacob/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t jithupauljacob/multi-worker:latest -t jithupauljacob/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push jithupauljacob/multi-client:latest
docker push jithupauljacob/multi-server:latest
docker push jithupauljacob/multi-worker:latest

docker push jithupauljacob/multi-client:$GIT_SHA
docker push jithupauljacob/multi-server:$GIT_SHA
docker push jithupauljacob/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jithupauljacob/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=jithupauljacob/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=jithupauljacob/multi-worker:$GIT_SHA