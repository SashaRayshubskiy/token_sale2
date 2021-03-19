rsync -r src/ docs/
rsync build/contracts/* docs/
git add docs
git commit -m "compiles assets for github pages"
git push -u origin master
