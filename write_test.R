# write_test.R - reads data on MCAT passages and questions and writes a test

print("Where are the files?")
path <- readLines(n=1)
setwd(path)
questions <- read.csv("questions.csv", header=TRUE, stringsAsFactors = FALSE)
answers <- read.csv("answers.csv", stringsAsFactors = FALSE)
passages <- read.csv("passages.csv", stringsAsFactors = FALSE)

test <- file("test.txt", open = "at")

writeLines(c("MCAT Practice Test",""), test)
n_p = length(passages$text)
q_number <- 1
for (i in 1:n_p) {
  writeLines(paste("Passage ",as.character(i),": ",passages$title[i], sep=""), test)
  writeLines("", test)
  writeLines(passages$text[i], test)
  q_ids <- questions$id[questions$p_id == i]
  q_text <- questions$text[q_ids]
  n_q = length(q_ids)
  for (j in 1:n_q) {
    writeLines("", test)
    a_ids <- answers$id[answers$q_id == q_ids[j]]
    question <- paste(as.character(q_number), ". ", q_text[j], sep="")
    writeLines(question, test)
    q_number <- q_number + 1
    writeLines("", test)
    choices <- answers$text[a_ids]
    abcd <- c(paste("(a)",choices[1]), paste("(b)", choices[2]),
              paste("(c)",choices[2]), paste("(d)", choices[4]))
    writeLines(abcd, test)
  }
  writeLines("", test)
}

close(test)

