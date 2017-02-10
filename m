From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 35/39] mmc: sdhci-pci: Conditionally compile pm sleep functions
Date: Fri, 10 Feb 2017 14:55:48 +0200
Message-ID: <1486731352-8018-36-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:63278 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751956AbdBJNXr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:23:47 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

It is confusing to have some parts of suspend / resume under conditional
compilation and some parts not. Use conditional compilation everywhere.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c    | 10 ++++++++++
 drivers/mmc/host/sdhci-pci-o2micro.c |  2 ++
 drivers/mmc/host/sdhci-pci.h         |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index cdf959bb782e..6ea6a5bce7ac 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -71,6 +71,7 @@ static int ricoh_mmc_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
 {
 	/* Apply a delay to allow controller to settle */
@@ -79,6 +80,7 @@ static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
 	msleep(500);
 	return 0;
 }
+#endif
 
 static const struct sdhci_pci_fixes sdhci_ricoh = {
 	.probe		= ricoh_probe,
@@ -89,7 +91,9 @@ static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
 
 static const struct sdhci_pci_fixes sdhci_ricoh_mmc = {
 	.probe_slot	= ricoh_mmc_probe_slot,
+#ifdef CONFIG_PM_SLEEP
 	.resume		= ricoh_mmc_resume,
+#endif
 	.quirks		= SDHCI_QUIRK_32BIT_DMA_ADDR |
 			  SDHCI_QUIRK_CLOCK_BEFORE_RESET |
 			  SDHCI_QUIRK_NO_CARD_NO_RESET |
@@ -715,6 +719,7 @@ static void jmicron_remove_slot(struct sdhci_pci_slot *slot, int dead)
 		jmicron_enable_mmc(slot->host, 0);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int jmicron_suspend(struct sdhci_pci_chip *chip)
 {
 	int i;
@@ -746,13 +751,16 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
 
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
@@ -761,8 +769,10 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
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
index fcf0f04cb90d..47869bc20c59 100644
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
 };
-- 
1.9.1

