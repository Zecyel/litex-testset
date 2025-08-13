# litex-testset
A testset of litexlang

## Run the code

The `prompt/` folder is gitignored. Generate by running the following code: (Don't forget to clone golitex and litex-tutorial repos!)

```bash
python autogen/dump_folder.py --path ../golitex/examples/testings/ -o ./prompt/testings.txt
python autogen/dump_folder.py --path ../golitex/examples/comprehensive_examples/ -o ./prompt/examples.txt
python autogen/dump_folder.py --path ../litex-tutorial/Turorial/ -o ./prompt/tutor.txt
```

Postscript: If you don't like `../litex-tutorial/Turorial/.order` file, you can manually delete it from `./prompt/tutor.txt`.

Put the theory you want to proof in `autogen/theory.jsonl`.

Then, you can set the environment variant and run the pipeline.

```bash
export OPENAI_API_KEY=你的大模型密钥
export OPENAI_BASE_URL=大模型服务商的base url，注意需要带上/v1/chat/completions之类的后缀
cd autogen && python3 gen.py
```

It'll generate `autogen/proof.jsonl`. You can run `python3 unfold_jsonl.py` to unfold all the proof into `proof/`.

Then, run `cd .. & chmod +x check.sh && ./check.sh` to figure out the accuracy of the generated proves.
