# Functions to support push and pull of model output files to Google Drive

# ---- Internal helpers --------------------------------------------------------

is_root <- function(folder) folder %in% c("", ".", "~", "~/", "/")

# Resolve a folder path to exactly one Drive folder
gd_folder <- function(folder) {
  if (is_root(folder)) {
    return(drive_get("~/"))
  }
  d <- drive_get(sub("/?$", "/", folder)) # trailing "/" = must be a folder
  if (nrow(d) != 1) {
    stop(sprintf("Expected 1 folder at '%s', found %d", folder, nrow(d)))
  }
  d
}

# Get a folder, creating it if it doesn't exist (parent must already exist)
gd_ensure_folder <- function(folder) {
  if (is_root(folder)) {
    return(drive_get("~/"))
  }
  d <- drive_get(sub("/?$", "/", folder))
  if (nrow(d) == 0) {
    d <- drive_mkdir(basename(folder), path = gd_folder(dirname(folder)))
  }
  if (nrow(d) != 1) {
    stop(sprintf("Expected 1 folder at '%s', found %d", folder, nrow(d)))
  }
  d
}

# ---- Helpers -----------------------------------------------------------------

# List contents of a Drive folder ("" = My Drive root)
gd_list <- function(folder = "") {
  drive_ls(gd_folder(folder))
}

# Pull one file from Drive to a local path
gd_pull <- function(
  remote_path,
  local_path = basename(remote_path),
  overwrite = TRUE
) {
  f <- drive_get(remote_path)
  if (nrow(f) != 1) {
    stop(sprintf("Expected 1 file at '%s', found %d", remote_path, nrow(f)))
  }
  dir.create(dirname(local_path), recursive = TRUE, showWarnings = FALSE)
  drive_download(f, path = local_path, overwrite = overwrite)
  invisible(local_path)
}

# Push one local file to Drive. drive_put() updates the file if it already
# exists at that path, so this won't create duplicates.
gd_push <- function(local_path, remote_path = basename(local_path)) {
  drive_put(
    media = local_path,
    path = gd_folder(dirname(remote_path)),
    name = basename(remote_path)
  )
  invisible(remote_path)
}

# Pull every file in a Drive folder (non-recursive) to a local folder
gd_pull_folder <- function(
  remote_folder,
  local_folder = basename(remote_folder)
) {
  files <- drive_ls(gd_folder(remote_folder))
  files <- files[!is_folder(files), ]
  dir.create(local_folder, recursive = TRUE, showWarnings = FALSE)
  for (i in seq_len(nrow(files))) {
    drive_download(
      files[i, ],
      path = file.path(local_folder, files$name[i]),
      overwrite = TRUE
    )
  }
  invisible(file.path(local_folder, files$name))
}

# Push every file in a local folder to a Drive folder (creates it if needed)
gd_push_folder <- function(
  local_folder,
  remote_folder = basename(local_folder)
) {
  target <- gd_ensure_folder(remote_folder)
  for (f in list.files(local_folder, full.names = TRUE)) {
    if (!dir.exists(f)) drive_put(media = f, path = target, name = basename(f))
  }
}

# ---- Read/write straight into R (no manual temp files) -----------------------
gd_read_csv <- function(remote_path, ...) {
  tmp <- tempfile(fileext = ".csv")
  on.exit(unlink(tmp))
  gd_pull(remote_path, tmp)
  read.csv(tmp, ...)
}

gd_write_csv <- function(df, remote_path, ...) {
  tmp <- tempfile(fileext = ".csv")
  on.exit(unlink(tmp))
  write.csv(df, tmp, row.names = FALSE, ...)
  gd_push(tmp, remote_path)
}

gd_read_rds <- function(remote_path) {
  tmp <- tempfile(fileext = ".rds")
  on.exit(unlink(tmp))
  gd_pull(remote_path, tmp)
  readRDS(tmp)
}

gd_write_rds <- function(obj, remote_path) {
  tmp <- tempfile(fileext = ".rds")
  on.exit(unlink(tmp))
  saveRDS(obj, tmp)
  gd_push(tmp, remote_path)
}

# Download all .rds files in a Drive folder to a local folder
gd_pull_rds_folder <- function(
  remote_folder,
  local_folder = basename(remote_folder)
) {
  files <- drive_ls(gd_folder(remote_folder), pattern = "\\.rds$")
  dir.create(local_folder, recursive = TRUE, showWarnings = FALSE)
  for (i in seq_len(nrow(files))) {
    drive_download(
      files[i, ],
      path = file.path(local_folder, files$name[i]),
      overwrite = TRUE
    )
  }
  invisible(file.path(local_folder, files$name))
}

# Read all .rds files in a Drive folder into a named list
gd_read_rds_folder <- function(remote_folder) {
  files <- drive_ls(gd_folder(remote_folder), pattern = "\\.rds$")
  out <- lapply(seq_len(nrow(files)), function(i) {
    tmp <- tempfile(fileext = ".rds")
    on.exit(unlink(tmp))
    drive_download(files[i, ], path = tmp, overwrite = TRUE)
    readRDS(tmp)
  })
  names(out) <- sub("\\.rds$", "", files$name)
  out
}
