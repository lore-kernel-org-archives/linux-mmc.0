From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 04/25] mmc: sdhci: Let drivers decide whether to use mmc_retune_needed() with pm
Date: Mon, 20 Mar 2017 19:50:32 +0200
Message-ID: <1490032253-6030-5-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21275 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756156AbdCTR6M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:12 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Devices might save and restore tuning values so that re-tuning might not be
needed after a pm transition.  Let drivers decide by pushing the
mmc_retune_needed() logic down to them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c      | 12 ++++++++++--
 drivers/mmc/host/sdhci-brcmstb.c   |  3 +++
 drivers/mmc/host/sdhci-esdhc-imx.c |  6 ++++++
 drivers/mmc/host/sdhci-of-arasan.c |  3 +++
 drivers/mmc/host/sdhci-of-at91.c   |  3 +++
 drivers/mmc/host/sdhci-of-esdhc.c  |  3 +++
 drivers/mmc/host/sdhci-pci-core.c  | 22 ++++++++++++++++++----
 drivers/mmc/host/sdhci-pci.h       |  2 ++
 drivers/mmc/host/sdhci-pltfm.c     |  3 +++
 drivers/mmc/host/sdhci-pxav3.c     |  5 +++++
 drivers/mmc/host/sdhci-s3c.c       |  6 ++++++
 drivers/mmc/host/sdhci-sirf.c      |  3 +++
 drivers/mmc/host/sdhci-spear.c     |  3 +++
 drivers/mmc/host/sdhci-st.c        |  6 +++++-
 drivers/mmc/host/sdhci.c           |  4 ----
 15 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 9dcb7048e3b1..665c5f3009b4 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -524,8 +524,12 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
 static int sdhci_acpi_suspend(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
+	struct sdhci_host *host = c->host;
 
-	return sdhci_suspend_host(c->host);
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
+	return sdhci_suspend_host(host);
 }
 
 static int sdhci_acpi_resume(struct device *dev)
@@ -544,8 +548,12 @@ static int sdhci_acpi_resume(struct device *dev)
 static int sdhci_acpi_runtime_suspend(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
+	struct sdhci_host *host = c->host;
+
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
 
-	return sdhci_runtime_suspend_host(c->host);
+	return sdhci_runtime_suspend_host(host);
 }
 
 static int sdhci_acpi_runtime_resume(struct device *dev)
diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 159f6f64c68e..242c5dc7a81e 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -29,6 +29,9 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	int res;
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	res = sdhci_suspend_host(host);
 	if (res)
 		return res;
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7123ef96ed18..cf666a03b812 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1322,6 +1322,9 @@ static int sdhci_esdhc_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	return sdhci_suspend_host(host);
 }
 
@@ -1346,6 +1349,9 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 
 	ret = sdhci_runtime_suspend_host(host);
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	if (!sdhci_sdio_irq_enabled(host)) {
 		clk_disable_unprepare(imx_data->clk_per);
 		clk_disable_unprepare(imx_data->clk_ipg);
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 1cfd7f900339..28feb5367c14 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -315,6 +315,9 @@ static int sdhci_arasan_suspend(struct device *dev)
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	ret = sdhci_suspend_host(host);
 	if (ret)
 		return ret;
diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 7fd964256faa..ce4ae21d5947 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -131,6 +131,9 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
 
 	ret = sdhci_runtime_suspend_host(host);
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	clk_disable_unprepare(priv->gck);
 	clk_disable_unprepare(priv->hclock);
 	clk_disable_unprepare(priv->mainck);
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d3aa67142839..ff37e7459386 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -528,6 +528,9 @@ static int esdhc_of_suspend(struct device *dev)
 
 	esdhc_proctl = sdhci_readl(host, SDHCI_HOST_CONTROL);
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	return sdhci_suspend_host(host);
 }
 
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 86560d590786..b7150e935fb6 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1653,6 +1653,7 @@ static int sdhci_pci_suspend(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
+	struct sdhci_host *host;
 	mmc_pm_flag_t slot_pm_flags;
 	mmc_pm_flag_t pm_flags = 0;
 	int i, ret;
@@ -1666,14 +1667,19 @@ static int sdhci_pci_suspend(struct device *dev)
 		if (!slot)
 			continue;
 
-		ret = sdhci_suspend_host(slot->host);
+		host = slot->host;
+
+		if (chip->pm_retune && host->tuning_mode != SDHCI_TUNING_MODE_3)
+			mmc_retune_needed(host->mmc);
+
+		ret = sdhci_suspend_host(host);
 
 		if (ret)
 			goto err_pci_suspend;
 
-		slot_pm_flags = slot->host->mmc->pm_flags;
+		slot_pm_flags = host->mmc->pm_flags;
 		if (slot_pm_flags & MMC_PM_WAKE_SDIO_IRQ)
-			sdhci_enable_irq_wakeups(slot->host);
+			sdhci_enable_irq_wakeups(host);
 
 		pm_flags |= slot_pm_flags;
 	}
