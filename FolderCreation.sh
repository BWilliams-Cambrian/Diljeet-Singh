#!/usr/bin/bash
mkdir -p EmployeeData/{HR,IT,Finance,Executive,Administrative,'Call Centre'}
cd EmployeeData
sudo chmod -R 760 HR
sudo chmod -R 764 IT
sudo chmod -R 764 Finance
sudo chmod -R 760 Executive
sudo chmod -R 764 Administrative
sudo chmod -R 764 'Call Centre'
sudo chgrp HR HR
sudo chgrp IT IT
sudo chgrp Finance Finance
sudo chgrp Executive Executive
sudo chgrp Administrative Administrative
sudo chgrp CallCentre 'Call Centre'

echo "7 folders were created"
