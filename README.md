# centos_runner
Runner for percolator builds under centos

To build and push a percolator runner for github actions, execute
```
sudo docker build -t lukall/centos_runner . ; sudo docker push lukall/centos_runner
```


To build percolator with docker, execute
```
sudo docker build -f percolator_builder .
```
