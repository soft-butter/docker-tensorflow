FROM nvidia/cuda:7.5-cudnn5-runtime-ubuntu14.04
MAINTAINER Joseph Cheng <indiejoseph@gmail.com>

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python-numpy \
        python-pip \
        python-scipy \
        && \
    apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

ENV TENSORFLOW_VERSION 0.9.0
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64/
ENV CUDA_ROOT=/usr/local/cuda

# Install TensorFlow GPU version.
RUN pip --no-cache-dir install \
    http://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.whl

# Copy cudnn files
RUN ln -s /usr/lib/x86_64-linux-gnu/libcudnn.so.5 /usr/lib/x86_64-linux-gnu/libcudnn.so
RUN cp /usr/lib/x86_64-linux-gnu/libcudnn* /usr/local/cuda/lib64/

# TensorBoard
EXPOSE 6006

CMD ["/bin/bash"]
