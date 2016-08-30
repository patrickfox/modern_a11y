# gulp build
# git push origin `git subtree split --prefix build gh-pages`:gh-pages --force
# git subtree push --prefix build origin gh-pages

gulp build
git branch -D gh-pages
git checkout -b gh-pages
git checkout master
git push origin `git subtree split --prefix build gh-pages`:gh-pages --force

# gulp build
# git subtree split --prefix build -b gh-pages-temp
# git push -f origin gh-pages-temp:gh-pages
# git branch -D gh-pages-temp