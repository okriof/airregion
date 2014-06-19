i = 0;
ad = cell(1,6);
% FIR '' '' UNL GND '690336N 0203255E - 653148N 0240824E -644100N 0225500E - 633700N 0213000E -632830N 0204000E - 631000N 0201000E -614000N 0193000E - 610000N 0191905E -601803N 0190756E - 601130N 0190512E -593346N 0195859E - 591524N 0203239E -590000N 0210000E - 573410N 0200900E -570000N 0195000E - 555100N 0173300E -545500N 0155200E - 545500N 0150807E -545500N 0142127E - 545500N 0125100E -552012N 0123827E - 561253N 0122205E -583000N 0103000E - 584540N 0103532E -585332N 0103820E - 690336N 0203255E';
%                 aor desig, freq,  upper, lower, sidepoints
%i=i+1; ad(i,:) = {'', '', '.', '', '', ''};
i=i+1; ad(i,:) = {'MALMÖ', 'ESMM ACC sector 2:1', '127.755', 'UNL', 'FL 285', '575020N 0141939E - 565727N 0155231E -565200N 0153959E - 564101N 0151432E -563741N 0150704E - 563006N 0145321E -561900N 0143212E - 555250N 0134214E -554600N 0132050E - 553831N 0130536E -553233N 0125337E - 553101N 0125032E -553238N 0124831E - 555101N 0122524E -560435N 0120801E - 563121N 0115716E -563601N 0120410E - 565522N 0123308E -573059N 0134209E - 575020N 0141939E'};




%% disp region
load mapmapping
% ren coords
ins = ad{6};
coordren = ins;
jj = 1;
for ii = 1:numel(ins)
    if ((ins(ii) >= '0' && ins(ii) <= '9') || ins(ii) == ' ')
        coordren(jj) = ins(ii);
        jj = jj + 1;
    end
end
coordren = coordren(1:jj-1);
coordren = reshape(sscanf(coordren,'%d'), 2, []);
% map
mapp = H*[coordren; ones(1, size(coordren,2))];
mapp = mapp(1:2,:)./repmat(mapp(3,:),2,1);
% display
imagesc(im); hold on;
plot(mapp(1,:), mapp(2,:),'mx-');
axis image
