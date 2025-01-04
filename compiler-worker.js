const { spawnSync } = require("child_process");

// Use the default "php" command (Render should have it installed already)
const phpPath = "php";  // This should work if Render's PHP runtime is being used

const runProcess = spawnSync(phpPath, [sourceFile], {
    input,
    encoding: "utf-8",
    timeout: 5000, // Timeout after 5 seconds
});

// Handle errors or success
if (runProcess.error || runProcess.stderr) {
    const error = runProcess.stderr || runProcess.error.message;
    return parentPort.postMessage({
        error: { fullError: `Runtime Error:\n${error}` },
    });
}

return parentPort.postMessage({
    output: runProcess.stdout || "No output received!",
});
