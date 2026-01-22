use std::process::Command;
use std::fs;

const BUILD_ID: &str = "build-001";
const IMAGE_FOLDER: &str = "/Users/username/web4-runner";

fn run(cmd: &str, args: &[&str]) {
    println!("Running: {} {:?}", cmd, args);
    let status = Command::new(cmd)
        .args(args)
        .status()
        .expect("failed to execute command");
    if !status.success() {
        panic!("Command failed: {} {:?}", cmd, args);
    }
}

fn main() {
    // 1️⃣ Prepare workspace
    fs::create_dir_all(format!("{}/output", IMAGE_FOLDER)).unwrap();

    // 2️⃣ Install tools
    run("bash", &["tools/install-xcode.sh"]);
    run("bash", &["tools/install-homebrew.sh"]);
    run("bash", &["tools/install-node.sh"]);

    // 3️⃣ Configure system
    run("bash", &["configure/configure-tccdb.sh"]);
    run("bash", &["configure/configure-shell.sh"]);

    // 4️⃣ Run tests & reports
    run("bash", &["tests/run-tests.sh"]);
    run("bash", &["tests/generate-report.sh"]);

    // 5️⃣ Upload artifacts (IPFS example)
    run("ipfs", &["add", "-r", &format!("{}/output", IMAGE_FOLDER)]);

    println!("Build {} complete ✅", BUILD_ID);
}
