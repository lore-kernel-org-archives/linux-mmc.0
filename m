From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Devicetree: Initialization order of mmc block devices?
Date: Wed, 18 Jul 2012 08:26:34 +0200
Message-ID: <5006571A.7060103@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:37223 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab2GRGaB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 02:30:01 -0400
Received: from smtp2-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 053BF1E40665
	for <linux-mmc@vger.kernel.org>; Wed, 18 Jul 2012 08:30:00 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "Wohlrab Knut (CM-AI/PJ-CA33)" <Knut.Wohlrab@de.bosch.com>


Similar to [1] we have a device which has two mmc block devices 
connected: One external removable and a second internal hard wired one. 
Depending on the availability of the external removable mmc card at boot 
time, the internal hard wired device becomes mmcblk1 (external mmc card 
available == mmcblk0) or mmcblk0 if the external one is not there. This 
order is given by the hardware.

With older, non-DT kernels, we used the hack from [2] to control the 
initialization order and force the internal hard wired device to mmcblk0.

Now, we are switching to a newer, DT based kernel. With a DT based 
kernel this hack doesn't seem to work an more.

Any idea how we could influence the initialization order of the mmc 
block devices using a DT based kernel? Ensuring that the internal, hard 
wired mmc card is always mapped to mmcblk0?

Many thanks and best regards

Dirk

[1] https://bugs.maemo.org/show_bug.cgi?id=2747

[2] https://bugs.maemo.org/show_bug.cgi?id=2747

bigger patch for fremantle kernel which extends also platform data 
structures

https://bugs.maemo.org/attachment.cgi?id=2127

--- kernel-2.6.28-20094803.3/arch/arm/mach-omap2/board-rx51-flash.c 
2010-01-24 23:23:10.000000000 +0100
+++ 
kernel-2.6.28-20094803.3-fanoush/arch/arm/mach-omap2/board-rx51-flash.c 
2010-01-24 22:22:02.000000000 +0100
@@ -59,6 +59,7 @@ static struct platform_device *rx51_flas
  static struct twl4030_hsmmc_info mmc[] __initdata = {
  	{
  		.name		= "external",
+		.mmcblk_devidx	= 1,
  		.mmc		= 1,
  		.wires		= 4,
  		.cover_only	= true,
@@ -69,6 +70,7 @@ static struct twl4030_hsmmc_info mmc[] _
  	},
  	{
  		.name		= "internal",
+		.mmcblk_devidx	= 0,
  		.mmc		= 2,
  		.wires		= 8,
  		.gpio_cd	= -EINVAL,
--- kernel-2.6.28-20094803.3/arch/arm/mach-omap2/mmc-twl4030.c 
2010-01-24 23:23:10.000000000 +0100
+++ kernel-2.6.28-20094803.3-fanoush/arch/arm/mach-omap2/mmc-twl4030.c 
2010-01-24 22:59:35.000000000 +0100
@@ -745,6 +745,7 @@ void __init twl4030_mmc_init(struct twl4
  		else
  			sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
  		mmc->slots[0].name = twl->name;
+		mmc->slots[0].mmcblk_devidx = c->mmcblk_devidx;
  		mmc->nr_slots = 1;
  		mmc->slots[0].wires = c->wires;
  		mmc->slots[0].internal_clock = !c->ext_clock;
--- kernel-2.6.28-20094803.3/arch/arm/mach-omap2/mmc-twl4030.h 
2010-01-24 23:23:10.000000000 +0100
+++ kernel-2.6.28-20094803.3-fanoush/arch/arm/mach-omap2/mmc-twl4030.h 
2010-01-24 22:20:51.000000000 +0100
@@ -19,6 +19,7 @@ struct twl4030_hsmmc_info {
  	int	gpio_cd;	/* or -EINVAL */
  	int	gpio_wp;	/* or -EINVAL */
  	char	*name;		/* or NULL for default */
+	int	mmcblk_devidx;  /* preferred mmcblkX device index */
  };

  #if	defined(CONFIG_TWL4030_CORE) && \
--- kernel-2.6.28-20094803.3/arch/arm/plat-omap/include/mach/mmc.h 
2010-01-24 23:23:10.000000000 +0100
+++ 
kernel-2.6.28-20094803.3-fanoush/arch/arm/plat-omap/include/mach/mmc.h 
2010-01-24 22:53:59.000000000 +0100
@@ -110,6 +110,7 @@ struct omap_mmc_platform_data {
  		int (* get_cover_state)(struct device *dev, int slot);

  		const char *name;
+		int mmcblk_devidx; /* preferred mmcblkX index for this slot */
  		u32 ocr_mask;

  		/* Card detection IRQs */
--- kernel-2.6.28-20094803.3/drivers/mmc/card/block.c	2010-01-24 
23:23:09.000000000 +0100
+++ kernel-2.6.28-20094803.3-fanoush/drivers/mmc/card/block.c	2010-01-24 
22:14:12.000000000 +0100
@@ -479,7 +479,7 @@ static struct mmc_blk_data *mmc_blk_allo
  	struct mmc_blk_data *md;
  	int devidx, ret;

-	devidx = find_first_zero_bit(dev_use, MMC_NUM_MINORS);
+	devidx = find_next_zero_bit(dev_use, MMC_NUM_MINORS, 
card->host->mmcblk_devidx);
  	if (devidx >= MMC_NUM_MINORS)
  		return ERR_PTR(-ENOSPC);
  	__set_bit(devidx, dev_use);
--- kernel-2.6.28-20094803.3/drivers/mmc/host/omap_hsmmc.c	2010-01-24 
23:23:09.000000000 +0100
+++ kernel-2.6.28-20094803.3-fanoush/drivers/mmc/host/omap_hsmmc.c 
2010-01-25 12:27:07.000000000 +0100
@@ -1710,6 +1710,7 @@ static int __init omap_hsmmc_probe(struc
  	mmc->max_seg_size = mmc->max_req_size;

  	mmc->ocr_avail = mmc_slot(host).ocr_mask;
+	mmc->mmcblk_devidx = mmc_slot(host).mmcblk_devidx;
  	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;

  	if (mmc_slot(host).wires >= 8)
--- kernel-2.6.28-20094803.3/include/linux/mmc/host.h	2010-01-24 
23:23:10.000000000 +0100
+++ kernel-2.6.28-20094803.3-fanoush/include/linux/mmc/host.h	2010-01-24 
22:12:20.000000000 +0100
@@ -207,7 +207,7 @@ struct mmc_host {
  #endif

  	struct dentry		*debugfs_root;
-
+	unsigned int		mmcblk_devidx; /* preferred mmc block device index 
(mmcblkX) */
  	unsigned long		private[0] ____cacheline_aligned;
  };
