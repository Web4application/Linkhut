private static void EnsureDiskSpace(string path, long minBytes = 2L * 1024 * 1024 * 1024)
{
    var drive = new DriveInfo(Path.GetPathRoot(path));
    if (drive.AvailableFreeSpace < minBytes)
        throw new IOException("Insufficient disk space for Lucene index rebuild.");
}