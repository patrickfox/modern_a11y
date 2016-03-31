gulp build
git push origin `git subtree split --prefix build gh-pages`:gh-pages --force
git subtree push --prefix build origin gh-pages