for i=1:12
subplot(3,4,i)
heatmap(R(start:stop,start:stop),'ColorLimits',[min(R(:)) max(R(:))]);
start=start+8;
stop=stop+8;
end

if (corrcoef(minG(oldPosition(1),oldPosition(2),:),minG(position(1),position(2),:)))>0