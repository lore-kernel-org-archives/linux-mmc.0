From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v2] mmc: sdhci: update check code for cd-broken or nonremovable card
Date: Fri,  1 Mar 2013 17:40:29 +0800
Message-ID: <1362130829-4677-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:57857 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221Ab3CAJkB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Mar 2013 04:40:01 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

in function sdhci_request:
1. If quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION is selected, there is no
card detection available and polling must be used. Gpio detect must
_not_ be supported under this case.
Change the sequence to check SDHCI_QUIRK_BROKEN_CARD_DETECTION first,
which make code more clear.
2. nonremovable card should be also assumed always present.

in function sdhci_enable_irq_wakeups:
1. nonremovable card should be also assumed no insert/remove wakeup
needed like some sdio cards which is nonremovable and can wakeup host
only by card int.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c94fd6c..e4ada0d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1337,19 +1337,20 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	host->mrq = mrq;
 
-	/*
-	 * Firstly check card presence from cd-gpio.  The return could
-	 * be one of the following possibilities:
-	 *     negative: cd-gpio is not available
-	 *     zero: cd-gpio is used, and card is removed
-	 *     one: cd-gpio is used, and card is present
-	 */
-	present = mmc_gpio_get_cd(host->mmc);
-	if (present < 0) {
-		/* If polling, assume that the card is always present. */
-		if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
-			present = 1;
-		else
+	/* If polling/nonremovable, assume that the card is always present. */
+	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
+			(host->mmc->caps & MMC_CAP_NONREMOVABLE)) {
+		present = 1;
+	} else {
+		/*
+		 * Firstly check card presence from cd-gpio.  The return could
+		 * be one of the following possibilities:
+		 *     negative: cd-gpio is not available
+		 *     zero: cd-gpio is used, and card is removed
+		 *     one: cd-gpio is used, and card is present
+		 */
+		present = mmc_gpio_get_cd(host->mmc);
+		if (IS_ERR_VALUE(present))
 			present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
 					SDHCI_CARD_PRESENT;
 	}
@@ -2504,7 +2505,8 @@ void sdhci_enable_irq_wakeups(struct sdhci_host *host)
 	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
 	val |= mask ;
 	/* Avoid fake wake up */
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
+			(host->mmc->caps & MMC_CAP_NONREMOVABLE))
 		val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 }
-- 
1.7.9.5

