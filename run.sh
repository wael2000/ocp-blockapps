## cp registry - ocr - ip :
ocr_ip=172.30.1.1
project_name=blockapps

echo "
    ____  __           __   ___
   / __ )/ /___  _____/ /__/   |  ____  ____  _____
  / __  / / __ \/ ___/ //_/ /| | / __ \/ __ \/ ___/
 / /_/ / / /_/ / /__/ ,< / ___ |/ /_/ / /_/ (__  )
/_____/_/\____/\___/_/|_/_/  |_/ .___/ .___/____/
================================================
 "

## login to ocp OCR

docker login -u admin -p $(oc whoami -t) 172.30.1.1:5000

## docker login -u admin -p eYX6gDJVZuJcDXGj9SQ4Y4nlXrHKADmrcLOjcxnWVDo 172.30.1.1:5000

## tag images
for image in $(docker images --format {{.Repository}}:{{.Tag}} | grep registry-aws.blockapps.net:5000/blockapps-repo)
do
  echo tag image: $image as ${ocr_ip}:5000/${project_name}/blockapps-${image_name}:latest
  image_name=${image##*/}              ## getting last part of the image name:tag
  image_name=${image_name%%:*}         ## extracting name from name:tag
  docker tag $image ${ocr_ip}:5000/${project_name}/blockapps-${image_name}:latest
done

for image in zookeeper:3.4.9 redis:3.2
do
 echo tag image: $image         ## extracting name from name:tag
 image_name=${image%%:*}         ## extracting name from name:tag
 docker tag  $image ${ocr_ip}:5000/${project_name}/blockapps-$image_name:latest
done

## push images
for image in zookeeper redis silo-smd-ui silo-bloch silo-blockapps-docs silo-cirrus silo-strato silo-kafka silo-nginx silo-postgres silo-postgrest
do
 echo push image: $image
  docker push ${ocr_ip}:5000/${project_name}/blockapps-$image:latest
done
