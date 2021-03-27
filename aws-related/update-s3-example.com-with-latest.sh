
echo -n "replacing example.org..."
grep -rli 'http://benschilke.com.s3-website-us-west-2.amazonaws.com' * | xargs -i@ sed -i 's/http:\/\/example.org/http:\/\/benschilke.com.s3-website-us-west-2.amazonaws.com/g' @
echo "done"
aws s3 rm s3://benschilke.com --recursive
aws s3 cp public/ s3://benschilke.com --recursive