@@ -1737,6 +1743,7 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
+	struct sdhci_host *host;
 	int i, ret;
 
 	chip = pci_get_drvdata(pdev);
@@ -1748,10 +1755,15 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
 		if (!slot)
 			continue;
 
-		ret = sdhci_runtime_suspend_host(slot->host);
+		host = slot->host;
 
+		ret = sdhci_runtime_suspend_host(host);
 		if (ret)
 			goto err_pci_runtime_suspend;
+
+		if (chip->rpm_retune &&
+		    host->tuning_mode != SDHCI_TUNING_MODE_3)
+			mmc_retune_needed(host->mmc);
 	}
 
 	if (chip->fixes && chip->fixes->suspend) {
@@ -2042,6 +2054,8 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 		chip->allow_runtime_pm = chip->fixes->allow_runtime_pm;
 	}
 	chip->num_slots = slots;
+	chip->pm_retune = true;
+	chip->rpm_retune = true;
 
 	pci_set_drvdata(pdev, chip);
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 36f743464fcc..e6e916b3361e 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -97,6 +97,8 @@ struct sdhci_pci_chip {
 	unsigned int		quirks;
 	unsigned int		quirks2;
 	bool			allow_runtime_pm;
+	bool			pm_retune;
+	bool			rpm_retune;
 	const struct sdhci_pci_fixes *fixes;
 
 	int			num_slots;	/* Slots on controller */
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index ad49bfaf5bf8..e090d8c42ddb 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -213,6 +213,9 @@ static int sdhci_pltfm_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	return sdhci_suspend_host(host);
 }
 
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 132670a612a0..22ed90433d29 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -527,6 +527,8 @@ static int sdhci_pxav3_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
 	pm_runtime_get_sync(dev);
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
 	ret = sdhci_suspend_host(host);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
@@ -560,6 +562,9 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	clk_disable_unprepare(pxa->clk_io);
 	if (!IS_ERR(pxa->clk_core))
 		clk_disable_unprepare(pxa->clk_core);
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 3e5c83d435ae..d02284da2ec6 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -743,6 +743,9 @@ static int sdhci_s3c_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	return sdhci_suspend_host(host);
 }
 
@@ -764,6 +767,9 @@ static int sdhci_s3c_runtime_suspend(struct device *dev)
 
 	ret = sdhci_runtime_suspend_host(host);
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	if (ourhost->cur_clk >= 0)
 		clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
 	clk_disable_unprepare(busclk);
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 5d068639dd3f..c251c6c0a112 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -237,6 +237,9 @@ static int sdhci_sirf_suspend(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	int ret;
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	ret = sdhci_suspend_host(host);
 	if (ret)
 		return ret;
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 255a896769b8..8c0f88428556 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -165,6 +165,9 @@ static int sdhci_suspend(struct device *dev)
 	struct spear_sdhci *sdhci = sdhci_priv(host);
 	int ret;
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	ret = sdhci_suspend_host(host);
 	if (!ret)
 		clk_disable(sdhci->clk);
diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index f8b3b919b947..9498c89eeae9 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -460,8 +460,12 @@ static int sdhci_st_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
-	int ret = sdhci_suspend_host(host);
+	int ret;
+
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
 
+	ret = sdhci_suspend_host(host);
 	if (ret)
 		goto out;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 642e1e4acdcf..c3c7df480a66 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2851,8 +2851,6 @@ int sdhci_suspend_host(struct sdhci_host *host)
 	sdhci_disable_card_detection(host);
 
 	mmc_retune_timer_stop(host->mmc);
-	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
-		mmc_retune_needed(host->mmc);
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
 		host->ier = 0;
@@ -2913,8 +2911,6 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 	unsigned long flags;
 
 	mmc_retune_timer_stop(host->mmc);
-	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
-		mmc_retune_needed(host->mmc);
 
 	spin_lock_irqsave(&host->lock, flags);
 	host->ier &= SDHCI_INT_CARD_INT;
-- 
1.9.1

