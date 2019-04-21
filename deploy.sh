docker build -t fabis94/multi-client:latest \
-t fabis94/multi-client:$SHA \
-f ./client/Dockerfile ./client

docker build -t fabis94/multi-worker:latest \
-t fabis94/multi-worker:$SHA \
-f ./worker/Dockerfile ./worker

docker build -t fabis94/multi-server:latest \
-t fabis94/multi-server:$SHA \
-f ./server/Dockerfile ./server

docker push fabis94/multi-client:latest
docker push fabis94/multi-client:$SHA

docker push fabis94/multi-worker:latest
docker push fabis94/multi-worker:$SHA

docker push fabis94/multi-server:latest
docker push fabis94/multi-server:$SHA

kubectl apply -f k8s/

kubectl set image deployments/server-deployment server=fabis94/multi-server:$SHA
kubectl set image deployments/client-deployment client=fabis94/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fabis94/multi-worker:$SHA
