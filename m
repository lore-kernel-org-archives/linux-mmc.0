From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/5] mmc: sdhi: Add write16_hook
Date: Mon, 20 Jun 2011 15:06:53 +0900
Message-ID: <1308550015-15717-4-git-send-email-horms@verge.net.au>
References: <1308550015-15717-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:35755 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab1FTGHJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 02:07:09 -0400
In-Reply-To: <1308550015-15717-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>, Simon Horman <horms@verge.net.au>

Some controllers require waiting for the bus to become idle
before writing to some registers. I have implemented this
by adding a hook to sd_ctrl_write16() and implementing
a hook for SDHI which waits for the bus to become idle.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

Dependenvies: "mmc: tmio: Share register access functions"
---
 drivers/mmc/host/sh_mobile_sdhi.c |   34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h       |    2 ++
 include/linux/mfd/tmio.h          |    8 ++++++++
 include/linux/mmc/tmio.h          |    1 +
 4 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index b365429..6c56453 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -27,6 +27,8 @@
 #include <linux/mfd/tmio.h>
 #include <linux/sh_dma.h>
 
+#include <asm/delay.h>
+
 #include "tmio_mmc.h"
 
 struct sh_mobile_sdhi {
@@ -55,6 +57,37 @@ static int sh_mobile_sdhi_get_cd(struct platform_device *pdev)
 		return -ENOSYS;
 }
 
+static void sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
+{
+	int timeout = 1000;
+
+	while (--timeout && !(sd_ctrl_read16(host, CTL_STATUS2) & (1 << 13)))
+		udelay(1);
+
+	if (!timeout)
+		dev_warn(host->pdata->dev, "timeout waiting for SD bus idle\n");
+
+}
+
+static void sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
+{
+	if (!(host->pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
+		return;
+
+	switch (addr)
+	{
+	case CTL_SD_CMD:
+	case CTL_STOP_INTERNAL_ACTION:
+	case CTL_XFER_BLK_COUNT:
+	case CTL_SD_CARD_CLK_CTL:
+	case CTL_SD_XFER_LEN:
+	case CTL_SD_MEM_CARD_OPT:
+	case CTL_TRANSACTION_CTL:
+	case CTL_DMA_ENABLE:
+		sh_mobile_sdhi_wait_idle(host);
+	}
+}
+
 static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_sdhi *priv;
@@ -86,6 +119,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
+	mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
 	if (p) {
 		mmc_data->flags = p->tmio_flags;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 0c22df0..5912cf3 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -153,6 +153,8 @@ static inline u32 sd_ctrl_read32(struct tmio_mmc_host *host, int addr)
 
 static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val)
 {
+	if (host->pdata->write16_hook)
+		host->pdata->write16_hook(host, addr);
 	writew(val, host->ctl + (addr << host->bus_shift));
 }
 
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 5a90266..dc5db86 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -68,6 +68,11 @@
  * controller and report the event to the driver.
  */
 #define TMIO_MMC_HAS_COLD_CD		(1 << 3)
+/*
+ * Some controllers require waiting for the SD bus to become
+ * idle before writing to some registers.
+ */
+#define TMIO_MMC_HAS_IDLE_WAIT		(1 << 4)
 
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
@@ -80,6 +85,8 @@ struct tmio_mmc_dma {
 	int alignment_shift;
 };
 
+struct tmio_mmc_host;
+
 /*
  * data for the MMC controller
  */
@@ -94,6 +101,7 @@ struct tmio_mmc_data {
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 	int (*get_cd)(struct platform_device *host);
+	void (*write16_hook)(struct tmio_mmc_host *host, int addr);
 };
 
 static inline void tmio_mmc_cd_wakeup(struct tmio_mmc_data *pdata)
diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
index 0a6e40d..f235757 100644
--- a/include/linux/mmc/tmio.h
+++ b/include/linux/mmc/tmio.h
@@ -21,6 +21,7 @@
 #define CTL_XFER_BLK_COUNT 0xa
 #define CTL_RESPONSE 0x0c
 #define CTL_STATUS 0x1c
+#define CTL_STATUS2 0x1e
 #define CTL_IRQ_MASK 0x20
 #define CTL_SD_CARD_CLK_CTL 0x24
 #define CTL_SD_XFER_LEN 0x26
-- 
1.7.4.4

