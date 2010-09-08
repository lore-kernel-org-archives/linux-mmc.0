From: Lei Wen <adrian.wenl@gmail.com>
Subject: Re: [PATCH v3] mmc: add config and runtime option for number of
 mmcblk minors
Date: Wed, 8 Sep 2010 22:25:58 +0800
Message-ID: <AANLkTikLLwfSXbnjPByXTktEFFVueeAd7HZS5ft-rj-m@mail.gmail.com>
References: <20100818041333.GA14149@lixom.net>
	<20100818171636.0625b668.akpm@linux-foundation.org>
	<20100819032230.GA21980@lixom.net>
	<20100820010242.GA29588@lixom.net>
	<20100820221323.GC8535@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58741 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab0IHOZ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Sep 2010 10:25:59 -0400
In-Reply-To: <20100820221323.GC8535@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Mandeep Baines <msb@chromium.org>

Hi,

On Sat, Aug 21, 2010 at 6:13 AM, Olof Johansson <olof@lixom.net> wrote:
> The old limit of number of minor numbers per mmcblk device was hardco=
ded
> at 8. This isn't enough for some of the more elaborate partitioning
> schemes, for example those used by Chrome OS.
>
> Since there might be a bunch of systems out there with static /dev
> contents that relies on the old numbering scheme, let's make it a
> build-time option with the default set to the previous 8.
>
> Also provide a boot/modprobe-time parameter to override the config
> default: mmcblk.perdev_minors.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Mandeep Baines <msb@chromium.org>
>
> ---
>
> Andrew, sorry for the churn but Mandeep had a couple of good points t=
hat
> needed addressing.
>
> Changes since v1:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* Runtime override of config default
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* Better help text
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* DIV_ROUND_UP for max_devices calculation
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* Clarify mmcblk device count limitations
>
> Changes since v2 based on feedback from Mandeep Baines:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* DIV_ROUND_UP is doing the wrong thing, w=
e'll end up using
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the last fractional range of minors=
 which we shouldn't.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* Documentation/devices.txt update
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* No need to compute max_devices twice, ju=
st do it at runtime.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0* Permission fix for the module_param -- i=
t's readonly.
>
> =C2=A0Documentation/devices.txt | =C2=A0 =C2=A06 ++++++
> =C2=A0drivers/mmc/card/Kconfig =C2=A0| =C2=A0 17 +++++++++++++++++
> =C2=A0drivers/mmc/card/block.c =C2=A0| =C2=A0 41 ++++++++++++++++++++=
++++++++++-----------
> =C2=A03 files changed, 53 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/devices.txt b/Documentation/devices.txt
> index 1d83d12..fdf3821 100644
> --- a/Documentation/devices.txt
> +++ b/Documentation/devices.txt
> @@ -2518,6 +2518,12 @@ Your cooperation is appreciated.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08 =3D /=
dev/mmcblk1 =C2=A0 =C2=A0 =C2=A0Second SD/MMC card
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=2E..
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The start of next =
SD/MMC card can be configured with
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CONFIG_MMC_BLOCK_M=
INORS, or overridden at boot/modprobe
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time using the mmc=
blk.perdev_minors option. That would
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bump the offset be=
tween each card to be the configured
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value instead of t=
he default 8.
> +
> =C2=A0179 char =C2=A0 =C2=A0 =C2=A0 CCube DVXChip-based PCI products
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =3D /=
dev/dvxirq0 =C2=A0 =C2=A0 =C2=A0First DVX device
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =3D /=
dev/dvxirq1 =C2=A0 =C2=A0 =C2=A0Second DVX device
> diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
> index 3f2a912..57e4416 100644
> --- a/drivers/mmc/card/Kconfig
> +++ b/drivers/mmc/card/Kconfig
> @@ -14,6 +14,23 @@ config MMC_BLOCK
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount the filesystem. Almost everyo=
ne wishing MMC support
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0should say Y or M here.
>
> +config MMC_BLOCK_MINORS
> + =C2=A0 =C2=A0 =C2=A0 int "Number of minors per block device"
> + =C2=A0 =C2=A0 =C2=A0 range 4 256
> + =C2=A0 =C2=A0 =C2=A0 default 8
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Number of minors per block device. One =
is needed for every
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 partition on the disk (plus one for the=
 whole disk).
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Number of total MMC minors available is=
 256, so your number
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 of supported block devices will be limi=
ted to 256 divided
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 by this number.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Default is 8 to be backwards compatible=
 with previous
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 hardwired device numbering.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If unsure, say 8 here.
> +
> =C2=A0config MMC_BLOCK_BOUNCE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "Use bounce buffer for simple hosts"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MMC_BLOCK
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index cb9fbc8..ec94f56 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -43,14 +43,26 @@
> =C2=A0#include "queue.h"
>
> =C2=A0MODULE_ALIAS("mmc:block");
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +#define MODULE_PARAM_PREFIX "mmcblk."
> +
> +
> +/*
> + * The defaults come from config options but can be overriden by mod=
ule
> + * or bootarg options.
> + */
> +static int perdev_minors =3D CONFIG_MMC_BLOCK_MINORS;
>
> =C2=A0/*
> - * max 8 partitions per card
> + * We've only got one major, so number of mmcblk devices is
> + * limited to 256 / number of minors per device.
> =C2=A0*/
> -#define MMC_SHIFT =C2=A0 =C2=A0 =C2=A03
> -#define MMC_NUM_MINORS (256 >> MMC_SHIFT)
> +static int max_devices;
>
> -static DECLARE_BITMAP(dev_use, MMC_NUM_MINORS);
> +/* 256 minors, so at most 256 separate devices */
> +static DECLARE_BITMAP(dev_use, 256);
>
> =C2=A0/*
> =C2=A0* There is one mmc_blk_data per slot.
> @@ -66,6 +78,9 @@ struct mmc_blk_data {
>
> =C2=A0static DEFINE_MUTEX(open_lock);
>
> +module_param(perdev_minors, int, 0444);
> +MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per devi=
ce");
> +
> =C2=A0static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_blk_data *md;
> @@ -87,10 +102,10 @@ static void mmc_blk_put(struct mmc_blk_data *md)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0md->usage--;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (md->usage =3D=3D 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int devmaj =3D=
 MAJOR(disk_devt(md->disk));
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int devidx =3D MIN=
OR(disk_devt(md->disk)) >> MMC_SHIFT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int devidx =3D MIN=
OR(disk_devt(md->disk)) / perdev_minors;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!devmaj)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 devidx =3D md->disk->first_minor >> MMC_SHIFT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 devidx =3D md->disk->first_minor / perdev_minors;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk_cleanup_qu=
eue(md->queue.queue);
>
> @@ -482,8 +497,8 @@ static struct mmc_blk_data *mmc_blk_alloc(struct =
mmc_card *card)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_blk_data *md;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int devidx, ret;
>
> - =C2=A0 =C2=A0 =C2=A0 devidx =3D find_first_zero_bit(dev_use, MMC_NU=
M_MINORS);
> - =C2=A0 =C2=A0 =C2=A0 if (devidx >=3D MMC_NUM_MINORS)
> + =C2=A0 =C2=A0 =C2=A0 devidx =3D find_first_zero_bit(dev_use, max_de=
vices);
> + =C2=A0 =C2=A0 =C2=A0 if (devidx >=3D max_devices)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR=
(-ENOSPC);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__set_bit(devidx, dev_use);
>
> @@ -500,7 +515,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct =
mmc_card *card)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0md->read_only =3D mmc_blk_readonly(card);
>
> - =C2=A0 =C2=A0 =C2=A0 md->disk =3D alloc_disk(1 << MMC_SHIFT);
> + =C2=A0 =C2=A0 =C2=A0 md->disk =3D alloc_disk(perdev_minors);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (md->disk =3D=3D NULL) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOME=
M;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_kfree=
;
> @@ -517,7 +532,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct =
mmc_card *card)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0md->queue.data =3D md;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0md->disk->major =3D MMC_BLOCK_MAJOR;
> - =C2=A0 =C2=A0 =C2=A0 md->disk->first_minor =3D devidx << MMC_SHIFT;
> + =C2=A0 =C2=A0 =C2=A0 md->disk->first_minor =3D devidx * perdev_mino=
rs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0md->disk->fops =3D &mmc_bdops;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0md->disk->private_data =3D md;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0md->disk->queue =3D md->queue.queue;
> @@ -593,7 +608,6 @@ static int mmc_blk_probe(struct mmc_card *card)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_blk_data *md;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char cap_str[10];
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> @@ -683,6 +697,11 @@ static int __init mmc_blk_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int res;
>
> + =C2=A0 =C2=A0 =C2=A0 if (perdev_minors !=3D CONFIG_MMC_BLOCK_MINORS=
)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("mmcblk: u=
sing %d minors per device\n", perdev_minors);
> +
> + =C2=A0 =C2=A0 =C2=A0 max_devices =3D 256 / perdev_minors;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D register_blkdev(MMC_BLOCK_MAJOR, "=
mmc");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> --
> 1.5.6.5
>

The patch's purpose is good. As modern sd&mmc is used to host the file
system, the 8 partition limitation is becoming a kind of bottleneck...
But why not just add GENHD_FL_EXT_DEVT flag to allow mmc use extended
partition numbers?

Like this modification?
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 8d2bd24..2e3eeb1 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -557,6 +557,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct
mmc_card *card)
        md->disk->private_data =3D md;
        md->disk->queue =3D md->queue.queue;
        md->disk->driverfs_dev =3D &card->dev;
+       md->disk->flags |=3D GENHD_FL_EXT_DEVT;

        /*
         * As discussed on lkml, GENHD_FL_REMOVABLE should:

Best regards,
Lei
