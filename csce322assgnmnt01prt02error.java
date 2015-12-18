import java.io.IOException;

import org.antlr.v4.runtime.*;


class csce322assgnmnt01prt02error extends BaseErrorListener{
    @Override
	
public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int position, String msg, RecognitionException e) {
	
// replace with code to process syntax errors
// possible work around: check exception and then output the correct output. Must have the output of .g4 file that will 	
Token t = (Token)offendingSymbol;
msg = "Line " + line + " Contains Unrecognized Token " + t.getText() + ".";
System.out.println( msg );
System.exit(0);	
return;
    }	
}
