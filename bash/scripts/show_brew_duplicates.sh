# Quick and dirty script to list outdated duplicates installed with brew

INSTALLED_APPS=`brew list`
for app in $INSTALLED_APPS
do
    APP_INFO=`brew info $app`
    if [[ $APP_INFO == *"*"* ]]; then
        echo " "
        echo "$APP_INFO"
    fi
done
