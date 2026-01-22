import os, strutils, times

const
  IMAGE_FOLDER = "/Users/username/web4-runner"
  BUILD_ID = "build-001"
  ARTIFACT_STORAGE = "ipfs"

# Utility: Run a shell command
proc run(cmd: string) =
  echo "Running: ", cmd
  let result = execProcess(cmd, stderr = Echo, stdout = Echo)
  if result != "":
    echo result

# ------------------------
# 1️⃣ Prepare workspace
# ------------------------
createDir(IMAGE_FOLDER & "/output", parents = true)
echo "Workspace ready at: ", IMAGE_FOLDER

# ------------------------
# 2️⃣ Install tools
# ------------------------
echo "Installing tools..."
run("bash tools/install-xcode.sh")
run("bash tools/install-homebrew.sh")
run("bash tools/install-node.sh")
run("bash tools/install-python.sh")
run("bash tools/install-dotnet.sh")

# ------------------------
# 3️⃣ Configure system
# ------------------------
echo "Configuring system..."
run("bash configure/configure-tccdb.sh")
run("bash configure/configure-shell.sh")
run("bash configure/configure-auto-updates.sh")

# ------------------------
# 4️⃣ Run tests & generate reports
# ------------------------
echo "Running tests..."
run("bash tests/run-tests.sh")
run("bash tests/generate-report.sh")

# ------------------------
# 5️⃣ Upload artifacts (IPFS / Web4)
# ------------------------
if ARTIFACT_STORAGE == "ipfs":
  run("ipfs add -r " & IMAGE_FOLDER & "/output")

# ------------------------
# ✅ Done
# ------------------------
let now = now()
echo "Build ", BUILD_ID, " complete ✅ at ", now.format("yyyy-MM-dd HH:mm:ss")
