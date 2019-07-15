# Singularity #

This project installs and configures the Singularity container system.

Singularity is a system for building and running Linux Containers. See the [Singularity](https://singularity.lbl.gov) project site for more information and documentation.

The project includes an example cluster template which adds Singularity to a PBS grid.   But the Singularity project is intended primarily as an additional capability that can be added to any Cyclecloud cluster.

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Singularity](#singularity)
    - [Pre-Requisites](#pre-requisites)
    - [Configuring the Project](#configuring-the-project)
    - [Deploying the Project](#deploying-the-project)
    - [Importing the Cluster Template](#importing-the-cluster-template)

<!-- markdown-toc end -->


## Pre-Requisites ##


This sample requires the following:

  1. The Singularity source tarball or the Singularity RPM or DEB files (depending on the OS you select for your cluster).
  
     a. Download the source or binaries following the instructions here: (https://singularity.lbl.gov/install-linux)
     	* To download the source, you can simply run:
	  `VERSION="3.1.1" && curl -L -O "https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz"`
     b. Place the source tarball and/or package files in the `./blobs/` directory.
     c. If the version is not 3.1.1 (the project default), then update the version number in the Files list
        in `./project.ini` and in the cluster template: `./templates/pbs-singularity.txt`.
     d. If you are starting from the package files, also add the package file names to the Files list in
        `./project.ini`
     
  3. CycleCloud must be installed and running.

     a. If this is not the case, see the CycleCloud QuickStart Guide for
        assistance.

  4. The CycleCloud CLI must be installed and configured for use.

  5. You must have access to log in to CycleCloud.

  6. You must have access to upload data and launch instances in your chosen
     Cloud Provider account.

  7. You must have access to a configured CycleCloud "Locker" for Project Storage
     (Cluster-Init and Chef).

  8. Optional: To use the `cyclecloud project upload <locker>` command, you must
     have a Pogo configuration file set up with write-access to your locker.

     a. You may use your preferred tool to interact with your storage "Locker"
        instead.


## Configuring the Project ##


The first step is to configure the project for use with your storage locker:

  1. Open a terminal session with the CycleCloud CLI enabled.

  2. Switch to the singularity project directory.

  3. Copy the following source tarballs and/or RPM and DEB files to `./blobs`
    
  4. If the version number is not 3.1.1, update the version numbers in `project.ini` and `templates/pbs-singularity.txt`

  5. If adding the RPM and/or DEB files, add them to the Files list in the `project.ini`
    

## Deploying the Project ##


To upload the project (including any local changes) to your target locker, run the
`cyclecloud project upload` command from the project directory.  The expected output looks like
this:

``` bash

   $ cyclecloud project upload my_locker
   Sync completed!

```


**IMPORTANT**

For the upload to succeed, you must have a valid Pogo configuration for your target Locker.


## Importing the Cluster Template ##


To import the cluster:

 1. Open a terminal session with the CycleCloud CLI enabled.

 2. Switch to the Singularity project directory.

 3. Run ``cyclecloud import_template PBS-Singularity -f templates/pbs-singularity.txt``.
    The expected output looks like this:
    
    ``` bash
    
    $ cyclecloud import_template PBS-Singularity -f templates/pbs-singularity.txt --force
    Importing template PBS-Singularity....
    ----------------------------
    PBS-Singularity : *template*
    ----------------------------
    Keypair:
    Cluster nodes:
	master: off
    Total nodes: 1
    ```



# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
