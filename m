From: Yunpeng Gao <yunpeng.gao@intel.com>
Subject: [PATCH] mmc: sdhci-pci: Enable SD/SDIO host controller support on INTEL Merrifield platform
Date: Mon, 11 Aug 2014 18:58:19 +0800
Message-ID: <1407754699-5691-1-git-send-email-yunpeng.gao@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44684 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbaHKK4e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Aug 2014 06:56:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Yunpeng Gao <yunpeng.gao@intel.com>

Current mmc-next mmc driver only supports emmc0/emmc1
host controllers for Intel Merrifield platform.
Since Merrifield platform actually disables emmc1 and also
support SD/SDIO host controllers, submit this patch
to do:
1. Enable SDHCI pci host controller support for SD/SDIO;
2. Change eMMC pin GPIO FLIS setting if eMMC HS200 enabled.

Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |   74 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 52c42fc..6b8351f 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -293,19 +293,79 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
 	.own_cd_for_runtime_pm = true,
 };
 
+/* Define Merrifield FLIS register address */
+#define TNG_EMMC_0_FLIS_ADDR		0xff0c0900
+#define TNG_EMMC_FLIS_SLEW		0x00000400
+#define TNG_EMMC_0_CLK_PULLDOWN		0x00000200
+
+static int mrfl_emmc_flis_setup_for_hs200(struct sdhci_pci_slot *slot)
+{
+	void __iomem *flis_addr;
+	unsigned int reg;
+	int i;
+
+	/* If eMMC HS200 not enabled, do nothing and exit */
+	if (slot->host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200)
+		return 0;
+
+	flis_addr = ioremap_nocache(TNG_EMMC_0_FLIS_ADDR, 64);
+	if (!flis_addr) {
+		pr_err("MRFL emmc FLIS addr ioremap failed!\n");
+		return -ENOMEM;
+	}
+
+	pr_info("MRFL emmc mapped FLIS addr: %p\n", flis_addr);
+	/*
+	 * Change TNG gpio FLIS settings for all eMMC0
+	 * CLK/CMD/DAT pins.
+	 * That is, including emmc_0_clk, emmc_0_cmd,
+	 * emmc_0_d_0, emmc_0_d_1, emmc_0_d_2, emmc_0_d_3,
+	 * emmc_0_d_4, emmc_0_d_5, emmc_0_d_6, emmc_0_d_7
+	 */
+	for (i = 0; i < 10; i++) {
+		reg = readl(flis_addr + (i * 4));
+		reg |= TNG_EMMC_FLIS_SLEW; /* SLEW B */
+		writel(reg, flis_addr + (i * 4));
+	}
+
+	/* Disable PullDown for emmc_0_clk */
+	reg = readl(flis_addr);
+	reg &= ~TNG_EMMC_0_CLK_PULLDOWN;
+	writel(reg, flis_addr);
+
+	/* Release the mapped address */
+	iounmap(flis_addr);
+
+	return 0;
+}
+
 /* Define Host controllers for Intel Merrifield platform */
 #define INTEL_MRFL_EMMC_0	0
 #define INTEL_MRFL_EMMC_1	1
+#define INTEL_MRFL_SD		2
+#define INTEL_MRFL_SDIO		3
 
 static int intel_mrfl_mmc_probe_slot(struct sdhci_pci_slot *slot)
 {
-	if ((PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFL_EMMC_0) &&
-	    (PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFL_EMMC_1))
-		/* SD support is not ready yet */
-		return -ENODEV;
-
-	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
-				 MMC_CAP_1_8V_DDR;
+	switch (PCI_FUNC(slot->chip->pdev->devfn)) {
+	case INTEL_MRFL_EMMC_0:
+		slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA |
+					MMC_CAP_NONREMOVABLE |
+					MMC_CAP_1_8V_DDR;
+		/* Change FLIS reg setup if eMMC HS200 enabled */
+		mrfl_emmc_flis_setup_for_hs200(slot);
+		break;
+	case INTEL_MRFL_SD:
+		slot->cd_gpio = 77;
+		break;
+	case INTEL_MRFL_SDIO:
+		slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+		break;
+	default:
+		dev_err(&slot->chip->pdev->dev, "Invalid PCI Func %d.\n",
+			PCI_FUNC(slot->chip->pdev->devfn));
+		break;
+	}
 
 	return 0;
 }
-- 
1.7.9.5

