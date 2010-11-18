From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH v2 3/3]mmc: Add the new quirk to MFLD SDHCI HC
Date: Thu, 18 Nov 2010 17:01:07 +0800
Message-ID: <20101118090107.GD18161@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, alan@linux.intel.com, arjan@linux.intel.com
List-Id: linux-mmc@vger.kernel.org

>From 26a27fbbb8c28f7b2e9079b7e600625af5718b8c Mon Sep 17 00:00:00 2001
From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Date: Thu, 18 Nov 2010 16:25:03 +0800
Subject: [PATCH 3/3] mmc: Add SDHCI_QUIRK_FORCE_ERASE_SINGLE to MFLD sdhci HC

This will be going to let MFLD SDHCI host controller to erase single block
each time.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 3d9c246..6eea1ba 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -169,11 +169,13 @@ static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1_hc2 = {
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
-	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
+				SDHCI_QUIRK_FORCE_ERASE_SINGLE,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_mfd_emmc_sdio = {
-	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
+				SDHCI_QUIRK_FORCE_ERASE_SINGLE,
 };
 
 static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
-- 
1.6.6.1
