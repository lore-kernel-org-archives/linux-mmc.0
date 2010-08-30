From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH v2] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Mon, 30 Aug 2010 11:50:19 +0100
Message-ID: <6c0f551ff67fb9f67f4b565fbe4ffdc1f4c8bc49.1283164379.git.matt@console-pimps.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:55597 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751447Ab0H3KuV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2010 06:50:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Arnd Hannemann <arnd@arndnet.de>, Samuel Ortiz <sameo@linux.intel.com>, Ian Molton <ian@mnementh.co.uk>

From: Yusuke Goda <yusuke.goda.sx@renesas.com>

Adjust the tmio_mmc block size check to accept 2-byte requests in 4-bit
mode if the hardware supports it.

Tested with the SDHI hardware block included in sh7724.

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Matt Fleming <matt@console-pimps.org>
---

Andrew, I've added some code to Yusuke's original patch based on
feedback from Ian Molton saying that the original change didn't work on
his hardware. I'd really prefer some Tested-by's and Acked-by's before
you take this patch just so we can make sure that everybody is happy and
that everybody's hardware still works.

Magnus was worried that this patch would conflict with the SDHI/MMCIF
hotplug patches from Arnd (particularly "[PATCH 1/4] tmio_mmc: Allow the
mfd driver to specify get_cd handler") but I seem to be able to shuffle
the patches around without any conflicts.

 drivers/mfd/sh_mobile_sdhi.c |    6 ++++++
 drivers/mmc/host/tmio_mmc.c  |   17 ++++++++++++-----
 include/linux/mfd/tmio.h     |    5 +++++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
index 7c23630..9d43316 100644
--- a/drivers/mfd/sh_mobile_sdhi.c
+++ b/drivers/mfd/sh_mobile_sdhi.c
@@ -125,6 +125,12 @@ static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->capabilities |= p->tmio_caps;
 	}
 
+	/*
+	 * All SDHI blocks support 2-byte and larger block sizes in 4-bit
+	 * bus width mode.
+	 */
+	mmc_data->flags |= TMIO_MMC_BLKSZ_2BYTES;
+
 	if (p && p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
 		priv->param_tx.slave_id = p->dma_slave_tx;
 		priv->param_rx.slave_id = p->dma_slave_rx;
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 1a47221..e7765a8 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -658,14 +658,21 @@ static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	struct mmc_data *data)
 {
+	struct mfd_cell *cell = host->pdev->dev.platform_data;
+	struct tmio_mmc_data *pdata = cell->driver_data;
+
 	pr_debug("setup data transfer: blocksize %08x  nr_blocks %d\n",
 		 data->blksz, data->blocks);
 
-	/* Hardware cannot perform 1 and 2 byte requests in 4 bit mode */
-	if (data->blksz < 4 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
-		pr_err("%s: %d byte block unsupported in 4 bit mode\n",
-		       mmc_hostname(host->mmc), data->blksz);
-		return -EINVAL;
+	/* Some hardware cannot perform 2 byte requests in 4 bit mode */
+	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
+		int blksz_2bytes = pdata->flags & TMIO_MMC_BLKSZ_2BYTES;
+
+		if (data->blksz < 2 || (data->blksz < 4 && !blksz_2bytes)) {
+			pr_err("%s: %d byte block unsupported in 4 bit mode\n",
+			       mmc_hostname(host->mmc), data->blksz);
+			return -EINVAL;
+		}
 	}
 
 	tmio_mmc_init_sg(host, data);
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 24c43bb..085f041 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -52,6 +52,11 @@
 
 /* tmio MMC platform flags */
 #define TMIO_MMC_WRPROTECT_DISABLE	(1 << 0)
+/*
+ * Some controllers can support a 2-byte block size when the bus width
+ * is configured in 4-bit mode.
+ */
+#define TMIO_MMC_BLKSZ_2BYTES		(1 << 1)
 
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
-- 
1.7.1

