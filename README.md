# bash-niceties

This project contains a collection of bash functions (and any required helpers) that have been found useful over the years.

Current members:
 - rus
    - [R]un [U]ntil [S]uccess
    - Prepend 'rus' before any command to run repeatedly until success.
        - Ex: rus cat /tmp/myfile
        - This example will repeatedly attempt to cat /tmp/myfile until it succeeds
    - Arguments:
        - -d &lt;int&gt; Delay, where &lt;int&gt; represents how many secs to sleep between attempts
        - -v Increase amount of info printed during execution
        - -m &lt;int&gt; Maximum allowed iterations, where &lt;int&gt; represents how many iterations to allow before quiting