docker build -t janslv/multi-client:latest -t janslv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t janslv/multi-server:latest -t janslv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t janslv/multi-worker:latest -t janslv/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push janslv/multi-client:latest
docker push janslv/multi-server:latest
docker push janslv/multi-worker:latest

docker push janslv/multi-client:$SHA
docker push janslv/multi-server:$SHA
docker push janslv/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=janslv/multi-server:$SHA
kubectl set image deployments/client-deployment client=janslv/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=janslv/multi-worker:$SHA