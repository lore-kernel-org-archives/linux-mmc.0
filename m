From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH V3] mmc: block: Add new ioctl to send multi commands
Date: Wed, 16 Sep 2015 10:54:37 -0700
Message-ID: <CAMHSBOUKYLfrYe+xBYY=ZVsqdXStPdmsJQRBTYsf4Pk=jNMrBg@mail.gmail.com>
References: <1442242844-6859-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442242844-6859-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Seshagiri Holi <sholi@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Grant Grundler <grundler@google.com>, Olof Johansson <olofj@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Sep 14, 2015 at 8:00 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> From: Seshagiri Holi <sholi@nvidia.com>
>
> Certain eMMC devices allow vendor specific device information to be read
> via a sequence of vendor commands. These vendor commands must be issued
> in sequence and an atomic fashion. One way to support this would be to
> add an ioctl function for sending a sequence of commands to the device
> atomically as proposed here. These multi commands are simple array of
> the existing mmc_ioc_cmd structure.
>
> The structure passed via the ioctl uses a __u64 type to specify the number
> of commands (so that the structure is aligned on a 64-bit boundary) and a
> zero length array as a header for list of commands to be issued. The
> maximum number of commands that can be sent is determined by
> MMC_IOC_MAX_CMDS (which defaults to 255 and should be more than
> sufficient).
>
> Signed-off-by: Seshagiri Holi <sholi@nvidia.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Grundler <grundler@google.com>
> Cc: Olof Johansson <olofj@chromium.org>
> [ jonathanh@nvidia.com: Rebased on linux-next from v3.18. Changed
>   userspace pointer type for multi command to be a u64. Renamed
>   from combo commands to multi commands. Updated patch based upon
>   feedback review comments received. Updated commit message ]
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> V3 changes:
> - Updated mmc_ioc_multi_cmd structure per Grant's feedback
> V2 changes:
> - Updated changelog per Arnd's feedback
> - Moved mmc_put/get_card() outside of __mmc_blk_ioctl_cmd()
>
>  drivers/mmc/card/block.c       | 214 ++++++++++++++++++++++++++++++-----------
>  include/uapi/linux/mmc/ioctl.h |  19 +++-
>  2 files changed, 177 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c742cfd7674e..2007023815cb 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -387,6 +387,24 @@ out:
>         return ERR_PTR(err);
>  }
>
> +static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
> +                                     struct mmc_blk_ioc_data *idata)
> +{
> +       struct mmc_ioc_cmd *ic = &idata->ic;
> +
> +       if (copy_to_user(&(ic_ptr->response), ic->response,
> +                        sizeof(ic->response)))
> +               return -EFAULT;
> +
> +       if (!idata->ic.write_flag) {
> +               if (copy_to_user((void __user *)(unsigned long)ic->data_ptr,
> +                                idata->buf, idata->buf_bytes))
> +                       return -EFAULT;
> +       }
> +
> +       return 0;
> +}
> +
>  static int ioctl_rpmb_card_status_poll(struct mmc_card *card, u32 *status,
>                                        u32 retries_max)
>  {
> @@ -447,12 +465,9 @@ out:
>         return err;
>  }
>
> -static int mmc_blk_ioctl_cmd(struct block_device *bdev,
> -       struct mmc_ioc_cmd __user *ic_ptr)
> +static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> +                              struct mmc_blk_ioc_data *idata)
>  {
> -       struct mmc_blk_ioc_data *idata;
> -       struct mmc_blk_data *md;
> -       struct mmc_card *card;
>         struct mmc_command cmd = {0};
>         struct mmc_data data = {0};
>         struct mmc_request mrq = {NULL};
> @@ -461,33 +476,12 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>         int is_rpmb = false;
>         u32 status = 0;
>
> -       /*
> -        * The caller must have CAP_SYS_RAWIO, and must be calling this on the
> -        * whole block device, not on a partition.  This prevents overspray
> -        * between sibling partitions.
> -        */
> -       if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
> -               return -EPERM;
> -
> -       idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
> -       if (IS_ERR(idata))
> -               return PTR_ERR(idata);
> -
> -       md = mmc_blk_get(bdev->bd_disk);
> -       if (!md) {
> -               err = -EINVAL;
> -               goto cmd_err;
> -       }
> +       if (!card || !md || !idata)
> +               return -EINVAL;
>
>         if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
>                 is_rpmb = true;
>
> -       card = md->queue.card;
> -       if (IS_ERR(card)) {
> -               err = PTR_ERR(card);
> -               goto cmd_done;
> -       }
> -
>         cmd.opcode = idata->ic.opcode;
>         cmd.arg = idata->ic.arg;
>         cmd.flags = idata->ic.flags;
> @@ -530,23 +524,21 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>
>         mrq.cmd = &cmd;
>
> -       mmc_get_card(card);
> -
>         err = mmc_blk_part_switch(card, md);
>         if (err)
> -               goto cmd_rel_host;
> +               return err;
>
>         if (idata->ic.is_acmd) {
>                 err = mmc_app_cmd(card->host, card);
>                 if (err)
> -                       goto cmd_rel_host;
> +                       return err;
>         }
>
>         if (is_rpmb) {
>                 err = mmc_set_blockcount(card, data.blocks,
>                         idata->ic.write_flag & (1 << 31));
>                 if (err)
> -                       goto cmd_rel_host;
> +                       return err;
>         }
>
>         if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_SANITIZE_START) &&
> @@ -557,7 +549,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>                         pr_err("%s: ioctl_do_sanitize() failed. err = %d",
>                                __func__, err);
>
> -               goto cmd_rel_host;
> +               return err;
>         }
>
>         mmc_wait_for_req(card->host, &mrq);
> @@ -565,14 +557,12 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>         if (cmd.error) {
>                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
>                                                 __func__, cmd.error);
> -               err = cmd.error;
> -               goto cmd_rel_host;
> +               return cmd.error;
>         }
>         if (data.error) {
>                 dev_err(mmc_dev(card->host), "%s: data error %d\n",
>                                                 __func__, data.error);
> -               err = data.error;
> -               goto cmd_rel_host;
> +               return data.error;
>         }
>
>         /*
> @@ -582,18 +572,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>         if (idata->ic.postsleep_min_us)
>                 usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
>
> -       if (copy_to_user(&(ic_ptr->response), cmd.resp, sizeof(cmd.resp))) {
> -               err = -EFAULT;
> -               goto cmd_rel_host;
> -       }
> -
> -       if (!idata->ic.write_flag) {
> -               if (copy_to_user((void __user *)(unsigned long) idata->ic.data_ptr,
> -                                               idata->buf, idata->buf_bytes)) {
> -                       err = -EFAULT;
> -                       goto cmd_rel_host;
> -               }
> -       }
> +       memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
>
>         if (is_rpmb) {
>                 /*
> @@ -607,9 +586,50 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>                                         __func__, status, err);
>         }
>
> -cmd_rel_host:
> +       return err;
> +}
> +
> +static int mmc_blk_ioctl_cmd(struct block_device *bdev,
> +                            struct mmc_ioc_cmd __user *ic_ptr)
> +{
> +       struct mmc_blk_ioc_data *idata;
> +       struct mmc_blk_data *md;
> +       struct mmc_card *card;
> +       int err;
> +
> +       /*
> +        * The caller must have CAP_SYS_RAWIO, and must be calling this on the
> +        * whole block device, not on a partition.  This prevents overspray
> +        * between sibling partitions.
> +        */
> +       if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
> +               return -EPERM;
> +
> +       idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
> +       if (IS_ERR(idata))
> +               return PTR_ERR(idata);
> +
> +       md = mmc_blk_get(bdev->bd_disk);
> +       if (!md) {
> +               err = -EINVAL;
> +               goto cmd_err;
> +       }
> +
> +       card = md->queue.card;
> +       if (IS_ERR(card)) {
> +               err = PTR_ERR(card);
> +               goto cmd_done;
> +       }
> +
> +       mmc_get_card(card);
> +
> +       err = __mmc_blk_ioctl_cmd(card, md, idata);
> +
>         mmc_put_card(card);
>
> +       if (!err)
> +               err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
> +
>  cmd_done:
>         mmc_blk_put(md);
>  cmd_err:
> @@ -618,13 +638,97 @@ cmd_err:
>         return err;
>  }
>
> +static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
> +                                  struct mmc_ioc_multi_cmd __user *user)
> +{
> +       struct mmc_blk_ioc_data **idata = NULL;
> +       struct mmc_ioc_cmd __user *cmds = user->cmds;
> +       struct mmc_card *card;
> +       struct mmc_blk_data *md;
> +       int i, err = -EFAULT;
> +       __u64 num_of_cmds;
> +
> +       /*
> +        * The caller must have CAP_SYS_RAWIO, and must be calling this on the
> +        * whole block device, not on a partition.  This prevents overspray
> +        * between sibling partitions.
> +        */
> +       if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
> +               return -EPERM;
> +
> +       if (copy_from_user(&num_of_cmds, &user->num_of_cmds,
> +                          sizeof(num_of_cmds)))
> +               return -EFAULT;
> +
> +       if (num_of_cmds > MMC_IOC_MAX_CMDS)
> +               return -EINVAL;
> +
> +       idata = kcalloc(num_of_cmds, sizeof(*idata), GFP_KERNEL);
> +       if (!idata)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < num_of_cmds; i++) {
> +               idata[i] = mmc_blk_ioctl_copy_from_user(&cmds[i]);
> +               if (IS_ERR(idata[i])) {
> +                       err = PTR_ERR(idata[i]);
> +                       num_of_cmds = i;
> +                       goto cmd_err;
> +               }
> +       }
> +
> +       md = mmc_blk_get(bdev->bd_disk);
> +       if (!md)
> +               goto cmd_err;
> +
> +       card = md->queue.card;
> +       if (IS_ERR(card)) {
> +               err = PTR_ERR(card);
> +               goto cmd_done;
> +       }
> +
> +       mmc_get_card(card);
> +
> +       for (i = 0; i < num_of_cmds; i++) {
> +               err = __mmc_blk_ioctl_cmd(card, md, idata[i]);
> +               if (err) {
> +                       mmc_put_card(card);
> +                       goto cmd_done;
Instead of exiting here, you should first copy to the user the data
and response of successful commands, mark the failed command as failed
and the remaining ones as "not executed".
This way, it will be easier for the user space application to find out
where the sequence failed. This especially true if some reverts are
needed.

Gwendal.
> +               }
> +       }
> +
> +       mmc_put_card(card);
> +
> +       /* copy to user if data and response */
> +       for (i = 0; i < num_of_cmds; i++) {
> +               err = mmc_blk_ioctl_copy_to_user(&cmds[i], idata[i]);
> +               if (err)
> +                       break;
> +       }
> +
> +cmd_done:
> +       mmc_blk_put(md);
> +cmd_err:
> +       for (i = 0; i < num_of_cmds; i++) {
> +               kfree(idata[i]->buf);
> +               kfree(idata[i]);
> +       }
> +       kfree(idata);
> +       return err;
> +}
> +
>  static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
>         unsigned int cmd, unsigned long arg)
>  {
> -       int ret = -EINVAL;
> -       if (cmd == MMC_IOC_CMD)
> -               ret = mmc_blk_ioctl_cmd(bdev, (struct mmc_ioc_cmd __user *)arg);
> -       return ret;
> +       switch (cmd) {
> +       case MMC_IOC_CMD:
> +               return mmc_blk_ioctl_cmd(bdev,
> +                               (struct mmc_ioc_cmd __user *)arg);
> +       case MMC_IOC_MULTI_CMD:
> +               return mmc_blk_ioctl_multi_cmd(bdev,
> +                               (struct mmc_ioc_multi_cmd __user *)arg);
> +       default:
> +               return -EINVAL;
> +       }
>  }
>
>  #ifdef CONFIG_COMPAT
> diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h
> index 1f5e68923929..7e385b83b9d8 100644
> --- a/include/uapi/linux/mmc/ioctl.h
> +++ b/include/uapi/linux/mmc/ioctl.h
> @@ -45,8 +45,24 @@ struct mmc_ioc_cmd {
>  };
>  #define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr = (__u64)(unsigned long) ptr
>
> -#define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
> +/**
> + * struct mmc_ioc_multi_cmd - multi command information
> + * @num_of_cmds: Number of commands to send. Must be equal to or less than
> + *     MMC_IOC_MAX_CMDS.
> + * @cmds: Array of commands with length equal to 'num_of_cmds'
> + */
> +struct mmc_ioc_multi_cmd {
> +       __u64 num_of_cmds;
> +       struct mmc_ioc_cmd cmds[0];
> +};
>
> +#define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
> +/*
> + * MMC_IOC_MULTI_CMD: Used to send an array of MMC commands described by
> + *     the structure mmc_ioc_multi_cmd. The MMC driver will issue all
> + *     commands in array in sequence to card.
> + */
> +#define MMC_IOC_MULTI_CMD _IOWR(MMC_BLOCK_MAJOR, 1, struct mmc_ioc_multi_cmd)
>  /*
>   * Since this ioctl is only meant to enhance (and not replace) normal access
>   * to the mmc bus device, an upper data transfer limit of MMC_IOC_MAX_BYTES
> @@ -54,4 +70,5 @@ struct mmc_ioc_cmd {
>   * block device operations.
>   */
>  #define MMC_IOC_MAX_BYTES  (512L * 256)
> +#define MMC_IOC_MAX_CMDS    255
>  #endif /* LINUX_MMC_IOCTL_H */
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
