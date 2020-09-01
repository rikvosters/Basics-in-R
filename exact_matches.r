exact.matches <- function (search.expression, corpus.vector, pcre=TRUE, case.sens=TRUE, characters.around=0, lines.around=0, clean.up.spaces=TRUE, output.conc=TRUE) {
   # Thanks to Earl Brown for feedback on an earlier version
   if (is.factor(corpus.vector)) { corpus.vector <- as.character(corpus.vector) }
   if (characters.around!=0 & lines.around!=0) {
      stop("At least one of 'characters.around' and 'lines.around' has to be zero ...")
   }
   line.numbers.with.matches <- grep(search.expression, corpus.vector, perl=pcre, value=FALSE, ignore.case=!case.sens) # the numbers of lines that contain matches
   if (any(line.numbers.with.matches)) { # if there are matches ...
      if (characters.around!=0) {
         lines.with.matches <- gsub("( ?_qW1aS3zX5eR7dF9cV_|_qW1aS3zX5eR7dF9cV_ ?)",
                                    " ",
                                    paste(corpus.vector, collapse = "_qW1aS3zX5eR7dF9cV_"),
                                    perl=TRUE)
      } else {
         lines.with.matches <- corpus.vector[line.numbers.with.matches] # the lines that contain matches
      }
      matches <- gregexpr(search.expression, lines.with.matches, perl = pcre, ignore.case = !case.sens) # the start positions and lengths of matches
      number.of.matches <- sapply(matches, length) # the number of matches per line (of the lines that have matches)
      lines <- rep(lines.with.matches, number.of.matches) # the lines with matches, each as many times as it has matches
      line.numbers.with.matches <- rep(line.numbers.with.matches, number.of.matches)
      starts <- unlist(matches) # starting positions of matches
      stops <- starts + unlist(sapply(matches, attr, "match.length")) - 1 # end positions of matches
      exact.string.matches <- substr(lines, starts, stops) # the exact matches
      if (output.conc) {
         lines.with.delimited.matches <- paste( # the lines with the tab-delimited matches
            substr(lines, if (characters.around!=0) starts-characters.around else 1, starts-1), "\t", # preceding contexts
            exact.string.matches, "\t", # matches
            substr(lines, stops+1, if (characters.around!=0) stops+characters.around else nchar(lines)), # subsequent contexts
            sep="")
         if (lines.around!=0) {
            corpus.vector <- append(corpus.vector, rep("", lines.around))
            starts.of.previous.lines <- pmax(0, line.numbers.with.matches - lines.around)
            ends.of.subsequent.lines <- pmin(line.numbers.with.matches + lines.around, length(corpus.vector))
            for (current.line.with.delimited.match in seq(lines.with.delimited.matches)) {
               lines.with.delimited.matches[current.line.with.delimited.match] <- paste(
                  paste(corpus.vector[starts.of.previous.lines[current.line.with.delimited.match]:(line.numbers.with.matches[current.line.with.delimited.match]-1)], collapse=" "),
                  lines.with.delimited.matches[current.line.with.delimited.match],
                  paste(corpus.vector[(line.numbers.with.matches[current.line.with.delimited.match]+1):ends.of.subsequent.lines[current.line.with.delimited.match]], collapse=" "),
                  sep=" ")
            }
         }
         # cleaning output as necessary/requested by user
         if (clean.up.spaces) { # clean up spaces around tabs
            lines.with.delimited.matches <- gsub(" *\t *", "\t", lines.with.delimited.matches, perl=TRUE)
         }
         lines.with.delimited.matches <- gsub("(^ {1,}| {1,}$)", "", lines.with.delimited.matches, perl=TRUE) # clean up leading and trailing spaces
      }

      output.list <- list(exact.string.matches,
                          if (characters.around!=0) starts else line.numbers.with.matches, # starting character positions or the numbers of lines with matches, each as many times as it has matches
                          length(unique(line.numbers.with.matches))/sum(nzchar(corpus.vector)),
                          if (output.conc) lines.with.delimited.matches else NA,
                          c(Pattern = search.expression, "Corpus (1st 100 char.)"=substr(paste(corpus.vector, collapse=" "), 1, 100), PCRE=pcre, "Case-sensitive"=case.sens),
                          "1.3 (22 March 2014)")
      names(output.list) <- c("Exact matches",
                              paste("Locations of matches (", ifelse (characters.around!=0, "characters", "lines"), ")", sep=""),
                              "Proportion of non-empty corpus parts with matches",
                              "Lines with delimited matches (if requested)",
                              "Search parameters",
                              "Version (date)")
      return(output.list)
   }
}
