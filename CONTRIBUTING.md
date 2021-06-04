# Firefighter

FireFighter inventory management app for Hackwell2.0

## Getting Started

<details>

<summary>
<h3 style="display:inline;">Set it up locally!</h3>
</summary>

### Fork it

You can get your own fork/copy of this project by using the <kbd>Fork</kbd> button.

![Fork Button](https://help.github.com/assets/images/help/repository/fork_button.jpg)

### Clone it

You need to clone (download) it to local machine using

```sh
$ git clone https://github.com/<YOUR_USERNAME>/Firefighter.git
```

Once you have cloned the repository, move to that folder first using `cd` command.

```sh
$ cd Firefighter
```

Move to this folder for all other commands.

### Set it up

Run the following commands to see that _your local copy_ has a reference to _your forked remote repository_ in Github :octocat:

```sh
$ git remote -v
origin  https://github.com/<YOUR_USERNAME>/Firefighter.git (fetch)
origin  https://github.com/<YOUR_USERNAME>/Firefighter.git (push)
```

Now, lets add a reference to the original [Firefighter](https://github.com/VarunSAthreya/Firefighter) repository using

```sh
$ git remote add upstream https://github.com/VarunSAthreya/Firefighter.git
```

> This adds a new remote named **_upstream_**.

Verify the changes using

```sh
$ git remote -v
origin    https://github.com/<YOUR_USERNAME>/Firefighter.git (fetch)
origin    https://github.com/<YOUR_USERNAME>/Firefighter.git (push)
upstream  https://github.com/VarunSAthreya/Firefighter.git (fetch)
upstream  https://github.com/VarunSAthreya/Firefighter.git (push)
```

### Sync it

**Always keep your local copy of repository updated with the original repository.**

Before making any changes and/or in an appropriate interval, run the following commands _carefully_ to update your local repository.

```sh
# Fetch all remote repositories and delete any deleted remote branches
$ git fetch --all --prune

# Switch to `main` branch
$ git checkout main

# Reset local `main` branch to match `upstream` repository's `main` branch
$ git reset --hard upstream/main

# Push changes to your forked `Firefighter` repo
$ git push origin
```

### You're Ready to Go

Once you have completed these steps, you are ready to start contributing or raise [Issues](https://github.com/VarunSAthreya/Firefighter/issues) and creating [pull requests](https://github.com/VarunSAthreya/Firefighter/pulls).

</details>

---

<details>
<summary>
<h3 style="display:inline;">Installation</h3>
</summary>

Make sure you have following installed on your machine:

-   [Flutter SDK](https://flutter.dev/docs/get-started/install)
-   [Android Studio](https://developer.android.com/studio) or [VSCode](https://code.visualstudio.com/download)

To setup Flutter in Android Studio check [here](https://flutter.dev/docs/development/tools/android-studio)

To setup Flutter in VSCode check [here](https://flutter.dev/docs/development/tools/vs-code)

-   Install flutter dependencies using:

```sh
$ flutter pub get
```

-   Setup Firebase(Only Android for now): For more details check [here](https://firebase.google.com/docs/flutter/setup?platform=android)

-   Setup GCP Project

-   Integrate Maps API

-   Replace the GCP API key in the file `android/app/src/main/AndroidManifest.xml` with `YOUR-API-KEY`

Run the app using:

```sh
$ flutter run
```

Upload firebase functions:

```sh
$ firebase deploy --only functions
```

</details>

---

### Create a new branch

Whenever you are going to make contribution. Please create separate branch using the command and keep your `main` branch clean and most stable version of your project (i.e. synced with remote branch).

```sh
# It will create a new branch with name <YOUR GITHUB USERNAME>/<ISSUE NUMBER> and switch to that branch
$ git checkout -b <YOUR GITHUB USERNAME>/<ISSUE NUMBER>
#Example
#$ git checkout -b monatheoctocat/1
```

Create a separate branch for contribution and try to use same name of branch as of your contributing feature associated with your assigned issue.

To switch to desired branch

```sh
# To switch from one branch to other
$ git checkout <BRANCH NAME>
```

To add the changes to the branch. Use

```sh
# To add all files to branch <YOUR GITHUB USERNAME>/<ISSUE NUMBER>
$ git add .
```

Type in a message relevant for code using

```sh
# This message get associated with all files you have changed
$ git commit -m '<relevant message>'
```

Now, Push your awesome work to your remote repository using

```sh
# To push your work to your remote repository
$ git push -u origin <BRANCH NAME>
#Example
#$ git push -u origin <YOUR GITHUB USERNAME>/<ISSUE NUMBER>
```

Finally, go to your repository in browser and click on `compare and pull requests`.
