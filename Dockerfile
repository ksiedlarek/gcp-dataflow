FROM gcr.io/dataflow-templates-base/python3-template-launcher-base
ARG WORKDIR=/dataflow/template
RUN mkdir -p ${WORKDIR}

WORKDIR ${WORKDIR}

# Due to a change in the Apache Beam base image in version 2.24, you must to install
# libffi-dev manually as a dependency. For more information:
# https://github.com/GoogleCloudPlatform/python-docs-samples/issues/4891

# update used packages
RUN apt-get update && apt-get install -y \
    libffi-dev \
 && rm -rf /var/lib/apt/lists/*

#COPY requirements.txt .
COPY wordcount.py .
COPY ./apache-beam-2.30.0.tar.gz /tmp

#ENV FLEX_TEMPLATE_PYTHON_REQUIREMENTS_FILE="${WORKDIR}/requirements.txt"
ENV FLEX_TEMPLATE_PYTHON_PY_FILE="${WORKDIR}/wordcount.py"

RUN python -m pip install --user --upgrade pip setuptools wheel
RUN python -m pip install /tmp/apache-beam-2.30.0.tar.gz
