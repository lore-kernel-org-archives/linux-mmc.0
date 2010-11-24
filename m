From: Philip Rakity <prakity@marvell.com>
Subject: [RFC] sdhc-pxa : mmp2 : Send 74 clocks when device powers up
Date: Tue, 23 Nov 2010 17:02:44 -0800
Message-ID: <1AA1F483-D811-46C1-9637-4B63710BF4F0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57552 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755504Ab0KXBIc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Nov 2010 20:08:32 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <markb@marvell.com>

Resent -- now plain text

MMC spec calls for the host to send 74 clocks to the card
during initialization, right after voltage stabilization.
the mmp2 controller does not start the clock when the clock
is enabled but does provide a way to generate the clocks by
programming the hardware.

Turning ON the clock does NOT do ensure this happens on MMP2 - Aspen (pxa168) - Tavor. 
Turning on the clock only ensure that when the first cmd is sent that the clock will 
be turned on.


Submitted as a RFC as I do not have a way to test this code using mmc-next.  
Code tested in marvell mmp2 linux environment.

Signed-off-by: Philip Rakity <prakity@marvell.com>

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 5a61208..bc83075 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -25,13 +25,21 @@
#include <linux/io.h>
#include <linux/err.h>
#include <plat/sdhci.h>
+#include <mach/cputype.h>
#include "sdhci.h"

#define DRIVER_NAME	"sdhci-pxa"

+#define SD_CFG_FIFO_PARAM	0x100
+#define  SDCFG_GEN_PAD_CLK_ON	(1<<6)
+
#define SD_FIFO_PARAM		0x104
#define DIS_PAD_SD_CLK_GATE	0x400

+#define SD_CE_ATA_2		0x10E
+#define  SDCE_MISC_INT_EN	(1<<1)
+#define  SDCE_MISC_INT		(1<<2)
+
struct sdhci_pxa {
	struct sdhci_host		*host;
	struct sdhci_pxa_platdata	*pdata;
@@ -39,6 +47,11 @@ struct sdhci_pxa {
	struct resource			*res;

	u8 clk_enable;
+	u8 power_mode;
+};
+
+static struct sdhci_ops sdhci_mmc_ops = {
+	.platform_send_init_74_clocks = NULL,
};

/*****************************************************************************\
@@ -73,6 +86,60 @@ static struct sdhci_ops sdhci_pxa_ops = {
	.set_clock = set_clock,
};

+/*
+ * MMC spec calls for the host to send 74 clocks to the card
+ * during initialization, right after voltage stabilization.
+ * the mmp2 controller does not start the clock when the clock
+ * is enabled but does provide a way to generate the clocks by
+ * programming the hardware.
+ */
+static void generate_init_clocks_mmp2(struct sdhci_host *host, u8 power_mode)
+{
+	struct sdhci_pxa *pxa = sdhci_priv(host);
+	u16 tmp;
+	int count;
+
+	if (pxa->power_mode == MMC_POWER_UP
+	&& power_mode == MMC_POWER_ON) {
+
+		/*
+		 * set we want notice of when 74 clocks are sent
+		 * (NOT an interrupt -- just a h/w flag that flips)
+		 */
+		tmp = readw(host->ioaddr + SD_CE_ATA_2);
+		tmp |= SDCE_MISC_INT_EN;
+		writew(tmp, host->ioaddr + SD_CE_ATA_2);
+
+		/* start sending the 74 clocks */
+		tmp = readw(host->ioaddr + SD_CFG_FIFO_PARAM);
+		tmp |= SDCFG_GEN_PAD_CLK_ON;
+		writew(tmp, host->ioaddr + SD_CFG_FIFO_PARAM);
+
+		/* slowest speed is about 100KHz or 10usec per clock */
+		udelay (740);
+		count = 0;
+#define MAX_WAIT_COUNT	5
+		while (count++ < MAX_WAIT_COUNT)
+		{
+			/* check if hardware has indicated clocks sent */
+			if ((readw(host->ioaddr + SD_CE_ATA_2) & SDCE_MISC_INT) == 0)
+				break;
+			udelay(10);
+		}
+
+		/* keep going if error -- could be okay */
+		if (count == MAX_WAIT_COUNT)
+			printk (KERN_WARNING "%s: %s: 74 clock interrupt not"
+				"cleared\n",
+				__func__,
+				mmc_hostname(host->mmc));
+		/* clear the interrupt bit if posted */
+		tmp = readw(host->ioaddr + SD_CE_ATA_2);
+		tmp |= SDCE_MISC_INT;
+		writew(tmp, host->ioaddr + SD_CE_ATA_2);
+	}
+	pxa->power_mode = power_mode;
+}
/*****************************************************************************\
 *                                                                           *
 * Device probing/removal                                                    *
@@ -145,6 +212,10 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
		host->mmc->caps |= MMC_CAP_8_BIT_DATA;

+	if (cpu_is_mmp2())
+		sdhci_mmc_ops.platform_send_init_74_clocks =
+			generate_init_clocks_mmp2;
+
	ret = sdhci_add_host(host);
	if (ret) {
		dev_err(&pdev->dev, "failed to add host\n");