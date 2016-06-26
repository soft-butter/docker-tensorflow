# Start with cuDNN base image
FROM kaixhin/cudnn:latest

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    python-pip \
    python-dev

# Set CUDA_ROOT
ENV CUDA_ROOT /usr/local/cuda/bin
ENV TF_BINARY_URL https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.9.0-cp27-none-linux_x86_64.whl

RUN pip install --upgrade $TF_BINARY_URL
