# litex-testset
A testset of litexlang

## Run the code

The `prompt/` folder is gitignored. Generate by running the following code:

```bash
python autogen/dump_folder.py --path ../golitex/examples/testings/ -o ./prompt/testings.txt
python autogen/dump_folder.py --path ../golitex/examples/comprehensive_examples/ -o ./prompt/examples.txt
python autogen/dump_folder.py --path ../litex-tutorial/Turorial/ -o ./prompt/tutor.txt
```

Postscript: If you don't like `../litex-tutorial/Turorial/.order` file, you can manually delete it from `./prompt/tutor.txt`.
