From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send ACMDs
Date: Thu, 17 Mar 2011 22:55:51 +0100
Message-ID: <201103172255.51442.arnd@arndb.de>
References: <203F41F6E33F954E8E8B02559FDC906F743176BFD2@modex01>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61686 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab1CQVz4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 17:55:56 -0400
In-Reply-To: <203F41F6E33F954E8E8B02559FDC906F743176BFD2@modex01>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>

On Thursday 17 March 2011 19:28:55 John Calixto wrote:
> Part 3 of the SD Specification (SD Card Association; www.sdcard.org) describes
> how to use the security function of an SD card using application specific
> commands in conjunction with CPRM algorithms and keys licensed from the 4C
> Entity (www.4centity.com).  This allows userspace applications to access this
> security feature.

Having the ability to send commands from user space sounds useful,
a number of other block drivers can do this, too.

However, for the specific example you mention, I think it would be
nicer to implement it in kernel space, and have a high-level
interface.

A few more comments about the implementation below.

> Tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652 SoC, TI OMAP3621 SoC, TI
> OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm MSM7200A SoC.

Is this safe to do while the device is operating and a file system
writes data?

Does it allow sending all commands or just the ones you require?

I've been thinking about adding something like this to allow
a passthrough mode for e.g. qemu, or perhaps for combining
it with a user space mmc host (to be written) to allow tracing
the communication between host and card from user space.

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

[style] Don't initialize variables to zero if they get assigned
to something else later, otherwise you prevent the compiler
from warning you about accesses to uninitialized variables.

> +#ifdef CONFIG_MMC_DEBUG
> +       char dbgbuf[64] = {0};
> +#endif

> +
> +       if (copy_from_user(&sdic, (void __user *) ioc_arg, sizeof(struct sd_ioc_cmd))) {
> +               printk(KERN_ERR "%s: error reading ioctl arg from userspace\n", __func__);
> +               return -EFAULT;
> +       }

Don't printk information about user input, only about unexpected
data you get from the card. If you print an error, use dev_err().

> +       if (sdic.struct_version != SD_IOC_CMD_STRUCT_VERSION)
> +               return -EINVAL;

Don't use version information for ioctl data structures. We cannot
change them anyways, so the version number is redundant.
If we ever need to extend the structure, it has to be done in
a compatible way, or by introducing a new ioctl command with
a different structure, but leaving the old one in place.

> +       /* Find the mmc structures based on the bdev. */
> +       md = mmc_blk_get(bdev->bd_disk);
> +       if (!md)
> +               return -EINVAL;
> +
> +       card = md->queue.card;
> +#ifdef CONFIG_MMC_DEBUG
> +       printk(KERN_DEBUG "%s: card = %p\n", __func__, card);
> +#endif

dev_dbg()

> +       if (IS_ERR(card))
> +               return PTR_ERR(card);
> +
> +#ifdef CONFIG_MMC_DEBUG
> +       printk(KERN_DEBUG "%s: host = %p\n", __func__, card->host);
> +#endif

dev_dbg()

> +       host = card->host;
> +       BUG_ON(!host);

try to be very careful about BUG_ON(), it's always better to return
an error if you can avoid crashing the current process.

> +       mmc_claim_host(host);
> +
> +       err = mmc_app_cmd(host, card);
> +       if (err) {
> +               dev_err(mmc_dev(host), "%s: CMD%d error\n", __func__, MMC_APP_CMD);
> +               goto ioctl_done;
> +       }

Is this an unexpected error case? If it can be triggered by sending
specific commands, it would be better to just return the error
number ot user space without printing anything.

> +       data_bytes = data.blksz * data.blocks;
> +       blocks = (unsigned char *) kzalloc(data_bytes, GFP_KERNEL);

No need for the typecast, kzalloc returns a void pointer.

> +       if (copy_from_user(blocks, sdic.data, data_bytes)) {
> +               dev_err(mmc_dev(host), "%s: error reading userspace buffer\n", __func__);

no printing here again

> +#ifdef CONFIG_MMC_DEBUG
> +       hex_dump_to_buffer(blocks, data_bytes, 16, 1, dbgbuf, sizeof(dbgbuf), 0);
> +       dev_dbg(mmc_dev(host), "%s: first bytes of pre data\n%s\n", __func__, dbgbuf);
> +#endif

Is this really still needed? I would assume that if your code works
fine, you can just remove the hex dump.

>  static const struct block_device_operations mmc_bdops = {
>         .open                   = mmc_blk_open,
>         .release                = mmc_blk_release,
>         .getgeo                 = mmc_blk_getgeo,
>         .owner                  = THIS_MODULE,
> +       .ioctl                  = mmc_blk_ioctl,
>  };

This also needs a compat_ioctl pointer, new drivers should always
work in both 32 and 64 bit mode.
 
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
 
Why not EXPORT_SYMBOL_GPL?

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

As I mentioned, any ioctl command that gets introduced needs to be
designed very carefully to make sure we don't need to change it in the
future. The only two things I can see here are:

* The struct_version should be removed
* The data pointer is not compatible between 32 and 64 bits.
  One solution for this would be to make it a __u64 argument
  and require the user to cast the pointer to a 64 bit type.

	Arnd
