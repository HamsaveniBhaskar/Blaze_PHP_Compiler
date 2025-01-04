const { parentPort, workerData } = require("worker_threads");
const { execFileSync, spawnSync } = require("child_process");
const path = require("path");
const os = require("os");

// Utility function to clean up temporary files
function cleanupFiles(...files) {
    files.forEach((file) => {
        try {
            require("fs").unlinkSync(file);
        } catch (err) {
            // Ignore errors
        }
    });
}

// Worker logic
(async () => {
    const { code, input } = workerData;

    // Paths for temporary source file and executable
    const tmpDir = os.tmpdir();
    const sourceFile = path.join(tmpDir, `temp_${Date.now()}.php`);

    try {
        // Write the code to the source file
        require("fs").writeFileSync(sourceFile, code);

        const phpPath = "/usr/bin/php";  // Use the full path if needed
const runProcess = spawnSync(phpPath, [sourceFile], {
    input,
    encoding: "utf-8",
    timeout: 5000, // Timeout after 5 seconds
});


        cleanupFiles(sourceFile);

        if (runProcess.error || runProcess.stderr) {
            const error = runProcess.stderr || runProcess.error.message;
            return parentPort.postMessage({
                error: { fullError: `Runtime Error:\n${error}` },
            });
        }

        // Send the output back to the main thread
        return parentPort.postMessage({
            output: runProcess.stdout || "No output received!",
        });
    } catch (err) {
        cleanupFiles(sourceFile);
        return parentPort.postMessage({
            error: { fullError: `Server error: ${err.message}` },
        });
    }
})();
