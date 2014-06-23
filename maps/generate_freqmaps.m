load ad;
load mapmapping;
load cellposecoords;
im = imread('swMapBase.png');

%% base image

for adid = size(ad,1):-1:1
    % ren coords
    ins = ad{adid,6};
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
    im = insertShape(im, 'Polygon', mapp(:).', 'Color', 180*[1 1 1], 'LineWidth', 4);
end

%     imagesc(im);
%     axis image
baseim = im;

%% freqs
freqs = zeros(size(ad,1),1);
for adid = 1:size(ad,1)
    freqs(adid) = str2double(ad{adid,3});
end

unfq = unique(freqs);
for fid = 1:numel(unfq)
    im = baseim;
    for adid = 1:size(ad,1)
        if (str2double(ad{adid,3}) == unfq(fid))
            ins = ad{adid,6};
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
            im = insertShape(im, 'Polygon', mapp(:).', 'Color', 0*[1 1 1], 'LineWidth', 4);
        end
    end
    
    for adid = size(ad,1):-1:1
        if (str2double(ad{adid,3}) == unfq(fid))
            poses = cellposecoords{adid,1};
            textcolor = 'magenta';
            for ii = 1:size(poses,1)
                im = insertText(im,poses(ii,:),ad{adid,4}, 'FontSize', fontsize, 'BoxOpacity', 0, 'TextColor', textcolor);
                im = insertText(im,poses(ii,:)+diffpose,ad{adid,5}, 'FontSize', fontsize, 'BoxOpacity', 0, 'TextColor', textcolor);
                im = insertText(im,poses(ii,:)+2*diffpose,ad{adid,3}, 'FontSize', fontsize, 'BoxOpacity', 0, 'TextColor', textcolor);
            end
        end
    end
    
    
    imagesc(im); axis image;
    pause(.1);
    %imwrite(im, sprintf('freqmaps/fq%d.png', unfq(fid)*1000));
end







