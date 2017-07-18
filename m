From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 6/6] mmc: sdhci: remove CONFIG_MMC_DEBUG from the driver
Date: Tue, 18 Jul 2017 17:01:43 +0800
Message-ID: <1500368503-160501-2-git-send-email-shawn.lin@rock-chips.com>
References: <1500368376-160272-1-git-send-email-shawn.lin@rock-chips.com>
 <1500368503-160501-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:46244 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdGRJCd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jul 2017 05:02:33 -0400
In-Reply-To: <1500368503-160501-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

sdhci uses CONFIG_MMC_DEBUG for showing ADMA descriptor
when occurring ADMA error. And it's also used to  dump the
registers whenever calling sdhci_add_host.

On one hand, I don't see any burden to always print the state
ADMA descriptor as it's rare and will help folks better understand
what was happening when seeing ADMA error.

On the other, git-blame points out that CONFIG_MMC_DEBUG for
sdhci_add_host was added since it's merged for the first time.
I don't know what exactly the intention was, but I guess folks
don't need it at all? IMHO, it's another all-or-none proposition.
I'd prefer to remove this sdhci_dumpregs from sdhci_add_host totally.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/sdhci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d43..82f1761 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2502,7 +2502,6 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 		sdhci_finish_command(host);
 }
 
-#ifdef CONFIG_MMC_DEBUG
 static void sdhci_adma_show_error(struct sdhci_host *host)
 {
 	void *desc = host->adma_table;
@@ -2530,9 +2529,6 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
 			break;
 	}
 }
-#else
-static void sdhci_adma_show_error(struct sdhci_host *host) { }
-#endif
 
 static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 {
@@ -3747,10 +3743,6 @@ int __sdhci_add_host(struct sdhci_host *host)
 		goto untasklet;
 	}
 
-#ifdef CONFIG_MMC_DEBUG
-	sdhci_dumpregs(host);
-#endif
-
 	ret = sdhci_led_register(host);
 	if (ret) {
 		pr_err("%s: Failed to register LED device: %d\n",
-- 
1.9.1


