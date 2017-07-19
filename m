From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 6/6] mmc: sdhci: remove CONFIG_MMC_DEBUG from the driver
Date: Wed, 19 Jul 2017 15:55:49 +0800
Message-ID: <1500450949-206953-5-git-send-email-shawn.lin@rock-chips.com>
References: <1500450661-158463-1-git-send-email-shawn.lin@rock-chips.com>
 <1500450949-206953-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:45716 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbdGSH5R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jul 2017 03:57:17 -0400
In-Reply-To: <1500450949-206953-1-git-send-email-shawn.lin@rock-chips.com>
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

On the other, folks may be interested in checking some registers
at probe time. So we remove the sdhci_dumpregs from __sdhci_add_host
and print some really useful registers in sdhci_setup_host.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- rework the changes for sdhci suggested by Adrian

 drivers/mmc/host/sdhci.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d43..cf2166e 100644
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
@@ -3230,6 +3226,13 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
+	DBG("Version:   0x%08x | Present:  0x%08x\n",
+	    sdhci_readw(host, SDHCI_HOST_VERSION),
+	    sdhci_readl(host, SDHCI_PRESENT_STATE));
+	DBG("Caps:      0x%08x | Caps_1:   0x%08x\n",
+	    sdhci_readl(host, SDHCI_CAPABILITIES),
+	    sdhci_readl(host, SDHCI_CAPABILITIES_1));
+
 	sdhci_read_caps(host);
 
 	override_timeout_clk = host->timeout_clk;
@@ -3747,10 +3750,6 @@ int __sdhci_add_host(struct sdhci_host *host)
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


