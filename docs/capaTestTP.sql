-- PRUEBA ALTA CONCESIONARIO 
CALL sp_altaConcesionario('Strianese', 'Av. Hipolito Yrigoyen 1105', @res, @msj);
SELECT @res AS nResultado, @msj AS cMensaje; -- el AS es para que en la columna se muestre nResultado y cMensaje en vez de @res y @msj

-- PRUEBA CONCESIONARIO DUPLICADO
CALL sp_altaConcesionario('Strianese', 'Av. Hipolito Yrigoyen 1105', @res, @msj);
SELECT @res AS nResultado, @msj AS cMensaje; -- el AS es para que en la columna se muestre nResultado y cMensaje en vez de @res y @msj
 
-- PRUEBA MODIFICACION CONCESIONARIO
CALL sp_modificarConcesionario(3, 'Strianese', 'Av. Hipolito Yrigoyen 9999', @res, @msj);
SELECT @res AS nResultado, @msj AS cMensaje;
 
-- PRUEBA ALTA DE PEDIDO CABECERA 
CALL sp_altaPedido(1, @id_pedido_nuevo, @res, @msj);
SELECT 
    @id_pedido_nuevo AS idPedidoGenerado,
    @res AS nResultado,
    @msj AS cMensaje;

-- PRUEBA ALTO DE MODELO
CALL sp_altaModelo('Cronos 2026', @res, @msj);
    
-- PRUEBA ALTA DE PEDIDO DETALLE
CALL sp_altaPedidoDetalle(@id_pedido_nuevo, 1, 5, @res, @msj);
SELECT @res AS nResultado, @msj AS cMensaje; 
    
-- PRUEBA ELIMINACION DE CONCESIONARIO
CALL sp_bajaConcesionario(1, @res, @msj);-- DEBE FALLAR PORQUE EL CONCESIONARIO TIENE PEDIDOS
SELECT @res AS nResultado, @msj AS cMensaje;
        
-- PRUEBA ELIMINACION DE DETALLE DE PEDIDO
CALL sp_bajaPedidoDetalle(@id_pedido_nuevo, 1, @res, @msj);
SELECT @res AS nResultado, @msj AS cMensaje; -- Esperado: 0 
    
-- PRUEBA ELIMINAR PEDIDO CABECERA
CALL sp_bajaPedido(@id_pedido_nuevo, @res, @msj);
SELECT @res AS nResultado, @msj AS cMensaje; -- Esperado: 0
    
-- PRUEBA BORRAR DETALLE DEL PEDIDO   
CALL sp_bajaPedidoDetalle(1, 1, @res, @msj);-- (id_pedido, id_modelo) 
SELECT @res AS Resultado, @msj AS Mensaje; 
    
-- PRUEBA BORRAR PEDIDO CABECERA
CALL sp_bajaPedido(1, @res, @msj);-- (id_pedido) 
SELECT @res AS Resultado, @msj AS Mensaje; 
    
-- BORRAR CONCESIONARIO
CALL sp_bajaConcesionario(6, @res, @msj);-- (id_concesionario) -- SE TIENEN QUE BORRAR LOS PEDIDOS ANTES PORQUE ESTAN VINCULADOS
SELECT @res AS Resultado, @msj AS Mensaje;
    
-- VER LISTADO DE CONCESIONARIOS
SELECT 
    *
FROM
    concesionario;
    