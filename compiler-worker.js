const { spawnSync } = require("child_process");

const phpPath = "php";  // Using the default PHP path

const runProcess = spawnSync(phpPath, [sourceFile], {
    input,
    encoding: "utf-8",
    timeout: 5000, // Timeout after 5 seconds
});

// Check if the process had errors and log them
if (runProcess.error) {
    console.error("Error executing PHP:", runProcess.error.message);
    return parentPort.postMessage({
        error: { fullError: `Runtime Error: ${runProcess.error.message}` },
    });
}

if (runProcess.stderr) {
    console.error("PHP stderr:", runProcess.stderr);
    return parentPort.postMessage({
        error: { fullError: `Runtime Error: ${runProcess.stderr}` },
    });
}

// Log the output of the PHP script
console.log("PHP output:", runProcess.stdout);

return parentPort.postMessage({
    output: runProcess.stdout || "No output received!",
});
