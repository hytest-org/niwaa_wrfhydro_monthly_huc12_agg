# NIWAA monthly WRFHydro HUC12 aggregations 

This repository is dedicated to understanding pre-existing scripts provided by NCAR colleagues that perform HUC12 aggregations on monthly WRFHydro datasets. This will be accomplished through three major tasks: 

1. Ensure scripts are working as written
2. Include essential documentation for workflow
3. Improve upon existing workflow in ways that suit the HyTEST team

Tasking can be tracked [here](https://github.com/hytest-org/hytest_internal/issues/47#issue-2468332257)

Task Team members: lstaub4, amsnyder and sfoks

## At a glance
**NCAR_Scripts:** Folder containing unedited workflow from NCAR

**Working:** Folder containing testing area of NCAR scripts


# Summary table of NIWAA WRF-Hydro Output files used in this tutorial 
both 3-hourly datasets and static datasets

# Summary of HUC12 spatial fabric used





## Contributing with Git Guide

This is a guide intended for Gitlab beginners. 

> ***Vocabulary used throughout this guide:***
> ***'Remote' refers to repository hosted online. 'Local' refers to repository on user device. The remote repository is both a back-up for workflows in case something happens to the user's local device and a platform for project visibility and contribution throughout the USGS.***

## SSH Setup 
*Ensure gitbash and miniconda3 are installed and connected to each other on device* 

> ***Must be on VPN for SSH to work with usgs gitlab.***

### Check for ssh keys on device
```
ls -al ~/.ssh
```
If none are listed, [a new key must be created](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

If there are keys existing, it needs to be confirmed that it is listed in the users gitlab SSH keys library. This can be done by navigating to the .ssh folder on the device, copying the public ssh key contents, and pasting into a new SSH key in the users gitlab profile. This process is described in more detail [here](https://phoenixnap.com/kb/git-clone-ssh).

### Ensure the SSH key is added to the SSH agent
Check to see if gitbash is connected to gitlab: 
```
ssh -T git@github.com
```
Check to see if ssh agent is running:
```
eval "$(ssh-agent -s)"
```
Add private ssh key on device to ssh agent
```
ssh-add <insert/path/to/private/key>
```

## Fork the repository of interest
Go to the [md-de-dc-wsc repo](https://code.usgs.gov/md-de-dc-wsc) in your browser.

Navigate to the project of interest and click "Fork" in the top right level with the repository name, this will open a forked copy of the repository that will belong to you.

# Clone the repository of interest
Within your fork, click the blue "Clone" button near the middle-right side of the screen. 

Click the copy icon under "Clone with SSH". Paste the ssh clone address with the following command: 
```
git clone <paste "Clone with SSH" contents here>
```
Repository familiarization. Navigate to the repository using *cd* and list all folders within using *ls*.
```
cd <name of repo cloned>
ls
```

### Make your own branch 
Name the new branch to reflect current task or issue at hand. 
```
git branch <name-of-branch>
```
Switch to this branch: 
```
git checkout <name-of-branch>
```

Start making changes, contributions, and adding workflows! 

## Push Contributions to repository
It is wise to frequently push your edits from the local branch to the remote branch to ensure our work is backed up. Many of these steps are described [here](https://www.earthdatascience.org/workshops/intro-version-control-git/basic-git-commands/). 


> ***Must be on VPN for push requests to work.***

Check the difference between your local branch and your remote branch: 
```
git status
```
Add all contributions to log:
```
git add --all
```
Leave a commit message to go along with contributions. Be as detailed as possible!
```
git commit -m "<message inserted here>" 
```
Check if this commit was added, adding the 5 will list last 5 commits. Leaving the 5 off will print the entire history, beware~
```
git log -n 5
```

Push local branch to remote branch to ensure workflow is backed up online!
```
git push origin <name-of-branch>
```

## Merge Branch to Main
Once the task or issue at hand has been completed or solved, the branch created can be merged into the main stem. Ensure that all commits have been completed and that the main branch on local machine is up to date with remote main branch. 

Check the difference between the local branch and the remote branch: 
```
git remote update
git status
```
If there is no difference, it is okay to merge. If there is a difference, there could be a handful of causes: 
1. Local branch is ahead of the remote branch.
    - go through git add, commit, and push process of local branch. 
2. Local branch is behind the remote branch. This could happen if another team member has contributed to the same branch. 
    - pull updates
    ```
    git pull  
    ```
If changes are made to the main branch that should be incorporated before branch task is finished, the main branch must be pulled and merged into desired branch. 
```
git checkout main 
git pull
```
This will update the local main branch to reflect the remote main branch. To add changes from updated main branch into the working branch: 
```
git checkout <name-of-branch>
git merge main
```

Once the working branch is ready, it can be merged into the main branch. This can be done by completing the add, commit, push combination and then going to the repository on Gitlab. From there, navigate to the desired branch using the drop down and select the "create merge requuest" button that will display in a banner on the top of the screen. 

The merge request will need to be approved and submitted- all developers on this project should have permission to do both. Once the merge of the desired branch into main is completed, the desired branch will be deleted remotely on Gitlab. It is best practice to also go into gitbash and also delete the now complete branch:
```
git checkout main
git branch -d <name-of-branch>
```

It is best practice to ensure that the local main branch is up to date before creating a new branch. This can be accomplished by performing the "git pull" command. 
