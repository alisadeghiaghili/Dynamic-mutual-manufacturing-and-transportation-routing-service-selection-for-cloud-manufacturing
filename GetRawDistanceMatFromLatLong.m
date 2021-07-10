function [DistanceMat,CityNames] = GetRawDistanceMatFromLatLong(FileAddress,X1DegreeDis,Y1DegreeDis, Howmany)

[num,~,raw] = xlsread(FileAddress);
RowNum = Howmany;
CityNames = raw(2:RowNum+1,1);
%lat & long
Coordinates = num(1:RowNum,1:2);
%lat
Coordinates(:,1) = Coordinates(:,1) * X1DegreeDis;
%long -- what is Y1DegreeDis
Coordinates(:,2) = Coordinates(:,2) * Y1DegreeDis;
DistanceMat = pdist2(Coordinates,Coordinates);
