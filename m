From: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Subject: [PATCH v2 3/4] mmc: sdhci-pxa: Add SDHCI driver for PXA16x
Date: Sun, 17 Mar 2013 13:19:45 -0500
Message-ID: <1363544385-3798-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: zhangfei.gao@marvell.com, dwang4@marvell.com, njun@marvell.com, wuqm@marvell.com, prakity@marvell.com
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

PXA16x devices uses SDHCI controller v1. As it's not much different
than v2 controller, v1 driver is merged with sdhci-pxav2 driver

v2 - instead of having separate file sdhci-pxav1, merge code with
     sdhci-pxav2 driver code as suggested by Chris Ball

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 drivers/mmc/host/Kconfig                |    7 ++++---
 drivers/mmc/host/sdhci-pxav2.c          |   30 +++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                |    3 +++
 drivers/mmc/host/sdhci.h                |    1 +
 include/linux/platform_data/pxa_sdhci.h |    2 ++
 5 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e5faed8..875e2475 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -207,14 +207,15 @@ config MMC_SDHCI_PXAV3
 	  If unsure, say N.
 
 config MMC_SDHCI_PXAV2
-	tristate "Marvell PXA9XX SD Host Controller support (PXAV2)"
+	tristate "Marvell PXA16X/PXA9XX SD Host Controller support (PXAV1/V2)"
 	depends on CLKDEV_LOOKUP
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
 	default y if CPU_PXA910
+	default y if CPU_PXA168
 	help
-	  This selects the Marvell(R) PXAV2 SD Host Controller.
-	  If you have a PXA9XX platform with SD Host Controller
+	  This selects the Marvell(R) PXAV1/V2 SD Host Controller.
+	  If you have a PXA16X or PXA9XX platform with SD Host Controller
 	  and a card slot, say Y or M here.
 
 	  If unsure, say N.
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index ac854aa..5af7d46 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/delay.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
@@ -75,7 +76,13 @@ static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
 			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
 		}
 
-		if (pdata && (pdata->flags & PXA_FLAG_ENABLE_CLOCK_GATING)) {
+		if (pdata && pdata->pxav1_controller) {
+			/* no clock gating */
+			tmp = readw(host->ioaddr + SD_FIFO_PARAM);
+			tmp |= DIS_PAD_SD_CLK_GATE;
+			writew(tmp, host->ioaddr + SD_FIFO_PARAM);
+		} else if (pdata && (pdata->flags
+				& PXA_FLAG_ENABLE_CLOCK_GATING)) {
 			tmp = readw(host->ioaddr + SD_FIFO_PARAM);
 			tmp &= ~CLK_GATE_SETTING_BITS;
 			writew(tmp, host->ioaddr + SD_FIFO_PARAM);
@@ -118,6 +125,20 @@ static u32 pxav2_get_max_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk);
 }
 
+/*
+ * we cannot talk to controller for 8 bus cycles according to sdio spec
+ * at lowest speed this is 100,000 HZ per cycle or 800,000 cycles
+ * which is quite a LONG TIME on a fast cpu -- so delay if needed
+ */
+static void platform_specific_completion(struct sdhci_host *host)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+
+	if (host->clock < 3200000 && pdata && pdata->delay_in_ms)
+		mdelay(pdata->delay_in_ms);
+}
+
 static struct sdhci_ops pxav2_sdhci_ops = {
 	.get_max_clock = pxav2_get_max_clock,
 	.platform_reset_exit = pxav2_set_private_registers,
@@ -218,6 +239,13 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 			host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
+		if (pdata->pxav1_controller) {
+			host->quirks |=	SDHCI_QUIRK_NO_BUSY_IRQ
+					| SDHCI_QUIRK_32BIT_DMA_SIZE;
+			pxav2_sdhci_ops.platform_specific_completion
+				= platform_specific_completion;
+		}
+
 		if (pdata->quirks)
 			host->quirks |= pdata->quirks;
 		if (pdata->host_caps)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6f0bfc0..430eabd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1001,6 +1001,9 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
+	if (host->ops->platform_specific_completion)
+		host->ops->platform_specific_completion(host);
+
 	mod_timer(&host->timer, jiffies + 10 * HZ);
 
 	host->cmd = cmd;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a6d69b7..ef2efd3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -282,6 +282,7 @@ struct sdhci_ops {
 	void	(*platform_resume)(struct sdhci_host *host);
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
+	void	(*platform_specific_completion)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
index 27d3156..865a578 100644
--- a/include/linux/platform_data/pxa_sdhci.h
+++ b/include/linux/platform_data/pxa_sdhci.h
@@ -54,6 +54,8 @@ struct sdhci_pxa_platdata {
 	unsigned int	quirks;
 	unsigned int	quirks2;
 	unsigned int	pm_caps;
+	bool		pxav1_controller;  /* set if pxa168 */
+	unsigned int	delay_in_ms;
 };
 
 struct sdhci_pxa {
-- 
1.7.9.5

*************************************************************************************************************************************************************
eInfochips Business Disclaimer : This e-mail message and all attachments transmitted with it are intended solely for the use of the addressee and may contain legally privileged and confidential information. If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any dissemination, distribution, copying, or other use of this message or its attachments is strictly prohibited. If you have received this message in error, please notify the sender immediately by replying to this message and please delete it from your computer. Any views expressed in this message are those of the individual sender unless otherwise stated. Company has taken enough precautions to prevent the 
 spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
*************************************************************************************************************************************************************


---------------------------------------------------------------------------------------------
Notice: 
This message has been scanned by Trend Micro Mail Security scanner and is believed to be clean
---------------------------------------------------------------------------------------------
