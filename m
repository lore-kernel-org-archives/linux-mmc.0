From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/3] tmio: add a platform flag to disable card write-protection
 detection
Date: Tue, 11 May 2010 11:52:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005111150500.6810@axis700.grange>
References: <Pine.LNX.4.64.1005111146330.6810@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42760 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932423Ab0EKJw2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 May 2010 05:52:28 -0400
In-Reply-To: <Pine.LNX.4.64.1005111146330.6810@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org

Write-protection status is not always available, e.g., micro-SD cards do not
have a write-protection switch at all. This patch adds a flag to let platforms
force tmio_mmc to consider the card writable.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.c |    5 ++++-
 include/linux/mfd/tmio.h    |    4 ++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 7e79ba4..11c19b0 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -640,8 +640,11 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 static int tmio_mmc_get_ro(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct mfd_cell	*cell = host->pdev->dev.platform_data;
+	struct tmio_mmc_data *pdata = cell->driver_data;
 
-	return (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT) ? 0 : 1;
+	return ((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
+		(sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT)) ? 0 : 1;
 }
 
 static const struct mmc_host_ops tmio_mmc_ops = {
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 360fc95..feeed0b 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -50,6 +50,9 @@
 		tmio_iowrite16((val) >> 16, (base) + ((reg + 2) << (shift))); \
 	} while (0)
 
+/* tmio MMC platform flags */
+#define TMIO_MMC_WRPROTECT_DISABLE	(1 << 0)
+
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
 void tmio_core_mmc_pwr(void __iomem *cnf, int shift, int state);
@@ -66,6 +69,7 @@ struct tmio_mmc_dma {
 struct tmio_mmc_data {
 	unsigned int			hclk;
 	unsigned long			capabilities;
+	unsigned long			flags;
 	struct tmio_mmc_dma		*dma;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
-- 
1.6.2.4
