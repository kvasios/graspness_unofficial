CUDA_VISIBLE_DEVICES=0 python test.py \
    --camera realsense \
    --dump_dir logs/log_kn/dump_epoch10 \
    --checkpoint_path logs/log_kn/minkuresunet_realsense.tar \
    --batch_size 1 \
    --dataset_root ./data/graspnet \
    --infer \
    --eval \
    --collision_thresh -1