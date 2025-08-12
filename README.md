# litex-testset
A testset of litexlang

## Run the code

The `prompt/` folder is gitignored. Generate by running the following code:

```bash
python autogen/dump_folder.py --path ../golitex/examples/ -o ./prompt/example.txt
python autogen/dump_folder.py --path ../litex-tutorial/Turorial/ -o ./prompt/tutor.txt
```