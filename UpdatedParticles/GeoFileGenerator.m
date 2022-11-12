scaledsizematrix=sizematrix./1000;
geoformatspec='SetFactory("OpenCASCADE");\nPoint(1) = {0,0,0,0};\nSphere(1) = {0,0,0,%1.8f};\nMeshSize{ PointsOf{ Surface{:}; } } = %1.9f;\nMesh.ElementOrder=1;\nMesh.Format=39;\n';
% sourcefile='shot.geo';
 numcopies = 3001;
% [path, basename, ext] = fileparts(sourcefile);
% filepattern = fullfile(path, [basename '%04d' ext]);
% destnames = cellstr(num2str((numcopies).',filepattern));
% cellfun(@(FID) copyfile(sourcefile,FID),destnames);
 batchfilespec='shotgeo.bat';
 for batch=1:1:numcopies
     batchfile=fopen(batchfilespec,'a+');
     batchspec='gmsh shot%04d.geo -2 shot%04d.inp \n';
     fprintf(batchfile,batchspec,batch,batch);
     fclose(batchfile);
 end

for n=1:1:numel(sizematrix)
    filename=sprintf('shot%04d.geo',n);
    file=fopen(filename,'w+');
    fprintf(file,geoformatspec,scaledsizematrix(n), scaledsizematrix(n)/10);
    fclose(file);
end