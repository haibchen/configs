FROM centos:7.4.1708

# install build tools/libraries required
RUN yum install -y unzip which wget gcc git patch openssl-devel bzip2-devel libffi-devel make
COPY jdk-8u172-linux-x64.rpm /tmp/
RUN yum install -y /tmp/jdk-8u172-linux-x64.rpm && rm -rf /tmp/jdk-8u172-linux-x64.rpm



ENV CUDA_VERSION 10.1.168
ENV CUDA_PKG_VERSION 10-1-$CUDA_VERSION-1

# The instructions below to install CUDA and cuDNN is dervied from nvidia cuda dockerfile : https://gitlab.com/nvidia/cuda
# https://gitlab.com/nvidia/cuda/commit/a5d3dc6c45f9f9c342d1223814cb54aa189d9bdf#2297edcd4408051997d1ab873113852a0682c3f1
# The reason for taking the path instead of the standard instruction is to reduce container image size
RUN NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/7fa2af80.pub | sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA && \
    echo "$NVIDIA_GPGKEY_SUM  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c --strict -
# https://gitlab.com/nvidia/container-images/cuda/blob/a5d3dc6c45f9f9c342d1223814cb54aa189d9bdf/dist/centos7/10.1/base/cuda.repo
COPY cuda.repo /etc/yum.repos.d/cuda.repo

# install cuda 10.1 runtime packages
RUN yum install -y cuda-cudart-$CUDA_PKG_VERSION cuda-compat-10-1  && ln -s cuda-10.1 /usr/local/cuda && rm -rf /var/cache/yum/*
ENV PATH=/usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# install cuda 10.1 devel packages
RUN yum install -y cuda-nvml-dev-$CUDA_PKG_VERSION cuda-command-line-tools-$CUDA_PKG_VERSION cuda-libraries-dev-$CUDA_PKG_VERSION \
    cuda-minimal-build-$CUDA_PKG_VERSION
RUN rm -rf /var/cache/yum/*
ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs

# install cudNN 7.6.1 packages
RUN CUDNN_DOWNLOAD_SUM=9885e38e71fa9844b3e4fb7c7211af41b24c9f76a9014f9d5e1768ddff2087dc && \
    curl -fsSL http://developer.download.nvidia.com/compute/redist/cudnn/v7.6.1/cudnn-10.1-linux-x64-v7.6.1.34.tgz -O && \
    echo "$CUDNN_DOWNLOAD_SUM  cudnn-10.1-linux-x64-v7.6.1.34.tgz" | sha256sum -c - && \
    tar --no-same-owner -xzf cudnn-10.1-linux-x64-v7.6.1.34.tgz -C /usr/local && \
    rm -rf cudnn-10.1-linux-x64-v7.6.1.34.tgz &&  ldconfig

# install NCCL (https://developer.download.nvidia.com/compute/machine-learning/repos/rhel7/x86_64/nvidia-machine-learning-repo-rhel7-1.0.0-1.x86_64.rpm)
RUN wget -O /tmp/nvidia-ML-repo-rhel7.rpm https://developer.download.nvidia.com/compute/machine-learning/repos/rhel7/x86_64/nvidia-machine-learning-repo-rhel7-1.0.0-1.x86_64.rpm
RUN rpm -i /tmp/nvidia-ML-repo-rhel7.rpm && yum clean all && \
    yum install -y libnccl-2.4.8-1+cuda10.1 libnccl-devel-2.4.8-1+cuda10.1 libnccl-static-2.4.8-1+cuda10.1 && \
    rm -rf /tmp/nvidia-ML-repo-rhel7.rpm



# install bazel 25.0
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.25.0/bazel-0.25.0-installer-linux-x86_64.sh && chmod a+x bazel-0.25.0-installer-linux-x86_64.sh
RUN ./bazel-0.25.0-installer-linux-x86_64.sh && rm -rf bazel-0.25.0-installer-linux-x86_64.sh



# install python 3.7 from source (See https://tecadmin.net/install-python-3-7-on-centos/)
RUN cd /usr/src && wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz && tar xzf Python-3.7.3.tgz
RUN cd /usr/src/Python-3.7.3 && ./configure && make altinstall && rm -rf /usr/src/Python-3.7.3.tgz
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3.7 get-pip.py && rm -rf get-pip.py



# create a python3.7 virtual environment
ENV VIRTUAL_ENV=/venv
RUN python3.7 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"



# install tensorflow python dependencies in the virtual environment
RUN pip install -U pip six numpy wheel setuptools mock future>=0.17.1
RUN pip install -U keras_applications==1.0.6 --no-deps
RUN pip install -U keras_preprocessing==1.0.5 --no-deps



COPY build_tensorflow_in_docker.sh /build_tensorflow_in_docker.sh
RUN chmod a+x /build_tensorflow_in_docker.sh
CMD ["/bin/bash", "/build_tensorflow_in_docker.sh"]
