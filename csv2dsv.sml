
fun convertDelimiters ( infilename , delim1 , outfilename , delim2 )=
    
    
    let 
        
        val ins = TextIO.openIn infilename
        val outs = TextIO.openOut outfilename
        
        val nof=ref 1
        val innof=  ref 1
        val b= ref true
        val lineno= ref 1
        fun yo(a:char) =
        if a=delim1 then if !b=true then (nof:= !nof+1;TextIO.output1(outs,delim2))
            else (TextIO.output1(outs,delim1))
        else if a= #"\n" then if !lineno=1 then (innof:= !nof;nof:=1;lineno:= !lineno+1;TextIO.output1(outs,a))
                            else (nof:=1;lineno:= !lineno+1;TextIO.output1(outs,a))
        else if a= #"\"" then (b:=not (!b);TextIO.output1(outs,a))
        else  TextIO.output1(outs,a);
       
        
        fun helper(copt: char option) =
            case copt of
                NONE => (TextIO.closeIn ins; TextIO.closeOut outs)
                |SOME(c) => ( yo(c) ; helper(TextIO.input1 ins))
    in
        helper(TextIO.input1 ins)

    
    end;

fun csv2tsv ( infilename , outfilename ) = convertDelimiters(infilename,#",",outfilename,#"\t");

fun tsv2csv ( infilename , outfilename ) = convertDelimiters(infilename,#"\t",outfilename,#",");
