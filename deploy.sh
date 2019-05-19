docker build -t wjatscheslav/multi-client:latest -t wjatscheslav/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wjatscheslav/multi-server:latest -t wjatscheslav/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wjatscheslav/multi-worker:latest -t wjatscheslav/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push wjatscheslav/multi-client:latest
docker push wjatscheslav/multi-server:latest
docker push wjatscheslav/multi-worker:latest
docker push wjatscheslav/multi-client:$SHA
docker push wjatscheslav/multi-server:$SHA
docker push wjatscheslav/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=wjatscheslav/multi-server:$SHA
kubectl set image deployments/client-deployment client=wjatscheslav/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wjatscheslav/multi-worker:$SHA