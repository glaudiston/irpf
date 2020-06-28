FROM ubuntu:latest
ARG USERNAME
ARG USERUID
ARG USERGID
ARG HOME
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y wget x11-apps openjdk-8-jre xdg-utils firefox fontconfig
ENV DISPLAY :0
RUN groupadd -g $USERGID $USERNAME
RUN useradd \
	--uid $USERUID \
	--gid $USERGID \
	-s /bin/bash \
	-md $HOME \
	$USERNAME >&2
USER $USERUID
WORKDIR $HOME
ENV LANG=pt_BR.UTF8
ENV _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=setting'
RUN wget "http://downloadirpf.receita.fazenda.gov.br/irpf/2020/irpf/arquivos/IRPF2020v1.4.jar"
#RUN xdg-settings set default-web-browser w3m.desktop
RUN chmod a+r IRPF2020v1.4.jar
