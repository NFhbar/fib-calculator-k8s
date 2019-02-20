# Build docker images and tag them with latest and with git SHA to force k8s to use new image
docker build -t nfhbar/fib-calculator-client:latest -t nfhbar/fib-calculator-client:$SHA -f ./client/Dockerfile ./client
docker build -t nfhbar/fib-calculator-server:latest -t nfhbar/fib-calculator-server:$SHA -f ./server/Dockerfile ./server
docker build -t nfhbar/fib-calculator-worker:latest -t nfhbar/fib-calculator-worker:$SHA -f ./worker/Dockerfile ./worker

# Push both tags to dockerhub
docker push nfhbar/fib-calculator-client:latest
docker push nfhbar/fib-calculator-server:latest
docker push nfhbar/fib-calculator-worker:latest
docker push nfhbar/fib-calculator-client:$SHA
docker push nfhbar/fib-calculator-server:$SHA
docker push nfhbar/fib-calculator-worker:$SHA

# Apply changes to k8s
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=nfhbar/fib-calculator-client:$SHA
kubectl set image deployments/server-deployment server=nfhbar/fib-calculator-server:$SHA
kubectl set image deployments/worker-deployment worker=nfhbar/fib-calculator-worker:$SHA