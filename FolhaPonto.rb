#!/usr/bin/ruby 

require 'date'
jornada = ARGV[0]
fer = ARGV[1]
$arq = File.open("folha.tex", "w")
adm = `awk 'length($1) > 3 {print}' < #{jornada}`

$arq.write("\\documentclass[12pt,a4paper]{article}
\\usepackage[top=1cm, bottom=1cm, left=2cm, right=2cm]{geometry}
\\linespread{1.3}
\\usepackage{sans}
\\usepackage[portuguese,brazilian]{babel}
\\usepackage[utf8]{inputenc} \n

\\begin{document}\n")

meses = {
	1 => "Janeiro",
	2 => "Fevereiro",
	3 => "Marco",
	4 => "Abril",
	5 => "Maio",
	6 => "Junho",
	7 => "Julho",
	8 => "Agosto",
	9 => "Setembro",
	10 => "Outubro",
	11 => "Novembro",
	12 => "Dezembro"
}

dias = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

semana = {
	0 => "dom",
	1 => "seg",
	2 => "ter",
	3 => "qua",
	4 => "qui",
	5 => "sex",
	6 => "sab"
}

n = Time.new
start = Date.new(2016, (n.mon-1), 21)
middle = Date.new(2016, n.mon)
ending = Date.new(2016, n.mon, 21)

$arq.write("\\newcommand{\\sab}{--- Sabado ---}
\\newcommand{\\dom}{--- Domingo ---}
\\newcommand{\\fer}{--- Feriado ---}\n")
semana.each do |n, d|
	if ((d <=> "dom") != 0 && (d <=> "sab") != 0)
		hora = ""
		string = `awk '$1 ~ "#{d}" {print}' < #{jornada}`
		string = string.split(" ")
		for i in 1...string.size
			hora << "#{string[i]} --- "
		end
		$arq.write("\\newcommand{\\#{d}}{--- #{hora}}\n")
	end
end

$arq.write("\n\\thispagestyle{empty}
\\begin{center}
\\Huge
\\textbf{Rede Linux IME-USP\\\\Folha de Ponto}
\\\\
\\large
#{meses[start.mon]}\/#{meses[ending.mon]} de 2016
\\end{center}

\\large
\\noindent \\textbf{Nome:} #{adm}
\\\\
\\textbf{Assinatura:}
\\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
\\\\
\\normalsize
\\begin{center}
\\begin{tabular}{|p{3.5cm}|p{9cm}|}
\\hline
\\multicolumn{2}{|c|}{\\textbf{#{meses[start.mon]}}} \\\\ \\hline\n")

puts ARGV.size
if (ARGV.size == 1) 	
	while (start != middle)
		$arq.write("#{start.day}/#{meses[start.mon]} & \\#{semana[start.wday]} \\\\ \\hline\n")
		start += 1
	end
	$arq.write("\\multicolumn{2}{|c|}{\\textbf{#{meses[start.mon]}}} \\\\ \\hline\n")
	while (start != ending)
		$arq.write("#{start.day}/#{meses[start.mon]} & \\#{semana[start.wday]} \\\\ \\hline\n")
		start += 1
	end
else
	while (start != middle)
		ent = `awk '$1 == #{start.day} && $2 == #{start.mon} {print \"Feriado\"}' < feriados`
		if ((ent <=> "Feriado\n") == 0)
			$arq.write("#{start.day}/#{meses[start.mon]} & \\fer \\\\ \\hline\n")
		else
			$arq.write("#{start.day}/#{meses[start.mon]} & \\#{semana[start.wday]} \\\\ \\hline\n")
		end
		start += 1
	end
	$arq.write("\\multicolumn{2}{|c|}{\\textbf{#{meses[start.mon]}}} \\\\ \\hline\n")
	while (start != ending)
		ent = `awk '$1 == #{start.day} && $2 == #{start.mon} {print \"Feriado\"}' < feriados`
		if ((ent <=> "Feriado\n") == 0)
			$arq.write("#{start.day}/#{meses[start.mon]} & \\fer \\\\ \\hline\n")
		else
			$arq.write("#{start.day}/#{meses[start.mon]} & \\#{semana[start.wday]} \\\\ \\hline\n")
		end
		start += 1
	end
end

$arq.write("\\end{tabular}
\\end{center}

\\end{document}\n")

`pdflatex folha.tex`
`rm folha.aux` 
`rm folha.log` 
