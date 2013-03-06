From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v3 3/3] mmc: sdhci: update check code for cd-broken or nonremovable card
Date: Wed,  6 Mar 2013 11:29:02 +0800
Message-ID: <1362540542-28995-4-git-send-email-kliu5@marvell.com>
References: <1362540542-28995-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39600 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755042Ab3CFD2i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Mar 2013 22:28:38 -0500
In-Reply-To: <1362540542-28995-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

card present check in function sdhci_request:
1. If quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION is selected, there is no
card detection available and polling must be used. Gpio detect must
_not_ be supported under this case.
Change the sequence to check SDHCI_QUIRK_BROKEN_CARD_DETECTION first,
which make code more clear.
2. nonremovable card should be also assumed always present.
3. change to call sdhci_do_get_cd directly

check in function sdhci_enable_irq_wakeups:
1. nonremovable card should be also assumed _no_ insert/remove wakeup
needed like some sdio cards which is nonremovable and can wakeup host
only by card int.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8b21d28..5c0a55f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -54,6 +54,7 @@ static void sdhci_finish_command(struct sdhci_host *);
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_tuning_timer(unsigned long data);
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
+static int sdhci_do_get_cd(struct sdhci_host *host);
 
 #ifdef CONFIG_PM_RUNTIME
 static int sdhci_runtime_pm_get(struct sdhci_host *host);
@@ -1337,22 +1338,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
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
-			present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
-					SDHCI_CARD_PRESENT;
-	}
+	present = sdhci_do_get_cd(host);
 
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		host->mrq->cmd->error = -ENOMEDIUM;
@@ -2505,7 +2491,8 @@ void sdhci_enable_irq_wakeups(struct sdhci_host *host)
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

