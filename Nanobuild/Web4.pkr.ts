import { execSync } from "child_process";
import fs from "fs";
import path from "path";

const IMAGE_FOLDER = "/Users/username/web4-runner";
const BUILD_ID = "build-001";
const ARTIFACT_STORAGE = "ipfs";

// Utility function
function run(command: string) {
  console.log("Running:", command);
  execSync(command, { stdio: "inherit" });
}

// 1️⃣ Prepare workspace
fs.mkdirSync(path.join(IMAGE_FOLDER, "output"), { recursive: true });

// 2️⃣ Install tools
run("bash tools/install-xcode.sh");
run("bash tools/install-homebrew.sh");
run("bash tools/install-node.sh");

// 3️⃣ Configure system
run("bash configure/configure-tccdb.sh");
run("bash configure/configure-shell.sh");

// 4️⃣ Run tests & reports
run("bash tests/run-tests.sh");
run("bash tests/generate-report.sh");

// 5️⃣ Upload artifacts (Web4/IPFS)
if (ARTIFACT_STORAGE === "ipfs") {
  run(`ipfs add -r ${path.join(IMAGE_FOLDER, "output")}`);
}

console.log(`Build ${BUILD_ID} complete ✅`);
