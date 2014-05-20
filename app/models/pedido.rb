class Pedido < ActiveRecord::Base
	require 'net/ftp'
	require 'Nokogiri'

	def self.FTP
		server = "http://integra.ing.puc.cl/"
		user = "grupo3"
		password = "23093md"

		ftp = NET::FTP.new(server, user, password)
		files = ftp.chdir ('Pedidos')
		files = ftp.nlst('pedido_*')

		#entry.name.split('.')[1]=="xml"

		files.each do |file|
			#name = File.basename(file, ".xml")
			#name = name.delete! 'pedido_'
			#if name.to_i > @savedLastOrder
				ftp.getbinaryfile(file)
				doc = Nokogiri::XML(open(file))

				actual = doc.xpath('//Pedidos')
				f = actual.at_xpath["@fecha"].value
				h = actual.at_xpath["@hora"].value
				d = actual.at_xpath("direccionId").value
				r = actual.at_xpath("rut").value
				e = actual.at_xpath("fecha").value				

				pedidos = actual.at_xpath("Pedido")
				pedidos.each do |data|
					p = Pedido.new
					p.fecha = f		
					p.hora = h
					p.direccion = d
					p.rut = r
					p.entrega = e
					p.sku = data.at_xpath("sku").value
					p.cantidad = data.at_xpath("cantidad").value
				end # end pedidos.each
			#end # end if
		end #end files.each
		ftp.close
	end # end ftp

	def showAll
		Post.all
	end
end
