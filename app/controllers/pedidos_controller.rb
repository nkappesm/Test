class PedidosController < ApplicationController

  def index
  	#Pedido.FTP
  	@pedidos = Pedido.all
  end
end
