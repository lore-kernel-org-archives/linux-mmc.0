From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 07/25] mmc: sdhci-pci: Use ACPI DSM to get driver strength for some Intel devices
Date: Mon, 20 Mar 2017 19:50:35 +0200
Message-ID: <1490032253-6030-8-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:11877 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756085AbdCTR6M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:12 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Make use  of an Intel ACPI _DSM that provides eMMC driver strength.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 77 +++++++--------------------------------
 drivers/mmc/host/sdhci-pci-data.c |  3 --
 2 files changed, 14 insertions(+), 66 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 3564327c9c7b..351920f4ec42 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -261,11 +261,13 @@ static int mfd_sdio_probe_slot(struct sdhci_pci_slot *slot)
 
 enum {
 	INTEL_DSM_FNS		=  0,
+	INTEL_DSM_DRV_STRENGTH	=  9,
 	INTEL_DSM_D3_RETUNE	= 10,
 };
 
 struct intel_host {
 	u32	dsm_fns;
+	int	drv_strength;
 	bool	d3_retune;
 };
 
@@ -326,6 +328,9 @@ static void intel_dsm_init(struct intel_host *intel_host, struct device *dev,
 	pr_debug("%s: DSM function mask %#x\n",
 		 mmc_hostname(mmc), intel_host->dsm_fns);
 
+	err = intel_dsm(intel_host, dev, INTEL_DSM_DRV_STRENGTH, &val);
+	intel_host->drv_strength = err ? 0 : val;
+
 	err = intel_dsm(intel_host, dev, INTEL_DSM_D3_RETUNE, &val);
 	intel_host->d3_retune = err ? true : !!val;
 }
@@ -345,67 +350,15 @@ static void sdhci_pci_int_hw_reset(struct sdhci_host *host)
 	usleep_range(300, 1000);
 }
 
-static int spt_select_drive_strength(struct sdhci_host *host,
-				     struct mmc_card *card,
-				     unsigned int max_dtr,
-				     int host_drv, int card_drv, int *drv_type)
+static int intel_select_drive_strength(struct mmc_card *card,
+				       unsigned int max_dtr, int host_drv,
+				       int card_drv, int *drv_type)
 {
-	int drive_strength;
-
-	if (sdhci_pci_spt_drive_strength > 0)
-		drive_strength = sdhci_pci_spt_drive_strength & 0xf;
-	else
-		drive_strength = 0; /* Default 50-ohm */
-
-	if ((mmc_driver_type_mask(drive_strength) & card_drv) == 0)
-		drive_strength = 0; /* Default 50-ohm */
-
-	return drive_strength;
-}
-
-/* Try to read the drive strength from the card */
-static void spt_read_drive_strength(struct sdhci_host *host)
-{
-	u32 val, i, t;
-	u16 m;
-
-	if (sdhci_pci_spt_drive_strength)
-		return;
-
-	sdhci_pci_spt_drive_strength = -1;
-
-	m = sdhci_readw(host, SDHCI_HOST_CONTROL2) & 0x7;
-	if (m != 3 && m != 5)
-		return;
-	val = sdhci_readl(host, SDHCI_PRESENT_STATE);
-	if (val & 0x3)
-		return;
-	sdhci_writel(host, 0x007f0023, SDHCI_INT_ENABLE);
-	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
-	sdhci_writew(host, 0x10, SDHCI_TRANSFER_MODE);
-	sdhci_writeb(host, 0xe, SDHCI_TIMEOUT_CONTROL);
-	sdhci_writew(host, 512, SDHCI_BLOCK_SIZE);
-	sdhci_writew(host, 1, SDHCI_BLOCK_COUNT);
-	sdhci_writel(host, 0, SDHCI_ARGUMENT);
-	sdhci_writew(host, 0x83b, SDHCI_COMMAND);
-	for (i = 0; i < 1000; i++) {
-		val = sdhci_readl(host, SDHCI_INT_STATUS);
-		if (val & 0xffff8000)
-			return;
-		if (val & 0x20)
-			break;
-		udelay(1);
-	}
-	val = sdhci_readl(host, SDHCI_PRESENT_STATE);
-	if (!(val & 0x800))
-		return;
-	for (i = 0; i < 47; i++)
-		val = sdhci_readl(host, SDHCI_BUFFER);
-	t = val & 0xf00;
-	if (t != 0x200 && t != 0x300)
-		return;
+	struct sdhci_host *host = mmc_priv(card->host);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct intel_host *intel_host = sdhci_pci_priv(slot);
 
-	sdhci_pci_spt_drive_strength = 0x10 | ((val >> 12) & 0xf);
+	return intel_host->drv_strength;
 }
 
 static int bxt_get_cd(struct mmc_host *mmc)
@@ -451,10 +404,8 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 	slot->hw_reset = sdhci_pci_int_hw_reset;
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BSW_EMMC)
 		slot->host->timeout_clk = 1000; /* 1000 kHz i.e. 1 MHz */
-	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_SPT_EMMC) {
-		spt_read_drive_strength(slot->host);
-		slot->select_drive_strength = spt_select_drive_strength;
-	}
+	slot->host->mmc_host_ops.select_drive_strength =
+						intel_select_drive_strength;
 	return 0;
 }
 
diff --git a/drivers/mmc/host/sdhci-pci-data.c b/drivers/mmc/host/sdhci-pci-data.c
index 56fddc622a54..a611217769f5 100644
--- a/drivers/mmc/host/sdhci-pci-data.c
+++ b/drivers/mmc/host/sdhci-pci-data.c
@@ -3,6 +3,3 @@
 
 struct sdhci_pci_data *(*sdhci_pci_get_data)(struct pci_dev *pdev, int slotno);
 EXPORT_SYMBOL_GPL(sdhci_pci_get_data);
-
-int sdhci_pci_spt_drive_strength;
-EXPORT_SYMBOL_GPL(sdhci_pci_spt_drive_strength);
-- 
1.9.1

