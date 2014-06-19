im = imread('swMap.png'); % ES_ENR_2_1_en_FIR_ACC_ map gimp converted  4960x7016
imagesc(im);

imPts = [ 490 4205 3559 1142;
         5529 5525  964  962];

coPts = [ 560000  560000  680000  680000;
         0060000 0240000 0240000 0060000];
     %  old x y   new x y
adjp = [1470 4308 1487 4725
        1795 6434 1903 6073
        3441 3980 3507 4515
        3328 2287 3432 2807];
     
     H = reshape(generate_homog(imPts(1,:), imPts(2,:), coPts(1,:), coPts(2,:)), 3,3).';
     Hadj = reshape(generate_homog(adjp(:,3), adjp(:,4), adjp(:,1), adjp(:,2)), 3,3).';
     
     H = Hadj*H;
     
     H*[coPts;1 1 1 1];
     ans./repmat(ans(3,:), 3,1)
     
hold on;
plot(imPts(1,:), imPts(2,:), 'rx');

% save swMap im H


%%
fir = '690336N 0203255E - 653148N 0240824E -644100N 0225500E - 633700N 0213000E -632830N 0204000E - 631000N 0201000E -614000N 0193000E - 610000N 0191905E -601803N 0190756E - 601130N 0190512E -593346N 0195859E - 591524N 0203239E -590000N 0210000E - 573410N 0200900E -570000N 0195000E - 555100N 0173300E -545500N 0155200E - 545500N 0150807E -545500N 0142127E - 545500N 0125100E -552012N 0123827E - 561253N 0122205E -583000N 0103000E - 584540N 0103532E -585332N 0103820E - 690336N 0203255E';

ins = fir;

% ins input
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


mapp = H*[coordren; ones(1, size(coordren,2))];
mapp = mapp(1:2,:)./repmat(mapp(3,:),2,1);

imagesc(im); hold on;
plot(mapp(1,:), mapp(2,:),'mx-');
