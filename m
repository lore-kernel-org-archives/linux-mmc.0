From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/5] mmc: sdhi: Add write16_hook
Date: Tue, 21 Jun 2011 08:00:10 +0900
Message-ID: <1308610812-3479-4-git-send-email-horms@verge.net.au>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1308610812-3479-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Some controllers require waiting for the bus to become idle
before writing to some registers. I have implemented this
by adding a hook to sd_ctrl_write16() and implementing
a hook for SDHI which waits for the bus to become idle.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

Dependencies: "mmc: tmio: Share register access functions"

v2:
* Include linux/delay.h instead of asm/delay.h
* Skip write if sh_mobile_sdhi_wait_idle() times out
  - The bus will probably be in an inconsistent state and writing
    may lock up the bus
* Only set hook if TMIO_MMC_HAS_IDLE_WAIT is set in platform data
  rather than checking for TMIO_MMC_HAS_IDLE_WAIT each time the
  hook is called.
---
 drivers/mmc/host/sh_mobile_sdhi.c |   36 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h       |    5 +++++
 include/linux/mfd/tmio.h          |    8 ++++++++
 include/linux/mmc/tmio.h          |    1 +
 4 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index b365429..c8b1f6b 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -26,6 +26,7 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/sh_dma.h>
+#include <linux/delay.h>
 
 #include "tmio_mmc.h"
 
@@ -55,6 +56,39 @@ static int sh_mobile_sdhi_get_cd(struct platform_device *pdev)
 		return -ENOSYS;
 }
 
+static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
+{
+	int timeout = 1000;
+
+	while (--timeout && !(sd_ctrl_read16(host, CTL_STATUS2) & (1 << 13)))
+		udelay(1);
+
+	if (!timeout) {
+		dev_warn(host->pdata->dev, "timeout waiting for SD bus idle\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
+{
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
+		return sh_mobile_sdhi_wait_idle(host);
+	}
+
+	return 0;
+}
+
 static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_sdhi *priv;
@@ -86,6 +120,8 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
+	if (mmc_data->flags & TMIO_MMC_HAS_IDLE_WAIT)
+		mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
 	if (p) {
 		mmc_data->flags = p->tmio_flags;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 0c22df0..211ef6e 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -153,6 +153,11 @@ static inline u32 sd_ctrl_read32(struct tmio_mmc_host *host, int addr)
 
 static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val)
 {
+	/* If there is a hook and it returns non-zero then there
+	 * is an error and the write should be skipped
+	 */
+	if (host->pdata->write16_hook && host->pdata->write16_hook(host, addr))
+		return;
 	writew(val, host->ctl + (addr << host->bus_shift));
 }
 
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 5a90266..0dc9804 100644
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
+	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
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

