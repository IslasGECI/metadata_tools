%GETCOORDINATESTARTCOUNT Encuentra los �ndices y la cantidad de datos de
%los vectores de coordenadas que vienen desde un archivo NetCDF.
%
% Descripci�n:
%
%   Los �ndices y cantidad de datos obtenidos se utilizar�n cuando se
%   importen los datos del archivo NetCDF para s�lo cargar los datos dentro
%   del dominio de la regi�n.
%
% Autores:
%
%   Efren Cabrera Ortega <efren.cabrera@islas.org.mx>
%   Yutzil Lora Cabrera <yutzil.lora@islas.org.mx>
%
% Referencias:
%
%   -
%
% Sintaxis:
%
%   Estructura = getCoordinateStartCount(nombreArchivo,idRegion)
%
% Entrada:
%
%   nombreArchivo (char)  Nombre del archivo NetCDF
%
%   idRegion (RegionID) ID de la regi�n
%
% Salida:
%
%   Estructura (struct) estructura con los �ndices y la cantidad de datos
%   de los vectores de coordenadas
%
% Ejemplos:
%
%   Estructura = getCoordinateStartCount('mur-sst-concatenado-mensual-2003-2017.nc',RegionID.guadalupe);
%
% See also: ncread
%
function Estructura = getCoordinateStartCount(nombreArchivo, GeoPoligono, lonAxis, latAxis)
% Se buscan los indices que corresponden a los limites de la regi�n
lon = ncread(nombreArchivo, lonAxis);
lat = ncread(nombreArchivo, latAxis);
% Se buscan los limites de la regi'on
lonMin = nanmin(GeoPoligono.lon);
lonMax = nanmax(GeoPoligono.lon);
latMin = nanmin(GeoPoligono.lat);
latMax = nanmax(GeoPoligono.lat);
% Acomoda las longitudes
lon(lon > 180) = lon(lon > 180) - 360;
% Se buscan los indices de longitud y latitud que caen dentro de la regi�n
esLon = lon > lonMin & lon < lonMax;
esLat = lat > latMin & lat < latMax;

Estructura.inicioLon = find(esLon, 1);
Estructura.inicioLat = find(esLat, 1);
Estructura.nLon = sum(esLon);
Estructura.nLat = sum(esLat);
end