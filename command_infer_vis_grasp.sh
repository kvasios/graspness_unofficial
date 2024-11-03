CUDA_VISIBLE_DEVICES=0 python infer_vis_grasp.py \
    --camera realsense \
    --dump_dir logs/log_kn/dump_epoch10 \
    --checkpoint_path logs/log_kn/minkuresunet_realsense.tar \
    --batch_size 1 \
    --dataset_root ./data/graspnet \
    --infer \
    --vis \
    --collision_thresh -1 \
    --scene 0100 \
    --index 0000