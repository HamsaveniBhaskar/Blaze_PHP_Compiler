const { spawnSync } = require("child_process");

const phpPath = "php";  // Use the default PHP path

const runProcess = spawnSync(phpPath, [sourceFile], {
    input,
    encoding: "utf-8",
    timeout: 5000, // Timeout after 5 seconds
});

// Check for process errors and log them
if (runProcess.error) {
    console.error("Error executing PHP:", runProcess.error.message);
    return parentPort.postMessage({
        error: { fullError: `Runtime Error: ${runProcess.error.message}` },
    });
}

if (runProcess.stderr) {
    console.error("PHP stderr:", runProcess.stderr);  // Log stderr output
    return parentPort.postMessage({
        error: { fullError: `Runtime Error: ${runProcess.stderr}` },
    });
}

if (runProcess.stdout) {
    console.log("PHP stdout:", runProcess.stdout);  // Log stdout output
} else {
    console.log("No output from PHP.");
}

return parentPort.postMessage({
    output: runProcess.stdout || "No output received!",
});

console.log('Running PHP process with:', sourceFile, input);
