Wildcards (globbing patterns)

Used by/for:
- cp
- rm
- ls
- mv
- bash string comparison
- ...many more

# Symbol        Description                     Example               Example matches
    ?       Single Character                    hel?                help, hell, hel1...
    *       Any number of characters            ca*                 car, ca, carpet, carpenter, car11...
    []      Single character from range         file[0-2]           file0, file1, file2
                                                [hd]ello            hello or dello
    {}      Comma separated terms               {*.txt,*.pdf}       hello.txt, doc.txt, source.pdf, book.pdf...
    [!]     Any character not listed in []      file[!1]            file2, file3...


# Some useful character classes: (use it within [] )

    [:upper:]   Uppercase character
    [:lower:]   Lowercase character
    [:alpha:]   Alphabetic character
    [:digit:]   Number character
    [:alnum:]   Alphanumeric character (not special characters)
    [:space:]   Whitespace character (space, tab, newline)


# Wildcards in string comparison
[[ $STRING == pattern_with_wildcards ]]

== is not mandatory but recommended to distinguish between normal string comparison and using wildcards

[[ $STRING == file[0-9].txt ]]
[[ $STRING == rich* ]]
