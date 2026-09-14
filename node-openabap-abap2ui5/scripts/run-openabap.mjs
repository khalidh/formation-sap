import { spawnSync } from "node:child_process";

function run(cmd, args) {
  const result = spawnSync(cmd, args, { stdio: "pipe", encoding: "utf8" });
  if (result.stdout) {
    process.stdout.write(result.stdout);
  }
  if (result.stderr) {
    process.stderr.write(result.stderr);
  }
  if (result.status !== 0) {
    throw new Error(`${cmd} ${args.join(" ")} failed with code ${result.status}`);
  }
  return result;
}

// 1) Transpile ABAP into JS modules.
run("npx", ["abap_transpile"]);

// 2) Run transpiled report with Node 20 for open-abap runtime compatibility.
const execResult = run("npx", ["-y", "node@20", "build/openabap/ztr_node_smoke_test.prog.mjs"]);

if (!execResult.stdout.includes("OPEN_ABAP_SMOKE_TEST_OK")) {
  throw new Error("Smoke test did not print OPEN_ABAP_SMOKE_TEST_OK");
}

console.log("OPEN_ABAP_RUNNER_OK");
