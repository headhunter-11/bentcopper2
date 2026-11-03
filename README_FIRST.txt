RISC-V assignment files for headhunter-11/bentcopper2

Contents:
- One rtl.sv for each of the 11 required modules.
- rnr-stage.yaml configured for the integration stage.

IMPORTANT:
These files have been generated from the assignment/module specifications available in the conversation.
They have NOT been compiled, simulated, or run through RISC-n-Roll CI. Treat this as a first implementation
to review and test, not as a confirmed passing submission.

To use:
1. Extract this ZIP into the root of your cloned bentcopper2 repository.
2. Ensure the folder names match exactly.
3. Review the RTL and YAML.
4. Run a SystemVerilog compiler/simulator if available.
5. Commit and push:
   git add -A
   git commit -m "Implement single-cycle RV32I processor"
   git push origin main

The YAML is set to stage: integration, which asks CI to test all stages/modules.
If you want to debug incrementally, change stage to fetch first, then decode, execute, and integration
as each stage passes.

The processor's data memory and instruction memory are external to the core, as reflected by the
assignment interface.
