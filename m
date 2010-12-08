From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH V3 3/3 ] mmc: add support for H/W clock gating of SD
	controller (resend)
Date: Tue, 7 Dec 2010 16:20:36 -0800
Message-ID: <4024F858-A92E-4DCC-8615-528BF48939D2@marvell.com>
References: <5017B261-76AC-428D-BAC2-8E1BBEB09A49@marvell.com>
 <20101208001618.GA3338@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:39377 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754013Ab0LHAcE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Dec 2010 19:32:04 -0500
In-Reply-To: <20101208001618.GA3338@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Mark Brown <markb@marvell.com>


>From 4f521dd851066e6f65cbf3b866502a2a308eb980 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Tue, 7 Dec 2010 09:05:39 -0800
Subject: [PATCH V2] sdhci: support H/W clock gating in Marvell PXA driver

This code is based on sdhci-pxa in mmc-next on Dec 2, 2010.

If cpu_is_mmp2() then enable MMC capability MMC_CAP_HW_CLOCK_GATING

Code may need changing based on the ongoing work on sdhci-pxa but since that
code is NOT in mmc-next better to have something that can work.

This code tested on Marvell Linux

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 5a61208..5cf47fd 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <plat/sdhci.h>
+#include <mach/cputype.h>
 #include "sdhci.h"
 
 #define DRIVER_NAME	"sdhci-pxa"
@@ -46,10 +47,27 @@ struct sdhci_pxa {
  * SDHCI core callbacks                                                      *
  *                                                                           *
 \*****************************************************************************/
+#ifdef CONFIG_MMC_CLKGATE
+static void hardware_clk_gating(struct sdhci_host *host)
+{
+	unsigned short tmp;
+	int enable;
+
+	enable = host->mmc->clk_gated;
+	tmp = readw(host->ioaddr + SD_FIFO_PARAM);
+
+	if (enable)
+		tmp &= ~DIS_PAD_SD_CLK_GATE;
+	else
+		tmp |= DIS_PAD_SD_CLK_GATE;
+
+	writew(tmp, host->ioaddr + SD_FIFO_PARAM);
+}
+#endif
+
 static void set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pxa *pxa = sdhci_priv(host);
-	u32 tmp = 0;
 
 	if (clock == 0) {
 		if (pxa->clk_enable) {
@@ -58,11 +76,6 @@ static void set_clock(struct sdhci_host *host, unsigned int clock)
 		}
 	} else {
 		if (0 == pxa->clk_enable) {
-			if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
-				tmp = readl(host->ioaddr + SD_FIFO_PARAM);
-				tmp |= DIS_PAD_SD_CLK_GATE;
-				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
-			}
 			clk_enable(pxa->clk);
 			pxa->clk_enable = 1;
 		}
@@ -71,6 +84,9 @@ static void set_clock(struct sdhci_host *host, unsigned int clock)
 
 static struct sdhci_ops sdhci_pxa_ops = {
 	.set_clock = set_clock,
+#ifdef CONFIG_MMC_CLKGATE
+	.platform_hw_clk_gate =  hardware_clk_gating,
+#endif
 };
 
 /*****************************************************************************\
@@ -145,6 +161,11 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
+#ifdef CONFIG_MMC_CLKGATE
+	if (cpu_is_mmp2())
+		host->mmc->caps |= MMC_CAP_HW_CLOCK_GATING;
+#endif
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
-- 
1.6.0.4




On Dec 7, 2010, at 4:16 PM, Chris Ball wrote:

> Hi Philip,
> 
> On Tue, Dec 07, 2010 at 02:46:25PM -0800, Philip Rakity wrote:
>> 8 bit width support dependency removed.  Code applies directly to mmc-next
>> Patches 2/3 and 3/3 unchanged
> 
> The submitted patches 2/3 and 3/3 are identical -- is there a separate
> third patch that's unsent so far, or did you mean to send only two?
> 
> Thanks,
> 
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

