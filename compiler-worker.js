const { parentPort, workerData } = require("worker_threads");
const { execSync } = require("child_process");
const os = require("os");
const path = require("path");

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
        // Write the PHP code to the source file
        require("fs").writeFileSync(sourceFile, code);

        // Execute the PHP code using PHP CLI
        const phpPath = "php"; // Default PHP path on most systems
        const phpProcess = execSync(`php ${sourceFile}`, {
            input,
            encoding: "utf-8",
            timeout: 5000, // Timeout after 5 seconds
        });

        cleanupFiles(sourceFile);

        // Send the output back to the main thread
        return parentPort.postMessage({
            output: phpProcess || "No output received!",
        });
    } catch (err) {
        cleanupFiles(sourceFile);
        return parentPort.postMessage({
            error: { fullError: `Server error: ${err.message}` },
        });
    }
})();
