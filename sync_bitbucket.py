"""
pip install pybitbucket
=== On Linux
 43 15    * * *   iulian python /home/iulian/WorkDev/dotfiles/sync_bitbucket.py
 chmod 644 /etc/cron.d/bitbucket
 chown root:root /etc/cron.d/bitbucket
 service cron reload
=== On OS X
 sudo crontab -u root -e
 SHELL=/bin/bash
 MAILTO=iulian
 PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
 43 19    * * *   cd /Users/iulian/WorkDev/dotfiles/ && python sync_bitbucket.py
===
The file bitbucket_credentials.py has to conform to this structure:
  BITBUCKET_USERNAME = "iulianu"
  BITBUCKET_PASSWORD = "lalala123"
  BITBUCKET_TEAMS = ["team1", "team2"]
  LOCAL_DIR = "~/Archive/bitbucket"
  LOCAL_USER = "iulian"
"""

import os
import sys
from pybitbucket.bitbucket import Bitbucket, Client
from pybitbucket.auth import BasicAuthenticator
from pybitbucket.team import Team
from pybitbucket.repository import Repository, RepositoryRole
import bitbucket_credentials as creds


bitbucket = Client(
    BasicAuthenticator(
        creds.BITBUCKET_USERNAME,
        creds.BITBUCKET_PASSWORD,
        'foo@gmail.com'))


def repo_url(owner, slug):
    return "https://%s:%s@bitbucket.org/%s/%s" % (creds.BITBUCKET_USERNAME, creds.BITBUCKET_PASSWORD, owner, slug)


def local_path(scm, owner, slug):
    return "%s/%s/%s/%s" % (creds.LOCAL_DIR, scm, owner, slug)


def fetch_command(scm, url):
    if scm == 'git':
        return "git fetch %s" % url
    elif scm == 'hg':
        return "hg pull %s" % url
    else:
        raise "Unknown SCM %s" % scm


def clone_command(scm, url, lpath):
    if scm == 'git':
        return "git clone -n %s %s" % (url, lpath)
    elif scm == 'hg':
        return "hg clone -U %s %s" % (url, lpath)
    else:
        raise "Unknown SCM %s" % scm


def sync_repo(scm, owner, repo_name):
    url = repo_url(owner, repo_name)
    lpath = local_path(scm, owner, repo_name)
    if os.path.exists(lpath):
        print("Updating %s" % repo_name)
        exit_code = os.system("cd %s && %s" % (lpath, fetch_command(scm, url)))
    else:
        print("Cloning %s/%s" % (owner, repo_name))
        exit_code = os.system(clone_command(scm, url, lpath))
    if exit_code != 0:
        print("Last command exited with code %s" % exit_code)
        sys.exit(exit_code)


def sync_owner(owner_name):
    repos = list(Repository.find_repositories_by_owner_and_role(owner_name, 'member', client=bitbucket))
    print("Count of repositories: %d" % len(repos))
    for repo in repos:
        print(repo.name)
        sync_repo(repo.scm, owner_name, repo.name)


os.system("mkdir -p %s" % creds.LOCAL_DIR)

sync_owner(creds.BITBUCKET_USERNAME)
for team in creds.BITBUCKET_TEAMS:
    sync_owner(team)
