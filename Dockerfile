FROM openanalytics/r-base

MAINTAINER "Vedha Viyash" vedhaviyash4@gmail.com

# Installing linux dependencies for the R packages
RUN apt-get update && apt-get install  -y software-properties-common
RUN add-apt-repository ppa:marutter/c2d4u3.5
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    build-essential \
    libcurl4-gnutls-dev \
    libxml2-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.0.0 \
    r-cran-rglpk \
    libglpk-dev

# Installing the R packages required to run this app
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('shinydashboard')"
RUN R -e "install.packages('DT')"
RUN R -e "install.packages('ompr')"
RUN R -e "install.packages(c('Rglpk', 'slam'))"
RUN R -e "install.packages('ROI')"
RUN R -e "install.packages('ompr.roi')"
RUN R -e "install.packages('ROI.plugin.glpk')"
RUN R -e "install.packages('dplyr')"


# Copy the shiny app files to the image and run the shiny app. Make sure to place the ui.R, server.R and the www in the location of this Dockerfile
COPY . /root/
WORKDIR /root/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp(port = getOption('shiny.port', 3838), host = getOption('shiny.host', '0.0.0.0'))"]