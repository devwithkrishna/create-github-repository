# create-github-repository
create-github-repository using automation

* This is using a github workflow to create a repositiry in a organization

* The credential used is ``` PERSONAL ACCESS TOKEN ``` 

for reference: ``` https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#create-an-organization-repository ```

:pushpin:
[create-an-organization-repository] (https://docs.github.com/en/rest/repos/repos?piVersion=2022-11-28#create-an-organization-repository)

## How code works?
Using a bash script, bash script receives parameters from github workflow and creates a github repo.

## Licensing templates

```
Choose an open source license template that best suits your needs, and then use the license keyword as the license_template string. For example, "mit" or "mpl-2.0"
```
[license-keyword] (https://docs.github.com/articles/licensing-a-repository/#searching-github-by-license-type)

## gitignore template

```
Desired language or platform .gitignore template to apply. Use the name of the template without the extension. For example, "Python".
```
[gitignore-template](https://github.com/github/gitignore)

**if gitignore template and license templates are set as " " then they will not be addded to payload.** 
