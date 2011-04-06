From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: Add ioctl to let userspace apps send ACMDs
Date: Wed, 6 Apr 2011 11:51:42 +0200
Message-ID: <BANLkTinsYioaa69ZdFpBAr-BK6RDh8V83g@mail.gmail.com>
References: <alpine.DEB.2.00.1104051450480.25803@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46570 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab1DFJwD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 05:52:03 -0400
Received: by pvg12 with SMTP id 12so483735pvg.19
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2011 02:52:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104051450480.25803@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>

2011/4/5 John Calixto <john.calixto@modsystems.com>:
> Sending ACMDs from userspace is useful for such things as:
>
> =C2=A0 =C2=A0- The security application of an SD card (SD Specificati=
on, Part 3,
> =C2=A0 =C2=A0 =C2=A0Security)
>
> =C2=A0 =C2=A0- SD passthrough for virtual machines
>
> Tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652 SoC, TI OMAP3621
> SoC, TI OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm MSM7200A SoC.
>
> Signed-off-by: John Calixto <john.calixto@modsystems.com>
> ---
> =C2=A0drivers/mmc/card/block.c =C2=A0| =C2=A0191 ++++++++++++++++++++=
+++++++++++++++++++++++++
> =C2=A0drivers/mmc/core/sd_ops.c | =C2=A0 =C2=A03 +-
> =C2=A0include/linux/mmc/core.h =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0include/linux/mmc/sd.h =C2=A0 =C2=A0| =C2=A0 16 ++++
> =C2=A04 files changed, 210 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 61d233a..c2e107c 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -31,6 +31,8 @@
> =C2=A0#include <linux/mutex.h>
> =C2=A0#include <linux/scatterlist.h>
> =C2=A0#include <linux/string_helpers.h>
> +#include <linux/compat.h>
> +#include <linux/delay.h>
>
> =C2=A0#include <linux/mmc/card.h>
> =C2=A0#include <linux/mmc/host.h>
> @@ -158,11 +160,200 @@ mmc_blk_getgeo(struct block_device *bdev, stru=
ct hd_geometry *geo)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> +static int mmc_blk_ioctl_acmd(struct block_device *bdev,
> + =C2=A0 =C2=A0 =C2=A0 struct sd_ioc_cmd __user *sdic_ptr)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct sd_ioc_cmd sdic;
> + =C2=A0 =C2=A0 =C2=A0 struct mmc_blk_data *md;
> + =C2=A0 =C2=A0 =C2=A0 struct mmc_host *host;
> + =C2=A0 =C2=A0 =C2=A0 struct mmc_card *card;
> + =C2=A0 =C2=A0 =C2=A0 struct mmc_command cmd =3D {0};
> + =C2=A0 =C2=A0 =C2=A0 struct mmc_data data =3D {0};
> + =C2=A0 =C2=A0 =C2=A0 struct mmc_request mrq =3D {0};
> + =C2=A0 =C2=A0 =C2=A0 struct scatterlist sg =3D {0};
> + =C2=A0 =C2=A0 =C2=A0 unsigned char *blocks =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 size_t data_bytes;
> + =C2=A0 =C2=A0 =C2=A0 int err;
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Only allow ACMDs on the whole block de=
vice, not on partitions. =C2=A0This
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* prevents overspray between sibling par=
titions.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (bdev !=3D bdev->bd_contains)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EPERM;

This should at least also check CAP_SYS_ADMIN capability.

> +
> + =C2=A0 =C2=A0 =C2=A0 md =3D mmc_blk_get(bdev->bd_disk);
> + =C2=A0 =C2=A0 =C2=A0 if (!md)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 card =3D md->queue.card;
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(card))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(car=
d);
> +
> + =C2=A0 =C2=A0 =C2=A0 host =3D card->host;
> + =C2=A0 =C2=A0 =C2=A0 mmc_claim_host(host);
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D mmc_app_cmd(host, card);
> + =C2=A0 =C2=A0 =C2=A0 if (err)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto acmd_done;
> +
> + =C2=A0 =C2=A0 =C2=A0 mrq.cmd =3D &cmd;
> + =C2=A0 =C2=A0 =C2=A0 mrq.data =3D &data;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (copy_from_user(&sdic, sdic_ptr, sizeof(sdi=
c))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EFAULT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto acmd_done;
> + =C2=A0 =C2=A0 =C2=A0 }

You should first copy and verify ioctl's data and only then claim host
and send commands. Preferably the check-and-copy should be separate
function.

