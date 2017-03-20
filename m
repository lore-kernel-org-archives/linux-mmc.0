From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 22/25] mmc: sdhci-pci: Conditionally compile pm sleep functions
Date: Mon, 20 Mar 2017 19:50:50 +0200
Message-ID: <1490032253-6030-23-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14086 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756313AbdCTR6j (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:39 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

It is confusing to have some parts of suspend / resume under conditional
compilation and some parts not. Use conditional compilation everywhere.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c    | 10 ++++++++++
 drivers/mmc/host/sdhci-pci-o2micro.c |  2 ++
 drivers/mmc/host/sdhci-pci.h         |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 7e8163affb26..47a3965dff4d 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -67,6 +67,7 @@ static int ricoh_mmc_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
 {
 	/* Apply a delay to allow controller to settle */
@@ -75,6 +76,7 @@ static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
 	msleep(500);
 	return 0;
 }
+#endif
 
 static const struct sdhci_pci_fixes sdhci_ricoh = {
 	.probe		= ricoh_probe,
@@ -85,7 +87,9 @@ static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
 
 static const struct sdhci_pci_fixes sdhci_ricoh_mmc = {
 	.probe_slot	= ricoh_mmc_probe_slot,
+#ifdef CONFIG_PM_SLEEP
 	.resume		= ricoh_mmc_resume,
+#endif
 	.quirks		= SDHCI_QUIRK_32BIT_DMA_ADDR |
 			  SDHCI_QUIRK_CLOCK_BEFORE_RESET |
 			  SDHCI_QUIRK_NO_CARD_NO_RESET |
@@ -751,6 +755,7 @@ static void jmicron_remove_slot(struct sdhci_pci_slot *slot, int dead)
 		jmicron_enable_mmc(slot->host, 0);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int jmicron_suspend(struct sdhci_pci_chip *chip)
 {
 	int i;
@@ -782,13 +787,16 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
 
 	return 0;
 }
+#endif
 
 static const struct sdhci_pci_fixes sdhci_o2 = {
 	.probe = sdhci_pci_o2_probe,
 	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
 	.probe_slot = sdhci_pci_o2_probe_slot,
+#ifdef CONFIG_PM_SLEEP
 	.resume = sdhci_pci_o2_resume,
+#endif
 };
 
 static const struct sdhci_pci_fixes sdhci_jmicron = {
@@ -797,8 +805,10 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
 	.probe_slot	= jmicron_probe_slot,
 	.remove_slot	= jmicron_remove_slot,
 
+#ifdef CONFIG_PM_SLEEP
 	.suspend	= jmicron_suspend,
 	.resume		= jmicron_resume,
+#endif
 };
 
 /* SysKonnect CardBus2SDIO extra registers */
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index d48f03104b5b..0ea34e2c7cba 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -384,8 +384,10 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
 {
 	sdhci_pci_o2_probe(chip);
 	return 0;
 }
+#endif
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index d53dccb0f416..e70a27058e0b 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -67,8 +67,10 @@ struct sdhci_pci_fixes {
 	int			(*add_host) (struct sdhci_pci_slot *);
 	void			(*remove_slot) (struct sdhci_pci_slot *, int);
 
+#ifdef CONFIG_PM_SLEEP
 	int			(*suspend) (struct sdhci_pci_chip *);
 	int			(*resume) (struct sdhci_pci_chip *);
+#endif
 
 	const struct sdhci_ops	*ops;
 	size_t			priv_size;
-- 
1.9.1

