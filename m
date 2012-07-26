From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Thu, 26 Jul 2012 10:06:08 +0200
Message-ID: <5010FA70.3080306@de.bosch.com>
References: <5006571A.7060103@de.bosch.com> <201207191313.46178.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:60374 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab2GZIJm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jul 2012 04:09:42 -0400
Received: from smtp2-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 95ABA1E40894
	for <linux-mmc@vger.kernel.org>; Thu, 26 Jul 2012 10:09:41 +0200 (CEST)
In-Reply-To: <201207191313.46178.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Wohlrab Knut (CM-AI/PJ-CA31)" <Knut.Wohlrab@de.bosch.com>

On 19.07.2012 15:13, Arnd Bergmann wrote:
> On Wednesday 18 July 2012, Dirk Behme wrote:
>> Any idea how we could influence the initialization order of the mmc 
>> block devices using a DT based kernel? Ensuring that the internal, hard 
>> wired mmc card is always mapped to mmcblk0?
> 
> I think the best solution would be to parse the "/aliases" device node
> and look for an "mmc0" or "mmc1" property with a phandle to the respective
> device. That's how we sort the serial ports. We have the of_alias_get_id()
> function to pick out a node from there, so it should be possible to use
> that in the mmc core similar to how we use it in the uart drivers.

Looking at the serial example you mentioned and trying to adapt that for 
mmcblkX I tried something like below [1] on a Freescale i.MX6 board and 
it seems to work :) Is this what you had in mind?

While I think the DT/of_alias_get_id() part looks ok (?), the way of 
passing the retrieved value from the driver sdhci-esdhc-imx.c to the 
block.c is quite hackish. I took it from the examples how this was 
hacked in the past.

Is there any better way of passing the information read in the driver by 
of_alias_get_id() to block.c? With the value read by of_alias_get_id() 
we somehow have to set name_idx in block.c.

Best regards

Dirk

[1]

Just fyi: From hardware point of view, usdhc1 connects the removable SD 
card, while usdhc3 attaches the non-removable eMMC. With the alias, 
independent if the SD card is there or not, the eMMC becomes always 
mmcblk1. And this is what we like to achieve here.

---
  arch/arm/boot/dts/imx6q-sabrelite.dts         |    5 +++++
  arch/arm/plat-mxc/include/mach/esdhc.h |    1 +
  drivers/mmc/card/block.c               |    6 ++++--
  drivers/mmc/host/sdhci-esdhc-imx.c     |   14 ++++++++++++++
  include/linux/mmc/host.h               |    3 +++
  5 files changed, 27 insertions(+), 2 deletions(-)

Index: a/arch/arm/boot/dts/imx6q-sabrelite.dts
===================================================================
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -18,6 +18,11 @@
  	model = "Freescale i.MX6 Quad sabrelite Sample Board";
  	compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";

+	aliases {
+		mmcblk0 = &usdhc1;
+		mmcblk1 = &usdhc3;
+	};
+
  	memory {
  		reg = <0x10000000 0x40000000>;
  	};
  	Index: freescale-linux-2.6-imx.git/drivers/mmc/host/sdhci-esdhc-imx.c
===================================================================
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -447,10 +447,21 @@ sdhci_esdhc_imx_probe_dt(struct platform
  			 struct esdhc_platform_data *boarddata)
  {
  	struct device_node *np = pdev->dev.of_node;
+	int ret;

  	if (!np)
  		return -ENODEV;

+	ret = of_alias_get_id(np, "mmcblk");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
+		return -ENODEV;
+	}
+
+	boarddata->devidx = ret;
+
  	if (of_get_property(np, "fsl,card-wired", NULL))
  		boarddata->cd_type = ESDHC_CD_PERMANENT;

@@ -581,6 +592,9 @@ static int __devinit sdhci_esdhc_imx_pro
  					host->mmc->parent->platform_data);
  	}

+	/* copy mmc block device index */
+	host->mmc->devidx = boarddata->devidx;
+
  	/* write_protect */
  	if (boarddata->wp_type == ESDHC_WP_GPIO) {
  		err = gpio_request_one(boarddata->wp_gpio, GPIOF_IN, "ESDHC_WP");
Index: a/arch/arm/plat-mxc/include/mach/esdhc.h
===================================================================
--- a/arch/arm/plat-mxc/include/mach/esdhc.h
+++ bt/arch/arm/plat-mxc/include/mach/esdhc.h
@@ -41,5 +41,6 @@ struct esdhc_platform_data {
  	enum wp_types wp_type;
  	enum cd_types cd_type;
  	int vdd_180;
+	unsigned int devidx;
  };
  #endif /* __ASM_ARCH_IMX_ESDHC_H */
Index: freescale-linux-2.6-imx.git/drivers/mmc/card/block.c
===================================================================
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1466,7 +1466,8 @@ static struct mmc_blk_data *mmc_blk_allo
  	struct mmc_blk_data *md;
  	int devidx, ret;

-	devidx = find_first_zero_bit(dev_use, max_devices);
+	devidx = find_next_zero_bit(dev_use, max_devices,
+			card->host->devidx);
  	if (devidx >= max_devices)
  		return ERR_PTR(-ENOSPC);
  	__set_bit(devidx, dev_use);
@@ -1484,7 +1485,8 @@ static struct mmc_blk_data *mmc_blk_allo
  	 * index anymore so we keep track of a name index.
  	 */
  	if (!subname) {
-		md->name_idx = find_first_zero_bit(name_use, max_devices);
+		md->name_idx = find_next_zero_bit(name_use, max_devices,
+				card->host->devidx);
  		__set_bit(md->name_idx, name_use);
  	} else
  		md->name_idx = ((struct mmc_blk_data *)
Index: a/include/linux/mmc/host.h
===================================================================
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -326,6 +326,9 @@ struct mmc_host {

  	unsigned int		actual_clock;	/* Actual HC clock rate */

+	/* preferred mmc block device index (mmcblkX) */
+	unsigned int		devidx;
+
  	unsigned long		private[0] ____cacheline_aligned;
  };

