####################################
## Antes de ejecutar este script, carga y selecciona algunos objetos del tipo TextGrid.
## Este script captura las etiquetas puntuales de la grada 2 de una transcripción 
## Sp_ToBI en un objeto TextGrid, ordenando las etiquetas en tres columnas distintas, 
## especificadas manualmente en la grada 4.
####################################

clearinfo

#Imprime el encabezado de la tabla.
appendInfoLine: "ID", tab$, "tonos.ANT", tab$, "tonos.CR", tab$, "tonos.PRED"

# Crea un vector con los sonidos seleccionados
grids# = selected# ("TextGrid")

# Comienza un bucle que itera tantas veces como el tamaño del vector <grids#>.
for grid from 1 to size(grids#)
	# Selecciona el objeto actual en el bucle.
    selectObject: grids# [grid]

	# Define la variable <gridName$> como el nombre del objeto seleccionado.
	gridName$ = selected$ ("TextGrid")	 	

	# Define la variable <numInt> como el número de intervalos contenidos en la grada 4 del objeto TextGrid seleccionado.
	numInt4 = Get number of intervals: 4

	ant$ = ""
	cr$ = ""
	pred$ = ""

	# Comienza un bucle que itere tantas veces como el valor de la variable <numInt4>.
	for i from 1 to numInt4
		# Obtén la etiqueta del intervalo actual.
		select TextGrid 'gridName$'

		etiqueta$ = Get label of interval: 4, i

		# Condición: si la cadena no está vacía, continúa, si no, detente.
		if etiqueta$ <> ""
			# Define la variable <acentos$> como una cadena vacía.
			acentos$ = ""
			# Define la variable <iniInt> como el punto en el tiempo en el que comienza el intervalo actual.
			iniINT = Get starting point: 4, i
			# Define la variable <finInt> como el punto en el tiempo en el que comienza el intervalo actual.
			finINT = Get end point: 4, i

			# Define la variable <grid2> como un recorte del TextGrid seleccionado, contenido por los puntos inicio y fin del intervalo actual
			grid2 = Extract part: iniINT, finINT, 1

			# Selecciona el objeto <grid2>
			selectObject: grid2
			
			# Define la variable <numInt3> como el número de intervalos contenidos en la grada 3 del objeto TextGrid seleccionado.
			numInt3 = Get number of points: 3
			
			for point from 1 to numInt3
				acc$ = Get label of point: 3, point
				acentos$ = acentos$ + " " + acc$
			endfor

			removeObject: grid2
			;appendInfoLine: acentos$

			# Condición: si la cadena es igual a "ANT", continúam si no, detente.
			if etiqueta$ = "ANT"
				ant$ = acentos$

			# Condición: si la cadena es igual a "ANT", continúam si no, detente.
			elif etiqueta$ = "CR"
				cr$ = acentos$
			
			# Condición: si la cadena es igual a "ANT", continúam si no, detente.
			elif etiqueta$ = "PRED"
				pred$ = acentos$

			# Finaliza el condicional actual.
			endif
			
		
		# Finaliza el condicional actual.
		endif

	# Finaliza el bucle actual.		
	endfor
	# Imprime la variable <gridName$>	
	appendInfoLine: gridName$ , tab$, ant$, tab$, cr$, tab$,  pred$

# Finaliza el bucle actual.
endfor

# Restore selection:
selectObject (grids#)