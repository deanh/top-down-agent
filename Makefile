clean:
	rm -f model.*
	rm -rf build

build:
	mkdir build
	/Applications/Godot.app/Contents/MacOS/Godot --headless --export-release "macOS" --path . build/top-down-mac.zip
	unzip -o build/top-down-mac.zip -d build

train:
	python stable_baselines3_run.py --speedup=8 --n_parallel=4 --env_path=./build/top-down-agent.command --timesteps=400_000 --onnx_export_path=model.onnx --save_model_path=model.zip --viz

infer:
	python stable_baselines3_run.py --timesteps=100_000 --resume_model_path=model.zip --inference --n_parallel=4 --speedup=8 --viz --env_path=./build/top-down-agent.command