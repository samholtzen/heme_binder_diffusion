FROM condaforge/miniforge3

RUN apt update && apt upgrade

RUN apt install -y libtiff-dev htop

WORKDIR /data

COPY envs/diffusion.yml envs/mlfold.yml /opt

RUN conda env create --file /opt/diffusion.yml

RUN CONDA_OVERRIDE_CUDA="11.8" conda env create --file /opt/mlfold.yml

RUN echo "conda activate diffusion" >> ~/.bashrc
SHELL ["conda", "run", "--no-capture-output", "-n", "diffusion", "/bin/bash", "-c"]

# RUN conda env update --name diffusion --file /opt/diffusion.yml

RUN conda install jupyter

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "diffusion", "jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]
