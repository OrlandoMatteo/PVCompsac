addpath matrici
filenames=["terzo_20.mat","primo_20.mat","secondo_20.mat" ];
%
Ns=[16 ,32 ,48];
productions=zeros(3,3,16);
for i=1:length(filenames)
    for j=1:length(Ns)
        filenames(i)
        Ns(j)
        productions(i,j,:)=test(filenames(i),Ns(j));
    end
end
        