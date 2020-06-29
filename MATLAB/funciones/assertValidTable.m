function assertValidTable(Tabla)
    Metadatos = Tabla.Properties.UserData;
    esCongruente = datatools.isDataCongruentWithMetadata(Tabla, Metadatos);
    assert(esCongruente, 'La tabla no es v�lida porque los metadatos no coinciden con los datos.');
end