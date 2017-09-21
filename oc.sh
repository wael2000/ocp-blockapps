project_name=blockapps

echo "
    ____  __           __   ___
   / __ )/ /___  _____/ /__/   |  ____  ____  _____
  / __  / / __ \/ ___/ //_/ /| | / __ \/ __ \/ ___/
 / /_/ / / /_/ / /__/ ,< / ___ |/ /_/ / /_/ (__  )
/_____/_/\____/\___/_/|_/_/  |_/ .___/ .___/____/
================================================
   --      -----    ---
 / /\ \  /  /\  \  /  /
 \ \/ / /  /  \  \/  /
   --   --     -----
 "

## create blockapps project
oc new-project ${project_name} --display-name=blockapps

## allow images to un with roor access
oc adm policy add-scc-to-group anyuid system:authenticated
oc adm policy add-scc-to-user anyuid system:serviceaccount:${project_name}:mysvcacct

## create objects from blockapps templates
oc process -f blockapps.yml | oc create -f -
