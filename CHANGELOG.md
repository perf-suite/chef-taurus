taurus CHANGELOG
==============================

# 3.0.2

Add support for docker kitchen testing. 
Removed yum-epel pin, yum pin remains which should be < 4.0.0 at this time.

# 3.0.1

Fix knife-supermarket requirement for single version constraint for a particular cookbook.

# 3.0.0

Added firewall_support, added runit down scripts, moved taurus config to global, moved jmeter
binary to /usr/local, change master host enable/disable to not nil is_master.  Added pip install
optional parameter for different index-host.

Added pins for Gemfile to support functional unit testing.  Add pins for yum to support yum-epel.

# 2.6.0

Add locustio server support via runit. Updated documentation.

# 2.5.0

Add jmeter server support via runit. Updated documentation.

# 2.4.2

Hotfix for spec test, de-duplicate jmeter-plugin ark downloads (remove CHEF-3694 warnings)
Cleanup package installation for tools and compact variables used.

# 2.4.1

Update documentation and include CI references

# 2.4.0

Add support for the Tsung Engine

# 2.3.0

Add support for the Gatling Engine

# 2.2.0

Add support for the Siege Engine

# 2.1.2

Fix platform selection for installation of yum-epel/apt

# 2.1.0

Add support for the Apache Benchmark Engine

# 2.0.0

Support Ubuntu Platform

# 1.0.0

Initial release of taurus
