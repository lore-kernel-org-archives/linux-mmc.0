From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send
	ACMDs
Date: Thu, 17 Mar 2011 18:35:01 +0000
Message-ID: <20110317183501.GA27290@trinity.fluff.org>
References: <203F41F6E33F954E8E8B02559FDC906F743176BFD2@modex01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:42763 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652Ab1CQSfE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Mar 2011 14:35:04 -0400
Content-Disposition: inline
In-Reply-To: <203F41F6E33F954E8E8B02559FDC906F743176BFD2@modex01>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>

On Thu, Mar 17, 2011 at 11:28:55AM -0700, John Calixto wrote:
> Part 3 of the SD Specification (SD Card Association; www.sdcard.org) describes
> how to use the security function of an SD card using application specific
> commands in conjunction with CPRM algorithms and keys licensed from the 4C
> Entity (www.4centity.com).  This allows userspace applications to access this
> security feature.
> 
> Tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652 SoC, TI OMAP3621 SoC, TI
> OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm MSM7200A SoC.
> 
> Signed-off-by: John Calixto <john.calixto@modsystems.com>
> ---
> (I'm resending because I forgot to cc the maintainer - sorry!)
> 
>  drivers/mmc/card/block.c  |  149 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/sd_ops.c |    3 +-
>  include/linux/mmc/core.h  |    1 +
>  include/linux/mmc/sd.h    |   18 ++++++
>  4 files changed, 170 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index bfc8a8a..62f742d 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -39,6 +39,7 @@
> 
>  #include <asm/system.h>
>  #include <asm/uaccess.h>
> +#include <asm/delay.h>
> 
>  #include "queue.h"
> 
> @@ -158,11 +159,159 @@ mmc_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>         return 0;
>  }
> 
> +static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode, unsigned int ioc_cmd, unsigned long ioc_arg)
> +{
> +       struct sd_ioc_cmd sdic = {0};
> +       struct mmc_blk_data *md = NULL;
> +       struct mmc_host *host = NULL;
> +       struct mmc_card *card = NULL;
> +       struct mmc_command cmd = {0};
> +       struct mmc_data data = {0};
> +       int err = 0;
> +       struct mmc_request mrq = {0};
> +       struct scatterlist sg = {0};
> +       unsigned char *blocks = NULL;
> +       size_t data_bytes = 0;
> +#ifdef CONFIG_MMC_DEBUG
> +       char dbgbuf[64] = {0};
> +#endif
> +
> +       /*
> +        * This is primarily used for application specific commands (ACMD), so
> +        * the current ioc_cmd validation is trivial.
> +        */
> +       if (ioc_cmd != SD_IOC_ACMD)
> +               return -EINVAL;
> +
> +       if (copy_from_user(&sdic, (void __user *) ioc_arg, sizeof(struct sd_ioc_cmd))) {
> +               printk(KERN_ERR "%s: error reading ioctl arg from userspace\n", __func__);
> +               return -EFAULT;
> +       }
> +
> +       if (sdic.struct_version != SD_IOC_CMD_STRUCT_VERSION)
> +               return -EINVAL;
> +
> +       /* Find the mmc structures based on the bdev. */
> +       md = mmc_blk_get(bdev->bd_disk);
> +       if (!md)
> +               return -EINVAL;
> +
> +       card = md->queue.card;
> +#ifdef CONFIG_MMC_DEBUG
> +       printk(KERN_DEBUG "%s: card = %p\n", __func__, card);
> +#endif
> +       if (IS_ERR(card))
> +               return PTR_ERR(card);
> +
> +#ifdef CONFIG_MMC_DEBUG
> +       printk(KERN_DEBUG "%s: host = %p\n", __func__, card->host);
> +#endif
> +       host = card->host;
> +       BUG_ON(!host);
> +
> +       mmc_claim_host(host);
> +
> +       err = mmc_app_cmd(host, card);
> +       if (err) {
> +               dev_err(mmc_dev(host), "%s: CMD%d error\n", __func__, MMC_APP_CMD);
> +               goto ioctl_done;
> +       }
> +
> +       mrq.cmd = &cmd;
> +       mrq.data = &data;
> +
> +       cmd.opcode = sdic.opcode;
> +       cmd.arg = sdic.arg;
> +       cmd.flags = sdic.flags;
> +
> +       data.sg = &sg;
> +       data.sg_len = 1;
> +       data.blksz = sdic.blksz;
> +       data.blocks = sdic.blocks;
> +
> +       data_bytes = data.blksz * data.blocks;
> +       blocks = (unsigned char *) kzalloc(data_bytes, GFP_KERNEL);

you shouldn't need this cast, 'void *' will go hapilly to any other type.

> +       if (!blocks) {
> +               err = -ENOMEM;
> +               goto ioctl_done;
> +       }
> +       sg_init_one(data.sg, blocks, data_bytes);
> +
> +
> +       if (copy_from_user(blocks, sdic.data, data_bytes)) {
> +               dev_err(mmc_dev(host), "%s: error reading userspace buffer\n", __func__);
> +               err = -EFAULT;
> +               goto ioctl_done;
> +       }
> +       if (sdic.write_flag) {
> +               data.flags = MMC_DATA_WRITE;
> +       } else {
> +               data.flags = MMC_DATA_READ;
> +       }
> +
> +       /* data.flags must already be set before doing this. */
> +       mmc_set_data_timeout(&data, card);
> +       /* Allow overriding the timeout_ns for empirical tuning. */
> +       if (sdic.force_timeout_ns)
> +               data.timeout_ns = sdic.force_timeout_ns;
> +
> +#ifdef CONFIG_MMC_DEBUG
> +       hex_dump_to_buffer(blocks, data_bytes, 16, 1, dbgbuf, sizeof(dbgbuf), 0);
> +       dev_dbg(mmc_dev(host), "%s: first bytes of pre data\n%s\n", __func__, dbgbuf);
> +#endif
> +
> +       mmc_wait_for_req(host, &mrq);
> +
> +       if (cmd.error) {
> +               dev_err(mmc_dev(host), "%s: cmd error %d\n", __func__, cmd.error);
> +               err = cmd.error;
> +               goto ioctl_done;
> +       }
> +       if (data.error) {
> +               dev_err(mmc_dev(host), "%s: data error %d\n", __func__, data.error);
> +               err = data.error;
> +               goto ioctl_done;
> +       }
> +
> +       /*
> +        * According to the SD specs, some commands require a delay after
> +        * issuing the command.
> +        */
> +       if (sdic.postsleep_us)
> +               udelay(sdic.postsleep_us);
> +
> +       if (copy_to_user(&(((struct sd_ioc_cmd *) ioc_arg)->response), cmd.resp, sizeof(u32) * 4)) {
> +               dev_err(mmc_dev(host), "%s: error copying response\n", __func__);
> +               err = -EFAULT;
> +               goto ioctl_done;
> +       }
> +
> +#ifdef CONFIG_MMC_DEBUG
> +       hex_dump_to_buffer(blocks, data_bytes, 16, 1, dbgbuf, sizeof(dbgbuf), 0);
> +       dev_dbg(mmc_dev(host), "%s: first bytes of post data\n%s\n", __func__, dbgbuf);
> +#endif
> +       if (!sdic.write_flag) {
> +               if (copy_to_user(sdic.data, blocks, data_bytes)) {
> +                       dev_err(mmc_dev(host), "%s: error copying data\n", __func__);
> +                       err = -EFAULT;
> +                       goto ioctl_done;
> +               }
> +       }
> +
> +ioctl_done:
> +       if (blocks)
> +               kfree(blocks);
> +       mmc_release_host(host);
> +       mmc_blk_put(md);
> +       return err;
> +}
> +
>  static const struct block_device_operations mmc_bdops = {
>         .open                   = mmc_blk_open,
>         .release                = mmc_blk_release,
>         .getgeo                 = mmc_blk_getgeo,
>         .owner                  = THIS_MODULE,
> +       .ioctl                  = mmc_blk_ioctl,
>  };
> 
>  struct mmc_blk_request {
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 797cdb5..0453dcd 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -20,7 +20,7 @@
>  #include "core.h"
>  #include "sd_ops.h"
> 
> -static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
> +int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
>  {
>         int err;
>         struct mmc_command cmd;
> @@ -48,6 +48,7 @@ static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
> 
>         return 0;
>  }
> +EXPORT_SYMBOL(mmc_app_cmd);
> 
>  /**
>   *     mmc_wait_for_app_cmd - start an application command and wait for
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 64e013f..1adda405 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -133,6 +133,7 @@ struct mmc_card;
> 
>  extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
>  extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
> +extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
>  extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
>         struct mmc_command *, int);
> 
> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> index 3fd85e0..a031cba 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -12,6 +12,8 @@
>  #ifndef MMC_SD_H
>  #define MMC_SD_H
> 
> +#include <linux/ioctl.h>
> +
>  /* SD commands                           type  argument     response */
>    /* class 0 */
>  /* This is basically the same command as for MMC with some quirks. */
> @@ -84,5 +86,21 @@
>  #define SD_SWITCH_ACCESS_DEF   0
>  #define SD_SWITCH_ACCESS_HS    1
> 
> +struct sd_ioc_cmd {
> +    unsigned int struct_version;
> +#define SD_IOC_CMD_STRUCT_VERSION 0
> +    int write_flag;  /* implies direction of data.  true = write, false = read */
> +    unsigned int opcode;
> +    unsigned int arg;
> +    unsigned int flags;
> +    unsigned int postsleep_us;  /* apply usecond delay *after* issuing command */
> +    unsigned int force_timeout_ns;  /* force timeout to be force_timeout_ns ns */
> +    unsigned int response[4];  /* CMD response */
> +    unsigned int blksz;
> +    unsigned int blocks;
> +    unsigned char *data;  /* DAT buffer */
> +};
> +#define SD_IOC_ACMD _IOWR(MMC_BLOCK_MAJOR, 0, struct sd_ioc_cmd *)
> +
>  #endif
> 
> --
> 1.7.4.1
> 
> This message contains information which is confidential and privileged.  Unless you are the addressee (or authorized to receive for the addressee), you may not use, copy or disclose to anyone the message or any information contained in the message. If you have received the message in error, please advise the sender by reply e-mail and delete the message.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

