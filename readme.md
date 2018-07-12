help:effective-pom -Dt=blabla -Doutput=f.xml -Djiraid=1,2,3,4,5,6,7,7,8,9,9,0 -Dv=1 -Da=art -Dg=gr -Pinject-application-home
del pom.xml
mvn install:install-file -Dfile=release.zip -DpomFile=f.xml -P!inject-application-home
