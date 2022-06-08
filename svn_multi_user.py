import subprocess

for i in range(1,3):
    subprocess.run("sleep 5",shell=True)
    print(i)
    cmd="./svn_seq.sh -a /home/seoji/work/ci_cd/svn/svn_repo_"+str(i)+" -c 5 -u fadu"+str(i)+" -p fadu"+str(i)+" | tee -a fadu"+str(i)+".log &"
    print(cmd)

    subprocess.run(cmd,shell=True)
