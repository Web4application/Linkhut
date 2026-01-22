public static string LuceneIndexPath =>
    Path.Combine(
        AppDomain.CurrentDomain.GetData("DataDirectory").ToString(),
        "lucene-xpoint"
    );

