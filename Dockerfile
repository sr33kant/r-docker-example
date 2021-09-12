FROM rocker/r-ver:4.0.2
RUN apt-get update -qq && apt-get install -y \
      libssl-dev \
      libcurl4-gnutls-dev
RUN R -e "install.packages('plumber', dependencies=TRUE)"
RUN R -e "install.packages('deplyr',dependencies=TRUE)"
RUN R -e "install.packages('taskscheduleR',dependencies=TRUE)"
RUN R -e "install.packages('varhandle',dependencies=TRUE)"
RUN R -e "install.packages('NHSRdatasets',dependencies=TRUE)"
RUN R -e "install.packages('readr', dependencies=TRUE)"
RUN R -e "install.packages('yaml', dependencies=TRUE)"
RUN R -e "install.packages('caret', dependencies=TRUE)"
RUN R -e "install.packages('ipred', dependencies=TRUE)"
RUN R -e "install.packages('swagger', dependencies=TRUE)"
RUN R -e "install.packages('rapidoc', dependencies=TRUE)"
COPY / /
EXPOSE 80
ENTRYPOINT ["Rscript", "plumb.R"]
