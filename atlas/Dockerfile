
# FROM maven:3.5.4-jdk-8 AS stage-atlas

# ENV	MAVEN_OPTS "-Xms2g -Xmx2g"
# ENV ATLAS_REV "21b15842fd74bc91910b2d8901dbea57769065d0"

# RUN git clone http://github.com/apache/atlas.git \
# 	&& cd atlas \
# 	&& git reset --hard $ATLAS_REV \
# 	&& mvn clean -DskipTests package -Pdist,embedded-hbase-solr \
# 	&& mv distro/target/apache-atlas-*-bin.tar.gz /apache-atlas.tar.gz

FROM centos:7

COPY apache-atlas.tar.gz /apache-atlas.tar.gz

RUN yum update -y \
	&& yum install -y python python36 java-1.8.0-openjdk java-1.8.0-openjdk-devel net-tools \
	&& yum clean all

RUN groupadd hadoop && \
	useradd -m -d /opt/atlas -g hadoop atlas

RUN pip3 install amundsenatlastypes==1.1.0

USER atlas

RUN cd /opt \
	&& tar xzf /apache-atlas.tar.gz -C /opt/atlas --strip-components=1

COPY model /tmp/model
COPY resources/atlas-setup.sh /tmp
COPY resources/credentials /tmp
COPY resources/init_amundsen.py /tmp

COPY resources/atlas-application.properties /opt/atlas/conf/

# COPY conf/ranger-atlas-audit.xml /opt/atlas/conf/
# COPY conf/ranger-atlas-security.xml /opt/atlas/conf/
# COPY conf/ranger-policymgr-ssl.xml /opt/atlas/conf/

# COPY install/ranger-atlas-plugin-2.1.0.jar /opt/atlas/libext/ranger-atlas-plugin-impl/
# COPY install/ranger-plugins-common-2.1.0.jar /opt/atlas/libext/ranger-atlas-plugin-impl/
# COPY install/ranger-plugins-cred-2.1.0.jar /opt/atlas/libext/ranger-atlas-plugin-impl/
# COPY install/ranger-plugins-audit-2.1.0.jar /opt/atlas/libext/ranger-atlas-plugin-impl/
# COPY install/ranger-atlas-plugin-shim-2.1.0.jar /opt/atlas/libext/
# COPY install/ranger-plugin-classloader-2.1.0.jar /opt/atlas/libext/

#COPY install/ranger-tools-2.1.0.jar /opt/atlas/libext/ranger-atlas-plugin-impl/
#COPY install/ranger-util-2.1.0.jar /opt/atlas/libext/ranger-atlas-plugin-impl/
#COPY install/ranger-plugins-installer-2.1.0.jar /opt/atlas/libext/ranger-atlas-plugin-impl/

USER root
ADD resources/entrypoint.sh /entrypoint.sh
RUN rm -rf /apache-atlas.tar.gz
COPY resources/ranger-2.1.0-atlas-plugin/ /opt/ranger-2.1.0-atlas-plugin
ENV JAVA_HOME "/usr/lib/jvm/java-1.8.0-openjdk"
RUN cd /opt/ranger-2.1.0-atlas-plugin && ./enable-atlas-plugin.sh


USER atlas

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]

EXPOSE 21000
