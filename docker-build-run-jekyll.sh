set -x
build_log_file=/tmp/docker_build$$.log

dockerJekyllName="docker_jekyll"

baseurl=`grep -e 'baseurl: .*' _config.yml | sed -e 's/: /=/' -e 's/baseurl/--baseurl/'`

dockerfile_image_path="/home/cls/gijeli/jekyll-server-docker" # Jan's
#dockerfile_image_path="/home/cls/gijeli/test/docker-jekyll"

#cache="--no-cache=true"
cache=""
#sudo rm -rf _site 
set +x
docker build ${cache} ${dockerfile_image_path} |  tee ${build_log_file}
set -x
image_no=`\
     grep "Successfully built " ${build_log_file} \
     | awk -F" " '{print $3}' `
rm -rf  ${build_log_file}
#sudo docker run --rm -v $(pwd):/data -p 4000:4000 ${image_no} serve -H 0.0.0.0 ${baseurl}
docker run -d --name ${dockerJekyllName} -v $(pwd):/data -p 4000:4000 ${image_no} serve -H 0.0.0.0 ${baseurl}
set +x

