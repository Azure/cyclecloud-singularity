#!/opt/cycle/jetpack/system/embedded/bin/python -m pytest
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.
import os
import glob
import subprocess


def test_singularity():
    # Change directory to examples tree
    os.chdir('/mnt/cluster-init/singularity/default/files/examples/sleep')

    # Make shell scripts executable
    shell_files = glob.glob('*.sh')
    for script in shell_files:
        os.chmod(os.path.join('.', script), 0755)

    # Build singularity image
    subprocess.check_call([os.path.join('.', 'build_image.sh')])

    # Submit sleep job
    subprocess.check_call([os.path.join('.', 'submit.sh')])