> +
> + =C2=A0 =C2=A0 =C2=A0 cmd.opcode =3D sdic.opcode;
> + =C2=A0 =C2=A0 =C2=A0 cmd.arg =3D sdic.arg;
> + =C2=A0 =C2=A0 =C2=A0 cmd.flags =3D sdic.flags;
> +
> + =C2=A0 =C2=A0 =C2=A0 data.sg =3D &sg;
> + =C2=A0 =C2=A0 =C2=A0 data.sg_len =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 data.blksz =3D sdic.blksz;
> + =C2=A0 =C2=A0 =C2=A0 data.blocks =3D sdic.blocks;
> +
> + =C2=A0 =C2=A0 =C2=A0 data_bytes =3D data.blksz * data.blocks;
> + =C2=A0 =C2=A0 =C2=A0 blocks =3D kzalloc(data_bytes, GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (!blocks) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto acmd_done;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 sg_init_one(data.sg, blocks, data_bytes);
> +
> +
> + =C2=A0 =C2=A0 =C2=A0 if (copy_from_user(blocks, sdic_ptr->data_ptr,=
 data_bytes)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EFAULT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto acmd_done;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (sdic.write_flag)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data.flags =3D MMC=
_DATA_WRITE;
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data.flags =3D MMC=
_DATA_READ;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* data.flags must already be set before doing=
 this. */
> + =C2=A0 =C2=A0 =C2=A0 mmc_set_data_timeout(&data, card);
> + =C2=A0 =C2=A0 =C2=A0 /* Allow overriding the timeout_ns for empiric=
al tuning. */
> + =C2=A0 =C2=A0 =C2=A0 if (sdic.force_timeout_ns)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data.timeout_ns =3D=
 sdic.force_timeout_ns;
> +
> + =C2=A0 =C2=A0 =C2=A0 mmc_wait_for_req(host, &mrq);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (cmd.error) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(mmc_dev(ho=
st), "%s: cmd error %d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 __func__, cmd.error);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D cmd.error;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto acmd_done;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (data.error) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(mmc_dev(ho=
st), "%s: data error %d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 __func__, data.error);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D data.error=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto acmd_done;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* According to the SD specs, some comman=
ds require a delay after
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* issuing the command.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (sdic.postsleep_us)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(sdic.postsl=
eep_us);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (copy_to_user(&(sdic_ptr->response), cmd.re=
sp, sizeof(cmd.resp))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EFAULT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto acmd_done;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!sdic.write_flag) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (copy_to_user(s=
dic_ptr->data_ptr, blocks, data_bytes)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 err =3D -EFAULT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto acmd_done;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> +acmd_done:
> + =C2=A0 =C2=A0 =C2=A0 kfree(blocks);
> + =C2=A0 =C2=A0 =C2=A0 mmc_release_host(host);
> + =C2=A0 =C2=A0 =C2=A0 mmc_blk_put(md);
> + =C2=A0 =C2=A0 =C2=A0 return err;
> +}
> +
> +static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
> + =C2=A0 =C2=A0 =C2=A0 unsigned int cmd, unsigned long arg)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&block_mutex);
> + =C2=A0 =C2=A0 =C2=A0 if (cmd =3D=3D SD_IOC_ACMD)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmc_blk_io=
ctl_acmd(bdev, (struct sd_ioc_cmd __user *)arg);
> + =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&block_mutex);
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +#ifdef CONFIG_COMPAT
> +struct sd_ioc_cmd32 {
> + =C2=A0 =C2=A0 =C2=A0 u32 write_flag;
> + =C2=A0 =C2=A0 =C2=A0 u32 opcode;
> + =C2=A0 =C2=A0 =C2=A0 u32 arg;
> + =C2=A0 =C2=A0 =C2=A0 u32 response[4];
> + =C2=A0 =C2=A0 =C2=A0 u32 flags;
> + =C2=A0 =C2=A0 =C2=A0 u32 blksz;
> + =C2=A0 =C2=A0 =C2=A0 u32 blocks;
> + =C2=A0 =C2=A0 =C2=A0 u32 postsleep_us;
> + =C2=A0 =C2=A0 =C2=A0 u32 force_timeout_ns;
> + =C2=A0 =C2=A0 =C2=A0 compat_uptr_t data_ptr;
> +};
> +#define SD_IOC_ACMD32 _IOWR(MMC_BLOCK_MAJOR, 0, struct sd_ioc_cmd32)
[...]

Since your implementing a new ioctl you can make the structure the
same for 64 and 32-bit archs and avoid all this compat crap.

Best Regards,
Micha=C5=82 Miros=C5=82aw
